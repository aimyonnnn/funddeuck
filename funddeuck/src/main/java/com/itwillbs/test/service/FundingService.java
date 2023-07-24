package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.test.mapper.*;
import com.itwillbs.test.vo.*;

@Service
public class FundingService {
	@Autowired 
	private FundingMapper mapper;

	public int registDelivery(DeliveryVO delivery) {
		return mapper.insertDelivery(delivery);
	}

}
