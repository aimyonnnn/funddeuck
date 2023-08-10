package com.itwillbs.test.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.*;

@Mapper
public interface BankMapper {

	// 토큰 관련 정보를 DB에 저장
	int insertToken(@Param("member_idx") int member_idx, @Param("token") ResponseTokenVO responseToken);
	
	// 토큰 정보 조회
	ResponseTokenVO selectToken(int member_idx);

	// 재인증 시 토큰 정보를 업데이트
	Integer updateToken(@Param("member_idx") int member_idx, @Param("token") ResponseTokenVO token);
	
	// 토큰 삭제
	int deleteToken(int member_idx);
	
	// 계좌 정보 저장
	int insertBankAccount(@Param("member_idx") int member_idx, @Param("bankAccount") BankAccountVO mostRecentBankAccount);
	
	// 계좌 정보 조회
	BankAccountVO selectBankAccountInfo(int member_idx);
	
	// 중복된 계좌 정보 조회(핀테크이용번호 일치 여부 확인)
	BankAccountVO selectBankAccount(@Param("member_idx") int member_idx, @Param("bankAccount") BankAccountVO mostRecentBankAccount);
	
	// 계좌변경시 등록된 계좌정보 삭제
	void deleteBankAccount(int member_idx);
	
	// 정산 입금내역 등록
	int insertDepositSettlement(@Param("member_id") String member_id, @Param("project_idx") int project_idx, @Param("paramMap") Map<String, Object> paramMap);

	// 환불 입금내역 등록
	int insertDepositRefund(@Param("member_id") String member_id, @Param("project_idx") int project_idx, @Param("paramMap") Map<String, Object> paramMap);
	
	// 펀딩 결제시(계좌) 입금내역 등록
	int insertFundingTranHist(@Param("member_id") String member_id, @Param("project_idx") int project_idx, @Param("withdrawResult") ResponseWithdrawVO withdrawResult);
 
	// 정산 목록 조회 요청
	List<BankingVO> selectAllSettlementBanking(
												@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, 
												@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	// 정산 목록 개수 조회 요청 
	int selectAllSettlementBankingCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	// 이번 달 정산 금액 조회 요청
	int selectMonthAmount();

}
