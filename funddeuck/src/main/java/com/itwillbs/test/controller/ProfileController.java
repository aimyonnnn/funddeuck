package com.itwillbs.test.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.ProfileService;
import com.itwillbs.test.vo.ProfileVO;

@Controller
public class ProfileController {

    @Autowired
    private ProfileService profileService;

    //프로필 매핑
    @GetMapping("/member/profile")
    public String profile() {
    	return "member/member_profile";
    }
    
    @PostMapping("/member/profile")
    @ResponseBody
    public ResponseEntity<String> saveProfile(@RequestBody ProfileVO profileVO) {
        try {
            profileService.saveProfile(profileVO);
            return ResponseEntity.ok("프로필이 저장되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("프로필 저장에 실패했습니다.");
        }
    }
}


