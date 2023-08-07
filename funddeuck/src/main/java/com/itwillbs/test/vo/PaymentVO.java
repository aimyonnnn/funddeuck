package com.itwillbs.test.vo;

import java.sql.Date;
import java.util.Optional;

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
    payment_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '주문번호(PK)',
    member_idx INT NOT NULL COMMENT '회원번호(FK)',
    project_idx INT NOT NULL COMMENT '프로젝트번호(FK)',
    reward_idx INT NOT NULL COMMENT '리워드번호(FK)',   
    delivery_idx INT NOT NULL  COMMENT '배송지번호(FK)',
    member_email VARCHAR(50) NOT NULL COMMENT '회원이메일',
    member_phone VARCHAR(50) NOT NULL COMMENT '회원연락처',   
    reward_amount INT NOT NULL COMMENT '리워드금액',
    additional_amount INT COMMENT '추가후원금',
    use_coupon_amount INT  COMMENT '쿠폰금액',
    total_amount INT NOT NULL COMMENT '최종결제금액',
    payment_date DATE NOT NULL COMMENT '주문날짜',
    payment_quantity INT NOT NULL COMMENT '주문수량',
    payment_confirm INT NOT NULL DEFAULT 1 COMMENT '결제승인여부(1:예약완료, 2:결제완료, 3:반환신청, 4:반환완료, 5:반환거절)', 
    payment_method INT NOT NULL COMMENT '결제수단(1:카드결제, 2:계좌결제)',
    refund_bank VARCHAR(50) COMMENT '환급받을은행명',
    refund_accountnum VARCHAR(50) COMMENT '환급받을계좌번호',
    delivery_method VARCHAR(50) COMMENT '배송방법',
    courier VARCHAR(50) COMMENT '택배사',
    waybill_num VARCHAR(50) COMMENT '운송장번호',
    delivery_status INT COMMENT '배송상황(1:미발송,2:배송중,3:배송완료)',
    cancel_context VARCHAR(200) COMMENT '취소신청시 취소사유',
    cancel_img VARCHAR(200) COMMENT '취소증빙이미지',
    FOREIGN KEY (member_idx) REFERENCES members(member_idx) ON DELETE CASCADE,
    FOREIGN KEY (project_idx) REFERENCES project(project_idx) ON DELETE CASCADE,
    FOREIGN KEY (reward_idx) REFERENCES reward(reward_idx) ON DELETE CASCADE,
    FOREIGN KEY (delivery_idx) REFERENCES delivery(delivery_idx) ON DELETE CASCADE
);
*/
@Data
public class PaymentVO {
	private int payment_idx;
	private int member_idx;
	private int project_idx;
	private int reward_idx;
	private int delivery_idx;
	private String member_email;
	private String member_phone;
	private int reward_amount;
	private int additional_amount;
	private int use_coupon_amount;
	private int total_amount;
	private Date payment_date;
	private int payment_quantity;
	private int payment_confirm;
	private int payment_method;
	private String refund_bank;
	private String refund_accountnum;
	private String delivery_method;
	private String courier;
	private String waybill_num;
	private int delivery_status;
	
	
	// ########## total_amount, payment_date 컬럼명 변경 시 꼭 알려주세요! ##########
	// 차트 & 프로젝트 현황 출력 시 사용
	private String date; 							// 결제 날짜
	private int amount;								// 결제 금액
	private int count; 								// 서포터 수 
	private String project_subject;					// 프로젝트명
	private String reward_name;						// 리워드명
	private String reward_option;					// 리워드 옵션
	private int reward_quantity;					// 리워드 수량
	private int remaining_quantity;					// 리워드 남은수량
	private int sales_quantity;						// 리워드 판매수량
	
	// ===============================================================================
	// 발송·환불 목록 출력 시 사용 
	private String member_name;
	private String delivery_date;
	private String delivery_reciever;
	private String delivery_phone;
	private String delivery_zipcode;
	private String delivery_add;
	private String delivery_detailadd;
	private String cancel_context;
	private String cancel_img;
	
	// ===============================================================================
	// 정산내역 출력 시 사용 
	private int project_plan;						// 프로젝트 요금제
	private String project_representative_name;		// 대표자명
	private String project_representative_email; 	// 대표자 이메일
	private String project_settlement_bank;			// 정산 받을 은행
	private String project_settlement_account;		// 정산 받을 계좌
	private String project_settlement_name;			// 정산 받을 예금주명
	private int total_reward_amount;				// 총 리워드 금액
	private int total_card_amount;					// 총 카드 금액
	private int total_additional_amount; 			// 총 추가 후원금액
	private int card_total_additional_amount;		// 총 카드 후원금액
	private int card_total_reward_amount;			// 총 카드 리워드 결제금액
	private int total_delivery_amount;				// 총 리워드 배송비
	private int card_total_delivery_amount;			// 총 카드 결제의 리워드 배송비
	
}
