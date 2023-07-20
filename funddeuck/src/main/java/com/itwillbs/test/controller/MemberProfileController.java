package com.itwillbs.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class MemberProfileController {

    @GetMapping("/member/profile")
    public String getMemberProfile() {
        return "/member/member_profile";
    }
    
}
