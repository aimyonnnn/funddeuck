package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.itwillbs.test.handler.MyPasswordEncoder;
import com.itwillbs.test.service.FundingService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.SendMailService;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.ProjectVO;

@Controller
public class MemberController {

	@Autowired
	FundingService fundingservice;
	
    @Autowired
    private MemberService service;
    
    @Autowired
    private SendMailService mailService;
    
    @GetMapping("memberMypage")
    public String myPage(HttpSession session, Model model) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	int fundingCount = fundingservice.getMemberFunDingCount((String)session.getAttribute("sId"), 0);
    	
    	System.out.println((String)session.getAttribute("sId"));
    	
    	System.out.println("fundingCount : " + fundingCount);
    	
    	model.addAttribute("fundingCount",fundingCount);
    	
        return "member/myPage"; 
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
    			model.addAttribute("msg", "5회 이상 틀린 아이디 입니다.\\n비밀번호찾기를 진행해주세요.");
    		return "fail_back";
    	} else if(passwordEncoder.matches(member.getMember_passwd(), isMember.getMember_passwd())) {
    		
    		isMember.setFalse_count(0);
    		service.updateFailCount(isMember);
    		session.setAttribute("sId", isMember.getMember_id());
    		session.setAttribute("sIdx", isMember.getMember_idx());
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
    
    // 팔로잉 페이지 이동
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
    
    // 찜 페이지 이동
    @GetMapping("ZimForm")
    public String ZimForm(HttpSession session, Model model
    		) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	List<Map<String,Object>> zimList = service.getZimList((String)session.getAttribute("sId"));
    	
    	model.addAttribute("zimList",zimList);
    	
    	return "member/member_zim";
    }
    
    // 찜 알람 설정
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
    
    // 찜하는지 여부
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
    
    //찜한 프로젝트의 최근 소식
    @GetMapping("zimFollowBoard")
    public String zimFollowBoard(HttpSession session, Model model) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	
    	return "member/member_zim_board";
    }
    
    //찜한 프로젝트의 최근 소식을 가져오는 ajax
    @PostMapping("ZimPostList")
    @ResponseBody
    public String ZimPostList(HttpSession session, @RequestParam int pageNum) {
    	
		int listLimit = 5;// 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit;
    	
    	List<Map<String, Object>> zimPostList = service.getZimPostList((String)session.getAttribute("sId"), startRow, listLimit);
    	
    	int listCount = service.getZimPostListCount((String)session.getAttribute("sId"));
    	
    	int pageListLimit = 5;
    	
    	int maxPage = listCount/listLimit + (listCount%listLimit > 0 ? 1 : 0);
    	
    	int startPage = (pageNum - 1 ) / pageListLimit * pageListLimit + 1;
    	
    	int endPage = startPage + pageListLimit - 1 ;
    	
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		
    	JSONObject jsonObject = new JSONObject();
		jsonObject.put("zimPostList", zimPostList);
		jsonObject.put("listCount", listCount);
    	
    	return jsonObject.toString();
    	
    }
    
    // 팔로우의 활동 페이지로 이동
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
    
    
    //멤버가한 펀딩리스트 페이지로 이동
    @GetMapping("MemberFunDing")
    public String MemberFunDing (HttpSession session, Model model) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	
    	return "member/member_funding";
    	
    }
    
    // 펀딩 모달에 띄울 거
    @PostMapping("FunDingModal")
    @ResponseBody
    public Map<String,Object> FunDingModal(@RequestParam int payment_idx) {
    	
    	Map<String,Object> map =fundingservice.getMemberModalFunding(payment_idx);
    	
    	
    	
    	return map;
    	
    }
    
    // 페이징 처리
    @PostMapping("MemberFundingPageing")
    @ResponseBody
    public String MemberFundingPageing(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, @RequestParam(defaultValue = "0") int payment_confirm) {
    	
    	System.out.println(pageNum + ", " +payment_confirm);
    	
		int listLimit = 5;// 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit;
		
		System.out.println("pageNum : " + pageNum + " listLimit : " + listLimit + " startRow : " + startRow + " payment_confirm : " + payment_confirm);
    	
    	List<Map<String, Object>> map = fundingservice.getMemberFunDing((String)session.getAttribute("sId"),payment_confirm, startRow, listLimit);
    	
    	int listCount = fundingservice.getMemberFunDingCount((String)session.getAttribute("sId"),payment_confirm);
    	
    	int pageListLimit = 5;
    	
    	int maxPage = listCount/listLimit + (listCount%listLimit > 0 ? 1 : 0);
    	
    	int startPage = (pageNum - 1 ) / pageListLimit * pageListLimit + 1;
    	
    	int endPage = startPage + pageListLimit - 1 ;
    	
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		Map<String, Integer> pageInfo = new HashMap<String, Integer>();
    	
		pageInfo.put("startPage", startPage);
		pageInfo.put("endPage", endPage);
		pageInfo.put("maxPage", maxPage);
		
    	JSONObject jsonObject = new JSONObject();
		jsonObject.put("map", map);
		jsonObject.put("pageInfo", pageInfo);
    	
    	return jsonObject.toString();
    	
    }
    
    //배송 완료 처리
    @PostMapping("deleveryComplete")
    @ResponseBody
    public String deleveryComplete(@RequestParam int payment_idx) {
    	
    	int updateCount = service.ModifyDeleveryComplete(payment_idx);
    	
    	if(updateCount > 0) {
    		return "true";
    	} else {
    		return "false";
    	}
    	
    }
    
    //반환신청
    @PostMapping(value = "cancellationRequest", consumes = "multipart/form-data")
    @ResponseBody
    public String cancellationRequest(@RequestPart("file") MultipartFile file,
    	    @RequestParam("context") String context,
    	    @RequestParam("cancel_idx") int cancel_idx ,HttpSession session) {
    	
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String uuid = UUID.randomUUID().toString();
		
		String fileName = uuid.substring(0,8) + "_" + file.getOriginalFilename();
		
		String saveFileName = subDir + "/" + fileName;
		
    	int updateCount = fundingservice.requestMemberCancellation(cancel_idx, context, saveFileName) ;
    	
    	if(updateCount > 0) {
    		try {
				file.transferTo(new File(saveDir,fileName));
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    		return "true";
    	}
    			
    	return "false";
    	
    }
    
    //리뷰 작성
    @PostMapping(value = "reivewRegistration", consumes = "multipart/form-data")
    @ResponseBody
    public String reivewRegistration(@RequestPart("file") MultipartFile file,
    	    @RequestParam("context") String context,
    	    @RequestParam("payment_idx") int payment_idx,
    	    @RequestParam("starRating") int starRating,
    	    HttpSession session) {
    	
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		String uuid = UUID.randomUUID().toString();
		
		String fileName = uuid.substring(0,8) + "_" + file.getOriginalFilename();
		
		String saveFileName = subDir + "/" + fileName;
		
    	int insertCount = service.reivewRegistration(payment_idx, context, starRating, saveFileName);
    	
    	if(insertCount > 0) {
    		try {
				file.transferTo(new File(saveDir,fileName));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
    		return "true";
    	}
    			
    	return "false";
    	
    	
    }
    
    //리뷰리스트로 이동
    @GetMapping("reviewListPage")
    public String reviewListPage(HttpSession session, Model model) {
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    	}
    	
    	return "member/member_review";
    }
    
    //리뷰 페이징 처리
    @PostMapping("MemberReveiwList")
    @ResponseBody
    public String MemberReveiwList(@RequestParam int pageNum, HttpSession session) {
    	
		int listLimit = 5;// 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit;
    	
		System.out.println((String)session.getAttribute("sId"));
		
    	List<Map<String, Object>> ReveiwList = service.getMemberReviewList((String)session.getAttribute("sId"),startRow,listLimit);
    	
    	int listCount = service.getMemberReveiwListCount((String)session.getAttribute("sId"));
    	
		int maxPage = listCount/listLimit + (listCount%listLimit > 0 ? 1 : 0);
    	
    	JSONObject jsonObject = new JSONObject();
    	
    	jsonObject.put("ReveiwList",ReveiwList);
    	jsonObject.put("maxPage",maxPage);
    		
    	
    	return jsonObject.toString();
    }
    
    //리뷰 삭제
    @PostMapping("reviewMemberDelete")
    @ResponseBody
    public String reviewMemberDelete(@RequestParam int num) {
    	
    	int updateCount = service.deleteMemberReview(num);
    	
    	if(updateCount > 0) {
    		return "true";
    	} else {
    		return "false";
    	}
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
