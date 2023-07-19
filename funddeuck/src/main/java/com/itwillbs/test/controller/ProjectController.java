package com.itwillbs.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.RewardVO;

@Controller
public class ProjectController {
	
	@Autowired
	private ProjectService projectService;
	
	// 리워드 등록
	@GetMapping("projectReward")
	public String projectReward() {
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
	
	// 프로젝트 탐색 페이지
	@GetMapping("projectDiscover")
	public String projectDiscoverForm() {
		return "project/project_discover";
	}
	
	// 리워드 추가하기
	@PostMapping("saveReward")
    @ResponseBody
    public String saveReward(@RequestBody List<RewardVO> rewardList) {
		System.out.println("saveReward");
		System.out.println(rewardList);
		
		if(rewardList.isEmpty()) {
			System.out.println("isEmpty()");
			return "false";
		}
		
		int insertCount = 0;
		for(RewardVO reward : rewardList) {
			boolean isSuccess = projectService.registReward(reward);
			if(isSuccess) insertCount++;
		}
		if(insertCount > 0) return "true";
        return "false";
    }
	
	// 메이커 등록 페이지
	@GetMapping("makerInfo")
	public String makerInfo() {
		return "project/maker_info";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
