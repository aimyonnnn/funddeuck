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
    
    //����媛��� ���댁�濡� �대��
    @GetMapping("JoinForm")
    public String JoinForm(HttpSession session, Model model) {
    	
    	// session�� 議댁�ы���ㅻ㈃ ��洹쇰�媛�
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "��紐삳�� ��洹쇱������.");
    		return "fail_back";
    	}
    	
    	return "join";
    }
    
    //���� 媛���
    @PostMapping("JoinPro")
    public String JoinPro(MembersVO member, HttpSession session, Model model) {
    	
    	// session�� 議댁�ы���ㅻ㈃ ��洹쇰�媛�
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "��紐삳�� ��洹쇱������.");
    		return "fail_back";
    	}
    	
    	int insertCount = service.insertMember(member);
    	
    	if(insertCount > 0) {
    		return "redirect:/";
    	} else {
    		model.addAttribute("msg", "����媛��� �ㅽ��");
    		return "fail_back";
    	}
    	
    }
    
    //濡�洹몄�� ���댁� �대��
    @GetMapping("LoginForm")
    public String LoginForm(HttpSession session, Model model) {
    	
    	// session�� 議댁�ы���ㅻ㈃ ��洹쇰�媛�
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
    	
    	//id�� 鍮�諛�踰��몄“��瑜� �듯�� 濡�洹몄�몄����
    	MembersVO isMember = service.getMemberInfo(member.getMember_id());

    		
    	if(isMember == null){
    		model.addAttribute("msg", "���대��媛� 議댁�ы��吏� ���듬����.");
    		return "fail_back";
    	}else if(isMember.getFalse_count()>=4) {
    			model.addAttribute("msg", "5�� �댁�� ��由� ���대�� ������.\\n鍮�諛�踰��몄갼湲곕�� 吏����댁＜�몄��");
    		return "fail_back";
    	} else if(isMember.getMember_passwd().equals(member.getMember_passwd())) {
    		
    		isMember.setFalse_count(0);
    		service.updateFailCount(isMember);
    		session.setAttribute("sId", member.getMember_id());
    		return "redirect:/";
    	}
    	isMember.setFalse_count(isMember.getFalse_count()+1);
    	service.updateFailCount(isMember);
		model.addAttribute("msg", "���대�� ���� 鍮�諛�踰��멸� �쇱���吏� ���듬����.\\n"+isMember.getFalse_count()+"�� ���몄�듬����. 5����由댁�� 濡�洹몄�몄�� 遺�媛��⑸����.");
		return "fail_back";
    	
    }
    
    @GetMapping("LogOut")
    public String LogOut(HttpSession session) {
    	session.invalidate();
    	
    	return "redirect:/";
    }
    
    //ajax瑜� �듯�� id以�蹂� ����
    @PostMapping("idDuplicate")
    @ResponseBody
    public String idDuplicate(@RequestParam String id) {
    	
    	MembersVO member = service.getMemberInfo(id);
    	
    	if(member==null) {
    		return "true";
    	}
    	
    	return "false";
    } 
    
    //ajax瑜� �듯�� email 以�蹂듯���� 諛� 諛��� 諛� �щ���
    @PostMapping("emailDuplicate")
    @ResponseBody
    public String emailDuplicate(@RequestParam String email) {
    	
    	String authCode = generateRandomNumbers(6);
    	
    	new Thread(new Runnable() {
			
			@Override
			public void run() {
				System.out.println("�ш린��");
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
    
    //�대��� 肄���媛� �쇱���吏� ����
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
    
	// ���� 肄��� ����
    public static String generateRandomNumbers(int count) {
        StringBuilder number = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < count; i++) {
            // 0 �댁�� 9 �댄���� ���� �レ�� ����
            int digit = random.nextInt(10);
            number.append(digit);
        }

        return number.toString();
    }
    
}
