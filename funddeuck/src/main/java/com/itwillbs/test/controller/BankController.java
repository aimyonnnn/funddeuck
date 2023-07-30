package com.itwillbs.test.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.test.service.BankApiService;
import com.itwillbs.test.service.BankService;
import com.itwillbs.test.vo.ResponseTokenVO;

@Controller
public class BankController {
	@Autowired
	private BankService bankService;
	@Autowired
	private BankApiService bankApiService;
	
	// 로그 출력을 위한 변수 선언
	private static final Logger logger = LoggerFactory.getLogger(BankController.class);
	
	// 메이커 정산 계좌 인증
	@GetMapping("FunddeuckCallback")
	public String accountAuth(@RequestParam Map<String, String> authResponse, Model model, HttpSession session) {
		// 정보 확인
		logger.info(authResponse.toString());
		
		// 인증 실패 시(= 인증 정보 존재하지 않을 경우) 오류 메세지 출력 및 인증 창 닫기
		if(authResponse == null || authResponse.get("code") == null) {
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "인증 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true); 
			return "bank_fail_back";
		}
		
		// 토큰 발급 요청
		ResponseTokenVO responseToken = bankApiService.requestToken(authResponse);
		logger.info("★★★★★ Access Token : " + responseToken.toString());
		
		if(responseToken.getAccess_token() == null) { // 토큰이 없을 경우
			model.addAttribute("msg", "토큰 발급 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true);
			return "bank_fail_back";
		}
		
		// 토큰을 DB에 저장
		boolean isRegistSuccess = bankService.registToken((String)session.getAttribute("sId"), responseToken);
		
		if(isRegistSuccess) {
			// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
			session.setAttribute("access_token", responseToken.getAccess_token());
			session.setAttribute("user_seq_no", responseToken.getUser_seq_no());

			model.addAttribute("msg", "계좌인증 완료!");
			model.addAttribute("targetURL", "projectManagement");
			model.addAttribute("isClose", true);
			
			return "bank_success_forward";
		} else {
			model.addAttribute("msg", "토큰 등록 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true);
			
			return "bank_fail_back";
		}
	}
}
