package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.*;

import com.itwillbs.test.vo.*;

@Mapper
public interface FundingMapper {

	int insertDelivery(DeliveryVO delivery);
	
}
