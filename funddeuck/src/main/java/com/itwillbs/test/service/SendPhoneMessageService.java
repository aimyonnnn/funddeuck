package com.itwillbs.test.service;

import java.util.HashMap;

import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class SendPhoneMessageService {
	
	public String SendMessage(String memberPhone, String message, int projectIdx) throws CoolsmsException{
		System.out.println("문자발송되었음");
		String api_key = "NCSDN9DK2QVHTNK3"; // 실제 테스트 시에 바꿔줘야함!
		String api_secret = "J62CUX5Q1HVNPUB3TFFN1FM1DWMNL7ZC"; // 실제 테스트 시에 바꿔줘야함!
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", memberPhone);    // 수신전화번호
	    params.put("from", "01041532874"); // 발신전화번호, 실제 테스트 시에 바꿔줘야함!
	    params.put("type", "sms"); 
	    params.put("text", message);
	 
	    coolsms.send(params); // 메시지 전송
			  
		return "true";
	}
	
}
