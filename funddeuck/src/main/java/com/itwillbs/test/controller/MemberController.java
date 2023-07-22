package com.itwillbs.test.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.ProfileService;
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.ProfileVO;

@Controller
public class MemberController {

    private final ProfileService profileService;
    
    @Autowired
    private MemberService service;

    @Autowired
    public MemberController(ProfileService profileService) {
        this.profileService = profileService;
    }

//    @GetMapping("/member/profile")
//    public String getMemberProfile(Model model) {
//        int memberIdx = 1;
//        ProfileVO profileVO = profileService.getProfileData(memberIdx);
//        model.addAttribute("profile", profileVO);
//        return "/member/member_profile";
//    }

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
    
    //회원가입 뷰로 이동하기 위한 Mapping
    @GetMapping("JoinForm")
    public String JoinForm(HttpSession session, Model model) {
    	
    	// session에 id가 존재한다면 접근 불가
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	return "join";
    }
    
    //회원가입기능
    @PostMapping("JoinPro")
    public String JoinPro(MembersVO member, HttpSession session, Model model) {
    	
    	// session에 id가 존재한다면 접근 불가
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	// 회원가입
    	int insertCount = service.insertMember(member);
    	
    	if(insertCount > 0) {
    		return "redirect:/";
    	} else {
    		model.addAttribute("msg", "회원가입실패");
    		return "fail_back";
    	}
    	
    }
    
    //로그린 폼으로 이동
    @GetMapping("LoginForm")
    public String LoginForm(HttpSession session, Model model) {
    	
    	// session에 id가 존재한다면 접근 불가
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	return "login";
    }
    
    //로그인
    @PostMapping("LoginPro")
    public String LoginPro(MembersVO member, HttpSession session, Model model) {
    	
    	System.out.println(member);
    	
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	//id가 일치한 회원 정보 가져오기
    	MembersVO isMember = service.getMemberInfo(member.getMember_id());
    	if(isMember == null){
    		session.setAttribute("sId", member.getMember_id());
    		model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
    		return "fail_back";
    	}else if(isMember.getMember_passwd().equals(member.getMember_passwd())) {
    		return "redirect:/";
    	}
		model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		return "fail_back";
    	
    }
    
}
