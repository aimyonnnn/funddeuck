package com.itwillbs.test.vo;

import lombok.Data;

/*
배송 정보를 관리하는 delivery_adr 테이블 정의
---------------------------------------
회원정보 (member_idx) - 정수, FK
리워드 배송지 주소 (delivery_address) - 문자(500자)
리워드 수령자 전화번호(delivery_phone_number) - 문자(10자)
---------------------------------------
CREATE TABLE delivery_adr (
	delivery_address VARCHAR(500)
	delivery_phone_number VARCHAR(10)
	FOREIGN KEY (member_idx) REFERENCES member(member_idx)
);
*/
@Data
public class DeliveryAdrVO {
	private int member_idx;
	private String delivery_address;
	private String delivery_phone_number;
}
