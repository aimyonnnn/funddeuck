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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.RewardVO;

@Controller
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	
	// 리워드 등록
	@GetMapping("projectReward")
	public String projectReward(@RequestParam(required = false) Integer reward_idx, Model model) {
		if (reward_idx != null) {
	        // 수정 버튼을 눌렀을 때 - reward_idx가 존재하면 해당 리워드 정보 조회
	        RewardVO reward = projectService.getRewardInfo(reward_idx);
	        model.addAttribute("reward", reward);
	    }
		return "project/project_reward";
	}
	
	// 프로젝트, 결제 현황
	@GetMapping("projectStatus")
	public String projectStatus() {
		return "project/project_status";
	}
	
	// 메이커 페이지 디테일
	@GetMapping("makerDetail")
	public String makerDetail() {
		return "project/maker_detail";
	}
	
	// 리워드 추가하기
	@PostMapping("saveReward")
    @ResponseBody
    public String saveReward(@ModelAttribute RewardVO reward) {
		System.out.println("saveReward");
		int insertCount = projectService.registReward(reward);
		System.out.println("insertCount : " + insertCount);
		if(insertCount > 0) return "true";
        return "false";
    }
	
	// 리워드 수정하기
	@PostMapping("modifyReward")
    @ResponseBody
    public String modifyReward(@ModelAttribute RewardVO reward, @RequestParam int reward_idx) {
		System.out.println("reward_idx : " + reward_idx);
		int updateCount = projectService.modifyReward(reward);
		System.out.println("updateCount : " + updateCount);
		if(updateCount > 0) return "true";
        return "false";
    }
	
	// 리워드 삭제하기
	@PostMapping("removeReward")
	@ResponseBody
	public String removeReward(@RequestParam int reward_idx) {
		System.out.println("reward_idx : " + reward_idx);
		int deleteCount = projectService.removeReward(reward_idx);
		System.out.println("deleteCount : " + deleteCount);
		if(deleteCount > 0) return "true";
		return "false";
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
	
	// 메이커 등록 비즈니스 로직처리
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
			// 리다이렉트
			return "redirect:/projectMaker";
		} else { // 실패
			model.addAttribute("msg", "메이커 등록 실패!");
			return "fail_back";
		}
		
	}
	
	// 프로젝트 등록 페이지
	@GetMapping("projectManagement")
	public String projectManagement() {
		return "project/project_management";
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
	
	
	
	
	
	
	
	
}
