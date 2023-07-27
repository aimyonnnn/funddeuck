package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.CouponVO;

@Mapper
public interface CouponMapper {
    List<CouponVO> getCouponsByNumAndUse(@Param("couponNum") String couponNum, @Param("couponUse") int couponUse);
    
    List<CouponVO> getCouponsByUse(@Param("couponUse") int couponUse);

	void saveCoupon(CouponVO couponVO);

	List<CouponVO> getAllCoupons();

}
