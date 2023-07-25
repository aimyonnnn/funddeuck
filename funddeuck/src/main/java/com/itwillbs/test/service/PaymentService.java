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
	
	// 메이커별 일별 결제 금액 조회
	public List<PaymentVO> getPaymentListCountByDay(LocalDate parsedStartDate, LocalDate parsedEndDate, int maker_idx) {
		return mapper.selectPaymentListCountByDay(parsedStartDate, parsedEndDate, maker_idx);
	}
	// 메이커별 일별 서포터 수 조회
	public List<PaymentVO> getSupporterListCountByDay(LocalDate parsedStartDate, LocalDate parsedEndDate, int maker_idx) {
		return mapper.selectSupporterListCountByDay(parsedStartDate, parsedEndDate, maker_idx);
	}
	// 메이커별 지난 7일간 결제 금액 조회
	public List<PaymentVO> getPaymentListAmountBy7Day(Integer maker_idx) {
		return mapper.selectPaymentListAmountBy7Day(maker_idx);
	}
	// 메이커별 지난 7일간 서포터 수 조회
	public List<PaymentVO> getSupporterListCountBy7Day(Integer maker_idx) {
		return mapper.selectSupporterListCountBy7Day(maker_idx);
	}
	// 메이커별 지난 7일간 전체 결제 금액 조회
	public List<PaymentVO> getPaymentTotalWeekRange() {
		return mapper.selectPaymentTotalWeekRange();
	}
	// 메이커별 지난 7일간 등록된 전체 서포터 수
	public List<PaymentVO> getSupporterCountWeekRange() {
		return mapper.selectSupporterCountWeekRange();
	}
	// 전체 메이커별 결제 금액 조회
	public List<PaymentVO> getTotalPayment(LocalDate parsedStartDate, LocalDate parsedEndDate) {
		return mapper.selectTotalPayment(parsedStartDate, parsedEndDate);
	}
	// 전체 메이커별 서포터 수 조회
	public List<PaymentVO> getTotalSupporter(LocalDate parsedStartDate, LocalDate parsedEndDate) {
		return mapper.selectTotalSupporter(parsedStartDate, parsedEndDate);
	}
	// 프로젝트별 지난 7일간 결제 금액 조회
	public List<PaymentVO> getProjectDailyPayment(Integer project_idx) {
		return mapper.selectProjectDailyPayment(project_idx);
	}
	// 프로젝트별 지난 7일간 서포터 수 조회
	public List<PaymentVO> getProjectSupporterCount(Integer project_idx) {
		return mapper.selectProjectSupporterCount(project_idx);
	}
	
}
