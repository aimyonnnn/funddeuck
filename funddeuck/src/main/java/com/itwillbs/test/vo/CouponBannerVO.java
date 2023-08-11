package com.itwillbs.test.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
 * create table coupon_banner(
	newCoupon_idx INT PRIMARY KEY AUTO_INCREMENT COMMENT '쿠폰배너번호(PK)',
    coupon_idx INT NOT NULL COMMENT '쿠폰번호(PK)',
    newCoupon_name VARCHAR(100) NOT NULL COMMENT '쿠폰배너이름',
    newCoupon_start DATE NOT NULL COMMENT '시작날짜',
    newCoupon_end DATE NOT NULL COMMENT '종료날짜',
    newCouponImage varchar(300) NOT NULL COMMENT '쿠폰사진',
    FOREIGN KEY (coupon_idx) REFERENCES coupon(coupon_idx) ON DELETE CASCADE
);
 */
@Data
public class CouponBannerVO {
    private int newCoupon_idx;
    private int coupon_idx;
    private String newCoupon_name;
    private String newCoupon_start; 
    private String newCoupon_end;   
	private String newCouponImage;
	//
	private MultipartFile file;
}
