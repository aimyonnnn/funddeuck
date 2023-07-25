package com.itwillbs.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.CouponService;
import com.itwillbs.test.vo.CouponVO;

@Controller
public class CouponController {
	
	private final CouponService couponService;

    @Autowired
    public CouponController(CouponService couponService) {
        this.couponService = couponService;
    }
    
    @GetMapping("/member/coupon")
    public String coupon() {
    	return "member/member_coupon";
    }
//    @GetMapping("/member/coupon")
//    @ResponseBody
//    public String getCouponByNumber(@RequestParam("coupon_num") String coupon_num, Model model) {
//        CouponVO coupon = couponService.getCouponByNumber(coupon_num);
//        if (coupon != null) {
//            model.addAttribute("coupon", coupon);
//        } else {
//            model.addAttribute("message", "쿠폰을 찾을 수 없습니다.");
//        }
//        return "member/member_coupon"; 
//    }
}



