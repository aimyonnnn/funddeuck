package com.itwillbs.test.vo;

import java.time.LocalDate;

import lombok.Data;

/*
 * CREATE TABLE coupon(
	coupon_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '������ȣ(PK)',
    coupon_name VARCHAR(100) NOT NULL COMMENT '�����̸�',
    coupon_text VARCHAR(500) NOT NULL COMMENT '�����뵵',
    coupon_num VARCHAR(20) NOT NULL COMMENT '�Է�������ȣ',
    coupon_sale INT NOT NULL COMMENT '�������η�',
    coupon_start DATE NOT NULL COMMENT '������������',
    coupon_end DATE NOT NULL COMMENT '������������',
    coupon_use INT NOT NULL COMMENT '������뿩��(0 �̻��, 1���)'
);
 */
@Data
public class CouponVO {
	private int coupon_idx;
    private String coupon_name;
    private String coupon_text;
    private String coupon_num;
    private int coupon_sale;
    private LocalDate coupon_start; 
    private LocalDate coupon_end; 
    private int coupon_use;
}
