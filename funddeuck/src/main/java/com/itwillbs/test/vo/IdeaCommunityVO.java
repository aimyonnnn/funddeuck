package com.itwillbs.test.vo;

import lombok.*;

/* 아이디어 테이블 생성
CREATE TABLE idea(
  idea_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '아이디어 번호(PK)',
  title VARCHAR(200) NOT NULL COMMENT '제목',
  member_idx INT NOT NULL COMMENT '회원 번호(FK)',
  description VARCHAR(800) NOT NULL COMMENT '내용',
  today DATETIME NOT NULL DEFAULT NOW() COMMENT '작성날짜',
  likecount INT NOT NULL COMMENT '좋아요수',
  FOREIGN KEY (member_idx) REFERENCES members(member_idx)
);
 */

@Data
public class IdeaCommunityVO {
    private int idea_idx;
    private String title;
    private int member_idx;
    private String description;
    private String today;
    private int likecount;
}