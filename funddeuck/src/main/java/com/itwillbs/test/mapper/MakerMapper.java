package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.MakerVO;

@Mapper
public interface MakerMapper {
	
	// 메이커 정보 조회하기
	MakerVO selectMakerInfo(Integer maker_idx);
	
	// 메이커 페이지 수정하기
	int updateMaker(int maker_idx);
	
	
	
}
