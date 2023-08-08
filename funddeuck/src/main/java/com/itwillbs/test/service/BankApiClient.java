package com.itwillbs.test.service;

import java.util.Map;

import org.json.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.*;

import com.itwillbs.test.handler.*;
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
	
	@Autowired
	private BankValueGenerator valueGenerator;
	
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
		parameters.add("redirect_uri", "http://c5d2302t2.itwillbs.com/funddeuck/callback"); // 기존 콜백 URL 그대로 활용
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
	
	// 사용자 인증
	public String authentication() {
	    String url = baseUrl + "/oauth/2.0/authorize"; // url 요청
	    // 요청에 필요한 파라미터 설정
	    UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
	            .queryParam("response_type", "code")
	            .queryParam("client_id", "4066d795-aa6e-4720-9383-931d1f60d1a9")
	            .queryParam("redirect_uri", "http://localhost:8089/test/callbackMember")
	            .queryParam("scope", "login inquiry transfer oob")
	            .queryParam("state", "12345678901234567890123456789012")
	            .queryParam("auth_type", "0")
	            .build();

	    return uriComponents.toString();
	}
	
	
	// 사용자인증 인증 생략 - GET 방식(수정해야함)
	public ResponseAuthVO authenticationSkip(String access_token, String user_seq_no, String user_ci) {
		String url = baseUrl + "/oauth/2.0/authorize"; // url 요청
		HttpHeaders httpHeaders = new HttpHeaders(); // 헤더 생성
		// 헤더 정보 추가
		httpHeaders.add("Kftc-Bfop-UserSeqNo",  user_seq_no); // 기존 고객의 사용자일련번호
		httpHeaders.add("Kftc-Bfop-UserCI",  user_ci); // 사용자의 CI
		httpHeaders.add("Kftc-Bfop-AccessToken",  access_token); // 기존 고객의 사용자일련번호
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders); // 바디 없이 헤더만 전달(바디 생략)
		// 요청에 필요한 파라미터 설정
		UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
				.queryParam("response_type", "code")
				.queryParam("client_id", "4066d795-aa6e-4720-9383-931d1f60d1a9")
				.queryParam("redirect_uri", "http://localhost:8089/test/callbackMember")
				.queryParam("scope", "login inquiry transfer oob")
				.queryParam("state", "12345678901234567890123456789012")
				.queryParam("auth_type", "2")
				.build();
		// REST 방식 요청
		restTemplate = new RestTemplate();
		
		// HTTP 요청 수행
	    ResponseEntity<ResponseAuthVO> responseEntity = 
	            restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, ResponseAuthVO.class);
	    logger.info("□□□□□□ 사용자인증 ResponseEntity.getBody() : " + responseEntity.getBody());

	    return responseEntity.getBody();
		
	}
	
	// 회원 계좌 출금(결제)
	public ResponseWithdrawVO requestWithdrawMember(int total_amount, String fintech_use_num, String access_token) {
		// 출금이체 요청 API 의 URL 생성 - POST 방식
		String url = baseUrl + "/v2.0/transfer/withdraw/fin_num";
		
		// 헤더 생성
		// => Content-Type 속성 JSON 형식으로 변경
		HttpHeaders httpHeaders = new HttpHeaders();
//			httpHeaders.add("Authorization", "Bearer " + map.get("access_token"));
//			httpHeaders.add("Content-Type", "application/json; charset=UTF-8"); // JSON 타입 요청 헤더 설정
		
		// 위의 코드와 동일한 작업을 수행하는 또 다른 방법
		httpHeaders.setBearerAuth(access_token); // Bearer 토큰 설정
		httpHeaders.setContentType(MediaType.APPLICATION_JSON); // JSON 타입 요청 헤더 설정
		
		// 요청 파라미터를 JSON 형식으로 생성하기 - org.json 패키지 클래스 활용
		JSONObject jo = new JSONObject();
		jo.put("bank_tran_id", valueGenerator.getBankTranId());
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분(N:계좌, C:계정 => N 고정)
		jo.put("cntr_account_num", "50000818"); // 약정계좌 계좌번호(테스트데이터 출금계좌 항목에 등록할 계좌번호) 사이트 계좌번호
		jo.put("dps_print_content", "펀뜩결제"); // 입금계좌 인자내역
		jo.put("fintech_use_num", fintech_use_num); // 출금계좌 핀테크이용번호(전달받은 값) 고객계좌
		jo.put("tran_amt", total_amount); // 거래금액 => 오픈뱅킹 사이트의 테스트데이터와 일치시켜야함
		jo.put("tran_dtime", valueGenerator.getTranDTime()); // 거래요청일시
		jo.put("req_client_name", "김보희"); // 거래를 요청한 사용자 이름 고객이름
		jo.put("req_client_fintech_use_num", fintech_use_num); // 거래를 요청한 사용자 핀테크번호
		jo.put("req_client_num", "1"); //  // 거래를 요청한 사용자 번호(아이디처럼 사용되는 번호, 임의부여)
		jo.put("transfer_purpose", "TR"); // 출금(송금)
		// 아래 3개 정보는 피싱 등의 사고 발생 시 지급 정지를 위한 정보(검증 수행하지 않음)
		jo.put("recv_client_name", "펀뜩"); // 출금이체 테스트 데이터 등록 시 수취인 성명에 기록할 이름 사이트이름
		jo.put("recv_client_bank_code", "002");
		jo.put("recv_client_account_num", "50000818"); // 아무번호 가능
		logger.info("□□□□□□ 출금이체 요청 JSON 데이터 : " + jo.toString());
		
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 파라미터 데이터로 JSONObject 객체를 문자열로 변환하여 전달 
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), httpHeaders);
		
		// 4. POST 요청 시 JSON 데이터를 전송하기 위해 RestTemplate 객체의 postForEntity() 메서드 호출
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 리턴되는 데이터를 관리하는 클래스 타입으로 지정
		//               (ResponseWithdrawVO 타입)
		// => 파라미터 : URL, HttpEntity 객체(요청 데이터 포함), 응답데이터 관리 클래스타입
		restTemplate = new RestTemplate();
		ResponseEntity<ResponseWithdrawVO> responseEntity = 
				restTemplate.postForEntity(url, httpEntity, ResponseWithdrawVO.class);
		logger.info("□□□□□□ 출금이체결과 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}
	
	// 환불
	public ResponseDepositVO requestDeposit(int total_amount, String fintech_use_num, String access_token) {
		// 입금이체 요청 API 의 URL 생성 - POST 방식
		String url = baseUrl + "/v2.0/transfer/deposit/fin_num";
		
		// 헤더 생성
		// => Content-Type 속성 JSON 형식으로 변경
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(access_token); // Bearer 토큰 설정
		httpHeaders.setContentType(MediaType.APPLICATION_JSON); // JSON 타입 요청 헤더 설정
		
		// 1개 입금정보를 저장할 JSONObject 객체 생성
		JSONObject joReq = new JSONObject();
		joReq.put("tran_no", "1"); // 거래순번
		joReq.put("bank_tran_id", valueGenerator.getBankTranId());
		joReq.put("fintech_use_num", fintech_use_num); // 입금계좌 핀테크이용번호(전달받은 값) => 고객계좌
		joReq.put("print_content", "펀뜩입금"); // 입금계좌 인자내역(테스트 데이터 등록)
		joReq.put("tran_amt", total_amount); // 거래금액(테스트 데이터 등록)
		joReq.put("req_client_name", "펀뜩"); // 거래를 요청한 사용자 이름
		joReq.put("req_client_fintech_use_num", fintech_use_num); // 거래를 요청한 사용자 핀테크번호 => 고객계좌
		joReq.put("req_client_num", "1"); //  // 거래를 요청한 사용자 번호(아이디처럼 사용되는 번호, 임의부여)
		joReq.put("transfer_purpose", "TR"); // 출금(송금)
		
		// 입금 정보를 배열로 관리할 JSONArray 객체 생성
		JSONArray jaReqList = new JSONArray();
		jaReqList.put(joReq);
		
		// 요청 파라미터를 JSON 형식으로 생성하기 - org.json 패키지 클래스 활용
		JSONObject jo = new JSONObject();
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분(N:계좌, C:계정 => N 고정)
		jo.put("cntr_account_num", "50000818"); // 약정계좌 계좌번호(테스트데이터 입금계좌 항목에 등록할 계좌번호)
		jo.put("wd_pass_phrase", "NONE"); // 테스트용은 "NONE" 값 고정
		jo.put("wd_print_content", "펀뜩결제"); // 출금계좌인자내역 => 아무거나
		jo.put("name_check_option", "on"); // 수취인성명 검증 여부(on:검증함) - 생략 시 기본값 on
		jo.put("tran_dtime", valueGenerator.getTranDTime()); // 거래요청일시
		jo.put("req_cnt", "1"); // 입금요청건수("1" 고정)
		jo.put("req_list", jaReqList); // 입금정보목록 - JSONArray 객체
		
		logger.info("□□□□□□ 입금이체 요청 JSON 데이터 : " + jo.toString());
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 파라미터 데이터로 JSONObject 객체를 문자열로 변환하여 전달 
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), httpHeaders);
		// 4. POST 요청 시 JSON 데이터를 전송하기 위해 RestTemplate 객체의 postForEntity() 메서드 호출
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 리턴되는 데이터를 관리하는 클래스 타입으로 지정
		//               (ResponseWithdrawVO 타입)
		// => 파라미터 : URL, HttpEntity 객체(요청 데이터 포함), 응답데이터 관리 클래스타입
		restTemplate = new RestTemplate();
		ResponseEntity<ResponseDepositVO> responseEntity = 
				restTemplate.postForEntity(url, httpEntity, ResponseDepositVO.class);
		logger.info("□□□□□□ 입금이체결과 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

	// 정산 - 1차 정산 입금
	public ResponseDepositVO requestDepositSettlement(Map<String, String> map) {
		
		// 입금이체 요청 API 의 URL 생성 - POST 방식
		String url = baseUrl + "/v2.0/transfer/deposit/fin_num";
		
		HttpHeaders httpHeaders = new HttpHeaders(); // 헤더 생성
		httpHeaders.setBearerAuth(map.get("access_token")); // Bearer 토큰 설정
		httpHeaders.setContentType(MediaType.APPLICATION_JSON); // JSON 타입 요청 헤더 설정
		
		// 1개 입금정보를 저장할 JSONObject 객체 생성
		JSONObject joReq = new JSONObject();
		joReq.put("tran_no", "1"); // 거래순번
		joReq.put("bank_tran_id", valueGenerator.getBankTranId());
		joReq.put("fintech_use_num", map.get("fintech_use_num")); // 입금계좌 핀테크이용번호(전달받은 값)
		joReq.put("print_content", "1차정산"); // 입금계좌 인자내역(테스트 데이터 등록)
		joReq.put("tran_amt", map.get("final_settlement")); // 거래금액(테스트 데이터 등록)
		joReq.put("req_client_name", "펀뜩"); // 거래를 요청한 사용자 이름
		joReq.put("req_client_fintech_use_num", map.get("fintech_use_num")); // 거래를 요청한 사용자 핀테크번호
		joReq.put("req_client_num", "1"); //  // 거래를 요청한 사용자 번호(아이디처럼 사용되는 번호, 임의부여)
		joReq.put("transfer_purpose", "TR"); // 출금(송금)
		
		// 입금 정보를 배열로 관리할 JSONArray 객체 생성
		JSONArray jaReqList = new JSONArray();
		jaReqList.put(joReq);
		
		// 요청 파라미터를 JSON 형식으로 생성
		JSONObject jo = new JSONObject();
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분(N:계좌, C:계정 => N 고정)
		jo.put("cntr_account_num", "50000818"); // 약정계좌 계좌번호(테스트데이터 입금계좌 항목에 등록할 계좌번호)
		jo.put("wd_pass_phrase", "NONE"); // 테스트용은 "NONE" 값 고정
		jo.put("wd_print_content", "1차정산"); // 출금계좌인자내역
		jo.put("name_check_option", "on"); // 수취인성명 검증 여부(on:검증함) - 생략 시 기본값 on
		jo.put("tran_dtime", valueGenerator.getTranDTime()); // 거래요청일시
		jo.put("req_cnt", "1"); // 입금요청건수("1" 고정)
		jo.put("req_list", jaReqList); // 입금정보목록 - JSONArray 객체
		
		logger.info("□□□□□□ 정산의 입금이체 요청 JSON 데이터 : " + jo.toString());
		
		// 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), httpHeaders);
		
		// POST 요청 시 JSON 데이터를 전송하기 위해 RestTemplate 객체의 postForEntity() 메서드 호출
		restTemplate = new RestTemplate();
		ResponseEntity<ResponseDepositVO> responseEntity = 
				restTemplate.postForEntity(url, httpEntity, ResponseDepositVO.class);
		logger.info("□□□□□□ 정산의 입금이체결과 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

}
