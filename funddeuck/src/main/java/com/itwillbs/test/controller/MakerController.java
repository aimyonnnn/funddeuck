package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.PaymentService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.FundingDoctorVO;
import com.itwillbs.test.vo.MakerBoardVO;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.PageInfoVO;
import com.itwillbs.test.vo.PaymentVO;
import com.itwillbs.test.vo.ProjectVO;

@Controller
public class MakerController {
	
	@Autowired
	private MakerService makerService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private PaymentService paymentService;
	
	// 메이커 등록 페이지
	@GetMapping("projectMaker")
	public String makerInfo(HttpSession session, Model model) {
	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) {
	        model.addAttribute("msg", "잘못된 접근입니다.");
	        return "fail_back";
	    }

	    int member_idx = projectService.getMemberIdx(sId);
	    Integer maker_idx = makerService.getMakerIdx(sId);
	    
	    if (maker_idx != null && maker_idx > 0) {
	        String targetURL = "projectManagement?maker_idx=" + makerService.getMakerIdx(memberService.getMemberId(member_idx));
	        model.addAttribute("msg", "메이커는 계정 당 1개만 만들 수 있습니다. \\n프로젝트 등록 페이지로 이동합니다.");
	        model.addAttribute("targetURL", targetURL);
	        return "success_forward";
	    } else {
	    	model.addAttribute("member_idx", member_idx);
	    	return "project/project_maker";
	    }

	}
	
	// 메이커 등록 비즈니스 로직 처리
	@PostMapping("projectMakerPro")
	public String projectMaker(MakerVO maker, Model model, HttpSession session, HttpServletRequest request) {
		
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
		
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		String fileName5 = uuid.substring(0, 8) + "_" + mFile5.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			maker.setMaker_file1(subDir + "/" + fileName1);
		}
		if(!mFile2.getOriginalFilename().equals("")) {
			maker.setMaker_file2(subDir + "/" + fileName2);
		}
		if(!mFile3.getOriginalFilename().equals("")) {
			maker.setMaker_file3(subDir + "/" + fileName3);
		}
		if(!mFile4.getOriginalFilename().equals("")) {
			maker.setMaker_file4(subDir + "/" + fileName4);
		}
		if(!mFile5.getOriginalFilename().equals("")) {
			maker.setMaker_file5(subDir + "/" + fileName5);
		}
		
		System.out.println("실제 업로드 파일명1 : " + maker.getMaker_file1());
		System.out.println("실제 업로드 파일명2 : " + maker.getMaker_file2());
		System.out.println("실제 업로드 파일명3 : " + maker.getMaker_file3());
		System.out.println("실제 업로드 파일명4 : " + maker.getMaker_file4());
		System.out.println("실제 업로드 파일명5 : " + maker.getMaker_file5());
		
		// -----------------------------------------------------------------------------------
		int insertCount = projectService.registMaker(maker);
		
		if(insertCount > 0) { // 성공
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
				
				if(!mFile3.getOriginalFilename().equals("")) {
					mFile3.transferTo(new File(saveDir, fileName3));
				}
				
				if(!mFile4.getOriginalFilename().equals("")) {
					mFile4.transferTo(new File(saveDir, fileName4));
				}
				
				if(!mFile5.getOriginalFilename().equals("")) {
					mFile5.transferTo(new File(saveDir, fileName5));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// 메이커 등록 성공 시 프로젝트 등록 페이지로 이동
			String targetURL = "projectManagement?maker_idx=" + maker.getMaker_idx();
			System.out.println("메이커 등록 성공 시 메이커 번호 조회 : " + maker.getMaker_idx());
			model.addAttribute("msg", "메이커 등록에 성공하였습니다. 프로젝트 등록 페이지로 이동합니다.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else { // 실패
			model.addAttribute("msg", "메이커 등록 실패!");
			return "fail_back";
		}
	}
	
	// 메이커 페이지
	@GetMapping("makerDetail")
	public String makerDetail(@RequestParam(required = false) Integer maker_idx, HttpSession session, Model model) {
	    String sId = (String) session.getAttribute("sId");
	    MakerVO maker = null;

	    if (maker_idx != null) {
	        maker = makerService.getMakerInfo(maker_idx);

	        if (maker == null) {
	            model.addAttribute("msg", "메이커 정보를 찾을 수 없습니다.");
	            return "fail_back";
	        }

	        // 승인된 프로젝트 리스트 조회
	        // project_approve_status = 5 & project_status = 2
//	        List<ProjectVO> pList = projectService.getAllProjectByMakerIdx(maker_idx);
	        List<ProjectVO> pList = projectService.getApprovedProjectsByMakerIdx(maker_idx);
	        
	        model.addAttribute("pList", pList);
	        // 메이커 공지사항 리스트 조회
	        List<MakerBoardVO> mList = projectService.getMakerBoardList(maker_idx);
	        model.addAttribute("mList", mList);
	        // 누적 서포터수 조회
	        Integer totalAcmlSupporters = paymentService.getAcmlSupportCount(maker_idx);
	        model.addAttribute("totalAcmlSupporters", totalAcmlSupporters);
	    }

	    if (sId != null) {
	        int member_idx = projectService.getMemberIdx(sId);
	        Integer loggedInMakerIdx = makerService.getMakerIdx(sId); // Integer로 변경

	        // 본인의 메이커인지 여부를 체크
	        boolean isMyMaker = loggedInMakerIdx != null && maker_idx != null && loggedInMakerIdx.equals(maker_idx);

	        if (isMyMaker && maker == null) {
	            // 로그인한 사용자의 메이커 정보를 가져옴
	            maker = makerService.getMakerInfo(loggedInMakerIdx);

	            if (maker == null) {
	                model.addAttribute("msg", "메이커 정보를 찾을 수 없습니다.");
	                return "fail_back";
	            }

	            // 로그인한 사용자의 프로젝트 리스트 조회
	            List<ProjectVO> pList = projectService.getAllProjectByMakerIdx(loggedInMakerIdx);
	            model.addAttribute("pList", pList);
	            // 로그인한 사용자의 메이커 공지사항 리스트 조회
	            List<MakerBoardVO> mList = projectService.getMakerBoardList(loggedInMakerIdx);
	            model.addAttribute("mList", mList);
	            // 누적 서포터수 조회
		        Integer totalAcmlSupporters = paymentService.getAcmlSupportCount(maker_idx);
		        model.addAttribute("totalAcmlSupporters", totalAcmlSupporters);
	        }

	        model.addAttribute("member_idx", member_idx);
	        model.addAttribute("isMyMaker", isMyMaker); // 본인의 메이커인지 여부를 모델에 추가
	    }

	    // maker 정보가 있다면 모델에 추가
	    if (maker != null) {
	        model.addAttribute("maker", maker);
	    }

	    return "project/maker_detail";
	}

	// 메이커 정보 변경
	@GetMapping("modifyMakerForm")
	public String modifyMakerForm(
			@RequestParam int maker_idx, @RequestParam(defaultValue = "1") int tab, HttpSession session, Model model) {
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		int memberIdx = projectService.getMemberIdx(sId);
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		List<MakerBoardVO> mList = projectService.getMakerBoardList(maker_idx);
		
		if(maker == null || memberIdx != maker.getMember_idx()) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		model.addAttribute("maker", maker);
		model.addAttribute("mList", mList);
		model.addAttribute("maker_idx", maker_idx);
		
		return "project/maker_detail_modifyForm";
	}
	
	// 메이커 페이지 수정하기 비즈니스 로직 처리
	@PostMapping("modifyMaker")
	public String modifyMaker(MakerVO maker, HttpSession session, Model model) {
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
		
		MultipartFile mFile1 = maker.getFile4();
		MultipartFile mFile2 = maker.getFile5();
		
		String uuid = UUID.randomUUID().toString();
		maker.setMaker_file4("");
		maker.setMaker_file5("");
		
		String fileName1 = null;
		String fileName2 = null;

		if (mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
		    fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		    maker.setMaker_file4(subDir + "/" + fileName1);
		}

		if (mFile2 != null && !mFile2.getOriginalFilename().equals("")) {
		    fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		    maker.setMaker_file5(subDir + "/" + fileName2);
		}

		System.out.println("실제 업로드 파일명1 : " + maker.getMaker_file4());
		System.out.println("실제 업로드 파일명2 : " + maker.getMaker_file5());
		// -----------------------------------------------------------------------------------
		int updateCount = makerService.modifyMaker(maker);
		
		if(updateCount > 0) {
			// 파일 업로드 처리
			try {
			    if (fileName1 != null) {
			        mFile1.transferTo(new File(saveDir, fileName1));
			    }
			    if (fileName2 != null) {
			        mFile2.transferTo(new File(saveDir, fileName2));
			    }
			} catch (IllegalStateException e) {
			    e.printStackTrace();
			} catch (IOException e) {
			    e.printStackTrace();
			}
			
			// 메이커 수정 성공 시 makerDetail로 이동
//			String targetURL = "makerDetail?maker_idx=" + maker.getMaker_idx();
//			System.out.println("메이커 idx : " + maker.getMaker_idx());
//			model.addAttribute("msg", "메이커 정보 수정이 완료되었습니다.");
//			model.addAttribute("targetURL", targetURL);
//			return "success_forward";
			System.out.println("메이커수정하기여기까지옴");
			String targetURL = "modifyMakerForm?maker_idx=" + maker.getMaker_idx() + "&tab=2"; // 파라미터 추가
			model.addAttribute("msg", "메이커 정보 수정이 완료되었습니다!");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else {
			model.addAttribute("msg", "글 수정 실패!");
			return "fail_back";
		}
	}

	// 메이커 수정하기 - 첨부파일 실시간 삭제
	@PostMapping("deleteFile")
	@ResponseBody
	public String deleteFile(int maker_idx,	String fileName, int fileNumber, HttpSession session) {
		System.out.println("deleteFile() - fileName : " + fileName);
		// 파일 삭제 요청
	    int deleteCount = makerService.removeMakerFile(maker_idx, fileName, fileNumber);
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
	
	// MakerDeatil - 공지사항 작성하기
	@PostMapping("makerBoardWritePro")
	public String makerBoardWritePro(MakerBoardVO makerBoard, Model model, HttpSession session, HttpServletRequest request) {
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
		
		MultipartFile mFile1 = makerBoard.getFile1();
		String uuid = UUID.randomUUID().toString();
		makerBoard.setMaker_board_file1("");
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			makerBoard.setMaker_board_file1(subDir + "/" + fileName1);
		}
		System.out.println("실제 업로드 파일명1 : " + makerBoard.getMaker_board_file1());
		// -----------------------------------------------------------------------------------
		int insertCount = projectService.registMakerBoard(makerBoard);
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
//			String targetURL = "makerDetail?maker_idx=" + makerBoard.getMaker_idx();
//			model.addAttribute("msg", "공지사항 작성이 성공적으로 완료되었습니다!");
//			model.addAttribute("targetURL", targetURL);
//			return "success_forward";
			System.out.println("메이커공지사항작성여기까지옴");
			String targetURL = "modifyMakerForm?maker_idx=" + makerBoard.getMaker_idx() + "&tab=1";
			model.addAttribute("msg", "공지사항 작성이 성공적으로 완료되었습니다!");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else { // 실패
			model.addAttribute("msg", "공지사항 작성이 실패하였습니다.");
			return "fail_back";
		}
	}
	
	// MakerDeatil - 공지사항 삭제하기
	@PostMapping("deleteMakerBoard")
	@ResponseBody
	public String deleteMakerBoard(@RequestParam int maker_board_idx) {
		int deleteCount = makerService.removeMakerBoard(maker_board_idx);
		if(deleteCount > 0) return "true";
		return "false";
	}
	
	// MakerDeatil - 공지사항 조회하기
	@PostMapping("getMakerBoardInfo")
	@ResponseBody
	public MakerBoardVO getMakerBoardInfo(@RequestParam int maker_board_idx) {
		MakerBoardVO makerBoard = makerService.getMakerBoardInfo(maker_board_idx);
		return makerBoard;
	}
	
	// Maker - 마이페이지
	@GetMapping("makerMypage")
	public String makerMypage(HttpSession session, Model model) {
		String sId = (String) session.getAttribute("sId");
	    if (sId == null) {
	        model.addAttribute("msg", "잘못된 접근입니다. 로그인 후 사용해 주세요!");
	        return "fail_back";
	    }
	    
	    Integer maker_idx = makerService.getMakerIdx(sId); // 메이커 번호 조회
		
		if(maker_idx == null) { // 메이커 번호 없을 시 
			model.addAttribute("msg", "메이커 생성 후 이용이 가능합니다!");
			return "fail_back";
		}
		
		// 메이커 정보 조회
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		
		// 작성중인 프로젝트 - 현재 프로젝트는 등록했는데 리워드는 등록 안한 상태
		List<ProjectVO> unapprovedList = projectService.getUnapprovedList(maker_idx);
		
		// 진행중인 프로젝트
		List<ProjectVO> proceedingList = projectService.getProceedingList(maker_idx);
				
		// 진행완료된 프로젝트
		List<ProjectVO> completeList = projectService.getCompleteList(maker_idx);
				
		model.addAttribute("maker", maker);
		model.addAttribute("unapprovedList", unapprovedList);
		model.addAttribute("proceedingList", proceedingList);
		model.addAttribute("completeList", completeList);
		
		return "member/maker_mypage";
	}

	// 펀딩 닥터 답변 확인 목록 페이지
	@GetMapping("fundingDoctorAnswer")
	public String fundingDoctorAnswer(
							@RequestParam(defaultValue = "") String searchType,
							@RequestParam(defaultValue = "") String searchKeyword,
							@RequestParam(defaultValue = "1") int pageNum,			
							Model model, HttpSession session) {
		
		String sId = (String) session.getAttribute("sId");
	    if (sId == null) {
	        model.addAttribute("msg", "잘못된 접근입니다. 로그인 후 사용해 주세요!");
	        return "fail_back";
	    }
	    
	    Integer maker_idx = makerService.getMakerIdx(sId); // 메이커번호 조회
	    
	    // 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
 		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
 		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
	    
	    List<FundingDoctorVO> doctorList = projectService.getAllDoctorList(searchType, searchKeyword, startRow, listLimit, maker_idx); // 메이커 번호로 등록된 펀딩닥터 답변 조회
	    
	    // 페이징 처리를 위한 계산 작업
 		// 1. 전체 게시물 수 조회 요청
 		int listCount = projectService.getAllDoctorListCount(searchType, searchKeyword, maker_idx);
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
 		model.addAttribute("doctorList", doctorList);
 		model.addAttribute("pageInfo", pageInfo);
		
		return "member/maker_funding_doctor";
	}
	
	// 펀딩 닥터 답변 확인 페이지
	@GetMapping("fundingDoctorAnswerDetail")
	public String fundingDoctorAnswerDetail(
			@RequestParam(defaultValue = "1") int pageNum, @RequestParam int project_idx, @RequestParam(defaultValue = "1") int type, 
			HttpSession session, Model model) {
		
		String sId = (String) session.getAttribute("sId");
	    if (sId == null) {
	        model.addAttribute("msg", "잘못된 접근입니다. 로그인 후 사용해 주세요!");
	        return "fail_back";
	    }
		
		FundingDoctorVO doctor = projectService.getFundingDoctorInfo(project_idx);
		model.addAttribute("doctor", doctor);
		return "member/maker_funding_doctor_detail";
	}
	
	// 작성중인 프로젝트 삭제
	@PostMapping("projectDelete")
	public String projectDelete(@RequestParam int project_idx, Model model, HttpSession session) {
		String sId = (String) session.getAttribute("sId");
	    if (sId == null) {
	        model.addAttribute("msg", "잘못된 접근입니다. 로그인 후 사용해 주세요!");
	        return "fail_back";
	    }
	    
	    int deleteCount = projectService.deleteProject(project_idx); // 작성중인 프로젝트 삭제
	    
	    if(deleteCount > 0) {
			 model.addAttribute("msg", "프로젝트가 성공적으로 삭제되었습니다!");
			 return "makerMypage";
	    } else {
	    	 model.addAttribute("msg", "잘못된 접근입니다. 로그인 후 사용해 주세요!");
		     return "fail_back";
	    }
	    
	}
	
	// MakerDetail에 Follow의 정보를 가져오기 위한 ajax
	@PostMapping("makerDetailFollow")
	@ResponseBody
	public String makerDetailFollow(@RequestParam int maker_idx, HttpSession session) {
		
//		System.out.println(maker_idx);
//		System.out.println((String)session.getAttribute("sId"));
		
		// 팔로우 하고 있는지 count 로 세어봄
		int isFollow = memberService.getisFollow(maker_idx, (String)session.getAttribute("sId"));
		
		if(isFollow > 0) {
			return "true";
		} else {
			return "false";
		}
	}
	
	//MakerDetail에 Follow 여부를 확인하고 넣기 및 삭제 ajax
	@PostMapping("makerDetailFollowCheck")
	@ResponseBody
	public String makerDetailFollowCheck(@RequestParam String maker_name, @RequestParam int isFollow ,HttpSession session) {
		
		System.out.println(maker_name);
		System.out.println(isFollow);
		
		if(isFollow == 1) {
			int insertCount = memberService.insertFallow(maker_name, (String)session.getAttribute("sId"));
			
			if(insertCount > 0) {
				return "true";
			}
			
		} else {
			int deletCount = memberService.deleteFallow(maker_name, (String)session.getAttribute("sId"));
			
			if(deletCount > 0) {
				return "true";
			}
		}
		
		return "false";
	}
	
}
