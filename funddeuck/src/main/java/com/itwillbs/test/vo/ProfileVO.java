package com.itwillbs.test.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
 * CREATE TABLE profile(
  profile_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '프로필 번호(PK)',
  member_idx INT NOT NULL COMMENT '회원 번호(FK)',
  profile_job1 VARCHAR(20) NOT NULL COMMENT '직업',
  profile_job2 VARCHAR(20) NOT NULL COMMENT '부업',
  profile_school1 VARCHAR(20) NOT NULL COMMENT '학교',
  profile_school2 VARCHAR(20) NOT NULL COMMENT '대학',
  profile_text VARCHAR(100) NOT NULL COMMENT '자기소개',
  profile_img VARCHAR(300) NOT NULL COMMENT '프로필 이미지 경로',
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
