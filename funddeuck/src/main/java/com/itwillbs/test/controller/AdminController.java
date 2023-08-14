package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.test.handler.EchoHandler;
import com.itwillbs.test.service.AdminService;
import com.itwillbs.test.service.BankService;
import com.itwillbs.test.service.CreditService;
import com.itwillbs.test.service.MakerBoardService;
import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.NotificationService;
import com.itwillbs.test.service.PaymentService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.service.SendPhoneMessageService;
import com.itwillbs.test.vo.ActivityListVO;
import com.itwillbs.test.vo.BankingVO;
import com.itwillbs.test.vo.ChartDataEntry;
import com.itwillbs.test.vo.ChartDataVO;
import com.itwillbs.test.vo.CreditVO;
import com.itwillbs.test.vo.FundingDoctorVO;
import com.itwillbs.test.vo.MakerBoardVO;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.NotificationVO;
import com.itwillbs.test.vo.PageInfoVO;
import com.itwillbs.test.vo.PaymentVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;
import com.itwillbs.test.vo.SendPhoneMessageVO;

import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
public class AdminController {
	
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private NotificationService notificationService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private SendPhoneMessageService sendPhoneMessageService;
	@Autowired
	private MakerService makerService;
	@Autowired
	private MakerBoardService makerBoardService;
	@Autowired
	private BankService bankService;
	
	private EchoHandler echoHandler;
	@Autowired
	public AdminController(EchoHandler echoHandler) {
		this.echoHandler = echoHandler;
	}
	@Autowired
	public AdminService adminService;
	@Autowired
	private CreditService creditService; 
	
	// 관리자 메인
	@GetMapping("admin")
	public String adminMain(HttpSession session, Model model) {
		
		List<ProjectVO> pList = projectService.getAllProjects();
		int totalProjectCount = pList.size();
		int todaySupporterCount = paymentService.getSupportCountByPaymentDate();
		
		List<MembersVO> memberList = memberService.getAllMemberList(); // 전체 멤버 리스트 조회
		int totalMembersCount = memberList.size(); // 전체 멤버 수 
		int todayMembersCount = memberService.getMembersCountByToday(); // 오늘 가입한 회원 수 
		
		model.addAttribute("pList", pList);
		model.addAttribute("totalProjectCount", totalProjectCount);
		model.addAttribute("totalMembersCount", totalMembersCount);
		model.addAttribute("todaySupporterCount", todaySupporterCount);
		model.addAttribute("todayMembersCount", todayMembersCount);
		
		return "admin/admin_main";
	}
	
	// 문자 보내기
	@PostMapping("savePhoneMessage")
	@ResponseBody
	public String savePhoneMessage(@RequestParam String member_id, @RequestParam String message) throws CoolsmsException {
		System.out.println("savePhoneMessage");
		MembersVO member = memberService.getMemberInfo(member_id);
		String memberPhone = member.getMember_phone();
		return sendPhoneMessageService.SendMessage(member_id, memberPhone, message, 1);
	}
	
	// 문자 보내기 모달창 호출 시 전화번호 조회해서 자동 입력
	@PostMapping("getPhoneNumber")
	@ResponseBody
	public String getPhoneNumber(@RequestParam String member_id) {
		MembersVO member = memberService.getMemberInfo(member_id);
		if(member == null) {
			return "false";
		} 
		return member.getMember_phone();
	}
	
	// 문자 관리
	@GetMapping("adminSmsManagement")
	public String adminSmsManagement(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,
			HttpSession session, Model model) {
		
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		List<SendPhoneMessageVO> sList = sendPhoneMessageService.getAllSmsList(searchKeyword, searchType, startRow, listLimit);
		int listCount = sendPhoneMessageService.getAllSmsListCount(searchKeyword, searchType);
		
		int pageListLimit = 10;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {	endPage = maxPage; }
		
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("sList", sList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_sms_management";
	}
	
	
	// 결제 관리 - 결제 정보 수정 - 첨부파일 실시간 삭제
	@PostMapping("deletePaymentFile")
	@ResponseBody
	public String deletePaymentFile(int payment_idx, String fileName, int fileNumber, HttpSession session) {
		System.out.println("deleteFile() - fileName : " + fileName);
		// 파일 삭제 요청
	    int deleteCount = paymentService.removePaymentFile(payment_idx, fileName, fileNumber);
	    if (deleteCount != 0) {
	        // 파일 삭제 로직
	        String uploadDir = "/resources/upload";
	        String saveDir = session.getServletContext().getRealPath(uploadDir);
	        String filePath = saveDir + "/" + fileName;
	        File file = new File(filePath);
	        if (file.exists()) {
	            if (file.delete()) {
	                return "success";
	            } else {
	                return "fail";
	            }
	        } else {
	            // 파일이 이미 삭제되어 있음
	            return "success";
	        }
	    } else {
	        return "fail";
	    }
	}
	
	// 결제 관리 - 결제 정보 수정 비즈니스 로직 처리
	@PostMapping("adminModifyPayment")
	public String adminModifyPayment(PaymentVO payment, Model model, @RequestParam(defaultValue = "1") int pageNum,
			HttpSession session, HttpServletRequest request) {
		
		System.out.println("adminModifyProject");
	    String uploadDir = "/resources/upload";
	    String saveDir = session.getServletContext().getRealPath(uploadDir);
	    String subDir = "";

	    try {
	        Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	        subDir = sdf.format(date);
	        saveDir += "/" + subDir;
	        Path path = Paths.get(saveDir);
	        Files.createDirectories(path);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    System.out.println("실제 업로드 폴더 경로: " + saveDir);
	    MultipartFile mFile1 = payment.getFile1();
	    String uuid = UUID.randomUUID().toString();
	    payment.setCancel_img("");
	    String fileName1 = null;

	    if (mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
	        fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
	        payment.setCancel_img(subDir + "/" + fileName1);
	    }
	    System.out.println("실제 업로드 파일명1 : " + payment.getCancel_img());
	    // -----------------------------------------------------------------------------------
	    int updateCount = paymentService.modifyPaymentByAdmin(payment);
	    if (updateCount > 0) {
	        // 파일 업로드 처리
	        try {
	            if (fileName1 != null) {
	                mFile1.transferTo(new File(saveDir, fileName1));
	            }
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	        // 결제 정보 변경 성공 시
//	        String targetURL = "adminPaymentDetail?payment_idx=" + payment.getPayment_idx() + "&pageNum=" + pageNum;
//			model.addAttribute("msg", "결제 정보 수정이 완료되었습니다.");
//			model.addAttribute("targetURL", targetURL);
//			return "success_forward";
			String targetURL =  "adminPaymentDetail?payment_idx=" + payment.getPayment_idx() + "&tab=1";
			model.addAttribute("msg", "결제 정보 수정이 완료되었습니다!");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
	    } else {
	        model.addAttribute("msg", "결제 정보 수정에 실패하였습니다.");
	        return "fail_back";
	    }
	}
	
	// 결제 관리 - 상세보기 페이지
	@GetMapping("adminPaymentDetail")
	public String adminPaymentDetail(
			@RequestParam(required = true) Integer payment_idx, @RequestParam(defaultValue = "1") int type ,HttpSession session, Model model) {
		PaymentVO payment = paymentService.getPaymentDetail(payment_idx);
		model.addAttribute("payment", payment);
		return "admin/admin_payment_detail";
	}
	
	// 결제 관리
	@GetMapping("adminPayment")
	public String adminPayment(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,
			HttpSession session, Model model) {
		
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		List<PaymentVO> pList = paymentService.getAllPaymentList(searchKeyword, searchType, startRow, listLimit);
		int listCount = paymentService.getAllPaymentListCount(searchKeyword, searchType);
		
		int pageListLimit = 10;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {	endPage = maxPage; }
		
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pList", pList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_payment";
	}
	
	// 메이커 정보 변경 페이지 - 메이커 관리 상세보기 클릭 시
	@GetMapping("adminMakerDetail")
	public String adminMakerDetail(@RequestParam(required = true) Integer maker_idx, @RequestParam(defaultValue = "1") int type,
			HttpSession session, Model model) {
		
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		List<MakerBoardVO> mList = makerBoardService.getAllMakerBoardList(maker_idx);
		
		model.addAttribute("maker", maker);
		model.addAttribute("mList", mList);
		
		return "admin/admin_maker_detail";
	}
	
	// 메이커 정보 변경 비즈니스 로직 처리
	@PostMapping("adminModifyMaker")
	public String adminModifyMaker(
			@RequestParam(defaultValue = "1") int pageNum,
			MakerVO maker, HttpSession session, Model model) {
		
		System.out.println("modifyMaker");
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = "";
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 파일 업로드 폴더 경로 출력
		System.out.println("실제 업로드 폴더 경로: " + saveDir);
		
		MultipartFile mFile1 = maker.getFile1();
		MultipartFile mFile2 = maker.getFile2();
		MultipartFile mFile3 = maker.getFile3();
		MultipartFile mFile4 = maker.getFile4();
		MultipartFile mFile5 = maker.getFile5();
		
		String uuid = UUID.randomUUID().toString();
		maker.setMaker_file1("");
		maker.setMaker_file2("");
		maker.setMaker_file3("");
		maker.setMaker_file4("");
		maker.setMaker_file5("");
		
		String fileName1 = null;
		String fileName2 = null;
		String fileName3 = null;
		String fileName4 = null;
		String fileName5 = null;

		if (mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
		    fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		    maker.setMaker_file1(subDir + "/" + fileName1);
		}

		if (mFile2 != null && !mFile2.getOriginalFilename().equals("")) {
		    fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		    maker.setMaker_file2(subDir + "/" + fileName2);
		}

		if (mFile3 != null && !mFile3.getOriginalFilename().equals("")) {
			fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
			maker.setMaker_file3(subDir + "/" + fileName3);
		}
		
		if (mFile4 != null && !mFile4.getOriginalFilename().equals("")) {
			fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
			maker.setMaker_file4(subDir + "/" + fileName4);
		}
		
		if (mFile5 != null && !mFile5.getOriginalFilename().equals("")) {
			fileName5 = uuid.substring(0, 8) + "_" + mFile5.getOriginalFilename();
			maker.setMaker_file5(subDir + "/" + fileName5);
		}
		
		System.out.println("실제 업로드 파일명1 : " + maker.getMaker_file1());
		System.out.println("실제 업로드 파일명2 : " + maker.getMaker_file2());
		System.out.println("실제 업로드 파일명3 : " + maker.getMaker_file3());
		System.out.println("실제 업로드 파일명4 : " + maker.getMaker_file4());
		System.out.println("실제 업로드 파일명5 : " + maker.getMaker_file5());
		
		// -----------------------------------------------------------------------------------
		
		int updateCount = makerService.ModifyMakerByAdmin(maker);
		
		if(updateCount > 0) {
			// 파일 업로드 처리
			try {
			    if (fileName1 != null) {
			        mFile1.transferTo(new File(saveDir, fileName1));
			    }
			    if (fileName2 != null) {
			        mFile2.transferTo(new File(saveDir, fileName2));
			    }
			    if (fileName3 != null) {
			    	mFile3.transferTo(new File(saveDir, fileName3));
			    }
			    if (fileName4 != null) {
			    	mFile4.transferTo(new File(saveDir, fileName4));
			    }
			    if (fileName5 != null) {
			    	mFile5.transferTo(new File(saveDir, fileName5));
			    }
			} catch (IllegalStateException e) {
			    e.printStackTrace();
			} catch (IOException e) {
			    e.printStackTrace();
			}
			
			// 메이커 정보 변경 성공 시
//			String targetURL = "adminMakerDetail?maker_idx=" + maker.getMaker_idx() + "&pageNum=" + pageNum;
//			model.addAttribute("msg", "메이커 정보 수정이 완료되었습니다!");
//			model.addAttribute("targetURL", targetURL);
//			return "success_forward";
			String targetURL =  "adminMakerDetail?maker_idx=" + maker.getMaker_idx() + "&pageNum=" + pageNum + "&tab=1";
			model.addAttribute("msg", "메이커 정보 수정이 완료되었습니다!");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else {
			model.addAttribute("msg", "메이커 정보 수정에 실패하였습니다.");
			return "fail_back";
		}
	}
	
	// 메이커 관리 페이지
	@GetMapping("adminMakerManagement")
	public String adminMakerManagement(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,
			HttpSession session, Model model) {
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		// 프로젝트 목록 조회 요청
		List<MakerVO> mList = makerService.getAllMakerList(searchKeyword, searchType, startRow, listLimit);
		
		// 페이징 처리를 위한 계산 작업
		// 1. 전체 게시물 수 조회 요청
		int listCount = makerService.getAllMakerListCount(searchKeyword, searchType);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {	endPage = maxPage; }
		
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("mList", mList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_maker_management";
	}
	
	// 프로젝트 관리
	@GetMapping("adminProjectManagement")
	public String projectControl(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,			
			Model model) {
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		// 프로젝트 목록 조회 요청
		// 프로젝트 승인 상태 1-미승인 2-승인요청 3-승인완료 4-승인거절 5-결제완료(펀딩+ 페이지에 출력 가능한 상태)
		List<ProjectVO> pList = projectService.getAllProject(searchKeyword, searchType, startRow, listLimit);
		
		// 페이징 처리를 위한 계산 작업
		// 1. 전체 게시물 수 조회 요청
		int listCount = projectService.getAllProjectCount(searchKeyword, searchType);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {	endPage = maxPage; }
		
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pList", pList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_project_management";
	}
	
	// 프로젝트 관리 - 상세 페이지
	@GetMapping("adminProjectManagementDetail")
	public String adminProjectManagementDetail(
			@RequestParam(defaultValue = "1") int pageNum, @RequestParam int project_idx, @RequestParam(defaultValue = "1") int type, 
			HttpSession session, Model model) {
		
		ProjectVO project = projectService.getProjectInfo(project_idx);
		List<RewardVO> rList = projectService.getRewardList(project_idx);
		
		model.addAttribute("project", project);
		model.addAttribute("rList", rList);
		
		return "admin/admin_project_management_detail";
	}
	
	// 프로젝트 승인완료 시 메이커에게 문자 메시지 전송하기
	// 프로젝트 상태컬럼 3-승인완료
	@PostMapping("sendPhoneMessage")
	@ResponseBody 
	public String checkPhone(@RequestParam String memberPhone, @RequestParam String message,
							@RequestParam Integer memberIdx, @RequestParam int projectIdx) throws CoolsmsException {
		String memberId = memberService.getMemberId(memberIdx);
		message = "[Funddeuck] 프로젝트 승인이 완료되었습니다. 프로젝트 요금 결제를 진행해주세요!";
		return sendPhoneMessageService.SendMessage(memberId, memberPhone, message, projectIdx);
	}
	
	// 프로젝트 승인 관리 페이지
	@GetMapping("adminProjectList")
	public String adminProject(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,			
			Model model) {
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		// 프로젝트 목록 조회 요청
		// 프로젝트 승인 상태 1-미승인 2-승인요청 3-승인완료 4-승인거절 5-결제완료(펀딩+ 페이지에 출력 가능한 상태)
		// project_approve_status != 1 리스트 조회 후 메이커, 리워드 버튼을 클릭 시에 다시 ajax로 리스트를 요청 후에 출력함.
		List<ProjectVO> pList = projectService.getAllRequestProject(searchType, searchKeyword, startRow, listLimit);
		
		// 페이징 처리를 위한 계산 작업
		// 1. 전체 게시물 수 조회 요청
		int listCount = projectService.getAllRequestProjectCount(searchType, searchKeyword);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {	endPage = maxPage; }
		
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("pList", pList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/admin_project_list";
	}
	
	// 프로젝트 승인완료 처리
	// 프로젝트 상태컬럼 변경하기 3-승인완료
	@GetMapping("approveProjectStatus")
	@ResponseBody
	public String approveProjectStatus(	@RequestParam int member_idx,
										@RequestParam int project_idx,
										@RequestParam int project_approve_status,
										HttpServletRequest request) {
		
		System.out.println("approveProjectStatus");
		
		// 승인완료 처리는 승인요청, 승인거절 상태에서만 가능 (미승인, 결제완료 상태에서는 승인완료 처리 불가)
		if(project_approve_status == 2 || project_approve_status == 4) {
			
			// member_id 조회하기
			String memberId = memberService.getMemberId(member_idx);
			
			// 프로젝트 승인상태 컬럼 변경하기 
			project_approve_status = 3;
			int updateCount = projectService.modifyProjectStatus(project_idx, project_approve_status);
			
			// 1. 상태컬럼 변경 성공 시 결제url이 담긴 toast 팝업 알림 보내기
			// 2. 결제url이 담긴 메시지 보내기
			// 3. 48시간 안에 결제하지 않을 시 승인거절 처리하는 스케줄러 호출
			
			if(updateCount > 0) { 
				
				// toast 팝업 알림 보내기
				String url = "projectPlanPayment?project_idx=" + project_idx;
				String subject = "[프로젝트 승인 알림] 프로젝트 승인이 완료되었습니다.";
				String content = 
						"<a href='" + url + "'>결제하기</a><a style='text-decoration: none; color: black;'> 링크 클릭 시 요금 결제 페이지로 이동합니다.<br>48시간 안에 결제를 진행하지 않으면 프로젝트가 승인거절 처리 됩니다.</a>";
				
				try {
					echoHandler.sendNotificationToUser(memberId, subject);
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				// 결제url이 담긴 메시지 보내기
				// 메세지함에서 해당 url 클릭 시 결제 페이지로 이동함
				int insertCount = notificationService.registNotification(memberId, subject, content);
				if(insertCount > 0) { // 메시지 보내기 성공 시
					
					// 프로젝트 승인 상태를 48시간 후에 체크하는 작업 예약
					adminService.scheduleCheckApproval(project_idx, memberId);
					System.out.println("스케줄러호출됨");
					return "true";
				}
			} 
		}
		
		return "false";
	}
	
	// 프로젝트 승인거절 처리하기
	// 프로젝트 상태컬럼 변경하기 4-승인거절
	@GetMapping("rejectProjectStatus")
	@ResponseBody
	public String rejectProjectStatus(@RequestParam int project_idx, @RequestParam int project_approve_status) {
		
		System.out.println("프로젝트승인상태:" + project_approve_status);
		
		// 승인거절 처리는 승인요청 상태일때만 가능함
		if(project_approve_status == 2) {
			
			System.out.println("승인거절처리여기까지옴");
			
			// 프로젝트 승인상태 컬럼 변경하기
			project_approve_status = 4;
			int updateCount = projectService.modifyProjectStatus(project_idx, project_approve_status);
			System.out.println("승인거절처리여기까지옴2");
			
			if(updateCount <= 0) { 
				return "false"; 
			}
			
			// 프로젝트 상태 컬럼 변경하기
			int project_status = 1;
			int updateCount2 = projectService.modifyProjectSatusProgress(project_idx, project_status);
			
			return (updateCount2 > 0) ? "true" : "false";
			
		} else {
			
			return "false";
		}
		
	}

	// 프로젝트 결제완료 처리하기
	// 프로젝트 상태컬럼 변경하기 5-결제완료
	@PostMapping("completePaymentStatus")
	@ResponseBody
	public String completePaymentStatus(@RequestParam Map<String, String> map) {
		System.out.println("이거 출력됨: " + map);
		// 멤버 조회하기
	    MembersVO member = memberService.getMemberInfoByProjectIdx(Integer.parseInt(map.get("project_idx")));
	    Integer member_idx = member.getMember_idx();
	    String member_id = member.getMember_id();

	    int project_idx = Integer.parseInt(map.get("project_idx"));
	    int project_approve_status = Integer.parseInt(map.get("project_approve_status"));

	    // 프로젝트 승인상태 컬럼 결제완료로 변경하기
	    int updateCount = projectService.modifyProjectStatus(project_idx, project_approve_status);

	    if (updateCount <= 0) {
	        return "false";
	    }

	    // 프로젝트 상태 컬럼 진행중으로 변경하기
	    int project_status = 2;
	    int updateCount2 = projectService.modifyProjectSatusProgress(project_idx, project_status);

	    if (updateCount2 <= 0) {
	        return "false";
	    }
	    
	    // 메이커에게 toast알림, 결제완료 메시지 보내기
	    String subject = "[프로젝트 요금제 결제완료 알림] 프로젝트 요금제 결제가 완료되었습니다.";
	    String content = "프로젝트 요금제 결제가 완료되었습니다. 펀딩+ 페이지에서 프로젝트를 확인해주세요. 감사합니다.";
	    
	    try {
			echoHandler.sendNotificationToUser(subject, content);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    
	    // 메시지함에 저장하기
	    int nCount = notificationService.registNotification(member_id, subject, content);
	    if(nCount <= 0) {
	    	return "false";
	    }

	    // credit 테이블에 결제 정보 저장하기
	    int insertCount = creditService.registCreditInfo(
	            map.get("payment_num"),
	            map.get("p_orderNum"),
	            Integer.parseInt(map.get("payment_total_price")),
	            member_idx);
	    System.out.println("여기까지옴2");
	    return (insertCount > 0) ? "true" : "false";
	}
	
	// 프로젝트 승인여부 확인하기
	@GetMapping("isProjectApproved")
	@ResponseBody
	public String isProjectApproved(@RequestParam int project_idx, @RequestParam int project_approve_status) {
		
		// 프로젝트 승인 상태 1-미승인 2-승인요청 3-승인완료 4-승인거절 5-결제완료(펀딩+ 페이지에 출력 가능한 상태)
		// 2-승인요청, 4-승인거절 일 때는 관리자가 승인 할 수 있게 true 리턴
		if(project_approve_status == 2 || project_approve_status == 4) return "true";
		
		ProjectVO project = projectService.getProjectApproved(project_idx, project_approve_status);
		
		// project가 null이 아니면 이미 승인처리 되었기 때문에 false 리턴
		if(project != null) {
			return "false";
		}
		return "true";
	}
	
	// 프로젝트 승인관리 -> 프로젝트 상세보기 페이지
	@GetMapping("adminProjectDetail")
	public String adminProjectDetail(@RequestParam int project_idx, HttpSession session, Model model) {
		// 파라미터로 전달받은 project_idx로 프로젝트 조회
		ProjectVO project = projectService.getProjectInfo(project_idx);
		List<RewardVO> rList = projectService.getRewardList(project_idx);
		// 프로젝트 테이블에서 project_idx로 maker_idx를 구한 뒤
		// maker_idx로 메이커 테이블을 조회 후 리턴받기!
		MakerVO maker = projectService.getMakerIdx(project_idx);
		// 피드백 메시지를 보내기 위해 member_id를 조회
		// 메시지 보내기를 클릭하면 받는사람 인풋에 member_id를 자동으로 호출함
		String memberId = memberService.getMemberId(maker.getMember_idx());
		System.out.println("아이디 조회 : " + memberId);
		// 승인 완료 문자 발송을 위해 휴대폰 번호 조회
		String memberPhone = memberService.getMemberPhone(maker.getMember_idx());
		System.out.println("휴대폰 번호 조회 : " + memberPhone);
		model.addAttribute("project", project);
		model.addAttribute("rList", rList);
		model.addAttribute("maker", maker);
		model.addAttribute("memberId", memberId);
		model.addAttribute("memberPhone", memberPhone);
		return "admin/admin_project_detail";
	}
	
	// 보낸 메시지함 - 관리자가 발송한 메시지 리스트를 출력
	@GetMapping("adminSentNotification")
	public String adminSentNotification(
			@RequestParam(defaultValue = "") String searchType, 
			@RequestParam(defaultValue = "") String searchKeyword, 
			@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, Model model) {
		// -------------------------------------------------------------------------
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		// -------------------------------------------------------------------------
		// notificationService - getTotalList() 메서드 호출하여 게시물 목록 조회 요청
		List<NotificationVO> nList = notificationService.getTotalList(searchType, searchKeyword, startRow, listLimit);
		// -------------------------------------------------------------------------
		// 한 페이지에서 표시할 페이지 목록(번호) 계산
		// 1. notificationService - getNotificationListCount() 메서드를 호출하여
		int listCount = notificationService.getNotificationListCount(searchType, searchKeyword);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		// 6. 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다
		//	  클 경우 끝 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		// 페이징 처리 정보를 저장할 PageInfoVO 객체에 계산된 데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("nList", nList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_sent_notification_list";
	}
	
	// 받은 메시지함 - 관리자가 받은 메시지 리스트를 출력
	@GetMapping("adminReceivedNotification")
	public String adminReceivedNotification(
			@RequestParam(defaultValue = "") String searchType, 
			@RequestParam(defaultValue = "") String searchKeyword, 
			@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, Model model) {
		String sId = (String) session.getAttribute("sId");
		// -------------------------------------------------------------------------
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		// -------------------------------------------------------------------------
		// notificationService - getTotalList() 메서드 호출하여 게시물 목록 조회 요청
		List<NotificationVO> nList = notificationService.getTotalListById(searchType, searchKeyword, sId, startRow, listLimit);
		// -------------------------------------------------------------------------
		// 한 페이지에서 표시할 페이지 목록(번호) 계산
		// 1. notificationService - getNotificationListCount() 메서드를 호출하여
		int listCount = notificationService.getTotalListCountById(searchType, searchKeyword, sId);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		// 6. 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다
		//	  클 경우 끝 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		// 페이징 처리 정보를 저장할 PageInfoVO 객체에 계산된 데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("nList", nList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_received_notification_list";
	}
	
	// 데이터 분석 
	@GetMapping("adminChart")
	public String adminChart(HttpSession session, Model model) {
		
		String sId = (String) session.getAttribute("sId");
		if(sId == null || !"admin".equals(sId)) {
			model.addAttribute("msg", "잘못된 접근 입니다.");
			return "fail_back";
		}
		
	    return "admin/admin_chart";
	}
	
	// 일별, 누적 결제금액, 누적 서포터수를 출력
	@GetMapping("/chartData2")
	@ResponseBody
	public ChartDataVO getChartData(
	        @RequestParam String startDate, @RequestParam String endDate, Model model) {
		
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	    LocalDate parsedStartDate = LocalDate.parse(startDate, formatter);
	    LocalDate parsedEndDate = LocalDate.parse(endDate, formatter);
	    System.out.println("parsedStartDate : " + parsedStartDate);
	    System.out.println("parsedEndDate : " + parsedEndDate);
	    
	    List<PaymentVO> paymentList = paymentService.getTotalPayment(parsedStartDate, parsedEndDate);			 // 전체 메이커별 결제 금액 조회
	    List<PaymentVO> supporterList = paymentService.getTotalSupporter(parsedStartDate, parsedEndDate);		 // 전체 메이커별 서포터 수 조회

	    List<String> labels = new LinkedList<>();
	    List<Integer> dailyPaymentAmounts = new LinkedList<>();
	    List<Integer> acmlPaymentAmounts = new LinkedList<>();
	    List<Integer> dailySupporterCounts = new LinkedList<>();
	    List<Integer> acmlSupporterCounts = new LinkedList<>();

	    int acmlPaymentAmount = 0;
	    int acmlSupporterCount = 0;

	    // paymentList에서 하나씩 꺼내면서 리스트에 저장
	    for (PaymentVO payment : paymentList) {
	        String dateString = payment.getDate();
	        labels.add(dateString); 										// 라벨에 날짜 추가
	        acmlPaymentAmount += payment.getAmount(); 						// 누적 결제 금액 계산
	        dailyPaymentAmounts.add(payment.getAmount()); 					// 일별 결제 금액 추가
	        acmlPaymentAmounts.add(acmlPaymentAmount);						// 누적 결제 금액 추가
	    }

	    int supporterIndex = 0; // 서포터 수 데이터 인덱스

	    for (String label : labels) {
	        if (supporterIndex < supporterList.size()) {
	            PaymentVO supporterData = supporterList.get(supporterIndex);
	            String dateString = supporterData.getDate();

	            if (label.equals(dateString)) {
	                acmlSupporterCount += supporterData.getCount(); 		// 누적 서포터 수 갱신
	                acmlSupporterCounts.add(acmlSupporterCount); 			// 누적 서포터 수 추가
	                dailySupporterCounts.add(supporterData.getCount());		// 일별 서포터 수 추가
	                supporterIndex++; 										// 다음 서포터 수 데이터로 이동
	                continue;
	            }
	        }
	        dailySupporterCounts.add(0); 									// 누락된 날짜에 대해 0으로 처리된 일별 서포터 수 추가
	        acmlSupporterCounts.add(acmlSupporterCount); 					// 이전의 누적 서포터 수 추가 (이전 데이터를 그대로 사용)
	    }
	    return new ChartDataVO(
    		labels, dailyPaymentAmounts, acmlPaymentAmounts, dailySupporterCounts, acmlSupporterCounts, acmlPaymentAmount, acmlSupporterCount);
	}

	// 프로젝트 정보 수정 비즈니스 로직 처리
	@PostMapping("adminModifyProject")
	public String adminModifyProject(@RequestParam(defaultValue = "1") int pageNum, ProjectVO project, HttpSession session, Model model) {

	    System.out.println("adminModifyProject");
	    String uploadDir = "/resources/upload";
	    String saveDir = session.getServletContext().getRealPath(uploadDir);
	    String subDir = "";

	    try {
	        Date date = new Date();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	        subDir = sdf.format(date);
	        saveDir += "/" + subDir;
	        Path path = Paths.get(saveDir);
	        Files.createDirectories(path);
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

	    // 파일 업로드 폴더 경로 출력
	    System.out.println("실제 업로드 폴더 경로: " + saveDir);

	    MultipartFile mFile1 = project.getFile1();
	    MultipartFile mFile2 = project.getFile2();
	    MultipartFile mFile3 = project.getFile3();
	    MultipartFile mFile4 = project.getFile4();
	    MultipartFile mFile5 = project.getFile5();

	    String uuid = UUID.randomUUID().toString();
	    project.setProject_thumnails1("");
	    project.setProject_thumnails2("");
	    project.setProject_thumnails3("");
	    project.setProject_image("");
	    project.setProject_settlement_image("");

	    String fileName1 = null;
	    String fileName2 = null;
	    String fileName3 = null;
	    String fileName4 = null;
	    String fileName5 = null;

	    if (mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
	        fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
	        project.setProject_thumnails1(subDir + "/" + fileName1);
	    }

	    if (mFile2 != null && !mFile2.getOriginalFilename().equals("")) {
	        fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
	        project.setProject_thumnails2(subDir + "/" + fileName2);
	    }

	    if (mFile3 != null && !mFile3.getOriginalFilename().equals("")) {
	        fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
	        project.setProject_thumnails3(subDir + "/" + fileName3);
	    }

	    if (mFile4 != null && !mFile4.getOriginalFilename().equals("")) {
	        fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
	        project.setProject_image(subDir + "/" + fileName4);
	    }

	    if (mFile5 != null && !mFile5.getOriginalFilename().equals("")) {
	        fileName5 = uuid.substring(0, 8) + "_" + mFile5.getOriginalFilename();
	        project.setProject_settlement_image(subDir + "/" + fileName5);
	    }

	    System.out.println("실제 업로드 파일명1 : " + project.getProject_thumnails1());
	    System.out.println("실제 업로드 파일명2 : " + project.getProject_thumnails2());
	    System.out.println("실제 업로드 파일명3 : " + project.getProject_thumnails3());
	    System.out.println("실제 업로드 파일명4 : " + project.getProject_image());
	    System.out.println("실제 업로드 파일명5 : " + project.getProject_settlement_image());

	    // -----------------------------------------------------------------------------------

	    int updateCount = projectService.modifyProjectByAdmin(project);

	    if (updateCount > 0) {
	        // 파일 업로드 처리
	        try {
	            if (fileName1 != null) {
	                mFile1.transferTo(new File(saveDir, fileName1));
	            }
	            if (fileName2 != null) {
	                mFile2.transferTo(new File(saveDir, fileName2));
	            }
	            if (fileName3 != null) {
	                mFile3.transferTo(new File(saveDir, fileName3));
	            }
	            if (fileName4 != null) {
	                mFile4.transferTo(new File(saveDir, fileName4));
	            }
	            if (fileName5 != null) {
	                mFile5.transferTo(new File(saveDir, fileName5));
	            }
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }

	        // 프로젝트 정보 변경 성공 시
//	        String targetURL = "adminProjectManagementDetail?project_idx=" + project.getProject_idx() + "&pageNum=" + pageNum;
//	        model.addAttribute("msg", "프로젝트 정보 수정이 완료되었습니다!");
//	        model.addAttribute("targetURL", targetURL);
//	        return "success_forward";
	        String targetURL =  "adminProjectManagementDetail?project_idx=" + project.getProject_idx() + "&pageNum=" + pageNum + "&tab=1";
			model.addAttribute("msg", "프로젝트 정보 수정이 완료되었습니다!");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
	    } else {
	        model.addAttribute("msg", "프로젝트 정보 수정에 실패하였습니다.");
	        return "fail_back";
	    }
	}
	
	// 프로젝트 수정하기 - 첨부파일 실시간 삭제
	@PostMapping("deleteProjectFile")
	@ResponseBody
	public String deleteProjectFile(int project_idx, String fileName, int fileNumber, HttpSession session) {
		System.out.println("deleteFile() - fileName : " + fileName);
		// 파일 삭제 요청
	    int deleteCount = projectService.removeProjectFile(project_idx, fileName, fileNumber);
	    if (deleteCount != 0) {
	        // 파일 삭제 로직
	        String uploadDir = "/resources/upload";
	        String saveDir = session.getServletContext().getRealPath(uploadDir);
	        String filePath = saveDir + "/" + fileName;
	        File file = new File(filePath);
	        if (file.exists()) {
	            if (file.delete()) {
	                return "success";
	            } else {
	                return "fail";
	            }
	        } else {
	            // 파일이 이미 삭제되어 있음
	            return "success";
	        }
	    } else {
	        return "fail";
	    }
	}
	
	// 리워드 수정 비즈니스 로직 처리
	@PostMapping("adminModifyReward")
	public String adminModifyReward(@RequestParam(defaultValue = "1") int pageNum, RewardVO reward, HttpSession session, Model model) {
		int updateCount = projectService.modifyReward(reward);
		if(updateCount > 0) { 
//			String targetURL = "adminProjectManagementDetail?project_idx=" + reward.getProject_idx() + "&pageNum=" + pageNum;
//	        model.addAttribute("msg", "리워드 정보 수정이 완료되었습니다!");
//	        model.addAttribute("targetURL", targetURL);
//	        return "success_forward";
			String targetURL =  "adminProjectManagementDetail?project_idx=" + reward.getProject_idx() + "&pageNum=" + pageNum + "&tab=2";
			model.addAttribute("msg", "리워드 정보 수정이 완료되었습니다!");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else {
			model.addAttribute("msg", "리워드 정보 수정에 실패하였습니다.");
			return "fail_back";
		}
	}
	
		// 회원 관리 페이지
		@GetMapping("adminMemberManagement")
		public String adminMember(@RequestParam(defaultValue = "") String searchType,
								  @RequestParam(defaultValue = "") String searchKeyword,
								  @RequestParam(defaultValue = "1") int pageNum,
								  HttpSession session, Model model) {
			
			String sId = (String) session.getAttribute("sId");
			if(sId == null || !"admin".equals(sId)) {
				model.addAttribute("msg", "잘못된 접근 입니다.");
				return "fail_back";
			}
			
			// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
			int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
			int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
			
			// 회원 목록 조회 요청
			List<MembersVO> memberList = memberService.getAllMemberList(searchKeyword, searchType, startRow, listLimit);
			
			// 차트를 위한 조회 요청
			LocalDate endDate = LocalDate.now(); // 오늘 날짜 가져오기
		    LocalDate startDate = endDate.minusDays(6); // 최근 일주일 전의 날짜 가져오기
			
		    List<MembersVO> memberTotalCounts = memberService.getMemberCountsByDate(startDate, endDate); // 누적 회원 수
			
			// 페이징 처리를 위한 계산 작업
			// 1. 전체 게시물 수 조회 요청
			int listCount = memberService.getAllMemberListCount(searchKeyword, searchType);
			// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
			int pageListLimit = 10;
			// 3. 전체 페이지 목록 갯수 계산
			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
			// 4. 시작 페이지 번호 계산
			int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
			// 5. 끝 페이지 번호 계산
			int endPage = startPage + pageListLimit - 1;
			if(endPage > maxPage) {	endPage = maxPage; }
			
			PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
			model.addAttribute("memberList", memberList);
			model.addAttribute("membersData", memberTotalCounts);
			model.addAttribute("pageInfo", pageInfo);
			
			return "admin/admin_member_management";
		}
		
		// 회원 상세정보 보기
		@GetMapping("adminMemberDetail")
		public String adminMemberDetail(@RequestParam(required = true) Integer member_idx, 
										HttpSession session, Model model) {
			MembersVO member = memberService.getMemberInfo(member_idx); // 회원 정보 조회
			
			int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 10개로 지정
			
			List<ActivityListVO> memberActivityList = memberService.getMemberActivityList(member_idx, listLimit); // 회원 활동내역 목록 조회
			
			model.addAttribute("member", member);
			model.addAttribute("memberActivityList", memberActivityList);
			
			return "admin/admin_member_detail";
		}
		
		// 회원 정보 변경 비즈니스 로직 처리
		@PostMapping("adminModifyMember")
		public String adminModifyMember(
				@RequestParam(defaultValue = "1") int pageNum,
				MembersVO member, HttpSession session, Model model) {
			
			int updateCount = memberService.ModifyMemberByAdmin(member); // 회원 정보 수정
			
			if(updateCount > 0) {
				// 회원 정보 변경 성공 시
				String targetURL = "adminMemberDetail?member_idx=" + member.getMember_idx() + "&pageNum=" + pageNum;
				model.addAttribute("msg", "회원 정보 수정이 완료되었습니다.");
				model.addAttribute("targetURL", targetURL);
				return "success_forward";
			} else {
				model.addAttribute("msg", "메이커 정보 수정에 실패하였습니다.");
				return "fail_back";
			}
		}
		
	@GetMapping("excelDownload")
    public void excelDownload(
//    		@RequestParam Map<String, Object> map,
    		@RequestParam(defaultValue = "") String searchType,
    		@RequestParam(defaultValue = "") String searchKeyword,
    		@RequestParam(defaultValue = "1") int pageNum,
    		HttpServletResponse response) throws IOException {
		
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		
	    List<ProjectVO> pList = projectService.getAllProject(searchKeyword, searchType, startRow, listLimit);
		
        Workbook wb = new XSSFWorkbook();
        Sheet sheet = wb.createSheet("첫번째 시트");
        Row row = null;
        Cell cell = null;
        int rowNum = 0;

        // Header
        row = sheet.createRow(rowNum++);
        cell = row.createCell(0);
        cell.setCellValue("번호");
        cell = row.createCell(1);
        cell.setCellValue("카테고리");
        cell = row.createCell(2);
        cell.setCellValue("프로젝트 이름");
        cell = row.createCell(3);
        cell.setCellValue("대표자");
        cell = row.createCell(4);
        cell.setCellValue("요금제");
        cell = row.createCell(5);
        cell.setCellValue("목표금액");
        cell = row.createCell(6);
        cell.setCellValue("기간");
        cell = row.createCell(7);
        cell.setCellValue("상태");

        // Body
        for (ProjectVO project : pList) {
            row = sheet.createRow(rowNum++);
            cell = row.createCell(0);
            cell.setCellValue(project.getProject_idx());
            cell = row.createCell(1);
            cell.setCellValue(project.getProject_category());
            cell = row.createCell(2);
            cell.setCellValue(project.getProject_subject());
            cell = row.createCell(3);
            cell.setCellValue(project.getProject_representative_name());
            cell = row.createCell(4);
            cell.setCellValue(project.getProject_plan());
            cell = row.createCell(5);
            cell.setCellValue(project.getProject_amount());
            cell = row.createCell(6);
            cell.setCellValue(project.getProject_start_date()+"~"+project.getProject_end_date());
            cell = row.createCell(7);
            if(project.getProject_approve_status() == 5) {
            	String status = "결제완료";
            	cell.setCellValue(status);
            	cell = row.createCell(8);
            }
        }
        // 컨텐츠 타입과 파일명 지정
        response.setContentType("ms-vnd/excel");
//		        response.setHeader("Content-Disposition", "attachment;filename=example.xls");
        response.setHeader("Content-Disposition", "attachment;filename=example.xlsx");

        // Excel File Output
        wb.write(response.getOutputStream());
        wb.close();
    }
	
	// 정산관리 
	@GetMapping("adminSettlement")
	public String adminSettlement(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,			
			Model model) {
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		// 정산 목록 조회 요청
		List<BankingVO> bankingList = bankService.getAllSettlementBanking(searchType, searchKeyword, startRow, listLimit);
				
		// 이번달 정산 금액 조회
		int monthAmount = bankService.getMonthAmount();
		
		// 페이징 처리를 위한 계산 작업
		// 1. 전체 게시물 수 조회 요청
		int listCount = bankService.getAllSettlementBankingCount(searchType, searchKeyword);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {	endPage = maxPage; }
				
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("bankingList", bankingList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("monthAmount", monthAmount);
				
		return "admin/admin_settlement";
	}
	
	// 정산 정보에 맞는 프로젝트 조회
	@GetMapping("adminBankingDetail")
	public String adminBankingDetail(
					@RequestParam(defaultValue = "1") int pageNum, @RequestParam int project_idx, @RequestParam(defaultValue = "1") int type, 
					HttpSession session, Model model) {
		
		ProjectVO project = projectService.getProjectInfo(project_idx);
		
		model.addAttribute("project", project);
		
		return "admin/admin_settlement_detail";
	}
	
	// 펀딩닥터 페이지
	@GetMapping("adminFundingDoctor")
	public String adminFundingDoctor(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,			
			Model model) {
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		// 펀딩 닥터 신청 프로젝트 조회 요청
		List<ProjectVO> projectList = projectService.getFundingDoctorProject(searchType, searchKeyword, startRow, listLimit);
		
		// 페이징 처리를 위한 계산 작업
		// 1. 전체 게시물 수 조회 요청
		int listCount = projectService.getFundingDoctorProject(searchType, searchKeyword);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {	endPage = maxPage; }
				
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("projectList", projectList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_funding_doctor";
	}
	
	// 펀딩닥터 상세보기
	@GetMapping("adminFundingDoctorDetail")
	public String adminFundingDoctorDetail(
				@RequestParam(defaultValue = "1") int pageNum, @RequestParam int project_idx, @RequestParam(defaultValue = "1") int type, 
				HttpSession session, Model model) {
		
		ProjectVO project = projectService.getProjectInfo(project_idx);	 			 // 프로젝트 조회
		List<RewardVO> rList = projectService.getRewardList(project_idx); 			// 리워드 조회
		FundingDoctorVO doctor = projectService.getFundingDoctorInfo(project_idx); // 완료된 컨설팅 조회
		
		model.addAttribute("project", project);
		model.addAttribute("rList", rList);
		model.addAttribute("doctor", doctor);
		
		return "admin/admin_funding_doctor_detail";
	}
	
	// 펀딩닥터 컨설팅 등록하기
	@PostMapping("fundingDoctorConsulting")
	public String fundingDoctorConsulting(FundingDoctorVO doctor, Model model, HttpSession session, HttpServletRequest request) {
		String content = doctor.getDoctor_content(); // textarea에서 입력받은 내용
	    content = content.replace("\n", "<br>"); // <br>태그로 변환
	    doctor.setDoctor_content(content);
		
		String uploadDir = "/resources/upload"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = "";
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile1 = doctor.getFile1();
		
		String uuid = UUID.randomUUID().toString();
		
		doctor.setDoctor_file("");
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			doctor.setDoctor_file(subDir + "/" + fileName1);
		}
		
		int insertCount = projectService.registFundingDoctor(doctor); // 펀딩 닥터 컨설팅 등록
		
		if(insertCount > 0) { // 성공
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			int project_idx = doctor.getProject_idx();
			int updateCount = projectService.modifyDoctorStatus(project_idx); // 컨설팅 완료로 상태 변경
			
			if(updateCount > 0 ) {
				// 컨설팅 등록 성공 시 목록으로 이동
				String targetURL = "adminFundingDoctor";
				model.addAttribute("msg", "펀딩닥터 컨설팅 등록에 성공하였습니다. 펀딩닥터 페이지로 이동합니다.");
				model.addAttribute("targetURL", targetURL);
				return "success_forward";
			} else {
				model.addAttribute("msg", "펀딩닥터 상태 변경 실패!");
				return "fail_back";
			}
		} else { // 실패
			model.addAttribute("msg", "펀딩닥터 컨설팅 등록 실패!");
			return "fail_back";
		}
	}
	
	
	@GetMapping("ChartDataEntry")
    @ResponseBody
    public List<PaymentVO> ChartDataEntry(
    		@RequestParam("projectStartDate") String projectStartDate, @RequestParam("projectEndDate") String projectEndDate) {
		System.out.println("여기까지옴");
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    LocalDate parsedStartDate = LocalDate.parse(projectStartDate, formatter);
	    LocalDate parsedEndDate = LocalDate.parse(projectEndDate, formatter);
	    System.out.println("parsedStartDate : " + parsedStartDate);
	    System.out.println("parsedEndDate : " + parsedEndDate);
        List<PaymentVO> dataEntries = paymentService.getTopSalesProject(projectStartDate, projectEndDate);
        return dataEntries;
    }

	
}
