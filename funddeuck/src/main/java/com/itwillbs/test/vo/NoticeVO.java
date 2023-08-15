package com.itwillbs.test.vo;

import java.sql.*;

import org.springframework.web.multipart.*;

import lombok.*;

// 공지사항
@Data
public class NoticeVO {
	private int notice_idx;
	private int notice_category;
	private String notice_name;
	private String notice_subject;
	private String notice_content;
	// 실제 파일명을 저장할 변수 선언
	private String notice_thumnail;
	private String notice_file;
	// MultipartFile 타입 변수 선언
	private MultipartFile thumnail;
	private MultipartFile file;
	private int notice_re_ref;
	private int notice_re_lev;
	private int notice_re_seq;
	private int notice_readcount;
	private Timestamp notice_date;

}
