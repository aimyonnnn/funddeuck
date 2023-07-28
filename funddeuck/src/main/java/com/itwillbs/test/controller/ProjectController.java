package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itwillbs.test.handler.EchoHandler;
import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.PaymentService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.ChartDataVO;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.PaymentVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;

@Controller
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MakerService makerService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private MemberService memberService;
	
	private EchoHandler echoHandler;
	@Autowired
	public ProjectController(EchoHandler echoHandler) {
		this.echoHandler = echoHandler;
	}
	
	// 프로젝트 메인
	@GetMapping("project")
	public String projectMain() {
		return "project/project_main";
	}
	
	// 프로젝트 승인 요청
	@GetMapping("approvalRequest")
	@ResponseBody
	public String approvalRequest(@RequestParam int project_idx, HttpServletRequest request) {
		System.out.println("approvalRequest - " + project_idx);
		// 파라미터로 전달받은 project_idx로 project_approve_status 상태를 2-승인요청으로 변경!
		// 프로젝트 승인 상태 1-미승인 2-승인요청 3-승인 4-반려
		// 관리자 페이지에서는 2-승인요청인것만 출력한다!
		int updateCount = projectService.modifyStatus(project_idx);
		if(updateCount > 0) {
			// 관리자에게 승인 요청 toast 팝업 띄우기
			// toast 클릭 시 관리자의 프로젝트 승인 페이지로 이동
			String adminProjectUrl = 
				request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/test/adminProjectList";
//				request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/funddeuck/adminProjectList";
			String notification = 
					"<a href='" + adminProjectUrl + "' style='text-decoration: none; color: black;'>메이커님께서 프로젝트 승인을 요청하였습니다.</a>";
			try {
				echoHandler.sendNotificationToUser("admin", notification);
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "true"; 
		} 
		return "false"; 
	}
	
	// 작성중인 프로젝트로 이동
	@GetMapping("projectUrl")
	public ModelAndView projectUrl(HttpSession session, Model model) {
	    String sId = (String) session.getAttribute("sId");
	    List<MembersVO> memberList = memberService.getIdx(sId);
	    MembersVO m = memberService.getMemberInfo(sId);
	    
	    if (memberList.isEmpty()) {
	    	model.addAttribute("msg", "작업중인 프로젝트가 없습니다.");
	    	return new ModelAndView("fail_back");
	    }

	    MembersVO member = memberList.get(0);
	    System.out.println("출력 테스트 : " + member);
	    int rewardIdx = member.getReward_idx();
	    int projectIdx = member.getProject_idx();
	    int makerIdx = member.getMaker_idx();

	    if (rewardIdx != 0) {
	        // reward_idx가 0이 아니면 projectReward로 리다이렉트
	        return new ModelAndView("redirect:/projectReward?reward_idx=" + rewardIdx);
	    } else if (makerIdx != 0) {
	    	// project_idx가 0이 아니면 projectManagement로 리다이렉트
	    	return new ModelAndView("redirect:/projectManagement?project_idx=" + projectIdx);
	    }
	    return new ModelAndView("redirect:/projectMaker?member_idx=" + m.getMember_idx());
	}
	
	// 리워드 설계 페이지
	@GetMapping("projectReward")
	public String projectReward(@RequestParam(required = false) Integer reward_idx, HttpSession session, Model model) {
		
		// 세션 아이디가 존재하지 않을 때 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		// 수정 버튼을 눌렀을 때 - reward_idx가 존재하면 리워드 수정을 위해 해당 리워드 정보 조회 후 view에 리워드 정보를 출력 
		if (reward_idx != null) {
			System.out.println("수정하기 버튼 클릭 시 - 리워드 번호 : " + reward_idx);
			
			// 리워드 작성자 판별 요청
			// 단, 세션 아이디가 admin이 아닐 때만 수행
			if(!sId.equals("admin")) {
				String rewardWriter = projectService.getRewardAuthorId(reward_idx, sId); // 리워드 작성자의 아이디를 조회
				if(!sId.equals(rewardWriter)) {
					// 리워드 작성자가 아닌 경우
					model.addAttribute("msg", "리워드 작성자가 아닙니다.");
					return "fail_back";
				} 
			}
			
			// 세션 아이디가 admin이거나 리워드 작성자인 경우, 리워드 정보 조회
			RewardVO reward = projectService.getRewardInfo(reward_idx);
			model.addAttribute("reward", reward);
	    }
		
		return "project/project_reward";
	}
	
	// 리워드 등록하기
	@PostMapping("saveReward")
    @ResponseBody
    public String saveReward(@ModelAttribute RewardVO reward) {
		System.out.println("saveReward");
		int insertCount = projectService.registReward(reward);
		System.out.println("insertCount : " + insertCount);
		if(insertCount > 0) { return "true"; } return "false";
    }
	
	// 리워드 수정하기
	@PostMapping("modifyReward")
    @ResponseBody
    public String modifyReward(@ModelAttribute RewardVO reward, @RequestParam int reward_idx, HttpSession session) {
		System.out.println("reward_idx : " + reward_idx);
		int updateCount = projectService.modifyReward(reward);
		System.out.println("updateCount : " + updateCount);
		if(updateCount > 0) { return "true"; } return "false";
    }
	
	// 리워드 삭제하기
	@PostMapping("removeReward")
	@ResponseBody
	public String removeReward(@RequestParam int reward_idx, HttpSession session) {
		System.out.println("삭제하기 버튼 클릭 시 - 리워드 번호 : " + reward_idx);
		
		// 세션 아이디가 존재하지 않을 때 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			return "false";
		}
		
		// 리워드 작성자 판별 요청
		// 단, 세션 아이디가 admin이 아닐 때만 수행
	    if(!"admin".equals(sId)) {
	        String rewardWriter = projectService.getRewardAuthorId(reward_idx, sId);
	        // 리워드 작성자가 아닌 경우
	        if (!sId.equals(rewardWriter)) {
	            return "false";
	        }
	    }
	    
	    // 리워드 삭제 처리
	    int deleteCount = projectService.removeReward(reward_idx);
	    if (deleteCount > 0) {
	        return "true";
	    }
	    
	    return "false"; // 리워드 삭제 실패 시
	}
	
	// 리워드 갯수 조회하기
	@GetMapping("rewardCount")
	@ResponseBody
	public String rewardCount(@RequestParam int project_idx) {
		int rewardCount = projectService.getRewardCount(project_idx);
		return rewardCount+"";
	}
	
	// 리워드 리스트 조회하기
	@GetMapping("rewardList")
	@ResponseBody
	public List<RewardVO> rewardList(@RequestParam int project_idx) {
	    List<RewardVO> rList = projectService.getRewardList(project_idx);
	    return rList;
	}
	
	// 메이커 등록 페이지
	@GetMapping("projectMaker")
	public String makerInfo(HttpSession session, Model model) {
		
		// 세션 아이디가 존재하지 않을 때 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		// 메이커 등록 페이지 접속 시 세션아이디로 member_idx를 조회 후 model에 저장
		int member_idx = projectService.getMemberIdx(sId);
		model.addAttribute("member_idx", member_idx);
		return "project/project_maker";
	}
	
	// 메이커 등록 비즈니스 로직 처리
	@PostMapping("projectMakerPro")
	public String projectMaker(MakerVO maker, Model model, HttpSession session, HttpServletRequest request) {
		System.out.println(maker);
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
	public String makerDetail(@RequestParam(required = false) Integer maker_idx, Model model) {
		System.out.println("makerDetail : " + maker_idx);
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		model.addAttribute("maker", maker);
		return "project/maker_detail";
	}
	
	// 메이커 수정하기 페이지
	@GetMapping("modifyMakerForm")
	public String modifyMakerForm(@RequestParam int maker_idx, Model model) {
		System.out.println("modifyMakerForm : " + maker_idx);
		// 메이커 정보 조회
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		model.addAttribute("maker", maker);
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
			String targetURL = "makerDetail?maker_idx=" + maker.getMaker_idx();
			System.out.println("메이커 idx : " + maker.getMaker_idx());
			model.addAttribute("msg", "메이커 정보 수정이 완료되었습니다.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else {
			model.addAttribute("msg", "글 수정 실패!");
			return "fail_back";
		}
	}
	
	// 메이커 페이지 수정하기 - 파일 실시간 삭제
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
	} // deleteFile
	
	// 프로젝트 등록 페이지
	@GetMapping("projectManagement")
	public String projectManagement(HttpSession session, Model model) {
		
		// 세션 아이디가 존재하지 않을 때 
//		String sId = (String) session.getAttribute("sId");
//		if(sId == null) {
//			model.addAttribute("msg", "잘못된 접근입니다.");
//			return "fail_back";
//		}
		
		return "project/project_management";
	}
	
	// 프로젝트 등록 비즈니스 로직 처리
	@PostMapping("projectManagementPro")
	public String projectManagementPro(ProjectVO project, Model model, HttpSession session, HttpServletRequest request) {
		
		// 이미지 파일 업로드 
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
		
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		String fileName5 = uuid.substring(0, 8) + "_" + mFile5.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			project.setProject_thumnails1(subDir + "/" + fileName1);
		}
		if(!mFile2.getOriginalFilename().equals("")) {
			project.setProject_thumnails2(subDir + "/" + fileName2);
		}
		if(!mFile3.getOriginalFilename().equals("")) {
			project.setProject_thumnails3(subDir + "/" + fileName3);
		}
		if(!mFile4.getOriginalFilename().equals("")) {
			project.setProject_image(subDir + "/" + fileName4);
		}
		if(!mFile5.getOriginalFilename().equals("")) {
			project.setProject_settlement_image(subDir + "/" + fileName5);
		}
		
		System.out.println("실제 업로드 썸네일명1:" + project.getProject_thumnails1());
		System.out.println("실제 업로드 썸네일명2:" + project.getProject_thumnails1());
		System.out.println("실제 업로드 썸네일명3:" + project.getProject_thumnails1());
		System.out.println("실제 업로드 상세이미지명:" + project.getProject_image());
		System.out.println("실제 업로드 통장사본명:" + project.getProject_settlement_image());
		
		// ------------------------------------------------------------------------------------
		
		// 주민등록번호 결합
		String representativeBirth1 = request.getParameter("representativeBirth1"); // 앞자리
		String representativeBirth2 = request.getParameter("representativeBirth2"); // 뒷자리
		String project_representative_birth = representativeBirth1 + "-" + representativeBirth2; // 결합
		project.setProject_representative_birth(project_representative_birth); // 저장
		
		// 해시태그 값 처리
		String project_hashtag = request.getParameter("project_hashtag");
		project.setProject_hashtag(project_hashtag);
		System.out.println("해시태그: " + project.getProject_hashtag());
		
		int insertCount = projectService.registProject(project);
		
		if(insertCount > 0) { // 성공 시 
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
			// 프로젝트 등록 성공 시 리워드 설계 페이지로 이동
			String targetURL = "projectReward?project_idx=" + project.getProject_idx();
			System.out.println("프로젝트 등록 성공 시 프로젝트 번호 조회 : " + project.getProject_idx());
			model.addAttribute("msg", "프로젝트 등록에 성공하였습니다. 리워드 설계 페이지로 이동합니다.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else { // 실패 시
			model.addAttribute("msg", "프로젝트 등록 실패!");
			return "fail_back";
		}
	}
	
	// 발송·환불 관리
	@GetMapping("projectShipping")
	public String projectShipping(HttpSession session, Model model) {
		
		// 세션 아이디가 존재하지 않을 때 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		// 세션 아이디로 member_idx 조회 
		int member_idx = projectService.getMemberIdx(sId);
		
		// 프로젝트 리스트 가져와서 Model 객체에 저장
		List<ProjectVO> projectList = projectService.getProjectList(member_idx);
		model.addAttribute("projectList", projectList);
		
		return "project/project_shipping";
	}
	
	// 발송·환불 관리 - 서포터 관리 출력
	@ResponseBody
	@PostMapping("shippingStatus")
	public Map<String, Object> shippingStatus(@RequestParam("project_idx") int project_idx) {
		Map<String, Object> data = new HashMap<>();
		
		// 배송상황 조회
		List<Map<String, Object>> deliveryStatus = paymentService.getDeliveryList(project_idx);
		
		// 환불승인여부 조회
		List<Map<String, Object>> refundStatus = paymentService.getRefundList(project_idx);
		
		System.out.println("프로젝트 번호: " + project_idx);
		System.out.println("배송상황: " + deliveryStatus);
		System.out.println("환불승인여부: " + refundStatus);
		
		data.put("deliveryStatus", deliveryStatus);
		data.put("refundStatus", refundStatus);
		
		return data;
	}
	
	// 발송·환불 관리 - 목록 출력
	@ResponseBody
	@PostMapping("shippingList")
	public List<PaymentVO> shippingList(@RequestParam int project_idx, 
										@RequestParam(value="filter", required = false) String filter, 
										@RequestParam(value="type", required = false) String type) {
		List<PaymentVO> data = new ArrayList<>();
		
		if(filter != null) { // delivery_status(배송상황)가 있을 때 목록 조회
			List<PaymentVO> deliveryAllList = paymentService.getDeliveryAllList(project_idx, filter);
			data.addAll(deliveryAllList);
		} else if(type != null) { // payment_confirm(환불승인여부)가 있을 때 목록 조회
			List<PaymentVO> refundAllList = paymentService.getRefundAllList(project_idx, type);
			data.addAll(refundAllList); 
		}
		
		System.out.println("data : " + data);
		return data;
	}
	
	// 수수료·정산 관리
	@GetMapping("projectSettlement")
	public String projectSettlement() {
		return "project/project_settlement";
	}
	
	@GetMapping("mypage")
	public String mypage() {
		return "myPage";
	}
	
	// 테스트 페이지
	@GetMapping("projectTest")
	public String projectTest(Model model, HttpSession session) {
		return "project/project_test";
	}
	
	// 프로젝트 현황
	// 페이지 로드 시 지난 7일간 결제 금액 차트를 불러옴
	@GetMapping("projectStatus")
	public String projectStatus(
			@RequestParam(required = false) Integer maker_idx, 
			@RequestParam(required = false) Integer project_idx, 
			HttpSession session, Model model) {
		System.out.println("projectStatus");

		// 메이커별 지난 7일간 결제 금액 조회
		List<PaymentVO> payList = paymentService.getPaymentListAmountBy7Day(maker_idx);
		// 메이커별 지난 7일간 서포터 수 조회
		List<PaymentVO> supporterList = paymentService.getSupporterListCountBy7Day(maker_idx);

		// Gson 객체 생성
		Gson gson = new Gson();

		// JsonArray 객체 생성
		JsonArray payArray = new JsonArray(); // 결제 금액
		JsonArray supporterArray = new JsonArray(); // 서포터 수

		// 변수 초기화
		int totalAmount = 0; // 누적 결제 금액
		int todayAmount = 0; // 오늘 결제 금액

		// payList에서 하나씩 꺼내서 JsonObject를 생성하고 payArray에 추가
		for (PaymentVO pay : payList) {
		    JsonObject object = new JsonObject();
		    object.addProperty("date", pay.getDate());
		    object.addProperty("amount", pay.getAmount());
		    payArray.add(object);

		    // 누적 결제 금액 계산
		    totalAmount += pay.getAmount();

		    // 오늘 결제 금액 계산 (오늘 날짜와 일치하는 경우)
		    LocalDate today = LocalDate.now();
		    LocalDate paymentDate = LocalDate.parse(pay.getDate());
		    if (today.isEqual(paymentDate)) {
		        todayAmount += pay.getAmount();
		    }
		}

		// supporterList에서 하나씩 꺼내서 JsonObject를 생성하고 supporterArray에 추가
		for (PaymentVO supporter : supporterList) {
		    JsonObject object = new JsonObject();
		    object.addProperty("date", supporter.getDate());
		    object.addProperty("supporterCount", supporter.getCount());
		    supporterArray.add(object);
		}

		// json 문자열로 변환 후 Model에 저장
		String payListAmount = gson.toJson(payArray);
		String supporterListCount = gson.toJson(supporterArray);
		model.addAttribute("payListAmount", payListAmount);
		model.addAttribute("todayAmount", todayAmount); // 오늘 결제 금액
		model.addAttribute("totalAmount", totalAmount); // 누적 결제 금액
		model.addAttribute("supporterListCount", supporterListCount); // 지난 7일간 서포터 수
		
		// ==============================================
		
		// 프로젝트별 지난 7일간 결제 금액 조회
		List<PaymentVO> projectPayList = paymentService.getProjectDailyPayment(project_idx);
		// 프로젝트별 지난 7일간 서포터 수 조회
		List<PaymentVO> projectSupporterList = paymentService.getProjectSupporterCount(project_idx);
		
		
		
		
		return "project/project_status";

	}
	
	// 시작일, 종료일 => 지정 가능
	// maker_idx(파라미터)를 받아서 차트를 불러옴
	@GetMapping("/chartData")
    @ResponseBody
    public ChartDataVO getChartData(
    		@RequestParam String startDate, @RequestParam String endDate, @RequestParam("maker_idx") int maker_idx, Model model) {
        // 날짜 형식을 지정하는 DateTimeFormatter 객체 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 시작일과 종료일을 파싱하여 LocalDate 객체로 변환
        LocalDate parsedStartDate = LocalDate.parse(startDate, formatter);
        LocalDate parsedEndDate = LocalDate.parse(endDate, formatter);
        System.out.println("parsedStartDate : " + parsedStartDate);
        System.out.println("parsedEndDate : " + parsedEndDate);
        System.out.println("메이커 번호 : " + maker_idx);

        // 메이커별 결제 금액 조회
        List<PaymentVO> paymentList = paymentService.getPaymentListCountByDay(parsedStartDate, parsedEndDate, maker_idx);

        // 메이커별 서포터 수 조회
        List<PaymentVO> supporterList = paymentService.getSupporterListCountByDay(parsedStartDate, parsedEndDate, maker_idx);

        // 차트에 사용될 라벨, 일별 결제 금액, 누적 결제 금액, 일별 서포터 수, 누적 서포터 수를 저장할 리스트 초기화
        List<String> labels = new LinkedList<>();
        List<Integer> dailyPaymentAmounts = new LinkedList<>();
        List<Integer> cumulativePaymentAmounts = new LinkedList<>();
        List<Integer> dailySupporterCounts = new LinkedList<>();
        List<Integer> cumulativeSupporterCounts = new LinkedList<>();

        int cumulativePaymentAmount = 0;
        int cumulativeSupporterCount = 0;

        // paymentList에서 하나씩 꺼내면서 리스트에 저장
        for (PaymentVO payment : paymentList) {
            String dateString = payment.getDate(); // 변경된 컬럼명인 'date'를 사용
            labels.add(dateString); // 라벨에 날짜 추가
            cumulativePaymentAmount += payment.getAmount(); // 누적 결제 금액 계산
            dailyPaymentAmounts.add(payment.getAmount()); // 일별 결제 금액 추가
            cumulativePaymentAmounts.add(cumulativePaymentAmount); // 누적 결제 금액 추가
        }

        int supporterIndex = 0; // 서포터 수 데이터 인덱스

        for (String label : labels) {
            if (supporterIndex < supporterList.size()) {
                PaymentVO supporterData = supporterList.get(supporterIndex);
                String dateString = supporterData.getDate(); // 변경된 컬럼명인 'date'를 사용

                if (label.equals(dateString)) {
                    cumulativeSupporterCount += supporterData.getCount(); // 누적 서포터 수 갱신
                    cumulativeSupporterCounts.add(cumulativeSupporterCount); // 누적 서포터 수 추가
                    dailySupporterCounts.add(supporterData.getCount()); // 일별 서포터 수 추가
                    supporterIndex++; // 다음 서포터 수 데이터로 이동
                    continue;
                }
            }
            dailySupporterCounts.add(0); // 누락된 날짜에 대해 0으로 처리된 일별 서포터 수 추가
            cumulativeSupporterCounts.add(cumulativeSupporterCount); // 이전의 누적 서포터 수 추가 (이전 데이터를 그대로 사용)
        }

        // ChartDataVO 객체를 생성하여 라벨, 일별 결제 금액, 누적 결제 금액, 일별 서포터 수, 누적 서포터 수를 담아 반환
        return new ChartDataVO(labels, dailyPaymentAmounts, cumulativePaymentAmounts, dailySupporterCounts, cumulativeSupporterCounts);
    }
	
}
