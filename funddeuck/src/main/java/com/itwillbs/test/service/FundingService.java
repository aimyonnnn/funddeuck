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
	public List<DeliveryVO> getDeliveryList(String id) {
		return mapper.selectDeliveryList(id);
	}
	// 기본 배송지 조회
	public DeliveryVO getDeliveryDefault(String id) {
		return mapper.selectDeliveryDefault(id);
	}
	// 선택한 배송지 조회
	public DeliveryVO getDeliveryInfo(String id, int changeDelivery_idx) {
		return mapper.selectDelivery(id, changeDelivery_idx);
	}

}
