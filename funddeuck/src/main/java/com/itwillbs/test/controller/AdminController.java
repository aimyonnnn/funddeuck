package com.itwillbs.test.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.test.handler.EchoHandler;
import com.itwillbs.test.service.AdminService;
import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.NotificationService;
import com.itwillbs.test.service.PaymentService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.service.SendPhoneMessageService;
import com.itwillbs.test.vo.ChartDataVO;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.NotificationVO;
import com.itwillbs.test.vo.PageInfoVO;
import com.itwillbs.test.vo.PaymentVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;

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
	
	private EchoHandler echoHandler;
	@Autowired
	public AdminController(EchoHandler echoHandler) {
		this.echoHandler = echoHandler;
	}
	@Autowired
	public AdminService adminService;
	
	// 관리자 메인
	@GetMapping("admin")
	public String adminMain(HttpSession session, Model model) {
		return "admin/admin_main";
	}
	
	// 메이커 상세정보 관리
	@GetMapping("adminMakerDetail")
	public String adminMakerDetail(@RequestParam(required = true) int maker_idx ,HttpSession session, Model model) {
		
		
		
		return "admin/admin_maker_detail";
	}
	
	
	// 메이커 관리
	@GetMapping("adminMakerManagement")
	public String adminMakerManagement(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,
			HttpSession session, Model model) {
		
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
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
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
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
	
	// 결제 관리
	@GetMapping("adminPayment")
	public String adminPayment() {
		return "admin/admin_payment";
	}
	
	// 프로젝트 승인완료 시 메이커에게 문자 메시지 전송하기
	// 프로젝트 상태컬럼 3-승인완료
	@PostMapping("sendPhoneMessage")
	@ResponseBody 
	public String checkPhone(@RequestParam String memberPhone, @RequestParam String message,
							@RequestParam String memberIdx,	@RequestParam int projectIdx) throws CoolsmsException {
		message = "[Funddeuck] 프로젝트 승인이 완료되었습니다. 프로젝트 요금 결제를 진행해주세요!";
		return sendPhoneMessageService.SendMessage(memberPhone, message, projectIdx);
	}
	
	// 프로젝트 승인관리 페이지
	@GetMapping("adminProjectList")
	public String adminProject(
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum,			
			Model model) {
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
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
	public String approveProjectStatus(
			@RequestParam int member_idx,
			@RequestParam int project_idx,
			@RequestParam int project_approve_status,
			HttpServletRequest request) {
		
		// toast 팝업 알림을 보내기 위해 member_id 조회하기
		String memberId = memberService.getMemberId(member_idx);
		
		// 프로젝트 상태컬럼을 3-승인완료로 변경하기 
		project_approve_status = 3;
		int updateCount = projectService.modifyProjectStatus(project_idx, project_approve_status);
		
		ProjectVO project = projectService.getProjectInfo(project_idx);
        project.setProject_approval_request_time(LocalDateTime.now());
        projectService.modifyProjectApprovalRequestTime(project);
		
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
				echoHandler.sendNotificationToUser(memberId, content);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 결제url이 담긴 메시지 보내기
			// 메세지함에서 해당 url 클릭 시 결제 페이지로 이동함
			int insertCount = notificationService.registNotification(memberId, subject, content);
			if(insertCount > 0) { // 메시지 보내기 성공 시
				
				// 프로젝트 승인 상태를 48시간 후에 체크하는 작업 예약
				adminService.scheduleCheckApproval(project_idx, memberId);
				
				return "true";
			}
			
		} 
		return "false";
	}
	
	// 프로젝트 승인거절 처리하기
	// 프로젝트 상태컬럼 변경하기 4-승인거절
	@GetMapping("rejectProjectStatus")
	@ResponseBody
	public String rejectProjectStatus(@RequestParam int project_idx, @RequestParam int project_approve_status) {
		// 프로젝트 상태컬럼 변경하기 4-반려
		int updateCount = projectService.modifyProjectStatus(project_idx, project_approve_status);
		if(updateCount > 0) { return "true"; } return "false";
	}
	
	// 프로젝트 결제완료 처리하기
	// 프로젝트 상태컬럼 변경하기 5-결제완료(펀딩+ 페이지에 출력 가능한 상태)
	@GetMapping("completePaymentStatus")
	@ResponseBody
	public String completePaymentStatus(@RequestParam int project_idx, @RequestParam int project_approve_status) {
		int updateCount = projectService.modifyProjectStatus(project_idx, project_approve_status);
		if(updateCount > 0) { return "true"; } return "false";
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
	
	// 관리자 메시지함
	// 관리가 발송한 메시지 리스트를 출력
	@GetMapping("adminMessage")
	public String adminMessage(
			@RequestParam(defaultValue = "") String searchType, 
			@RequestParam(defaultValue = "") String searchKeyword, 
			@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, Model model) {
		// -------------------------------------------------------------------------
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
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
		
		return "admin/admin_notification_list";
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

	
}
