package com.itwillbs.test.vo;

import lombok.Data;
/* 프로필 테이블
 *  create table profile(
 	profile_idx int PRIMARY KEY AUTO_INCREMENT, -- 프로파일 번호
 	member_idx int not null,
 	profile_job1 varchar(20),
 	profile_job2 varchar(20),
	profile_school1 varchar(20),
	profile_school2 varchar(20),
	profile_text varchar(100),
	profile_img varchar(100)
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
    
}
