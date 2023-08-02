package com.itwillbs.test.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.test.vo.PaymentVO;
import com.itwillbs.test.vo.ProjectVO;

@Mapper
public interface PaymentMapper {
	
	// 메이커별 일별 결제 금액 조회
	List<PaymentVO> selectPaymentListCountByDay(
			@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate, @Param("maker_idx") int maker_idx);
	
	// 메이커별 일별 서포터 수 조회
	List<PaymentVO> selectSupporterListCountByDay(
			@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate, @Param("maker_idx") int maker_idx);
	
	// 메이커별 지난 7일간 결제 금액 조회
	List<PaymentVO> selectPaymentListAmountBy7Day(Integer maker_idx);
	
	// 메이커별 지난 7일간 서포터 수 조회
	List<PaymentVO> selectSupporterListCountBy7Day(Integer maker_idx);
	
	// 전체 메이커별 지난 7일간 결제 금액 조회
	List<PaymentVO> selectPaymentTotalWeekRange();
	
	// 전체 메이커별 지난 7일간 등록된 서포터 수
	List<PaymentVO> selectSupporterCountWeekRange();
	
	// 전체 메이커별 결제 금액 조회
	List<PaymentVO> selectTotalPayment(@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate);
	
	// 전체 메이커별 서포터 수 조회
	List<PaymentVO> selectTotalSupporter(@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate);
	
	// 프로젝트별 지난 7일간 결제 금액 조회
	List<PaymentVO> selectProjectDailyPayment(
			@Param("project_idx") Integer project_idx, @Param("startDateProject")String startDateProject, @Param("endDateProject") String endDateProject);
	
	// 프로젝트별 지난 7일간 서포터 수 조회
	List<PaymentVO> selectProjectSupporterCount(
			@Param("project_idx") Integer project_idx, @Param("startDateProject")String startDateProject, @Param("endDateProject") String endDateProject);

	// 프로젝트별 배송상황 조회
	List<Map<String, Object>> selectDeliveryList(int project_idx);

	// 환불승인여부 조회
	List<Map<String, Object>> selectRefundList(int project_idx);

	// delivery_status(배송상황)가 있을 때 목록 조회
	List<PaymentVO> selectDeliveryAllList(@Param("project_idx") int project_idx, @Param("filter") String filter);

	// payment_confirm(환불승인여부)가 있을 때 목록 조회
	List<PaymentVO> selectRefundAllList(@Param("project_idx") int project_idx, @Param("type") String type);

	// 발송입력 - 모달창 리스트 조회
	List<PaymentVO> selectShippingModalList(int payment_idx);

	// 송장 입력 후 발송 업데이트
	int updateShippingInfo(@Param("payment_idx") int payment_idx, @Param("delivery_method") String delivery_method, @Param("courier") String courier, @Param("waybill_num") String waybill_num);

	// 결제 목록 조회
	List<PaymentVO> selectPaymentList(int payment_idx);
	
	// 메이커의 전체 프로젝트 결제 내역 조회
	List<PaymentVO> selectAllMakerPayment(@Param("maker_idx") Integer maker_idx);
	
	// 메이커의 전체 프로젝트 결제 내역 갯수 조회
	int selectAllMakerPaymentCount(Integer maker_idx);

	// 프로젝트 리스트 조회
	List<ProjectVO> selectPaymentByProjectIdx(
			@Param("maker_idx") int maker_idx, @Param("project_idx") int project_idx,
			@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate, 
			@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	// 송장번호 입력 후 일주일 후 '배송완료'로 상태변경
	int updateDeliveryStatusPaymentList(int payment_idx);
	
	// 갯수 조회
	int selectTotalCountByProjectIdx(
			@Param("maker_idx") int maker_idx, @Param("project_idx") int project_idx,
			@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate
			);

	// 리워드 조회
	List<PaymentVO> selectRemainingQuantities(int project_idx);	
	
}
