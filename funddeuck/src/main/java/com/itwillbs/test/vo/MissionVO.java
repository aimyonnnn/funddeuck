package com.itwillbs.test.vo;

import java.sql.Timestamp;

import lombok.Data;
/*

-- 메이커 챌린지를 위한 미션 테이블 생성 
CREATE TABLE mission (
    mission_idx INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '미션 번호',
    maker_idx INT NOT NULL COMMENT '메이커번호',
    mission_name VARCHAR(255) NOT NULL COMMENT '미션 이름',
    points INT NOT NULL DEFAULT 0 COMMENT '획득한 점수',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '미션 완료 일시',
    UNIQUE KEY unique_mission (maker_idx, mission_name), -- 중복 미션 방지를 위한 유니크 키 설정
    foreign key (maker_idx) references maker(maker_idx) ON DELETE CASCADE
);

*/
@Data
public class MissionVO {
	private int mission_idx;
    private int member_idx;
    private String mission_name;
    private int points;
    private Timestamp created_at;
    // 현재 점수
    private int total_points;
}
