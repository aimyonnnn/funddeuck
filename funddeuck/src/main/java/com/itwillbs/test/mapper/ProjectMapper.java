package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.RewardVO;

@Mapper
public interface ProjectMapper {
	
	// 리워드 저장하기
	boolean insertReward(RewardVO reward);
	
	// 메이커 등록하기
	int insertMaker(MakerVO maker);
	
}
