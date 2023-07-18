package com.itwillbs.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProjectController {
	
	// 리워드 관리
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
	
	
}
