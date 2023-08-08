package com.itwillbs.test.vo;

import lombok.*;
// 입금이체 API 응답 데이터의 1개 입금 정보를 관리하는 클래스 정의
@Data
public class DepositInfoVO {
	private String tran_no; // 거래순번
	private String bank_tran_id; // 거래고유번호
	private String bank_tran_date; // 거래일자
	private String bank_code_tran; // 응답코드를부여한참가은행표준코드 
	private String bank_rsp_code; // 응답코드
	private String bank_rsp_message; // 응답메세지
	private String fintech_use_num; // 핀테크이용번호
	private String account_alias; // 계좌별명
	private String bank_code_std; // 입금기관표준코드
	private String bank_code_sub; // 입금기관점별코드
	private String bank_name; // 입금기관
	private String savings_bank_name; // 개별저축은행명
	private String account_num_masked; // 입금계좌번호(출력용)
	private String print_content; // 입금계좌인자내역
	private String account_holder_name; // 수취인성명
	private String tran_amt; // 거래금액
	private String cms_num; // CMS 번호
}
