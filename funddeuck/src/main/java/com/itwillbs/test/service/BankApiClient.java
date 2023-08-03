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
import org.springframework.web.util.*;

import com.itwillbs.test.vo.*;

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
		parameters.add("redirect_uri", "http://localhost:8089/test/callback"); // 기존 콜백 URL 그대로 활용
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
	
	// 토큰 발급 요청(회원)
	public ResponseTokenVO requestTokenMember(Map<String, String> authResponse) {
		
		String url = baseUrl + "/oauth/2.0/token"; // url 요청
		HttpHeaders httpHeaders = new HttpHeaders(); // 헤더 생성
		httpHeaders.add("Content-Type",  "application/x-www-form-urlencoded; charset=UTF-8"); // 헤더 정보 추가
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>(); // 요청에 필요한 파라미터 설정
		
		parameters.add("code", authResponse.get("code")); // 응답 데이터 활용
		parameters.add("client_id", clientId); // @Value 어노테이션으로 포함한 속성값
		parameters.add("client_secret", clientSecret); // @Value 어노테이션으로 포함한 속성값
		parameters.add("redirect_uri", "http://localhost:8089/test/callbackMember"); // 사용자 인증 주소랑 일치 시켜야함
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
	
	// 사용자 정보 조회 요청
	public ResponseUserInfoVO requestUserInfo(String access_token, String user_seq_no) {
		String url = baseUrl + "/v2.0/user/me"; // url 생성 - GET 방식
		HttpHeaders httpHeaders = new HttpHeaders(); // 헤더 설정
		httpHeaders.add("Authorization", "Bearer " + access_token); // 헤더에 정보 추가
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders); // 바디 없이 헤더만 전달(바디 생략)
		// 요청에 필요한 파라미터 설정
		UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
									.queryParam("user_seq_no", user_seq_no)
									.build();
		// REST 방식 요청
		restTemplate = new RestTemplate();
		
		// HTTP 요청 수행
		ResponseEntity<ResponseUserInfoVO> responseEntity = 
				restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, ResponseUserInfoVO.class);
		logger.info("□□□□□□ 사용자정보조회 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

}
