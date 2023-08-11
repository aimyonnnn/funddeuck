package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.test.service.CouponService;
import com.itwillbs.test.vo.CouponBannerVO;
import com.itwillbs.test.vo.CouponVO;

@Controller
public class CouponController {
	
    @Autowired
    private CouponService couponService;

    @GetMapping("/adminCoupon")
    public String adminCoupon(HttpSession session, Model model) {
        // 세션에서 로그인 정보를 가져옴
        Integer memberIdx = (Integer) session.getAttribute("sIdx");
        
        // 로그인 정보가 없거나 memberIdx가 1(admin의 member_idx이용)이 아니면 메인 화면으로 리다이렉트
        if (memberIdx == null || memberIdx != 1) {
            return "redirect:/";
        }

        // 쿠폰 목록을 조회하여 모델에 추가
        List<CouponVO> couponList = couponService.getCouponList();
        model.addAttribute("couponList", couponList);
        
        // admin/coupon 페이지로 이동
        return "admin/admin_coupon";
    }

    @PostMapping("/saveCoupon")
    @ResponseBody
    public String saveCoupon(@RequestBody CouponVO couponVO) {
        couponService.registerCoupon(couponVO);
        return "success";
    }
    
    @PostMapping("/processExpiredCoupons")
    @ResponseBody
    public List<CouponVO> processExpiredCoupons() {
        List<CouponVO> expiredCoupons = couponService.getExpiredCoupons();

        for (CouponVO coupon : expiredCoupons) {
            coupon.setCoupon_use(1);
            couponService.updateCoupon(coupon);
        }

        return couponService.getCouponList();
    }
    
    @GetMapping("/expiredCoupons")
    public String getExpiredCoupons(Model model) {
        List<CouponVO> expiredCoupons = couponService.getExpiredCoupons();
        model.addAttribute("expiredCouponList", expiredCoupons);
        
        return "admin/expired_coupons";
    }

    //-------------------------------------------------------------------------------------
    
    @GetMapping("/coupon")
    public String memberCoupon(HttpSession session, Model model) {
    	Integer memberIdx = (Integer) session.getAttribute("sIdx");
    
        if (memberIdx == null ) {
            return "redirect:/";
        }	

        List<CouponVO> couponList = couponService.getCouponsByMemberAndStatus(memberIdx, 0);
        List<CouponVO> usedCoupons = couponService.getUsedCoupons(memberIdx);

        model.addAttribute("couponList", couponList);
        model.addAttribute("usedCoupons", usedCoupons);

    	return "member/member_coupon";	
    }
    
    @PostMapping("/coupon-info")
    @ResponseBody
    public ResponseEntity<CouponVO> getCouponInfo(@RequestParam("couponNumber") String couponNumber, HttpSession session) {
        CouponVO couponInfo = couponService.getCouponInfoByNumber(couponNumber);

        if (couponInfo != null) {
            Integer memberIdx = (Integer) session.getAttribute("sIdx");
            if (memberIdx != null) {
                couponInfo.setMember_idx(memberIdx); 
                couponService.registerCoupon(couponInfo); 
            }
            return ResponseEntity.ok(couponInfo);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    
    //---------------------------------------------------------------------------------------
    @PostMapping("/saveCouponBanner")
    @ResponseBody
    public String saveCouponBanner(@ModelAttribute CouponBannerVO couponBannerVO, @RequestParam(name = "fileName", required = false) String uploadedFileName, HttpSession session, Model model) {
    	String fileName = null;
    	String data = "success";
        // 쿠폰 광고 등록 로직 추가
        couponService.insertCouponBanner(couponBannerVO, fileName, session); // 파일 이름을 함께 전달
        System.out.println("확인3");                

        String targetURL = "adminCoupon"; 
        model.addAttribute("msg", "쿠폰 광고 등록이 완료되었습니다.");
        model.addAttribute("targetURL", targetURL);
        System.out.println("확인4");
        return data;
    }
    
    @GetMapping("/couponList")
    @ResponseBody
    public List<CouponBannerVO> getCouponList() {
    	System.out.println("확인6");
        List<CouponBannerVO> newCouponList = couponService.getNewCouponList();
        return newCouponList;
    }

    
   }
  

