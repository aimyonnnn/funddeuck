package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.CreditMapper;
import com.itwillbs.test.vo.CreditVO;

@Service
public class CreditService {

	@Autowired
	private CreditMapper mapper;

	public CreditVO registCreditInfo(int payment_num, int p_orderNum, int payment_total_price, Integer member_idx) {
		return mapper.insertCreditInfo(payment_num, p_orderNum, payment_total_price, member_idx);
	}
	
}