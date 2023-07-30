package com.itwillbs.test.vo;

import lombok.Data;

@Data
public class ResponseTokenVO {
	private int token_idx; // 토큰 고유번호
	private int member_idx; // 회원 번호(참조)
	private String access_token; // 액세스 토큰
	private String token_type; // 토큰 타입
	private String expires_in; // 만료 기간
	private String refresh_token; // 갱신 시 사용하는 토큰
	private String scope; // 권한 범위
	private String user_seq_no; // 사용자 일련번호
}
