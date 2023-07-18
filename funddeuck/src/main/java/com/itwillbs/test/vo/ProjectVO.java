package com.itwillbs.test.vo;

import java.sql.Date;

import lombok.Data;

/*
프로젝트 정보를 관리하는 project 테이블 정의
---------------------------------------
프로젝트 번호(project_idx) - 정수, PK, AUTO_INCREMENT
프로젝트 이름(project_title) - 문자(50자), NN
프로젝트 카테고리(project_category) - 문자(10자), NN
프로젝트 내용(project_content) - 문자(500자)
프로젝트 이미지(project_image) - 문자(500자)
프로젝트 시작일(project_start_date) - 날짜(DATE), NN
프로젝트 종료일(project_end_date) - 날짜(DATE), NN
프로젝트 즐겨찾기 수(project_like) - 정수
프로젝트 등록일(project_create_date) - 날짜 및 시각, NN
프로젝트 상태(project_status) - 정수, NN
프로젝트 메이커(maker_idx) - 정수
---------------------------------------
CREATE TABLE project (
	project_idx INT PRIMARY KEY AUTO_INCREMENT,
	project_title VARCHAR(50) NOT NULL,
	project_category VARCHAR(10) NOT NULL,
	project_content VARCHAR(500),
	project_image VARCHAR(100),
	project_start_date DATE NOT NULL,
	project_end_date DATE NOT NULL,
	project_like INT,
	project_create_date DATETIME NOT NULL,
	project_status INT NOT NULL,
	FOREIGN KEY (maker_idx) REFERENCES maker_idx(maker_idx) ON DELETE CASCADE
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
