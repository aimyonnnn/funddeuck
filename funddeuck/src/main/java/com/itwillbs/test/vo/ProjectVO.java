package com.itwillbs.test.vo;

import java.sql.Date;

import lombok.Data;

/*
-- 프로젝트 테이블 생성
CREATE TABLE project (
    project_idx int PRIMARY KEY AUTO_INCREMENT COMMENT '프로젝트 번호',
    project_category varchar(10) NOT NULL COMMENT '프로젝트 카테고리',
    project_subject varchar(30) NOT NULL COMMENT '프로젝트 제목',
    project_thumnails1 varchar(100) NOT NULL COMMENT '프로젝트 썸네일 (1)',
    project_thumnails2 varchar(100) COMMENT '프로젝트 썸네일 (2)',
    project_thumnails3 varchar(100) COMMENT '프로젝트 썸네일 (3)',
    project_image varchar(100) NOT NULL COMMENT '프로젝트 내용 상세 이미지',
    project_introduce varchar(300) NOT NULL COMMENT '프로젝트 소개',
    project_target int NOT NULL COMMENT '목표 금액',
    project_start_date date NOT NULL COMMENT '프로젝트 시작일',
    project_end_date date NOT NULL COMMENT '프로젝트 종료일',
    project_hashtag1 varchar(20) NOT NULL COMMENT '검색용 태그1',
    project_hashtag2 varchar(20) COMMENT '검색용 태그2',
    project_hashtag3 varchar(20) COMMENT '검색용 태그3',
    project_representative_name varchar(50) NOT NULL COMMENT '대표자명',
    project_representative_email varchar(50) NOT NULL COMMENT '대표 이메일',
    project_representative_birth varchar(14) NOT NULL COMMENT '대표 주민등록번호',
    project_tax_email varchar(50) NOT NULL COMMENT '세금계산서 발행 이메일',
    project_settlement_bank varchar(20) NOT NULL COMMENT '정산받을 은행',
    project_settlement_account varchar(30) NOT NULL COMMENT '정산받을 계좌번호',
    project_settlement_name varchar(50) NOT NULL COMMENT '예금주명',
    project_settlement_image varchar(100) NOT NULL COMMENT '통장사본 이미지',
    project_approve_status int NOT NULL COMMENT '프로젝트 승인 상태',
    member_idx int NOT NULL COMMENT '멤버 번호',
    FOREIGN KEY (member_idx) references member(member_idx)
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
