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
	
	// 전체 목록 조회
	List<PaymentVO> selectAllList(int project_idx);
	
	// 목록 인원수 조회
	int selectPaymentListCount(int project_idx);
	
	// 발송 및 환불 정보 입력 - 모달창 리스트 조회
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
	
	// 미발송 및 배송중, 반환신청 조회 조회
	int selectDeliveryCount(int payment_idx);
	
	// 미발송 및 배송중이 없다면 2주 후 최종정산 가능으로 프로젝트 상태 변경
	void updateProjectStatus(int payment_idx);
	
	// 펀딩금 반환 거절 상태 변경
	int updateShippingRefuse(int payment_idx);
	
	// 갯수 조회
	int selectTotalCountByProjectIdx(
			@Param("maker_idx") int maker_idx, @Param("project_idx") int project_idx,
			@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate
			);

	// 리워드 조회
	List<PaymentVO> selectRemainingQuantities(int project_idx);	
	
	// 결제내역 조회
	PaymentVO selectPaymentDetail(int payment_idx);

	// 정산내역 조회
	List<PaymentVO> selectSettlementList(int project_idx);
	
	// 오늘 등록된 서포터 수
	int selectSupportCountByPaymentDate();
	
	// 관리자 - 결제내역 조회
	List<PaymentVO> selectAllPaymentList(
			@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType,
			@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 관리자 - 결제내역 갯수 조회
	int selectAllPaymentListCount(@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType);
	
	// 관리자 - 결제정보 수정
	int updatePaymentByAdmin(PaymentVO payment);
	
	// 관리자 - 결제정보 수정 - 첨부파일 실시간 삭제
	int deletePaymentFile(@Param("payment_idx") int payment_idx, @Param("fileName") String fileName, @Param("fileNumber") int fileNumber);

	// 결제 정보 등록
	int registCreditInfo(@Param("member_idx") int member_idx
			, @Param("project_idx") int project_idx
			, @Param("reward_idx") int reward_idx
			, @Param("delivery_idx") int delivery_idx
			, @Param("member_email") String member_email
			, @Param("member_phone") String member_phone
			, @Param("reward_amount") int reward_amount
			, @Param("additional_amount") int additional_amount
			, @Param("use_coupon_amount") int use_coupon_amount
			, @Param("total_amount") int total_amount
			, @Param("payment_quantity") int payment_quantity
			, @Param("payment_confirm") int payment_confirm
			, @Param("payment_method") int payment_method);
	
	// 메이커벌 누적 서포터수 조회
	Integer selectAcmlSupportCount(Integer maker_idx);

}
