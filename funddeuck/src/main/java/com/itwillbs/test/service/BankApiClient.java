package com.itwillbs.test.service;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.test.vo.ResponseTokenVO;

@Service
public class BankApiClient {
	
	// classpath:/config/appdata.properties 파일 내의 속성값 자동 주입
	@Value("${base_url}")
	private String baseUrl;
	@Value("${client_id}")
	private String clientId;
	@Value("${client_secret}")
	private String clientSecret;
	
	private RestTemplate restTemplate;
	
	private static final Logger logger = LoggerFactory.getLogger(BankApiClient.class);

	// 토큰 발급 요청
	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		
		String url = baseUrl + "/oauth/2.0/token"; // url 요청
		HttpHeaders httpHeaders = new HttpHeaders(); // 헤더 생성
		httpHeaders.add("Content-Type",  "application/x-www-form-urlencoded; charset=UTF-8"); // 헤더 정보 추가
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>(); // 요청에 필요한 파라미터 설정
		
		parameters.add("code", authResponse.get("code")); // 응답 데이터 활용
		parameters.add("client_id", clientId); // @Value 어노테이션으로 포함한 속성값
		parameters.add("client_secret", clientSecret); // @Value 어노테이션으로 포함한 속성값
		parameters.add("redirect_uri", "http://localhost:8089/fintech/callback"); // 기존 콜백 URL 그대로 활용
		parameters.add("grant_type", "authorization_code"); // 고정값
		logger.info("□□□□□ parameters : " + parameters.toString());
		
		// 요청에 사용될 헤더와 파라미터를 갖는 객체 생성
		HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String,String>>(parameters, httpHeaders);
		
		restTemplate = new RestTemplate(); // REST 방식 요청을 위한 객체 생성
		
		// HTTP 요청 수행
		ResponseEntity<ResponseTokenVO> responseEntity = restTemplate.exchange(url, HttpMethod.POST, httpEntity, ResponseTokenVO.class);
		
		logger.info("□□□□□ ResponseEntity.getBody() : " + responseEntity.getBody());
		logger.info("□□□□□ ResponseEntity.getStatusCode() : " + responseEntity.getStatusCode());
		
		return responseEntity.getBody(); // 응답 데이터 리턴
	}

}
