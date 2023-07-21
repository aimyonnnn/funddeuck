package com.itwillbs.test.controller;

import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.test.service.*;
import com.itwillbs.test.vo.*;

@Controller
public class FundingController {
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService memberService;
	
	// 펀딩 탐색 페이지
	@GetMapping("fundingDiscover")
	public String fundingDiscoverForm() {
		return "funding/funding_discover";
	}
	
	// 펀딩 상세페이지 이동
	@GetMapping ("fundingDetail")
	public String fundingDetail() {
		return "funding/funding_detail";
	}
	
	// 펀딩 주문페이지 이동
	@GetMapping ("fundingOrder")
	public String fundingOrder(Model model) {
//		public String fundingOrder(@RequestParam int project_idx, @RequestParam int reward_idx, HttpSession session) {
		// session에 저장되어있는 회원아이디 가져오기
//		String id = (String)session.getAttribute("sId");
		// 아이디(가데이터)
		String id = "honggd";
		// 프로젝트 번호(가데이터)
		int project_idx = 1;
		// 상세페이지에서 고른 리워드번호 필요(가데이터)
		int reward_idx = 1;
		// 회원 정보 불러오기
		MembersVO member = memberService.getMemberInfo(id);
		System.out.println(member);
		// 프로젝트 정보 불러오기
		ProjectVO project = projectService.getProjectInfo(project_idx);
		System.out.println(project);
		// 선택한 리워드 정보 불러오기
		RewardVO reward = projectService.getRewardInfo(reward_idx);
		System.out.println(reward);
		// 리워드 리스트 불러오기
		List<RewardVO> rewardList = projectService.getRewardList(project_idx);
		System.out.println(rewardList);
		model.addAttribute("member", member);
		model.addAttribute("project", project);
		model.addAttribute("reward", reward);
		model.addAttribute("rewardList", rewardList);
		return "funding/funding_order";
	}
		
}
