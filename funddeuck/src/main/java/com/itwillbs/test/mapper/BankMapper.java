package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.ResponseTokenVO;

@Mapper
public interface BankMapper {

	// 토큰 관련 정보를 DB에 저장
	int insertToken(@Param("member_idx") int member_idx, @Param("token") ResponseTokenVO responseToken);
	
	// 토큰 정보 조회
	ResponseTokenVO selectToken(int member_idx);

}
