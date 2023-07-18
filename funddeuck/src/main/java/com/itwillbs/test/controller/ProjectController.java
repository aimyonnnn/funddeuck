package com.itwillbs.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ProjectController {
	
	@GetMapping("projectReward")
	public String projectReward() {
		return "project/project_reward";
	}
	
	@GetMapping("projectStatus")
	public String projectStatus() {
		return "project/project_status";
	}
	
}
