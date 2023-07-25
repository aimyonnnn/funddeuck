package com.itwillbs.test.vo;

import lombok.Data;
/*
CREATE TABLE members (
	member_idx int PRIMARY KEY AUTO_INCREMENT COMMENT '회원번호(PK)',
	member_name varchar(20) NOT NULL COMMENT '회원이름',
	member_id varchar(20) NOT NULL UNIQUE COMMENT '회원아이디',
	member_passwd varchar(50) NOT NULL COMMENT '회원비밀번호',
	member_email varchar(50) NOT NULL COMMENT '회원이메일',
	member_phone varchar(20) NOT NULL COMMENT '회원전화번호',
	false_count int NOT NULL DEFAULT 0 COMMENT '로그인 실패 카운트'
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
	private int false_count;
	
}
