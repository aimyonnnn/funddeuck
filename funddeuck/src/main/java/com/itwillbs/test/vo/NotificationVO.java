package com.itwillbs.test.vo;

import java.sql.Timestamp;

import lombok.Data;

/*
-- 알림(메시지) 테이블
CREATE TABLE notification (
    notification_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '알림번호',
    member_id VARCHAR(50) NOT NULL COMMENT '회원아이디',
    notification_subject VARCHAR(100) NOT NULL COMMENT '알림제목',
    notification_content VARCHAR(1000) NOT NULL COMMENT '알림내용',
    notification_regdate TIMESTAMP NOT NULL COMMENT '생성날짜',
    notification_read_status INT NOT NULL COMMENT '알림상태: 1-읽지 않음, 2-읽음',
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);
*/

@Data
public class NotificationVO {
	private int notification_idx;              // 알림번호
    private String member_id;				   // 회원아이디
    private String notification_subject;	   // 알림제목
    private String notification_content;	   // 알림내용
    private Timestamp notification_regdate;	   // 생성날짜
    private int notification_read_status;	   // 알림상태 1-읽지 않음, 2-읽음
}
