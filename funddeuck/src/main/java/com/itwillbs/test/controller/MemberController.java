package com.itwillbs.test.controller;

import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.SendMailService;
import com.itwillbs.test.vo.MembersVO;

@Controller
public class MemberController {

    @Autowired
    private MemberService service;
    
    @Autowired
    private SendMailService mailService;
    
    @GetMapping("/member/mypage")
    public String myPage() {
        return "member/myPage"; 
    }
    
    @GetMapping("/member/coupon")
    public String Coupon() {
    	return "member/member_coupon";
    }
    
    //회원가입 페이지로 이동
    @GetMapping("JoinForm")
    public String JoinForm(HttpSession session, Model model) {
    	
    	// session이 존재한다면 접근불가
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	return "join";
    }
    
    //회원 가입
    @PostMapping("JoinPro")
    public String JoinPro(MembersVO member, HttpSession session, Model model) {
    	
    	// session이 존재한다면 접근불가
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	int insertCount = service.insertMember(member);
    	
    	if(insertCount > 0) {
    		return "redirect:/";
    	} else {
    		model.addAttribute("msg", "회원가입 실패");
    		return "fail_back";
    	}
    	
    }
    
    //로그인 페이지 이동
    @GetMapping("LoginForm")
    public String LoginForm(HttpSession session, Model model) {
    	
    	// session이 존재한다면 접근불가
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
    	
    	//id와 비밀번호조회를 통한 로그인작업
    	MembersVO isMember = service.getMemberInfo(member.getMember_id());
    	if(isMember == null){
    		model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
    		return "fail_back";
    	}else if(isMember.getMember_passwd().equals(member.getMember_passwd())) {
    		session.setAttribute("sId", member.getMember_id());
    		return "redirect:/";
    	}
		model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
		return "fail_back";
    	
    }
    
    //ajax를 통한 id중복 확인
    @PostMapping("idDuplicate")
    @ResponseBody
    public String idDuplicate(@RequestParam String id) {
    	
    	MembersVO member = service.getMemberInfo(id);
    	
    	if(member==null) {
    		return "true";
    	}
    	
    	return "false";
    } 
    
    //ajax를 통한 email 중복확인 및 발송 및 재발송
    @PostMapping("emailDuplicate")
    @ResponseBody
    public String emailDuplicate(@RequestParam String email) {
    	
    	String authCode = generateRandomNumbers(6);
    	
    	new Thread(new Runnable() {
			
			@Override
			public void run() {
				System.out.println("여기옴");
				mailService.sendAuthMail(email, authCode);
			}
		}).start();
    	
    	
    	if(authCode == null || authCode.equals("")) {
    		return "false";
    	}
    	
    	int isEmail = service.selectEmail(email);
    	
    	if(isEmail > 0) {
    		int updateCount = service.updateAuthCode(email, authCode);
    		if(updateCount > 0) {
    			return "true";
    		} else {
    			return "false";
    		}
    	} else {
    		int insertCount = service.emailDuplicate(email, authCode);
    		if(insertCount > 0) {
    			return "true";
    		} else {
    			return "false";
    		}
    	}
    }
    
    //이메일 코드가 일치한지 확인
    @PostMapping("certificationAuthCode")
    @ResponseBody
    public String certificationAuthCode(@RequestParam String email, @RequestParam String authCode) {
    	
    	if(email == null || email.equals("") || authCode == null || authCode.equals("")) {
    		return "false";
    	}
    	
    	int selectCount = service.isAuthCode(email, authCode);
    	
    	System.out.println("selectCount" + selectCount);
    	
    	if(selectCount > 0) {
    		
    		int deleteCount = service.authCodeDelete(email, authCode);
    		
    		System.out.println("deleteCount"+deleteCount);
    		
    		if(deleteCount > 0) {
    			return "true";
    		}
    		
    		return "false";
    	}
    	
    	return "false";
    }
    
	// 랜덤 코드 생성
    public static String generateRandomNumbers(int count) {
        StringBuilder number = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < count; i++) {
            // 0 이상 9 이하의 랜덤 숫자 생성
            int digit = random.nextInt(10);
            number.append(digit);
        }

        return number.toString();
    }
    
}
