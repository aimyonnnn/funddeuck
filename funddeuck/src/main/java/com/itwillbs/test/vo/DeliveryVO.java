package com.itwillbs.test.vo;

import lombok.Data;

/*
배송 정보를 관리하는 delivery 테이블 정의
---------------------------------------
CREATE TABLE delivery (
	delivery_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '배송지번호(PK)',
	member_id VARCHAR(20) NOT NULL COMMENT '회원아이디(FK)',
	delivery_reciever VARCHAR(50) NOT NULL COMMENT '수취인',
	delivery_phone VARCHAR(50) NOT NULL COMMENT '수취인연락처',
	delivery_zipcode VARCHAR(10) NOT NULL COMMENT '수취인우편번호',
  	delivery_add VARCHAR(500) NOT NULL COMMENT '수취인주소',
  	delivery_detailadd VARCHAR(500) NOT NULL COMMENT '수취인상세주소',
  	delivery_default BOOLEAN NOT NULL DEFAULT 0 COMMENT '기본배송지여부(0: 아니오, 1: 예)',
 	FOREIGN KEY (member_id) REFERENCES members(member_id)    
);
*/
@Data
public class DeliveryVO {
	private int delivery_idx;
	private String member_id;
	private String delivery_reciever;
	private String delivery_phone;
	private String delivery_zipcode;
	private String delivery_add;
	private String delivery_detailadd;
	private boolean delivery_default;
	
}
