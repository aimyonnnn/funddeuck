package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProjectMapper;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.RewardVO;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectMapper mapper;
	
	// 리워드 저장하기
	public int registReward(RewardVO reward) {
		return mapper.insertReward(reward);
	}
	// 메이커 등록하기
	public int registMaker(MakerVO maker) {
		return mapper.insertMaker(maker);
	}
	// 리워드 갯수 조회 하기
	public int getRewardCount(int project_idx) {
		return mapper.selectRewardCount(project_idx);
	}
	// 리워드 리스트 조회 하기
	public List<RewardVO> getRewardList(int project_idx) {
		return mapper.selectRewardList(project_idx);
	}
	// 리워드 조회하기
	public RewardVO getRewardInfo(Integer reward_idx) {
		return mapper.selectRewardInfo(reward_idx);
	}
	// 리워드 수정하기
	public int modifyReward(RewardVO reward) {
		return mapper.updateReward(reward);
	}
	
}
