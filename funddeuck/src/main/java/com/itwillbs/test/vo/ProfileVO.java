package com.itwillbs.test.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
 * CREATE TABLE profile(
  profile_idx int PRIMARY KEY AUTO_INCREMENT COMMENT '�������� ��ȣ(PK)',
  member_idx int NOT NULL COMMENT 'ȸ����ȣ(FK)',
  profile_job1 varchar(20) NOT NULL COMMENT 'ȸ��',
  profile_job2 varchar(20) NOT NULL COMMENT '��å',
  profile_school1 varchar(20) NOT NULL COMMENT '�б�',
  profile_school2 varchar(20) NOT NULL COMMENT '�а�',
  profile_text varchar(100) NOT NULL COMMENT '�ڱ�Ұ�',
  profile_img varchar(300) NOT NULL COMMENT '�����ʻ���',
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
