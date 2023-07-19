package com.itwillbs.test.service;

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
	public boolean registReward(RewardVO reward) {
		return mapper.insertReward(reward);
	}
	
	// 메이커 등록하기
	public int registMaker(MakerVO maker) {
		return mapper.insertMaker(maker);
	}
	
}
