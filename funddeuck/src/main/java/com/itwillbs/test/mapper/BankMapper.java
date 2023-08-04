package com.itwillbs.test.mapper;

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
	
	// 계좌 정보 저장
	int insertBankAccount(@Param("member_idx") int member_idx, @Param("bankAccount") BankAccountVO mostRecentBankAccount);
	
	// 계좌 정보 조회(핀테크이용번호 일치 여부 확인)
	BankAccountVO selectBankAccount(@Param("member_idx") int member_idx, @Param("bankAccount") BankAccountVO mostRecentBankAccount);
	
	// 계좌 정보 조회
	BankAccountVO selectBankAccountInfo(int member_idx);
}
