package com.itwillbs.test.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ActivityListVO {			// 관리자 - 회원 활동내역 
	private String activity_type; 	// 테이블타입
	private Date activity_date; 		// 활동날짜
	private String content;			// 활동내용
}
