package com.itwillbs.test.vo;

import lombok.Data;

/*
 * CREATE TABLE coupon(
    coupon_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '������ȣ(PK)',
    coupon_name VARCHAR(100) NOT NULL COMMENT '�����̸�',
    coupon_text VARCHAR(500) NOT NULL COMMENT '�����뵵',
    coupon_num INT(20) NOT NULL COMMENT '�Է�������ȣ',
    coupon_sale INT NOT NULL COMMENT '�������η�',
    coupon_start INT NOT NULL COMMENT '������������',
    coupon_end INT NOT NULL COMMENT '������������',
    conpon_use INT NOT NULL COMMENT '������뿩��'
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
