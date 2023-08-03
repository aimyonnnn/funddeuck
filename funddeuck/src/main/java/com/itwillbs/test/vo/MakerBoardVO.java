package com.itwillbs.test.vo;

import org.springframework.web.multipart.MultipartFile;

import com.google.protobuf.Timestamp;

import lombok.Data;

/*
-- 메이커 공지사항 게시판 생성
create table maker_board (
	maker_board_idx int not null primary key auto_increment comment '메이커 게시판 번호',
	maker_idx int not null comment '메이커 번호',
	maker_board_subject varchar(255) not null comment '게시판 제목',
	maker_baord_content varchar(1000) not null comment '게시판 내용',
	maker_board_regdate timestamp not null comment '게시판 등록일자',
	maker_board_file1 varchar(255) comment '게시판 첨부파일',
	foreign key (maker_idx) references maker(maker_idx) ON DELETE CASCADE
);
 */

@Data
public class MakerBoardVO {
	private int maker_board_idx;
	private int maker_idx;
	private String maker_board_subject;
	private String maker_baord_content;
	private Timestamp maker_board_regdate;
	private String maker_board_file1;
	// 주의! 폼에서 전달받는 실제 파일 자체를 다룰 MultipartFile 타입 변수 선언도 필요
	// => 이 때, 멤버변수명은 input type="file" 태그의 name 속성명(파라미터명)과 동일해야함
	private MultipartFile file1;
}
