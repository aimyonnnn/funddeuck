package com.itwillbs.test.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.controller.BankController;
import com.itwillbs.test.mapper.SendPhoneMessageMapper;
import com.itwillbs.test.vo.SendPhoneMessageVO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class SendPhoneMessageService {
	
	@Autowired
	private SendPhoneMessageMapper mapper;
	
	private static final Logger logger = LoggerFactory.getLogger(SendPhoneMessageService.class);

	
	// 문자 발송
	public String SendMessage(String memberId, String memberPhone, String message, int projectIdx) throws CoolsmsException{
		System.out.println("문자발송되었음");
		String api_key = "NCSDN9DK2QVHTNK3"; 								// 실제 테스트 시에 바꿔줘야함!
		String api_secret = "J62CUX5Q1HVNPUB3TFFN1FM1DWMNL7ZC"; 			// 실제 테스트 시에 바꿔줘야함!
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", memberPhone);   									 // 수신전화번호
	    params.put("from", "01041532874"); 									 // 발신전화번호, 실제 테스트 시에 바꿔줘야함!
	    params.put("type", "sms"); 
	    params.put("text", message);										 // 메시지 내용
	 
	    coolsms.send(params); 												 // 메시지 전송
	    
	    int insertCount = mapper.insertSms(memberId, memberPhone, message);
	    if(insertCount > 0) {
	    	logger.info("■■■■■ 문자 발송 내역이 저장되었습니다.");
	    } else {
	    	logger.info("■■■■■ 문자 발송 내역 저장에 실패하였습니다.");
	    }
	    
		return "true";
	}
	
	// 관리자 - 문자 리스트 조회
	public List<SendPhoneMessageVO> getAllSmsList(String searchKeyword, String searchType, int startRow, int listLimit) {
		return mapper.selectAllSmsList(searchKeyword, searchType, startRow, listLimit);
	}
	
	// 관리자 - 문자 갯수 조회
	public int getAllSmsListCount(String searchKeyword, String searchType) {
		return mapper.selectAllSmsListCount(searchKeyword, searchType);
	}
	
}
