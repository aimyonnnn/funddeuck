package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.DeliveryVO;

@Mapper
public interface DeliveryMapper {

	// 배송정보 조회
	DeliveryVO selectDeliveryList(int delivery_idx);

}
