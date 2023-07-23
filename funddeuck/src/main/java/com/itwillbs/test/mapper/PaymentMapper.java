package com.itwillbs.test.mapper;

import java.time.LocalDate;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.PaymentVO;

@Mapper
public interface PaymentMapper {
	
	// 일별 결제 금액 조회
	List<PaymentVO> selectPaymentListCountByDay(
			@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate, @Param("maker_idx") int maker_idx);
	
	// 일별 서포터 수 조회
	List<PaymentVO> selectSupporterListCountByDay(
			@Param("parsedStartDate") LocalDate parsedStartDate, @Param("parsedEndDate") LocalDate parsedEndDate, @Param("maker_idx") int maker_idx);
	
	// 지난 7일간 결제 금액 조회
	List<PaymentVO> selectPaymentListAmountBy7Day();

	
	
}
