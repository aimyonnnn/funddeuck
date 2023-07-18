package com.itwillbs.test.vo;

import java.sql.Date;

import lombok.Data;

/*
계속 수정될 예정입니다
CREATE TABLE project (
    project_idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '프로젝트 번호',
    member_idx INT NOT NULL COMMENT '회원번호',
    project_category VARCHAR(255) NOT NULL COMMENT '카테고리',
    project_subject VARCHAR(255) NOT NULL COMMENT '내용',
    project_end_date DATE NOT NULL COMMENT '종료일자',
    search_tag VARCHAR(255) NOT NULL COMMENT '태그',
    maker_name VARCHAR(255) NOT NULL COMMENT '메이커 이름',
    maker_email VARCHAR(255) NOT NULL COMMENT '메이커 이메일',
    maker_tel VARCHAR(255) NOT NULL COMMENT '메이커 전화번호',
    maker_url VARCHAR(255) NOT NULL COMMENT '메이커 홈페이지',
    representative_name VARCHAR(255) NOT NULL COMMENT '대표자 이름',
    representative_email VARCHAR(255) NOT NULL COMMENT '대표자 이메일',
    representative_birth1 VARCHAR(6) NOT NULL COMMENT '대표자 주민번호 앞자리',
    representative_birth2 VARCHAR(7) NOT NULL COMMENT '대표자 주민번호 뒷자리',
    tax_email VARCHAR(255) NOT NULL COMMENT '세금계산서 발행 이메일',
    bank_category VARCHAR(255) NOT NULL COMMENT '은행 종류',
    bank_account VARCHAR(255) NOT NULL COMMENT '은행 계좌',
    bank_name VARCHAR(255) NOT NULL COMMENT '은행명'
    -- FOREIGN KEY (member_idx) REFERENCES member (member_idx)
);
*/

@Data
public class ProjectVO {
	private int project_idx;
	private String project_title;
	private String project_category;
	private String project_content;
	private String project_image;
	private Date project_start_date;
	private Date project_end_date;
	private int project_like;
	private Date project_create_date;
	private Date project_status;
	private int maker_idx;
}
