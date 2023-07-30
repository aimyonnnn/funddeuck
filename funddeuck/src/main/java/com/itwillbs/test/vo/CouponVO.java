package com.itwillbs.test.vo;

import lombok.Data;

/*
 * CREATE TABLE coupon(
    coupon_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰번호(PK)',
    coupon_name VARCHAR(100) NOT NULL COMMENT '쿠폰이름',
    coupon_text VARCHAR(500) NOT NULL COMMENT '쿠폰설명',
    coupon_num INT(20) NOT NULL COMMENT '입력번호',
    coupon_sale INT NOT NULL COMMENT '할인률',
    coupon_start INT NOT NULL COMMENT '시작날짜',
    coupon_end INT NOT NULL COMMENT '종료날짜',
    coupon_use INT NOT NULL COMMENT '쿠폰사용'
);
 */
@Data
public class CouponVO {
    private int coupon_idx;
    private String coupon_name;
    private String coupon_text;
    private int coupon_num;
    private int coupon_sale;
    private String coupon_start; 
    private String coupon_end;   
    private boolean coupon_use;    
}
