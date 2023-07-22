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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;

@Controller
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MakerService makerService;
	
	// 리워드 등록하기
	@GetMapping("projectReward")
	public String projectReward(@RequestParam(required = false) Integer reward_idx, HttpSession session, Model model) {
		
		// 세션 아이디가 존재하지 않을 때 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 수정 버튼을 눌렀을 때 - reward_idx가 존재하면 해당 리워드 정보 조회
		if (reward_idx != null) {
			System.out.println("수정하기 버튼 클릭 시 - 리워드 번호 : " + reward_idx);
			
			// 리워드 작성자 판별 요청
//		    String rewardWriter = projectService.getRewardAuthorId(reward_idx); // 리워드 작성자의 아이디를 조회
			
			
	        RewardVO reward = projectService.getRewardInfo(reward_idx);
	        model.addAttribute("reward", reward);
	    }
		return "project/project_reward";
	}
	
	// 프로젝트 현황
	@GetMapping("projectStatus")
	public String projectStatus() {
		return "project/project_status";
	}
	
	// 리워드 추가하기
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
	public String removeReward(@RequestParam int reward_idx) {
		System.out.println("reward_idx : " + reward_idx);
		int deleteCount = projectService.removeReward(reward_idx);
		System.out.println("deleteCount : " + deleteCount);
		if(deleteCount > 0) { return "true"; } return "false";
	}
	
	// 리워드 갯수 조회하기
	@GetMapping("rewardCount")
	@ResponseBody
	public String rewardCount(@RequestParam int project_idx) {
		System.out.println("rewardCount() - project_idx : " + project_idx);
		int rewardCount = projectService.getRewardCount(project_idx);
		return rewardCount+"";
	}
	
	// 리워드 리스트 조회하기
	@GetMapping("rewardList")
	@ResponseBody
	public List<RewardVO> rewardList(@RequestParam int project_idx) {
	    System.out.println("rewardList() - project_idx: " + project_idx);
	    List<RewardVO> rList = projectService.getRewardList(project_idx);
	    return rList;
	}
	
	// 메이커 등록 페이지
	@GetMapping("projectMaker")
	public String makerInfo() {
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
			model.addAttribute("msg", "메이커 등록에 성공하였습니다. 프로젝트 등록 페이지로 이동합니다.");
			model.addAttribute("targetURL", "projectManagement");
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
	public String projectManagement() {
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
			String targetURL = "projectReward";
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
	public String projectShipping() {
		return "project/project_shipping";
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
	
	
	
	
	
	
	
	
	
}
