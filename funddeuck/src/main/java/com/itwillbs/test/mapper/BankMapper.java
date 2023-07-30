package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.ResponseTokenVO;

@Mapper
public interface BankMapper {

	// 토큰 관련 정보를 DB에 저장
	int insertToken(String id, ResponseTokenVO responseToken);

}
