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
	
}
