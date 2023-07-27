package com.itwillbs.test.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.handler.MyPasswordEncoder;
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
    
    //�쉶�썝媛��엯 �럹�씠吏�濡� �씠�룞
    @GetMapping("JoinForm")
    public String JoinForm(HttpSession session, Model model) {
    	
    	// session�씠 議댁옱�븳�떎硫� �젒洹쇰텋媛�
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    		return "fail_back";
    	}
    	
    	return "join";
    }
    
    //�쉶�썝 媛��엯
    @PostMapping("JoinPro")
    public String JoinPro(MembersVO member, HttpSession session, Model model) {
    	
        	// session�씠 議댁옱�븳�떎硫� �젒洹쇰텋媛�
	if(session.getAttribute("sId") != null) {
    	model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    	return "fail_back";
    	}
	
		// ------------ BCryptPasswordEncoder 媛앹껜 �솢�슜�븳 �뙣�뒪�썙�뱶 �븫�샇�솕(= �빐�떛) --------------
		// => MyPasswordEncoder �겢�옒�뒪�뿉 紐⑤뱢�솕
		// 1. MyPasswordEncoder 媛앹껜 �깮�꽦
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 硫붿꽌�뱶�뿉 �룊臾� �쟾�떖�븯�뿬 �븫�샇臾� �뼸�뼱�삤湲�
		String securePasswd = passwordEncoder.getCryptoPassword(member.getMember_passwd());
		// 3. 由ы꽩諛쏆� �븫�샇臾몄쓣 MemberVO 媛앹껜�뿉 �뜮�뼱�벐湲�
		member.setMember_passwd(securePasswd);
		// -------------------------------------------------------------------------------------
    	
    	int insertCount = service.insertMember(member);
    	
    	if(insertCount > 0) {
    		return "redirect:/";
    	} else {
    		model.addAttribute("msg", "�쉶�썝媛��엯 �떎�뙣");
    		return "fail_back";
    	}
    	
    }
    
    //濡쒓렇�씤 �럹�씠吏� �씠�룞
    @GetMapping("LoginForm")
    public String LoginForm(HttpSession session, Model model) {
    	
    	// session�씠 議댁옱�븳�떎硫� �젒洹쇰텋媛�
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    		return "fail_back";
    	}
    	
    	return "login";
    }
    
    //濡쒓렇�씤
    @PostMapping("LoginPro")
    public String LoginPro(MembersVO member, HttpSession session, Model model) {
    	
    	System.out.println(member);
    	
    	if(session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    		return "fail_back";
    	}
    	
    	//1. BCryptPasswordEncoder 媛앹껜 �깮�꽦
    	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    	
    	
    	//id�� 鍮꾨�踰덊샇議고쉶瑜� �넻�븳 濡쒓렇�씤�옉�뾽
    	MembersVO isMember = service.getMemberInfo(member.getMember_id());

    		
    	if(isMember == null){
    		model.addAttribute("msg", "�븘�씠�뵒媛� 議댁옱�븯吏� �븡�뒿�땲�떎.");
    		return "fail_back";
    	}else if(isMember.getFalse_count()>=4) {
    			model.addAttribute("msg", "5�쉶 �씠�긽 ��由� �븘�씠�뵒 �엯�땲�떎.\\n鍮꾨�踰덊샇李얘린瑜� 吏꾪뻾�빐二쇱꽭�슂");
    		return "fail_back";
    	} else if(passwordEncoder.matches(member.getMember_passwd(), isMember.getMember_passwd())) {
    		
    		isMember.setFalse_count(0);
    		service.updateFailCount(isMember);
    		session.setAttribute("sId", member.getMember_id());
    		return "redirect:/";
    	}
    	isMember.setFalse_count(isMember.getFalse_count()+1);
    	service.updateFailCount(isMember);
		model.addAttribute("msg", "�븘�씠�뵒 �삉�뒗 鍮꾨�踰덊샇媛� �씪移섑븯吏� �븡�뒿�땲�떎.\\n"+isMember.getFalse_count()+"�쉶 ���졇�뒿�땲�떎. 5�쉶��由댁떆 濡쒓렇�씤�씠 遺덇��빀�땲�떎.");
		return "fail_back";
    	
    }
    
    //濡쒓렇�븘�썐
    @GetMapping("LogOut")
    public String LogOut(HttpSession session) {
    	session.invalidate();
    	
    	return "redirect:/";
    }
    
  //ajax瑜� �넻�븳 id以묐났 �솗�씤
    @PostMapping("idDuplicate")
    @ResponseBody
    public String idDuplicate(@RequestParam String id) {
    	
    	MembersVO member = service.getMemberInfo(id);
    	
    	if(member==null) {
    		return "true";
    	}
    	
    	return "false";
    } 
    
  //ajax瑜� �넻�븳 email 以묐났�솗�씤 諛� 諛쒖넚 諛� �옱諛쒖넚
    @PostMapping("emailDuplicate")
    @ResponseBody
    public String emailDuplicate(@RequestParam String email) {
    	
    	int isMemberEmail = service.selectMemberEmail(email);
    	
    	if(isMemberEmail > 0) {
    		return "duplication";
    	}
    	
    	String authCode = generateRandomNumbers(6);
    	
    	new Thread(new Runnable() {
			
			@Override
			public void run() {
				System.out.println("�뿬湲곗샂");
				mailService.sendAuthMail(email, authCode);
			}
		}).start();
    	
    	
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
    
    //�씠硫붿씪 肄붾뱶媛� �씪移섑븳吏� �솗�씤
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
    
    // �븘�씠�뵒 李얘린 form �쑝濡� �씠�룞
    @GetMapping("idFindForm")
    public String idFindForm() {
    	return "Login/id_find";
    }
    
    // �븘�씠�뵒 李얘린
    @PostMapping("idFindPro")
    @ResponseBody
    public Map<String, Object> idFindPro(@RequestParam String email) {
    	
    	Map<String, Object> map = new HashMap<>();
    	
    	System.out.println(email);
    	
    	
    	MembersVO member = service.getMemberInfoEmail(email);
    	
    	if(member == null) {
    		map.put("result", "false");
    		return map;
    	}
    	
    	map.put("result", "true");
    	map.put("member", member);
    	
    	return map;
    }
    
    // 鍮꾨�踰덊샇 李얘린 form �쑝濡� �씠�룞
    @GetMapping("passwdFindForm")
    public String passwdFindForm() {
    	return "Login/passwd_find";
    }
    
    //�럹�뒪�썙�뱶 李얘린 ajax
    @PostMapping("passwdFindPro")
    @ResponseBody
    public Map<String,Object> passwdFindPro(@RequestParam String email, @RequestParam String id){
    	
    	Map<String, Object> map = new HashMap<>();
    	
    	
    	MembersVO member = service.getMemberInfo(id);
    	
    	if(member.getMember_email().equals(email)) {
	    	UUID uuid = UUID.randomUUID();
	    	
	    	String authCode = uuid.toString().split("-")[4];
	    	
	    	new Thread(new Runnable() {
				
				@Override
				public void run() {
					mailService.sendPasswdMail(email, authCode);
				}
			}).start();
	    	
	    	map.put("result", "true");
	    	map.put("url", email.split("@")[1]);
	    	
	    	int isEmail = service.selectEmail(email);
	    	
			if (isEmail > 0) {
				service.updateAuthCode(email, authCode);
			} else {
				service.emailDuplicate(email, authCode);
			}
	    	
	    	
    	} else {
    		map.put("result", "false");
    	}
    	
    	
    	return map;
    }
    
    //�럹�뒪�썙�뱶 蹂�寃� �뤌�쑝濡� �씠�룞
    @GetMapping("ModifyPasswdForm")
    public String ModifyPasswdForm (@RequestParam String authCode, @RequestParam String email, Model model, HttpSession session) {
    	
    	MembersVO member = service.getMemberInfoEmail(email);
    	
    	if(member == null || session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    		return "fail_back";
    	}
    	
    	int selectCount = service.isAuthCode(email, authCode);
    	
    	System.out.println("selectCount" + selectCount);
    	
    	if(selectCount > 0) {
    		
    		int deleteCount = service.authCodeDelete(email, authCode);
    		
    		System.out.println("deleteCount"+deleteCount);
    		
    		if(deleteCount > 0) {
    			
    			model.addAttribute("email", email);
    			
    			return "Login/passwd_modify";
    			
    		}
    		model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    		return "fail_back";
    	}
    	model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
		return "fail_back";
    	
    }
    
    //�럹�뒪�썙�뱶 蹂�寃�
    @PostMapping("ModifyPasswdPro")
    public String ModifyPasswdPro(@RequestParam String passwd, @RequestParam String email, Model model, HttpSession session) {
    	
    	if(session.getAttribute("id") != null) {
    		model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    		return "fail_back";
    	}
    	
		// ------------ BCryptPasswordEncoder 媛앹껜 �솢�슜�븳 �뙣�뒪�썙�뱶 �븫�샇�솕(= �빐�떛) --------------
		// => MyPasswordEncoder �겢�옒�뒪�뿉 紐⑤뱢�솕
		// 1. MyPasswordEncoder 媛앹껜 �깮�꽦
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 硫붿꽌�뱶�뿉 �룊臾� �쟾�떖�븯�뿬 �븫�샇臾� �뼸�뼱�삤湲�
		String securePasswd = passwordEncoder.getCryptoPassword(passwd);
		// -------------------------------------------------------------------------------------
    	
    	int updateCount = service.modifyPasswd(securePasswd, email);
    	
    	if(updateCount > 0) {
    		model.addAttribute("msg", "鍮꾨�踰덊샇媛� 蹂�寃쎈릺�뿀�뒿�땲�떎.");
    		model.addAttribute("targetURL", "./");
    		return "success_forward";
    	} else {
    		model.addAttribute("msg", "�옒紐삳맂 �젒洹쇱엯�땲�떎.");
    		return "fail_back";
    	}
    	
    }
    
    
    
 // �옖�뜡 肄붾뱶 �깮�꽦
    public static String generateRandomNumbers(int count) {
        StringBuilder number = new StringBuilder();
        Random random = new Random();

        for (int i = 0; i < count; i++) {
        	// 0 �씠�긽 9 �씠�븯�쓽 �옖�뜡 �닽�옄 �깮�꽦
            int digit = random.nextInt(10);
            number.append(digit);
        }

        return number.toString();
    }
    
    @GetMapping("passwdForm")
    public String passwdForm() {
    	return "passwd";
    }
    
    @GetMapping("passwd")
    @ResponseBody
    public String passwd(@RequestParam String passwd) {
    	
    	System.out.println(passwd);
    	
		// ------------ BCryptPasswordEncoder 媛앹껜 �솢�슜�븳 �뙣�뒪�썙�뱶 �븫�샇�솕(= �빐�떛) --------------
		// => MyPasswordEncoder �겢�옒�뒪�뿉 紐⑤뱢�솕
		// 1. MyPasswordEncoder 媛앹껜 �깮�꽦
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 硫붿꽌�뱶�뿉 �룊臾� �쟾�떖�븯�뿬 �븫�샇臾� �뼸�뼱�삤湲�
		return passwordEncoder.getCryptoPassword(passwd);
		// -------------------------------------------------------------------------------------
    	
    }
    
}
