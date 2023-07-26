package com.itwillbs.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


import com.itwillbs.test.service.CouponService;

@Controller
@RequestMapping("/member")
public class CouponController {
    private final CouponService couponService;

    public CouponController(CouponService couponService) {
        this.couponService = couponService;
    }

    @GetMapping("/couponmain")
    public String main() {
    	return "/member/member_coupon";
    }
}
