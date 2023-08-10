package com.itwillbs.test.vo;

import lombok.*;

@Data
public class BankingVO { 
	private int banking_idx;
//	private int member_idx;
	private String member_id;
	private int project_idx;
	private String banking_bank_name; // 은행명 카드사
	private String banking_account_num_masked; // 계좌번호(마스킹) 승인번호
	private String banking_bank_tran_date; // 거래일자
	private String banking_account_holder_name; // 수취(송금)인 성명
	private String banking_tran_amt; // 거래금액
	private String banking_print_content; // 계좌인자내역
	private int banking_status; // 거래상태 1-입금, 2-출금
	// 타입만들어서 은행인지 카드인지 
	
	
	// =====================================================================
	// 정산내역 출력용
	private String project_subject;
	private String project_representative_name;
	private int project_status;
}
