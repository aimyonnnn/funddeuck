package com.itwillbs.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.test.service.CouponService;
import com.itwillbs.test.vo.CouponVO;

import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
public class CouponController {

    @Autowired
    private CouponService couponService;

    @GetMapping("/member/coupon")
    public String showCouponPage(HttpSession session, Model model) {
        CouponVO couponInfo = (CouponVO) session.getAttribute("couponInfo");
        if (couponInfo != null) {
            model.addAttribute("couponInfo", couponInfo);
        }

        List<CouponVO> usedCoupons = couponService.getUsedCoupons();
        model.addAttribute("usedCoupons", usedCoupons);

        return "member/member_coupon";
    }
    
    @PostMapping("/member/coupon-info")
    @ResponseBody
    public List<CouponVO> getCouponsByNum(@RequestParam("coupon_num") String couponNum, HttpSession session) {
        System.out.println("coupon_num" + couponNum);
        List<CouponVO> coupons = couponService.getCouponsByNumAndUse(couponNum, 0);
        if (!coupons.isEmpty()) {
            // 세션에 쿠폰 정보 저장
            session.setAttribute("couponInfo", coupons);
        }
        return coupons;
    }
    
    
    @PostMapping("/admin/saveCoupon")
    @ResponseBody
    public void saveCoupon(@RequestBody CouponVO couponVO) {
        couponService.saveCoupon(couponVO);
    }
    
    @GetMapping("/admin/coupon")
    public String showAdminCouponPage(Model model) {
        List<CouponVO> couponList = couponService.getAllCoupons();
        model.addAttribute("couponList", couponList);
        return "admin/admin_coupon";
    }
}
