package com.itwillbs.test.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

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
	
	// 프로젝트별 배송상황 조회
	public List<Map<String, Object>> getDeliveryList(int project_idx) {
		return mapper.selectDeliveryList(project_idx);
	}
	
	// 환불승인여부 조회
	public List<Map<String, Object>> getRefundList(int project_idx) {
		return mapper.selectRefundList(project_idx);
	}
	
	// delivery_status(배송상황)가 있을 때 목록 조회
	public List<PaymentVO> getDeliveryAllList(int project_idx, String filter) {
		return mapper.selectDeliveryAllList(project_idx, filter);
	}
	
	// payment_confirm(환불승인여부)가 있을 때 목록 조회
	public List<PaymentVO> getRefundAllList(int project_idx, String type) {
		return mapper.selectRefundAllList(project_idx, type);
	}
	// 메이커의 전체 프로젝트 결제 내역 조회
	public List<PaymentVO> getAllMakerPayment(Integer maker_idx) {
		return mapper.selectAllMakerPayment(maker_idx);
	}
	
	// 발송입력 - 모달창 리스트 조회
	public List<PaymentVO> getShippingModalList(int payment_idx) {
		return mapper.selectShippingModalList(payment_idx);
	}
	
	// 송장 입력 후 발송 업데이트
	public int modifyShippingInfo(int payment_idx, String delivery_method, String courier, String waybill_num) {
		return mapper.updateShippingInfo(payment_idx, delivery_method, courier, waybill_num);
	}
	
	// 결제 목록 조회 
	public List<PaymentVO> getPaymentList(int payment_idx) {
		return mapper.selectPaymentList(payment_idx);
	}
	
	
}
