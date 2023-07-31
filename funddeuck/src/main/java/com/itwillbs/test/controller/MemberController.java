package com.itwillbs.test.controller;

import java.util.HashMap;
import java.util.List;
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
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.ProjectVO;

@Controller
public class MemberController {

    @Autowired
    private MemberService service;
    
    @Autowired
    private SendMailService mailService;
    
    @GetMapping("memberMypage")
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
	
		// ------------ BCryptPasswordEncoder 객체 활용한 패스워드 암호화(= 해싱) --------------
		// => MyPasswordEncoder 클래스에 모듈화
		// 1. MyPasswordEncoder 객체 생성
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
		String securePasswd = passwordEncoder.getCryptoPassword(member.getMember_passwd());
		// 3. 리턴받은 암호문을 MemberVO 객체에 덮어쓰기
		member.setMember_passwd(securePasswd);
		// -------------------------------------------------------------------------------------
    	
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
    	
    	//1. BCryptPasswordEncoder 객체 생성
    	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    	
    	
    	//id와 비밀번호조회를 통한 로그인작업
    	MembersVO isMember = service.getMemberInfo(member.getMember_id());

    		
    	if(isMember == null){
    		model.addAttribute("msg", "아이디가 존재하지 않습니다.");
    		return "fail_back";
    	}else if(isMember.getFalse_count()>=4) {
    			model.addAttribute("msg", "5회 이상 틀린 아이디 입니다.\\n비밀번호찾기를 진행해주세요");
    		return "fail_back";
    	} else if(passwordEncoder.matches(member.getMember_passwd(), isMember.getMember_passwd())) {
    		
    		isMember.setFalse_count(0);
    		service.updateFailCount(isMember);
    		session.setAttribute("sId", member.getMember_id());
    		return "redirect:/";
    	}
    	isMember.setFalse_count(isMember.getFalse_count()+1);
    	service.updateFailCount(isMember);
		model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.\\n"+isMember.getFalse_count()+"회 틀렸습니다. 5회틀릴시 로그인이 불가합니다.");
		return "fail_back";
    	
    }
    
    //로그아웃
    @GetMapping("LogOut")
    public String LogOut(HttpSession session) {
    	session.invalidate();
    	
    	return "redirect:/";
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
    	
    	int isMemberEmail = service.selectMemberEmail(email);
    	
    	if(isMemberEmail > 0) {
    		return "duplication";
    	}
    	
    	String authCode = generateRandomNumbers(6);
    	
    	new Thread(new Runnable() {
			
			@Override
			public void run() {
				System.out.println("여기옴");
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
    
    // 아이디 찾기 form 으로 이동
    @GetMapping("idFindForm")
    public String idFindForm() {
    	return "Login/id_find";
    }
    
    // 아이디 찾기
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
    
    // 비밀번호 찾기 form 으로 이동
    @GetMapping("passwdFindForm")
    public String passwdFindForm() {
    	return "Login/passwd_find";
    }
    
    //페스워드 찾기 ajax
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
    
    //페스워드 변경 폼으로 이동
    @GetMapping("ModifyPasswdForm")
    public String ModifyPasswdForm (@RequestParam String authCode, @RequestParam String email, Model model, HttpSession session) {
    	
    	MembersVO member = service.getMemberInfoEmail(email);
    	
    	if(member == null || session.getAttribute("sId") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
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
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	model.addAttribute("msg", "잘못된 접근입니다.");
		return "fail_back";
    	
    }
    
    //페스워드 변경
    @PostMapping("ModifyPasswdPro")
    public String ModifyPasswdPro(@RequestParam String passwd, @RequestParam String email, Model model, HttpSession session) {
    	
    	if(session.getAttribute("id") != null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
		// ------------ BCryptPasswordEncoder 객체 활용한 패스워드 암호화(= 해싱) --------------
		// => MyPasswordEncoder 클래스에 모듈화
		// 1. MyPasswordEncoder 객체 생성
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
		String securePasswd = passwordEncoder.getCryptoPassword(passwd);
		// -------------------------------------------------------------------------------------
    	
    	int updateCount = service.modifyPasswd(securePasswd, email);
    	
    	if(updateCount > 0) {
    		model.addAttribute("msg", "비밀번호가 변경되었습니다.");
    		model.addAttribute("targetURL", "./");
    		return "success_forward";
    	} else {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    }
    
    @GetMapping("FallowingForm")
    public String FallowingForm(HttpSession session, Model model) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	List<Map<String,Object>> fallowList = service.getfallowList((String)session.getAttribute("sId"));
    	
    	model.addAttribute("fallowList", fallowList);
    	
    	
    	return "member/member_fallowing";
    	
    }
    
    // 팔로우 알람에 대한 ajax
    @PostMapping("fallowingAlam")
    @ResponseBody
    public String isAlam(@RequestParam String maker_name, @RequestParam int is_alam, HttpSession session) {
    	
    	int updateCount = service.fallowingAlam(maker_name, is_alam, (String)session.getAttribute("sId"));
    	
    	if(updateCount > 0) {
    		return "true";
    	} else {
    		return "false";
    	}
    }
    
    // 팔로우 채크에 대한 ajax
    @PostMapping("fallowCheck")
    @ResponseBody
    public String fallowCheck(@RequestParam String maker_name, @RequestParam int is_fallow, HttpSession session) {
    	
    	
    	if(is_fallow == 1) {
    		int deleteCount = service.deleteFallow(maker_name, (String)session.getAttribute("sId"));
    		
    		if(deleteCount > 0) {
    			return "true";
    		} else {
    			return "false";
    		}
    	} else {
    		int insertCount = service.insertFallow(maker_name, (String)session.getAttribute("sId"));
    		
    		if(insertCount > 0) {
    			return "true";
    		} else {
    			return "false";
    		}
    	}
    }
    
    @GetMapping("ZimForm")
    public String ZimForm(HttpSession session, Model model) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	List<Map<String,Object>> zimList = service.getZimList((String)session.getAttribute("sId"));
    	
    	model.addAttribute("zimList",zimList);
    	
    	return "member/member_zim";
    }
    
    @PostMapping("zimAlam")
    @ResponseBody
    public String zimAlam(HttpSession session, @RequestParam int isAlam, @RequestParam int project_idx) {
    	
    	System.out.println(isAlam + ", " + project_idx);
    	
    	int updateCount = service.zimAlam(project_idx, isAlam , (String)session.getAttribute("sId"));
    	
    	if(updateCount > 0) {
    		return "true";
    	} else {
    		return "false";
    	}
    	
    	
    }
    
    @PostMapping("isZim")
    @ResponseBody
    public String isZim(HttpSession session, @RequestParam int is_zim, @RequestParam int project_idx) {
    	
    	if(is_zim == 0) {
    		int deleteCount = service.deleteZim(project_idx, (String)session.getAttribute("sId"));
    		
    		if(deleteCount > 0) {
    			return "true";
    		} else {
    			return "false";
    		}
    	} else {
    		int insertCount = service.insertZim(project_idx, (String)session.getAttribute("sId"));
    		
    		if(insertCount > 0) {
    			return "true";
    		} else {
    			return "false";
    		}
    	}
    	
    }
    
    @GetMapping("FollowBoardForm")
    public String FollowBoardForm(HttpSession session, Model model) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	List<ProjectVO> projectList = service.getProject((String)session.getAttribute("sId"));
    	
    	model.addAttribute("projectList", projectList);
    	
    	return "member/member_following_board";
    	
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
    
    @GetMapping("passwdForm")
    public String passwdForm() {
    	return "passwd";
    }
    
    @GetMapping("passwd")
    @ResponseBody
    public String passwd(@RequestParam String passwd) {
    	
    	System.out.println(passwd);
    	
		// ------------ BCryptPasswordEncoder 객체 활용한 패스워드 암호화(= 해싱) --------------
		// => MyPasswordEncoder 클래스에 모듈화
		// 1. MyPasswordEncoder 객체 생성
		MyPasswordEncoder passwordEncoder = new MyPasswordEncoder();
		// 2. getCryptoPassword() 메서드에 평문 전달하여 암호문 얻어오기
		return passwordEncoder.getCryptoPassword(passwd);
		// -------------------------------------------------------------------------------------
    	
    }
    
}
