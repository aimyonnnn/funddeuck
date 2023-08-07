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
	
	
	
	
}
