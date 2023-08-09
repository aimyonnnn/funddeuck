package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MissionMapper {
	
	// 누적 점수 조회
	Integer acmlCurrentPoints(int maker_idx);


}
