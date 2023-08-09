package com.itwillbs.test.vo;

import java.util.*;

import lombok.*;

// 사용자 계좌 1개의 정보 관리하는 클래스 정의
@Data
public class BankAccountVO {
	private int bankAccount_idx; 
	private int member_idx;
	private String fintech_use_num; // 핀테크이용번호
	private String account_alias; // 계좌별명
	private String bank_code_std; // 출금기관표준코드
	private String bank_code_sub; // 출금기관점별코드
	private String bank_name; // 출금기관명
	private String savings_bank_name; // 개별저축은행명
	private String account_num; // 계좌번호
	private String account_num_masked; // 계좌번호(마스킹)
	private String account_seq; // 회차번호
	private String account_holder_name; // 계좌예금주명
	private String account_holder_type; // 계좌구분(P:개인)
	private String inquiry_agree_yn; // 조회서비스 동의여부
//	private String inquiry_agree_dtime; // 조회서비스 동의일시
	private Date inquiry_agree_dtime; // 조회서비스 동의일시
	private String transfer_agree_yn; // 출금서비스 동의여부
	private String transfer_agree_dtime; // 출금서비스 동의일시
	private String account_state; // 계좌상태
//	private String user_ci; // 사용자 CI (사용자인증생략 API사용시 필요)
}