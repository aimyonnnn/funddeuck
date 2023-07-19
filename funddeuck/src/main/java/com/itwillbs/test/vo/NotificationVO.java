package com.itwillbs.test.vo;

import java.sql.Timestamp;

import lombok.Data;

/*
-- 알림(메시지) 테이블 (프로젝트 등록 내 관리자 피드백)
CREATE TABLE notification (
  notification_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '알림번호',
  member_id VARCHAR(50) NOT NULL COMMENT '회원아이디',
  notification_content VARCHAR(500) NOT NULL COMMENT '알림내용',
  notification_regdate TIMESTAMP NOT NULL COMMENT '생성날짜',
  notification_read_status INT NOT NULL COMMENT '알림상태: 1-읽지 않음, 2-읽음'
  -- FOREIGN KEY (member_id) REFERENCES member(member_id)
);
*/

@Data
public class NotificationVO {
	private int notification_idx;              // 알림번호
    private String member_id;				   // 회원아이디
    private String notification_content;	   // 알림내용
    private Timestamp notification_regdate;	   // 생성날짜
    private int notification_read_status;	   // 알림상태 1-읽지 않음, 2-읽음
}
