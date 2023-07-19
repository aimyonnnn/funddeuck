package com.itwillbs.test.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class FundingController {
	
	// 펀딩 상세페이지 이동
	@GetMapping ("fundingDetail")
	public String fundingDetail() {
		return "funding/funding_detail";
	}
}
