package com.itwillbs.test.vo;

import java.time.LocalDate;

import lombok.Data;

/*
 * CREATE TABLE coupon(
	coupon_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰번호(PK)',
    coupon_name VARCHAR(100) NOT NULL COMMENT '쿠폰이름',
    coupon_text VARCHAR(500) NOT NULL COMMENT '쿠폰용도',
    coupon_num VARCHAR(20) NOT NULL COMMENT '입력쿠폰번호',
    coupon_sale INT NOT NULL COMMENT '쿠폰할인률',
    coupon_start DATE NOT NULL COMMENT '쿠폰시작일자',
    coupon_end DATE NOT NULL COMMENT '쿠폰만료일자',
    coupon_use INT NOT NULL COMMENT '쿠폰사용여부(0 미사용, 1사용)'
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
