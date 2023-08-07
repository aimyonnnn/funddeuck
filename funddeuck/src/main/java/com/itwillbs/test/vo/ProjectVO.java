package com.itwillbs.test.vo;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
-- 프로젝트 테이블 생성
CREATE TABLE project (
    project_idx int PRIMARY KEY AUTO_INCREMENT COMMENT '프로젝트 번호',
    project_plan int NOT NULL COMMENT '프로젝트 요금제: 1- 기본요금제, 2-인플루언서요금제',
    project_category varchar(10) NOT NULL COMMENT '프로젝트 카테고리',
    project_subject varchar(30) NOT NULL COMMENT '프로젝트 제목',
    project_thumnails1 varchar(100) NOT NULL COMMENT '프로젝트 썸네일 (1)',
    project_thumnails2 varchar(100) COMMENT '프로젝트 썸네일 (2)',
    project_thumnails3 varchar(100) COMMENT '프로젝트 썸네일 (3)',
    project_image varchar(100) NOT NULL COMMENT '프로젝트 내용 상세 이미지',
    project_introduce varchar(300) NOT NULL COMMENT '프로젝트 소개',
    project_semi_introduce varchar(150) NOT NULL COMMENT '프로젝트 한줄 소개',
    project_target int NOT NULL COMMENT '목표 금액',
	project_cumulative_amount int COMMENT '누적 금액',
    project_start_date date NOT NULL COMMENT '프로젝트 시작일',
    project_end_date date NOT NULL COMMENT '프로젝트 종료일',
    project_hashtag varchar(20) NOT NULL COMMENT '검색용 태그',
    project_representative_name varchar(50) NOT NULL COMMENT '대표자명',
    project_representative_email varchar(50) NOT NULL COMMENT '대표 이메일',
    project_representative_birth varchar(14) NOT NULL COMMENT '대표 주민등록번호',
    project_tax_email varchar(50) NOT NULL COMMENT '세금계산서 발행 이메일',
    project_settlement_bank varchar(20) NOT NULL COMMENT '정산받을 은행',
    project_settlement_account varchar(30) NOT NULL COMMENT '정산받을 계좌번호',
    project_settlement_name varchar(50) NOT NULL COMMENT '예금주명',
    project_fintech_use_num varchar(50) NOT NULL COMMENT '핀테크이용번호',
    project_settlement_image varchar(100) NOT NULL COMMENT '통장사본 이미지',
    project_approve_status int NOT NULL COMMENT '프로젝트 승인 상태 1-미승인 2-승인요청 3-승인완료 4-승인거절 5-결제완료(펀딩+ 페이지에 출력 가능한 상태)',
    project_status int NOT NULL COMMENT '프로젝트 상태 1-미진행 2-진행중 3-진행완료 4-정산신청 5-정산완료',
	project_approval_request_time DATETIME COMMENT '프로젝트 승인 요청 시간',
    maker_idx int NOT NULL COMMENT '메이커 번호',
	token_idx int NOT NULL COMMENT '프로젝트 인증에 사용될 토큰 번호',
	first_amount INT DEFAULT 0 COMMENT '1차 정산금액',
    settlement_status INT NOT NULL DEFAULT 1 COMMENT '정산 상태(1: 미정산, 2:1차정산완료, 3:최종정산완료)'
    FOREIGN KEY (maker_idx) REFERENCES maker(maker_idx) ON DELETE CASCADE,
	FOREIGN KEY (token_idx) references token(token_idx) ON DELETE CASCADE
);

*/

@Data
public class ProjectVO {
	private int project_idx;								// 프로젝트 번호
	private int project_plan;								// 프로젝트 요금제
	private String project_category;						// 프로젝트 카테고리
	private String project_subject;							// 프로젝트 제목
	private String project_thumnails1;						// 프로젝트 썸네일 (1)
	private String project_thumnails2;						// 프로젝트 썸네일 (2)
	private String project_thumnails3;						// 프로젝트 썸네일 (3)
	private String project_image;							// 프로젝트 내용 상세 이미지
	private String project_introduce;						// 프로젝트 소개
	private String project_semi_introduce;					// 프로젝트 한 줄 소개
	private int project_target;								// 목표 금액
	private int project_cumulative_amount;					// 누적 금액
	private int project_amount;								// 프로젝트 달성 금액
	private Date project_start_date;						// 프로젝트 시작일
	private Date project_end_date;							// 프로젝트 종료일
	private String project_hashtag;							// 검색용 태그
	private String project_representative_name;				// 대표자명
	private String project_representative_email;			// 대표 이메일
	private String project_representative_birth;			// 대표 주민등록번호
	private String project_tax_email;						// 세금계산서 발행 이메일
	private String project_settlement_bank;					// 정산받을 은행
	private String project_settlement_account;				// 정산받을 계좌번호
	private String project_settlement_name;					// 예금주명
	private String project_fintech_use_num;					// 프로젝트 핀테크 이용번호
	private String project_settlement_image;				// 통장사본 이미지
	private int project_approve_status;						// 프로젝트 승인 상태
	private Timestamp project_approval_request_time;    	// 프로젝트 승인 요청 시간 1-미승인 2-승인요청 3-승인완료 4-승인거절 5-결제완료(펀딩+ 페이지에 출력 가능한 상태)
	private int project_status;								// 프로젝트 상태 프로젝트 상태 1-미진행 2-진행중 3-진행완료 4-정산신청 5-정산완료
	private int maker_idx;									// 메이커 번호
	private int token_idx;									// 프로젝트 계좌 인증에 사용될 토큰 번호
	private int first_amount;								// 1차 정산금액
	private int settlement_status;							// 정산 상태 1-미정산, 2-1차정산완료, 3-최종정산완료
	
	private MultipartFile file1;							// 프로젝트 썸네일 (1)
 	private MultipartFile file2;							// 프로젝트 썸네일 (2)
 	private MultipartFile file3;							// 프로젝트 썸네일 (3)
 	private MultipartFile file4;							// 프로젝트 내용 상세 이미지
 	private MultipartFile file5;							// 통장사본 이미지
}