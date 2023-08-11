package com.itwillbs.test.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
 CREATE TABLE doctor (
	doctor_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '펀딩닥터 번호',
	project_idx INT NOT NULL COMMENT '프로젝트번호',
	doctor_subject VARCHAR(20) NOT NULL COMMENT '펀딩닥터 제목',
	doctor_content VARCHAR(500) NOT NULL COMMENT '펀딩닥터 내용',
	doctor_file VARCHAR(255) COMMENT '펀딩닥터 첨부파일',
	FOREIGN key(project_idx) REFERENCES project(project_idx)
 );
 */
@Data
public class FundingDoctorVO {
	private int doctor_idx;					// 펀딩닥터 번호
	private int project_idx;				// 프로젝트 번호
	private String doctor_subject;			// 펀딩닥터 제목
	private String doctor_content;			// 펀딩닥터 내용
	private String doctor_file;				// 펀딩닥터 첨부파일
	private MultipartFile file1;			// 펀딩닥터 첨부파일
	
	
	// 답변 페이지 출력용
	private String project_subject;
}
