package com.itwillbs.test.mapper;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.CouponVO;

@Mapper
public interface CouponMapper {

	void insertCoupon(CouponVO couponVO);
	
    List<CouponVO> getCouponList();

	List<CouponVO> getExpiredCoupons();

	void updateCoupon(CouponVO couponVO);

	List<CouponVO> getExpiredCoupons(LocalDateTime now);
	
	//-----------------------------------------------------------------------------------------

	CouponVO getCouponInfoByNumber(String couponNumber);
	
    List<CouponVO> getCouponsByMemberAndStatus(@Param("memberIdx") int memberIdx, @Param("couponUse") int couponUse);

	List<CouponVO> getUsedCoupons(int memberIdx);


}