package com.itwillbs.test.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.vo.MembersVO;

@Controller
public class MemberController {

    @Autowired
    private MemberService service;


    @GetMapping("/member/mypage")
    public String myPage() {
        return "member/myPage"; 
    }
    
    @GetMapping("/member/coupon")
    public String Coupon() {
    	return "member/member_coupon";
    }
    
    //����媛��� 酉곕� �대����湲� ���� Mapping
    @GetMapping("JoinForm")
    public String JoinForm(HttpSession session, Model model) {
    	
    	// session�� id媛� 議댁�ы���ㅻ㈃ ��洹� 遺�媛�
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "��紐삳�� ��洹쇱������.");
    		return "fail_back";
    	}
    	
    	return "join";
    }
    
    //����媛���湲곕��
    @PostMapping("JoinPro")
    public String JoinPro(MembersVO member, HttpSession session, Model model) {
    	
    	// session�� id媛� 議댁�ы���ㅻ㈃ ��洹� 遺�媛�
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "��紐삳�� ��洹쇱������.");
    		return "fail_back";
    	}
    	
    	// ����媛���
    	int insertCount = service.insertMember(member);
    	
    	if(insertCount > 0) {
    		return "redirect:/";
    	} else {
    		model.addAttribute("msg", "����媛����ㅽ��");
    		return "fail_back";
    	}
    	
    }
    
    //濡�洹몃┛ �쇱�쇰� �대��
    @GetMapping("LoginForm")
    public String LoginForm(HttpSession session, Model model) {
    	
    	// session�� id媛� 議댁�ы���ㅻ㈃ ��洹� 遺�媛�
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "��紐삳�� ��洹쇱������.");
    		return "fail_back";
    	}
    	
    	return "login";
    }
    
    //濡�洹몄��
    @PostMapping("LoginPro")
    public String LoginPro(MembersVO member, HttpSession session, Model model) {
    	
    	System.out.println(member);
    	
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "��紐삳�� ��洹쇱������.");
    		return "fail_back";
    	}
    	
    	//id媛� �쇱��� ���� ��蹂� 媛��몄�ㅺ린
    	MembersVO isMember = service.getMemberInfo(member.getMember_id());
    	if(isMember == null){
    		session.setAttribute("sId", member.getMember_id());
    		model.addAttribute("msg", "���대�� ���� 鍮�諛�踰��멸� �쇱���吏� ���듬����.");
    		return "fail_back";
    	}else if(isMember.getMember_passwd().equals(member.getMember_passwd())) {
    		return "redirect:/";
    	}
		model.addAttribute("msg", "���대�� ���� 鍮�諛�踰��멸� �쇱���吏� ���듬����.");
		return "fail_back";
    	
    }
    
    //���대�� ���몄�� ���� ajax 援щЦ
    @PostMapping("idDuplicate")
    @ResponseBody
    public String idDuplicate(@RequestParam String id) {
    	
    	MembersVO member = service.getMemberInfo(id);
    	
    	if(member==null) {
    		return "true";
    	}
    	
    	return "false";
    } 
    
}
