package com.itwillbs.test.vo;

import lombok.Data;

/*
 * CREATE TABLE coupon(
    coupon_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰번호(PK)',
    coupon_name VARCHAR(100) NOT NULL COMMENT '쿠폰이름',
    coupon_text VARCHAR(500) NOT NULL COMMENT '쿠폰용도',
    coupon_num INT(20) NOT NULL COMMENT '입력쿠폰번호',
    coupon_sale INT NOT NULL COMMENT '쿠폰할인률',
    coupon_start INT NOT NULL COMMENT '쿠폰시작일자',
    coupon_end INT NOT NULL COMMENT '쿠폰만료일자',
    conpon_use INT NOT NULL COMMENT '쿠폰사용여부'
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
