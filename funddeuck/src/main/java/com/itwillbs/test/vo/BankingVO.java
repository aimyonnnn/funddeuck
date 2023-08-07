package com.itwillbs.test.vo;

import lombok.*;

@Data
public class BankingVO { 
	private int banking_idx;
//	private int member_idx;
	private String member_id;
	private int project_idx;
	private String banking_bank_name; // 은행명
	private String banking_account_num_masked; // 계좌번호(마스킹)
	private String banking_bank_tran_date; // 거래일자
	private String banking_account_holder_name; // 수취(송금)인 성명
	private String banking_tran_amt; // 거래금액
	private String banking_print_content; // 계좌인자내역
	private int banking_status; // 거래상태 1-입금, 2-출금

}
