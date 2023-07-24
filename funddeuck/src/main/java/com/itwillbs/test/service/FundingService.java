package com.itwillbs.test.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.test.mapper.*;
import com.itwillbs.test.vo.*;

@Service
public class FundingService {
	@Autowired 
	private FundingMapper mapper;
	
	// 배송지 등록
	public int registDelivery(DeliveryVO delivery) {
		return mapper.insertDelivery(delivery);
	}
	// 배송지 목록 조회
	public List<DeliveryVO> getDeliveryList(int member_idx) {
		return mapper.selectDeliveryList(member_idx);
	}

}
