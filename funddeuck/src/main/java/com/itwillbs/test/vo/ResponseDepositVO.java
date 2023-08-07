package com.itwillbs.test.vo;

import java.util.*;

import lombok.*;
// 입금이체 API 응답 데이터를 관리하는 클래스 정의
@Data
public class ResponseDepositVO {
	private String api_tran_id; // 거래고유번호
	private String api_tran_dtm; // 거래일시
	private String rsp_code; // 응답코드
	private String rsp_message; // 응답메세지
	private String wd_bank_code_std; // 출금기관표준코드
	private String wd_bank_code_sub; // 출금기관점별코드
	private String wd_bank_name; // 출금기관명
	private String wd_account_num_masked; // 출금계좌번호
	private String wd_print_content; // 출금계좌인자내역
	private String wd_account_holder_name; // 송금성명
	private String res_cnt; // 입금건수
	private List<DepositInfoVO> res_list; // 입금목록
}
