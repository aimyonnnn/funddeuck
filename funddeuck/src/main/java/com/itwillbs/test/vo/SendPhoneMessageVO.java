package com.itwillbs.test.vo;

import java.sql.Timestamp;

import lombok.Data;

/*
-- SMS 문자 관리 테이블 생성
CREATE TABLE sms_history (
    sms_idx INT NOT NULL PRIMARY KEY auto_increment comment 'sms번호',
    member_id VARCHAR(20) NOT NULL COMMENT '회원아이디',
    sent_date timestamp NOT NULL COMMENT '발송날짜',
    recipient VARCHAR(255) NOT NULL COMMENT '수신자 전화번호',
    message TEXT NOT NULL COMMENT '메시지내용',
    status INT NOT NULL COMMENT 'sms상태 1-발송완료 2-발송실패',
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);
*/

@Data
public class SendPhoneMessageVO {
	private int sms_idx;					// sms번호
    private String member_id;				// 회원아이디
    private Timestamp sent_date;			// 발송날짜
    private String recipient;				// 수신자 전화번호
    private String message;					// 메시지내용
    private int status;						// sms상태 1-발송완료 2-발송실패
}
