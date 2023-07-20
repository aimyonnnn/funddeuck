package com.itwillbs.test.vo;

import java.sql.Date;

import lombok.Data;

/*
결제 정보를 관리하는 payment 테이블 정의
---------------------------------------
결제 번호(payment_idx) - 정수, PK, AUTO_INCREMENT
결제일자 (payment_date) - 날짜(DATE), NN
결제회원 (member_idx) - 정수, FK
결제 프로젝트(project_idx) - 정수, FK
결제 프로젝트 리워드(reward_name) - 문자(50자), NN
결제 프로젝트 리워드 가격(reward_amount) - 정수, NN
사용한 쿠폰 금액(use_coupon_amount) - 정수, NN
기부 금액(donation) - 정수
총 결제금액(total_amount) - 정수, NN
리워드 배송지 주소 (delivery_address) - 문자(500자)
리워드 수령자 전화번호(delivery_phone_number) - 문자(10자)
---------------------------------------
CREATE TABLE payment (
	payment_idx INT PRIMARY KEY AUTO_INCREMENT,
	payment_date DATE NOT NULL,
	reward_name VARCHAR(50) NOT NULL,
	reward_amount INT NOT NULL,
	use_coupon_amount INT,
	donation INT,
	total_amount INT NOT NULL,
	delivery_address VARCHAR(500)
	delivery_phone_number VARCHAR(10)
	FOREIGN KEY (member_idx) REFERENCES member(member_idx)
	FOREIGN KEY (project_idx) REFERENCES project(project_idx)
);
*/
@Data
public class PaymentVO {
	private int payment_idx;
	private Date payment_date;
	private String reward_name;
	private int reward_amount;
	private int donation;
	private int total_amount;
	private String delivery_address;
	private String delivery_phone_number;
	private int member_idx;
	private int project_idx;
}
