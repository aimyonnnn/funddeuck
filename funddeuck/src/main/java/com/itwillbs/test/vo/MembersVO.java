package com.itwillbs.test.vo;

import java.sql.Timestamp;
import java.time.LocalDate;

import lombok.Data;
/*
CREATE TABLE members (
    member_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '회원번호(PK)',
    member_name VARCHAR(20) NOT NULL COMMENT '회원이름',
    member_id VARCHAR(20) NOT NULL UNIQUE COMMENT '회원아이디',
    member_passwd VARCHAR(100) NOT NULL COMMENT '회원비밀번호',
    member_email VARCHAR(50) NOT NULL UNIQUE COMMENT '회원이메일',
    member_phone VARCHAR(20) NOT NULL COMMENT '회원전화번호',
    member_status INT NOT NULL DEFAULT 1 COMMENT '회원상태',
    member_grade INT NOT NULL DEFAULT 1 COMMENT '회원등급',
    false_count INT NOT NULL DEFAULT 0 COMMENT '로그인 실패 카운트',
    join_date DATETIME NOT NULL DEFAULT NOW() COMMENT '회원가입일'
);
*/

@Data
public class MembersVO {
	private int member_idx;
	private String member_name;
	private String member_id;
	private String member_passwd;
	private String member_email;
	private String member_phone;
	private int member_status;
	private String member_grade;
	private int false_count;
	private Timestamp join_date;
	
	//
	private int reward_idx;
	private int project_idx;
	private int maker_idx;
	
	// 회원 차트용
	private LocalDate date;
	private int count;
}
