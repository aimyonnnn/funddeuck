package com.itwillbs.test.vo;

import lombok.Data;

/*
-- 리워드 테이블 생성
CREATE TABLE reward (
    reward_idx INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '리워드 번호',
    project_idx INT NOT NULL COMMENT '프로젝트 번호',
    reward_price INT NOT NULL COMMENT '리워드 가격',
    reward_category VARCHAR(100) COMMENT '리워드 카테고리',
    reward_name VARCHAR(500) COMMENT '리워드명',
    reward_quantity INT NOT NULL COMMENT '리워드 수량',
    reward_residual_quantity INT NOT NULL COMMENT '리워드 잔여 수량',
    reward_option VARCHAR(255) NOT NULL COMMENT '리워드 옵션',
    reward_detail VARCHAR(1000) NOT NULL COMMENT '리워드 설명',
    delivery_status VARCHAR(50) NOT NULL COMMENT '배송여부',
    delivery_price INT NOT NULL COMMENT '배송비',
    delivery_date VARCHAR(50) NOT NULL COMMENT '발송 시작일',
    reward_info TEXT NOT NULL COMMENT '리워드 정보 제공 고시',
    FOREIGN KEY (project_idx) REFERENCES project (project_idx)
); 
*/
@Data
public class RewardVO {
	private int reward_idx; 				// 리워드 번호
	private int project_idx; 				// 리워드 번호
	private int reward_price; 				// 리워드 가격
	private String reward_category; 		// 리워드 카테고리
	private String reward_name; 			// 리워드명 
	private int reward_quantity;			// 리워드 수량
	private String reward_option; 			// 리워드 옵션
	private String reward_detail; 			// 리워드 설명
	private String delivery_status; 		// 배송여부 
	private int delivery_price; 			// 배송비
	private String delivery_date; 			// 발송 시작일
	private String reward_info; 			// 리워드 정보 제공 고시
}
