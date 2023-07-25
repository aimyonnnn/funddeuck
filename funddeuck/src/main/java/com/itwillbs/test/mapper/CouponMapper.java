package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.CouponVO;
import com.itwillbs.test.vo.MakerVO;

@Mapper
public interface CouponMapper {
    CouponVO getCouponByNumber(String coupon_num);
}
