package com.itwillbs.test.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.PaymentMapper;
import com.itwillbs.test.vo.DeliveryVO;
import com.itwillbs.test.vo.PaymentVO;
import com.itwillbs.test.vo.ProjectVO;

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
	public List<PaymentVO> getProjectDailyPayment(Integer project_idx, String startDateProject, String endDateProject) {
		return mapper.selectProjectDailyPayment(project_idx, startDateProject, endDateProject);
	}
	// 프로젝트별 지난 7일간 서포터 수 조회
	public List<PaymentVO> getProjectSupporterCount(Integer project_idx, String startDateProject, String endDateProject) {
		return mapper.selectProjectSupporterCount(project_idx, startDateProject, endDateProject);
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
	
	// 전체 목록 조회
	public List<PaymentVO> getAllList(int project_idx) {
		return mapper.selectAllList(project_idx);
	}
	
	// 목록 인원수 조회
	public int getPaymentListCount(int project_idx) {
		return mapper.selectPaymentListCount(project_idx);
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
	
	// 메이커의 전체 프로젝트 결제 내역 조회
	public List<PaymentVO> getAllMakerPayment(Integer maker_idx) {
		return mapper.selectAllMakerPayment(maker_idx);
	}
		
	// 메이커의 전체 프로젝트 결제 내역 갯수 조회
	public int getAllMakerPaymentCount(Integer maker_idx) {
		return mapper.selectAllMakerPaymentCount(maker_idx);
	}
	
	// 메이커의 프로젝트별 결제 내역 조회
	public List<ProjectVO> getPaymentByProjectIdx(int maker_idx, int project_idx, LocalDate parsedStartDate, LocalDate parsedEndDate, int startRow, int listLimit) {
		return mapper.selectPaymentByProjectIdx(maker_idx, project_idx, parsedStartDate, parsedEndDate, startRow, listLimit);
	}
	
	// 갯수 조회
	public int getTotalCountByProjectIdx(int maker_idx, int project_idx, LocalDate parsedStartDate, LocalDate parsedEndDate) {
		return mapper.selectTotalCountByProjectIdx(maker_idx, project_idx, parsedStartDate, parsedEndDate);
	}
	
	// 리워드 조회
	public List<PaymentVO> getRemainingQuantities(int project_idx) {
		return mapper.selectRemainingQuantities(project_idx);
	}
	
	// 결제내역 조회
	public PaymentVO getPaymentDetail(int payment_idx) {
		return mapper.selectPaymentDetail(payment_idx);
	}
	
	// 정산내역 조회
	public List<PaymentVO> getSettlementList(int project_idx) {
		return mapper.selectSettlementList(project_idx);
	}
	
	// 오늘 등록된 서포터 수
	public int getSupportCountByPaymentDate() {
		return mapper.selectSupportCountByPaymentDate();
	}
	
	// 관리자 - 결제내역 조회
	public List<PaymentVO> getAllPaymentList(String searchKeyword, String searchType, int startRow, int listLimit) {
		return mapper.selectAllPaymentList(searchKeyword, searchType, startRow, listLimit);
	}
	
	// 관리자 - 결제내역 갯수 조회
	public int getAllPaymentListCount(String searchKeyword, String searchType) {
		return mapper.selectAllPaymentListCount(searchKeyword, searchType);
	}
	
	// 관리자 - 결제정보 수정
	public int modifyPaymentByAdmin(PaymentVO payment) {
		return mapper.updatePaymentByAdmin(payment);
	}
	
	// 관리자 - 결제정보 수정 - 첨부파일 실시간 삭제
	public int removePaymentFile(int payment_idx, String fileName, int fileNumber) {
		return mapper.deletePaymentFile(payment_idx, fileName, fileNumber);
	}
	
}
