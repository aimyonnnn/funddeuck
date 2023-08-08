package com.itwillbs.test.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
		
		// DB에 저장된 토큰 정보 확인
		ResponseTokenVO existingToken = bankService.getTokenInfo(member_idx);
		
		boolean isRegistSuccess = false;
		boolean isUpdateSuccess = false;
		
		// 저장된 토큰이 없거나 만료된 경우 새로운 토큰을 저장하고, 이미 저장된 토큰이 있다면 업데이트
		if (existingToken == null) {
			// 토큰을 DB에 저장
			isRegistSuccess = bankService.registToken(member_idx, responseToken);
		} else {
			// 토큰을 DB에 업데이트
			isUpdateSuccess = bankService.updateTokenInfo(member_idx, responseToken);
		}
		
		if(isRegistSuccess || isUpdateSuccess) {
			// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
			session.setAttribute("access_token", responseToken.getAccess_token());
			session.setAttribute("user_seq_no", responseToken.getUser_seq_no());
			
			model.addAttribute("msg", "계좌인증 완료!");
			
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
			
				model.addAttribute("mostRecentBankAccount", mostRecentBankAccount);
				// 토큰 idx 전달 => 필요 ?
				model.addAttribute("token_idx", responseToken.getToken_idx());
				model.addAttribute("isClose", true);
				
				return "bank_success_forward";
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
	
	// 정산 요청
	@PostMapping("bankSettlement")
	public String bankSettlement(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// member_idx 조회
		String sId = (String) session.getAttribute("sId");
		int member_idx = projectService.getMemberIdx(sId);
		
		ResponseTokenVO token = bankService.getTokenInfo(member_idx); // 멤버에 저장된 액세스토큰 조회
		
		session.setAttribute("access_token", token.getAccess_token()); // 세션에 저장
		
		// Map 객체에 엑세스토큰 추가
		map.put("access_token", token.getAccess_token());
		
		// 권한 확인
		if(session.getAttribute("sId") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "fail_back";
		}
		
		// 입금이체 요청
		ResponseDepositVO depositResult = bankApiService.requestDepositSettlement(map);
		
		model.addAttribute("depositResult", depositResult);
		
		return "project/projectSettlement";
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
		
		// DB에 저장된 토큰 정보 확인
		ResponseTokenVO existingToken = bankService.getTokenInfo(member_idx);
		
		boolean isRegistSuccess = false;
		boolean isUpdateSuccess = false;
		
		// 저장된 토큰이 없거나 만료된 경우 새로운 토큰을 저장하고, 이미 저장된 토큰이 있다면 업데이트
		if (existingToken == null) {
			// 토큰을 DB에 저장
			isRegistSuccess = bankService.registToken(member_idx, responseToken);
		} else {
			// 토큰을 DB에 업데이트
			isUpdateSuccess = bankService.updateTokenInfo(member_idx, responseToken);
		}
		
		if(isRegistSuccess || isUpdateSuccess) { 
			model.addAttribute("msg", "계좌인증 완료!");
			
			// 계좌인증 완료 후 해당 회원의 토큰정보조회
			ResponseTokenVO token = bankService.getTokenInfo(member_idx);
			logger.info("●●●●● token : " + token);
			if(token != null) { // 토큰 정보 존재시
				// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
				session.setAttribute("access_token", token.getAccess_token());
				session.setAttribute("user_seq_no", token.getUser_seq_no());
				// 엑세스토큰과 사용자번호 저장
				String access_token = token.getAccess_token();
				logger.info("●●●●● access_token : " + access_token);
				String user_seq_no = token.getUser_seq_no();
				logger.info("●●●●● user_seq_no : " + user_seq_no);			
				// 핀테크 이용자 정보 조회
				ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no); 
				logger.info("●●●●● userInfo : " + userInfo);
				// CI(Connect Info) 저장(인증생략시 사용)
				String user_ci = userInfo.getUser_ci();
				// BankAccountVO 중에 조회서비스 동의일시(inquiry_agree_dtime)가 제일 최근인 계좌 가져오기
				List<BankAccountVO> bankAccountList = userInfo.getRes_list();
				BankAccountVO mostRecentBankAccount = null;
				for(BankAccountVO bankAccount : bankAccountList) {
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
				logger.info("●●●●● 제일 최근 조회서비스 동의 계좌: " + mostRecentBankAccount);
				
				// 핀테크이용번호가 일치하는 계좌정보 있는지 조회
				BankAccountVO bankAccount = bankService.getBankAccount(member_idx, mostRecentBankAccount);
				
				boolean isRegistAccountSuccess = false;
				if(bankAccount == null) { // 계좌정보 조회
					// 계좌정보 DB 저장
					mostRecentBankAccount.setUser_ci(user_ci); // 사용자 CI 저장
					logger.info("●●●●● 사용자 user_ci : " + user_ci);
					isRegistAccountSuccess = bankService.registBankAccount(member_idx, mostRecentBankAccount);
				} else { // 등록된 계좌가 존재함 
					// 등록된 계좌가 같을때, 변경시에는 계좌정보 수정 해주기
					model.addAttribute("msg", "이미 등록된 계좌입니다!");
					model.addAttribute("isClose", true);
					return "bank_fail_back";
				}
				
				if(isRegistAccountSuccess) {
					// 세션에 핀테크이용번호 저장 
					session.setAttribute("fintech_use_num", mostRecentBankAccount.getFintech_use_num());
					model.addAttribute("mostRecentBankAccount", mostRecentBankAccount);
					// 토큰 idx 전달 => 필요 ?
					model.addAttribute("token_idx", responseToken.getToken_idx());
					model.addAttribute("isClose", true);
					return "bank_success_forward_member";
				} else {
					model.addAttribute("msg", "계좌등록 오류 발생! 다시 인증해주세요!");
					model.addAttribute("isClose", true);
					return "bank_fail_back";
				}
				
				
			} else {
				model.addAttribute("msg", "계좌조회 오류 발생! 다시 인증해주세요!");
				model.addAttribute("isClose", true);
				return "bank_fail_back";
			}
			
			
		} else {
			model.addAttribute("msg", "계좌인증 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true);
			return "bank_fail_back";
		}
	}
	
//	// 계좌인증버튼 클릭시
//	@GetMapping("authMember")
//	public String authMember(Model model, HttpSession session) {
//		// member_idx 조회
//		String sId = (String) session.getAttribute("sId");
//		int member_idx = projectService.getMemberIdx(sId);
//		// DB에 저장된 엑세스 토큰 여부확인
//		ResponseTokenVO existingToken = bankService.getTokenInfo(member_idx);
//		if(existingToken == null) { // 토큰 없을 경우 
//			System.out.println("사용자 인증하러감!");
//			return  "redirect:" + bankApiService.authentication();
//		} else { // 토큰 존재시 
//			// 사용자인증생략
//			// access_token user_seq_no user_ci 필요
//			String access_token = existingToken.getAccess_token();
//			String user_seq_no = existingToken.getUser_seq_no();
//			// 계좌 정보 가져오기 
//			String user_ci = bankService.getUserCI(member_idx);
//			if(user_ci == null) { // 계좌 등록하지 않은 회원
//				return  "redirect:" + bankApiService.authentication();
//			} else { // 오류발생함..
//				System.out.println("사용자 인증생략!");
//				ResponseAuthVO responseAuth = bankApiService.authenticationSkip(access_token, user_seq_no, user_ci);
//				logger.info("●●●●● responseAuth :" + responseAuth.toString());
////				return  "redirect:" + bankApiService.authenticationSkip(access_token, user_seq_no, user_ci);			
//				return  "redirect:callbackMember" ;			
//			}
//		}
//		
//	}
//	
//	
//	// 회원 계좌인증(테스트)
//	@GetMapping("callbackMember")
//	public String callbackMember(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
//		logger.info("●●●●● authResponse :" + authResponse.toString());
//		
//		// 인증 실패 시(= 인증 정보 존재하지 않을 경우) 오류 메세지 출력 및 인증 창 닫기
//		if(authResponse == null || authResponse.get("code") == null) {
//			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
//			model.addAttribute("msg", "인증 오류 발생! 다시 인증하세요!");
//			model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
//			return "fail_back";
//		}
//		// 엑세스 토큰 발급 요청
//		ResponseTokenVO responseToken = bankApiService.requestTokenMember(authResponse);
//		logger.info("★★★★★ Access Token : " + responseToken.toString());
//		
//		if(responseToken.getAccess_token() == null) { // 토큰 없을 경우
//			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
//			model.addAttribute("msg", "토큰 발급 오류 발생! 다시 인증하세요!");
//			model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
//			return "fail_back";
//		}
//		// member_idx 조회
//		String sId = (String) session.getAttribute("sId");
//		int member_idx = projectService.getMemberIdx(sId);
//		
//		// 토큰 DB 저장
//		boolean isRegistSuccess = bankService.registToken(member_idx, responseToken);
//		
//		if(isRegistSuccess) { 
//			model.addAttribute("msg", "계좌인증 완료!");
//			
//			// 계좌인증 완료 후 해당 회원의 토큰정보조회
//			ResponseTokenVO token = bankService.getTokenInfo(member_idx);
//			logger.info("●●●●● token : " + token);
//			if(token != null) { // 토큰 정보 존재시
//				// 엑세스토큰과 사용자번호 저장 (세션 저장?)
//				// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
//				session.setAttribute("access_token", token.getAccess_token());
//				session.setAttribute("user_seq_no", token.getUser_seq_no());
//				String access_token = token.getAccess_token();
//				logger.info("●●●●● access_token : " + access_token);
//				String user_seq_no = token.getUser_seq_no();
//				logger.info("●●●●● user_seq_no : " + user_seq_no);			
//				// 핀테크 이용자 정보 조회
//				ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no); 
////				logger.info("●●●●● userInfo : " + userInfo);
//				// CI(Connect Info) 저장(인증생략시 사용)
//				String user_ci = userInfo.getUser_ci();
//				// BankAccountVO 중에 조회서비스 동의일시(inquiry_agree_dtime)가 제일 최근인 계좌 가져오기
//				List<BankAccountVO> bankAccountList = userInfo.getRes_list();
//				BankAccountVO mostRecentBankAccount = null;
//				for(BankAccountVO bankAccount : bankAccountList) {
//				    // mostRecentBankAccount 변수 초기화
//				    if (mostRecentBankAccount == null) {
//				        mostRecentBankAccount = bankAccount;
//				    } else {
//				        // 가장 최근의 조회서비스 동의일시를 찾기 위해 inquiry_agree_dtime 비교
//				        Date mostRecentDateTime = mostRecentBankAccount.getInquiry_agree_dtime();
//				        Date currentDateTime = bankAccount.getInquiry_agree_dtime();
//	
//				        if (currentDateTime.after(mostRecentDateTime)) {
//				            mostRecentBankAccount = bankAccount;
//				        }
//				    }
//				}
//				logger.info("●●●●● 제일 최근 조회서비스 동의 계좌: " + mostRecentBankAccount);
//				
//				// DB에 핀테크이용번호가 일치하는 계좌정보 있는지 조회
//				BankAccountVO bankAccount = bankService.getBankAccount(member_idx, mostRecentBankAccount);
//				
//				boolean isRegistAccountSuccess = false;
//				if(bankAccount == null) { 
//					// 계좌정보 DB 저장
//					mostRecentBankAccount.setUser_ci(user_ci); // 사용자 CI 저장
//					logger.info("●●●●● 사용자 user_ci : " + user_ci);
//					isRegistAccountSuccess = bankService.registBankAccount(member_idx, mostRecentBankAccount);
//				} else { // 있다면 삭제
//	//				bankService.deleteBankAccount(member_idx, mostRecentBankAccount);
//					isRegistAccountSuccess = true;
//				}
//				
//				if(isRegistAccountSuccess) {
//					session.setAttribute("fintech_use_num", mostRecentBankAccount.getFintech_use_num());
//					model.addAttribute("mostRecentBankAccount", mostRecentBankAccount);
//					model.addAttribute("isClose", true);
//					return "bank_success_forward_member";
//				} else {
//					model.addAttribute("msg", "계좌등록 오류 발생! 다시 인증해주세요!");
//					model.addAttribute("isClose", true);
//					return "bank_fail_back";
//				}
//				
//				
//			} else {
//				model.addAttribute("msg", "계좌조회 오류 발생! 다시 인증해주세요!");
//				model.addAttribute("isClose", true);
//				return "bank_fail_back";
//			}
//			
//			
//		} else {
//			model.addAttribute("msg", "계좌인증 오류 발생! 다시 인증하세요!");
//			model.addAttribute("isClose", true);
//			return "bank_fail_back";
//		}
//	}
	
	
}
