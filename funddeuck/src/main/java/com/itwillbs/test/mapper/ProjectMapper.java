package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;

@Mapper
public interface ProjectMapper {
	
	// 리워드 저장하기
	int insertReward(RewardVO reward);
	
	// 메이커 등록하기
	int insertMaker(MakerVO maker);
	
	// 리워드 갯수 조회하기
	int selectRewardCount(int project_idx);
	
	// 리워드 리스트 조회하기
	List<RewardVO> selectRewardList(int project_idx);
	
	// 리워드 조회하기
	RewardVO selectRewardInfo(Integer reward_idx);
	
	// 리워드 수정하기
	int updateReward(RewardVO reward);
	
	// 리워드 삭제하기
	int deleteReward(int reward_idx);

	// 프로젝트 등록하기 
	int insertProject(ProjectVO project);
	
}
