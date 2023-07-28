package com.itwillbs.test.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
 * CREATE TABLE profile(
  profile_idx int PRIMARY KEY AUTO_INCREMENT COMMENT '프로파일 번호(PK)',
  member_idx int NOT NULL COMMENT '회원번호(FK)',
  profile_job1 varchar(20) NOT NULL COMMENT '회사',
  profile_job2 varchar(20) NOT NULL COMMENT '직책',
  profile_school1 varchar(20) NOT NULL COMMENT '학교',
  profile_school2 varchar(20) NOT NULL COMMENT '학과',
  profile_text varchar(100) NOT NULL COMMENT '자기소개',
  profile_img varchar(300) NOT NULL COMMENT '프로필사진',
  FOREIGN KEY (member_idx) REFERENCES members(member_idx)
 );
 */
@Data
public class ProfileVO {
	private int profile_idx;
	private int member_idx;
	private String profile_job1;
	private String profile_job2;
	private String profile_school1;
	private String profile_school2;
	private String profile_text;
	private String profile_img;
	//
	private MultipartFile file;
	
}
