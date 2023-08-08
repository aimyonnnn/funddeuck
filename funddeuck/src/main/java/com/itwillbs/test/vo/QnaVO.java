package com.itwillbs.test.vo;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
QNA 정보를 관리하는 qna 테이블 정의
---------------------------------------
CREATE TABLE qna (
	qna_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '문의번호(PK)',
	member_id VARCHAR(20) NOT NULL COMMENT '회원아이디(FK)',
	qna_division int NOT NULL comment '서포터/메이커 구분 - 1 : 메이커 , 2: 서포터',
	qna_subject VARCHAR(50) NOT NULL COMMENT '문의 제목',
	qna_context VARCHAR(10) NOT NULL COMMENT '문의 내용',
  	qna_date DATETIME NOT NULL comment '문의시간',
  	qna_file VARCHAR(100) comment '첨부파일',
 	FOREIGN KEY (member_id) REFERENCES members(member_id) 
);
*/
@Data
public class QnaVO {
	private int qna_idx;
	private String member_id;
	private int qna_division;
	private String qna_subject;
	private String qna_context;
	private String qna_file;
	private Timestamp qna_date;
	
	// 첨부파일을 받기 위해 추가
	private MultipartFile file1;
}
