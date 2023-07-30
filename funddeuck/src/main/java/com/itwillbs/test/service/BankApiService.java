package com.itwillbs.test.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.vo.ResponseTokenVO;

@Service
public class BankApiService {
	// 실제 금융API 요청을 수행할 BankApiClient 선언
	@Autowired
	private BankApiClient bankApiClient;

	// 토큰 발급 요청
	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		return bankApiClient.requestToken(authResponse);
	}

}
