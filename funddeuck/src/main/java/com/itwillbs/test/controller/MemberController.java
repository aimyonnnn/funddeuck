package com.itwillbs.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.ProfileService;
import com.itwillbs.test.vo.ProfileVO;

@Controller
public class MemberController {

    private final ProfileService profileService;

    @Autowired
    public MemberController(ProfileService profileService) {
        this.profileService = profileService;
    }

    @GetMapping("/member/profile")
    public String getMemberProfile(Model model) {
        int memberIdx = 1;
        ProfileVO profileVO = profileService.getProfileData(memberIdx);
        model.addAttribute("profile", profileVO);
        return "/member/member_profile";
    }

    @PostMapping("/member/profile")
    @ResponseBody
    public String saveMemberProfile(@ModelAttribute ProfileVO profileVO) {
    	System.out.println("saveMemberProfile");
        profileService.saveProfileData(profileVO);
        return "true";
    }
    
    @GetMapping("/member/mypage")
    public String myPage() {
        return "member/myPage"; 
    }
    
    @GetMapping("/member/coupon")
    public String Coupon() {
    	return "member/member_coupon";
    }
    
}
