package com.itwillbs.test.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.test.vo.*;

@Mapper
public interface FundingMapper {
	// 배송지 등록
	int insertDelivery(DeliveryVO delivery);
	// 배송지 목록 조회
	List<DeliveryVO> selectDeliveryList(String id);
	// 기본 배송지 조회
	DeliveryVO selectDeliveryDefault(String id);
	// 변경한 배송지 조회
	DeliveryVO selectDelivery(@Param(value = "id") String id,@Param(value = "delivery_idx") int changeDelivery_idx);
	// 쿠폰 목록 조회
	List<CouponVO> selectCouponList();
	// 기존의 기본 배송지 설정 변경
	void updateDeliveryDefault();
	
}
