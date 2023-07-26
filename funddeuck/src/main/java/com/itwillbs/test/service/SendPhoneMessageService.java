package com.itwillbs.test.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class SendPhoneMessageService {
	
	public String SendMessage(String memberPhone, String message) throws CoolsmsException{
		String api_key = "NCSDN9DK2QVHTNK3"; // 실제 테스트 시에 바꿔줘야함!
		String api_secret = "#"; // 실제 테스트 시에 바꿔줘야함!
		Message coolsms = new Message(api_key, api_secret);
			
		HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", memberPhone);    // 수신전화번호
	    params.put("from", "01041532874"); // 발신전화번호, 실제 테스트 시에 바꿔줘야함!
	    params.put("type", "sms"); 
	    params.put("text", "프로젝트 승인이 완료되었습니다. 아래 페이지에서 요금 결제를 진행해주세요.");
	 
	    coolsms.send(params); // 메시지 전송
			  
		return "true";
	}
	
}
