package com.itwillbs.test.controller;

import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@Controller
public class FundingController {
	
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
	public String fundingOrder() {
		return "funding/funding_order";
	}
	
}
