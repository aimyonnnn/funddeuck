package com.itwillbs.test.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.PaymentMapper;
import com.itwillbs.test.vo.PaymentVO;

@Service
public class PaymentService {

	@Autowired
	private PaymentMapper mapper;
	
	// 일별 결제 금액 조회
	public List<PaymentVO> getPaymentListCountByDay(LocalDate parsedStartDate, LocalDate parsedEndDate) {
		return mapper.selectPaymentListCountByDay(parsedStartDate, parsedEndDate);
	}
	// 일별 서포터 수 조회
	public List<PaymentVO> getSupporterListCountByDay(LocalDate parsedStartDate, LocalDate parsedEndDate) {
		return mapper.selectSupporterListCountByDay(parsedStartDate, parsedEndDate);
	}
	
}
