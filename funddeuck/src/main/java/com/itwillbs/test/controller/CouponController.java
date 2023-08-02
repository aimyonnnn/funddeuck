package com.itwillbs.test.controller;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.CouponService;
import com.itwillbs.test.vo.CouponVO;

@Controller
public class CouponController {
	
    @Autowired
    private CouponService couponService;

    @GetMapping("/admin/coupon")
    public String adminCoupon(HttpSession session, Model model) {
        // 세션에서 로그인 정보를 가져옴
        Integer memberIdx = (Integer) session.getAttribute("sIdx");
        
        // 로그인 정보가 없거나 memberIdx가 3이 아니면 메인 화면으로 리다이렉트
        if (memberIdx == null || memberIdx != 3) {
            return "redirect:/";
        }

        // 쿠폰 목록을 조회하여 모델에 추가
        List<CouponVO> couponList = couponService.getCouponList();
        model.addAttribute("couponList", couponList);
        
        // admin/coupon 페이지로 이동
        return "admin/admin_coupon";
    }

    @PostMapping("/admin/saveCoupon")
    @ResponseBody
    public String saveCoupon(@RequestBody CouponVO couponVO) {
        couponService.registerCoupon(couponVO);
        return "success";
    }
    
    @PostMapping("/admin/processExpiredCoupons")
    @ResponseBody
    public List<CouponVO> processExpiredCoupons() {
        List<CouponVO> expiredCoupons = couponService.getExpiredCoupons();

        for (CouponVO coupon : expiredCoupons) {
            coupon.setCoupon_use(1);
            couponService.updateCoupon(coupon);
        }

        return couponService.getCouponList();
    }
    
    @GetMapping("/admin/expiredCoupons")
    public String getExpiredCoupons(Model model) {
        List<CouponVO> expiredCoupons = couponService.getExpiredCoupons();
        model.addAttribute("expiredCouponList", expiredCoupons);
        
        return "admin/expired_coupons";
    }


    
    
}
