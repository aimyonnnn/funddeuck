package com.itwillbs.test.vo;

import lombok.Data;

/*
배송 정보를 관리하는 delivery 테이블 정의
---------------------------------------
회원정보 (member_idx) - 정수, FK
리워드 배송 정보 저장 상태 판별(delivery_adr_status) - 정수
리워드 배송지 주소 (delivery_address) - 문자(500자)
리워드 수령자 전화번호(delivery_phone_number) - 문자(10자)
---------------------------------------
CREATE TABLE delivery (
	delivery_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '배송지번호(PK)',
	member_idx INT NOT NULL COMMENT '회원번호(FK)',
	delivery_reciever VARCHAR(50) NOT NULL COMMENT '수취인',
	delivery_phone VARCHAR(50) NOT NULL COMMENT '수취인연락처',
	delivery_zipcode VARCHAR(10) NOT NULL COMMENT '수취인우편번호',
  	delivery_add VARCHAR(500) NOT NULL COMMENT '수취인주소',
  	delivery_detailadd VARCHAR(500) NOT NULL COMMENT '수취인상세주소',
 	FOREIGN KEY (member_idx) REFERENCES members(member_idx)    
);
*/
@Data
public class DeliveryVO {
	private int delivery_idx;
	private int member_idx;
	private String delivery_reciever;
	private String delivery_phone;
	private String delivery_zipcode;
	private String delivery_add;
	private String delivery_detailadd;
	private String delivery_default;
	
}
