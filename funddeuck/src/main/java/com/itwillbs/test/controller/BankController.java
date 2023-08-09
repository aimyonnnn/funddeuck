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
		
		int project_idx = Integer.parseInt(map.get("project_idx")); // 프로젝트 번호 저장
		String member_id = sId;	// 멤버 아이디 저장 
		
		// 권한 확인
		if(session.getAttribute("sId") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "fail_back";
		}
		
		// 입금이체 요청
		ResponseDepositVO depositResult = bankApiService.requestDepositSettlement(map);
		
		// 정산 금액
		int final_settlement = Integer.parseInt(map.get("final_settlement"));
		
		// 정산 입금내역 DB에 저장                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   `
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("depositInfoList", depositResult.getRes_list());
		
		int insertCount = bankService.registDepositSettlement(member_id, project_idx, paramMap);
		
		if(insertCount > 0) { // DB 저장 성공 시 
			int updateCount = projectService.updateProjectSettlementStatus(project_idx, final_settlement); // 정산 완료 후 프로젝트 상태 및 1차 금액 변경
			
			if(updateCount > 0) { // 상태 변경 성공 시 
				String targetURL = "projectSettlement";
				model.addAttribute("msg", "정산이 완료 되었습니다!");
				model.addAttribute("targetURL", targetURL);
				return "success_forward";
			} else {
				model.addAttribute("msg", "정산 상태 변경에 실패했습니다!");
				return "fail_back";
			}
		} else {
			model.addAttribute("msg", "정산 등록이 실패했습니다!");
			return "fail_back";
		}
	}
	
	// 환불 요청
	@PostMapping("bankRefund")
	public String bankRefund(@RequestParam Map<String, String> map, HttpSession session, Model model) {
		// member_idx 조회
		String sId = (String) session.getAttribute("sId");
		int member_idx = projectService.getMemberIdx(sId);
		
		ResponseTokenVO token = bankService.getTokenInfo(member_idx); // 멤버에 저장된 액세스토큰 조회
		session.setAttribute("access_token", token.getAccess_token()); // 세션에 저장
		map.put("access_token", token.getAccess_token()); // Map 객체에 엑세스토큰 추가
		
		int project_idx = Integer.parseInt(map.get("project_idx")); // 프로젝트 번호 저장
		String member_id = map.get("member_id");	// 멤버 아이디 저장 
		
		// 권한 확인
		if(session.getAttribute("sId") == null || session.getAttribute("access_token") == null) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "fail_back";
		}
		
		// 입금이체 요청
		ResponseDepositVO depositResult = bankApiService.requestDepositSettlement(map);
		
		// 결제 고유번호
		int payment_idx = Integer.parseInt(map.get("payment_idx"));
		
		// 환불내역 DB에 저장                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   `
		Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("depositInfoList", depositResult.getRes_list());
		
		int insertCount = bankService.registDepositRefund(member_id, project_idx, paramMap);
		
		if(insertCount > 0) { // DB 저장 성공 시 
			int updateCount = projectService.updateProjectRefundStatus(payment_idx); // 정산 완료 후 환불 상태 및 최종 금액 변경
			
			if(updateCount > 0) { // 상태 변경 성공 시 
				String targetURL = "projectShipping";
				model.addAttribute("msg", "환불이 완료 되었습니다!");
				model.addAttribute("targetURL", targetURL);
				return "success_forward";
			} else {
				model.addAttribute("msg", "환불 상태 변경에 실패했습니다!");
				return "fail_back";
			}
		} else {
			model.addAttribute("msg", "환불 등록이 실패했습니다!");
			return "fail_back";
		}
	}
	
	// 계좌인증 / 계좌변경 버튼 클릭시
	@GetMapping("authMember")
	public String authMember(Model model, HttpSession session) {
		// member_idx 조회
		String sId = (String) session.getAttribute("sId");
		int member_idx = projectService.getMemberIdx(sId);
		// 아니면 계좌정보 확인?
		// DB에 저장된 엑세스 토큰 여부확인
		ResponseTokenVO existingToken = bankService.getTokenInfo(member_idx);
		if(existingToken == null) { // 토큰 없을 경우(첫 계좌등록)
			System.out.println("첫 계좌등록시");
			// 사용자인증요청 API 
			return "redirect:" + bankApiService.authentication();
		} else { // 토큰 존재시(계좌변경)
			System.out.println("계좌변경시");
			// DB에 등록되어있던 토큰 정보 삭제
			boolean isDeleteTokenSuccess = bankService.deleteToken(member_idx);
			if(isDeleteTokenSuccess) { // 토큰 정보 삭제 성공시
				return "redirect:" + bankApiService.authentication();
			} else { // 토큰 정보 삭제 실패시
				model.addAttribute("msg", "토큰 정보 삭제 오류! 다시 인증하세요!");
				model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
				return "bank_fail_back";				
			}
		}
		
	}
	
	// 회원 계좌인증 / 계좌변경
	@GetMapping("callbackMember")
	public String callbackMember(@RequestParam Map<String, String> authResponse, HttpSession session, Model model) {
		logger.info("●●●●● authResponse :" + authResponse.toString());
		// 인증 실패 시(= 인증 정보 존재하지 않을 경우) 오류 메세지 출력 및 인증 창 닫기
		if(authResponse == null || authResponse.get("code") == null) {
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "인증 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
			return "bank_fail_back";
		}
		// 엑세스 토큰 발급 API 요청
		ResponseTokenVO responseToken = bankApiService.requestTokenMember(authResponse);
		logger.info("★★★★★ Access Token : " + responseToken.toString());
		
		// 토큰 발급 요청 후 토큰이 존재하지 않을 경우
		if(responseToken.getAccess_token() == null) { 
			// Model 객체를 통해 출력할 메세지(msg) 전달 및 창 닫기 여부(isClose)도 전달
			model.addAttribute("msg", "토큰 발급 오류 발생! 다시 인증하세요!");
			model.addAttribute("isClose", true); // true : 창 닫기, false : 창 닫기 X(이전페이지로 돌아가기)
			return "bank_fail_back";
		}
		
		// member_idx 조회
		String sId = (String) session.getAttribute("sId");
		int member_idx = projectService.getMemberIdx(sId);
		
		// 토큰 정보 DB 저장
		boolean isRegistSuccess = bankService.registToken(member_idx, responseToken);
		
		if(isRegistSuccess) { 
			// 해당 회원의 토큰 정보 조회
			ResponseTokenVO token = bankService.getTokenInfo(member_idx);
			logger.info("●●●●● token : " + token);
			if(token == null) { // 토큰 정보 DB 조회 실패시
				model.addAttribute("msg", "토큰 정보 조회 오류 발생! 다시 인증해주세요!");
				model.addAttribute("isClose", true);
				return "bank_fail_back";
			} else { // 토큰 정보 DB 조회 성공시
				// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
				session.setAttribute("access_token", token.getAccess_token());
				session.setAttribute("user_seq_no", token.getUser_seq_no());
				String access_token = token.getAccess_token();
				logger.info("●●●●● access_token : " + access_token);
				String user_seq_no = token.getUser_seq_no();
				logger.info("●●●●● user_seq_no : " + user_seq_no);
				// 사용자정보조회 요청 API
				ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no);
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
				logger.info("●●●●● 제일 최근 조회서비스 동의 계좌 : " + mostRecentBankAccount);
				logger.info("●●●●● 핀테크이용번호 : " + mostRecentBankAccount.getFintech_use_num());
				// 회원이 가지고 있는 계좌정보 조회 
				BankAccountVO isExistingBankAccount = bankService.getBankAccountInfo(member_idx);
				if(isExistingBankAccount == null) { // 계좌정보 미존재(첫 계좌등록)
					// 계좌정보 DB 등록
					boolean isRegistAccountSuccess = bankService.registBankAccount(member_idx, mostRecentBankAccount);
					if(isRegistAccountSuccess) { // 계좌정보 DB 등록 성공시
						// 세션에 핀테크이용번호 저장
						// 성공 페이지에 model로 계좌정보 전달
						model.addAttribute("msg", "계좌 등록 완료!");
						session.setAttribute("fintech_use_num", mostRecentBankAccount.getFintech_use_num());
						model.addAttribute("mostRecentBankAccount", mostRecentBankAccount);
						model.addAttribute("isClose", true);
						return "bank_success_forward_member";
					} else { // 계좌정보 DB 등록 실패시
						model.addAttribute("msg", "계좌등록 오류 발생! 다시 인증해주세요!");
						model.addAttribute("isClose", true);
						return "bank_fail_back";
					}
					
				} else { // 계좌정보 존재(계좌변경)
					// 핀테크이용번호가 일치하는 계좌정보 있는지 조회(중복확인)
					boolean isDupeBankAccount = bankService.getBankAccount(member_idx, mostRecentBankAccount);
					if(!isDupeBankAccount) { // 중복된 계좌정보가 없을 경우
						// 등록된 계좌정보 삭제
						// 변경된 계좌정보 DB 등록
						boolean isRegistAccountSuccess = bankService.registBankAccount(member_idx, mostRecentBankAccount);
						if(isRegistAccountSuccess) { // 계좌정보 DB 등록 성공시
							// 세션에 핀테크이용번호 저장
							// 성공 페이지에 model로 계좌정보 전달
							model.addAttribute("msg", "계좌 변경 완료!");
							session.setAttribute("fintech_use_num", mostRecentBankAccount.getFintech_use_num());
							model.addAttribute("mostRecentBankAccount", mostRecentBankAccount);
							model.addAttribute("isClose", true);
							return "bank_success_forward_member";
						} else { // 계좌정보 DB 등록 실패시
							model.addAttribute("msg", "계좌변경 오류 발생! 다시 인증해주세요!");
							model.addAttribute("isClose", true);
							return "bank_fail_back";
						}
						
					} else { // 중복된 계좌정보 있을 경우
						model.addAttribute("msg", "이미 등록된 계좌입니다! 다시 인증해주세요!");
						model.addAttribute("isClose", true);
						return "bank_fail_back";
					}
				}
				
			}
		} else { // 토큰 정보 DB 저장 실패
			model.addAttribute("msg", "토큰 정보 저장 오류 발생! 다시 인증해주세요!");
			model.addAttribute("isClose", true);
			return "bank_fail_back";
		}
	}
	
	
}
