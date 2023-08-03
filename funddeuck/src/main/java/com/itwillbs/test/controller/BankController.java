package com.itwillbs.test.controller;

import java.util.*;

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
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.*;

@Controller
public class BankController {
	@Autowired
	private BankService bankService;
	@Autowired
	private BankApiService bankApiService;
	@Autowired
	private ProjectService projectService;
	
	// 로그 출력을 위한 변수 선언
	private static final Logger logger = LoggerFactory.getLogger(BankController.class);
	
	// 메이커 정산 계좌 인증
	@GetMapping("callback")
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
		
		// member_idx 조회
		String sId = (String) session.getAttribute("sId");
		int member_idx = projectService.getMemberIdx(sId);
		System.out.println("member_idx : " + member_idx);
		
		// 토큰을 DB에 저장
		boolean isRegistSuccess = bankService.registToken(member_idx, responseToken);
		
		if(isRegistSuccess) {
			// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
			session.setAttribute("access_token", responseToken.getAccess_token());
			session.setAttribute("user_seq_no", responseToken.getUser_seq_no());
			

			model.addAttribute("msg", "계좌인증 완료!");
			model.addAttribute("token_idx", responseToken.getToken_idx());
			model.addAttribute("isClose", true);
			
			return "bank_success_forward";
		} else {
			model.addAttribute("msg", "토큰 등록 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true);
			
			return "bank_fail_back";
		}
	}
	
	// 회원 계좌인증
	@GetMapping("callbackMember")
	public String accountAuthMember(@RequestParam Map<String, String> authResponse, Model model, HttpSession session) {
		
		logger.info(authResponse.toString());
		
		// 인증 실패 시(= 인증 정보 존재하지 않을 경우) 오류 메세지 출력 및 인증 창 닫기
		if(authResponse == null || authResponse.get("code") == null) {
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "인증 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
			return "fail_back";
		}
		
		// 엑세스 토큰 발급 요청
		ResponseTokenVO responseToken = bankApiService.requestTokenMember(authResponse);
		logger.info("★★★★★ Access Token : " + responseToken.toString());
		
		
		if(responseToken.getAccess_token() == null) { // 토큰 없을 경우
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "토큰 발급 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
			return "fail_back";
		}
		
		// member_idx 조회
		String sId = (String) session.getAttribute("sId");
		int member_idx = projectService.getMemberIdx(sId);
		System.out.println("member_idx : " + member_idx);
		
		// 토큰 관련 정보 DB 저장
		boolean isRegistSuccess = bankService.registToken(member_idx, responseToken);
		
		if(isRegistSuccess) { 
			// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
			session.setAttribute("access_token", responseToken.getAccess_token());
			session.setAttribute("user_seq_no", responseToken.getUser_seq_no());

			model.addAttribute("msg", "계좌인증 완료!");
			
			// 계좌인증 여부 확인 필요한가?
			// 계좌인증 완료 후 해당 회원의 토큰정보조회
			ResponseTokenVO token = bankService.getTokenInfo(member_idx);
			logger.info("●●●●● token : " + token);
			if(token != null) { // 토큰 정보 존재시
				// 엑세스토큰과 사용자번호 저장
				String access_token = token.getAccess_token();
				logger.info("●●●●● userInfo : " + access_token);
				String user_seq_no = token.getUser_seq_no();
				logger.info("●●●●● userInfo : " + user_seq_no);
				// 핀테크 이용자 정보 조회
				ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no); 
				logger.info("●●●●● userInfo : " + userInfo);
				System.out.println(userInfo);
				// BankAccountVO 중에 조회서비스 동의일시(inquiry_agree_dtime)가 제일 최근인 계좌 가져오기
				List<BankAccountVO> bankAccountList = userInfo.getRes_list();
				BankAccountVO mostRecentBankAccount = null;
				for(BankAccountVO bankAccount : bankAccountList) {
					System.out.println("조회서비스 동의일시" + bankAccount.getInquiry_agree_dtime());
					
				    // mostRecentBankAccount 변수 초기화
				    if (mostRecentBankAccount == null) {
				        mostRecentBankAccount = bankAccount;
				    } else {
				        // 가장 최근의 조회서비스 동의일시를 찾기 위해 inquiry_agree_dtime 비교
				        Date mostRecentDateTime = mostRecentBankAccount.getInquiry_agree_dtime();
				        Date currentDateTime = bankAccount.getInquiry_agree_dtime();

				        if (currentDateTime.after(mostRecentDateTime)) {
				            mostRecentBankAccount = bankAccount;
				        }
				    }
				}
				
				System.out.println("제일 최근 조회서비스 동의 계좌: " + mostRecentBankAccount);
				model.addAttribute("mostRecentBankAccount", mostRecentBankAccount);
				// 토큰 idx 전달 => 필요 ?
				model.addAttribute("token_idx", responseToken.getToken_idx());
				model.addAttribute("isClose", true);
				
				return "bank_success_forward_member";
			} else {
				model.addAttribute("msg", "오류 발생! 다시 인증하세요!");
				model.addAttribute("isClose", true);
				
				return "bank_fail_back";
				
			}
			
		} else {
			model.addAttribute("msg", "오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true);
			
			return "bank_fail_back";
		}
		
	}
	
	
}
