package com.itwillbs.test.vo;

import java.sql.Timestamp;

import lombok.Data;

/*
-- 프로젝트 커뮤니티 게시판 생성
create table project_community (
	project_community_idx int not null primary key auto_increment comment '프로젝트 커뮤니티 게시물 번호',
	project_idx int not null comment '프로젝트 번호',
	member_id varchar(20) not null comment '작성자 아이디',
	project_community_subject varchar(255) not null comment '프로젝트 커뮤니티 게시물 제목',
	project_community_content varchar(1000) not null comment '프로젝트 커뮤니티 게시물 내용',
	project_community_regdate timestamp not null comment '프로젝트 커뮤니티 게시물 등록일자',
	foreign key (member_idx) references members(member_idx) ON DELETE CASCADE,
	foreign key (project_idx) references project(project_idx) ON DELETE CASCADE
);
*/
@Data
public class ProjectCommunityVO {
	
	private int project_community_idx;            // '프로젝트 커뮤니티 게시물 번호'
	private int project_idx;                      // '프로젝트 번호'
	private String member_id;                     // '작성자 아이디'
	private String project_community_subject;     // '프로젝트 커뮤니티 게시물 제목'
	private String project_community_content;     // '프로젝트 커뮤니티 게시물 내용'
	private Timestamp project_community_regdate;  // '프로젝트 커뮤니티 게시물 등록일자'
}
