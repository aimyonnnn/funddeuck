package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.DeliveryMapper;
import com.itwillbs.test.vo.*;

@Service
public class DeliveryService {
    @Autowired
    private DeliveryMapper mapper;

    // 배송 정보 조회
	public DeliveryVO getDeliveryList(int delivery_idx) {
		return mapper.selectDeliveryList(delivery_idx);
	}
}
