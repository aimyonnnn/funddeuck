package com.itwillbs.test.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.vo.*;

@Service
public class BankApiService {
	// 실제 금융API 요청을 수행할 BankApiClient 선언
	@Autowired
	private BankApiClient bankApiClient;

	// 토큰 발급 요청
	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		return bankApiClient.requestToken(authResponse);
	}
	
	// 토큰 발급 요청(회원)
	public ResponseTokenVO requestTokenMember(Map<String, String> authResponse) {
		return bankApiClient.requestTokenMember(authResponse);
	}
	
	// 사용자 정보 조회 요청
	public ResponseUserInfoVO requestUserInfo(String access_token, String user_seq_no) {
		return bankApiClient.requestUserInfo(access_token, user_seq_no);
	}
	
	// 사용자인증
	public String authentication() {
		return bankApiClient.authentication();
	}
	
	// 사용자인증 인증생략
	public ResponseAuthVO authenticationSkip(String access_token, String user_seq_no, String user_ci) {
		return bankApiClient.authenticationSkip(access_token, user_seq_no, user_ci);
	}
	
	// 회원 계좌 출금
	public ResponseWithdrawVO requestWithdrawMember(int total_amount, String fintech_use_num, String access_token) {
		return bankApiClient.requestWithdrawMember(total_amount, fintech_use_num, access_token);
	}
	
	// 환불
	public ResponseDepositVO requestDeposit(int total_amount, String fintech_use_num, String access_token) {
		return bankApiClient.requestDeposit(total_amount, fintech_use_num, access_token);
	}

}
