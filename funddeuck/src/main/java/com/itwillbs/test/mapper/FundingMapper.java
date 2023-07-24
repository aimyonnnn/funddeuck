package com.itwillbs.test.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.test.vo.*;

@Mapper
public interface FundingMapper {

	int insertDelivery(DeliveryVO delivery);

	List<DeliveryVO> selectDeliveryList(int member_idx);
	
}
