package com.itwillbs.test.vo;

import lombok.*;


// 사용자인증 응답 데이터
@Data
public class ResponseAuthVO {
	private String code; // 
	private String scope; // 
	private String client_info; // 
	private String state; // 
}
