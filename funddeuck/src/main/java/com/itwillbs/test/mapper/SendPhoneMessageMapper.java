package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.SendPhoneMessageVO;


@Mapper
public interface SendPhoneMessageMapper {
	
	// 문자 저장
	int insertSms(@Param("memberId") String memberId, @Param("memberPhone") String memberPhone, @Param("message") String message);
	
	// 관리자 - 문자 리스트 조회
	List<SendPhoneMessageVO> selectAllSmsList(
			@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType, 
			@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 관리자 - 문자 갯수 조회
	int selectAllSmsListCount(@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType);
	
	// 전화번호 인증 코드 저장
	int insertDuplicateSmsCode(@Param("code") String code, @Param("memberPhone") String memberPhone);
	
	// 인증 테이블에 전화번호가 존재하는지 확인
	int selectDuplicateSmsCode(String memberPhone);
	
	// 인증 테이블에 전화번호가 존재하면 코드만 변경
	int updateDuplicateSmsCode(@Param("code") String code, @Param("memberPhone") String memberPhone);

	
	
}
