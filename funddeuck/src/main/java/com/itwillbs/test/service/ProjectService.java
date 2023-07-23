package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProjectMapper;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectMapper mapper;
	
	// 由ъ���� ���ν��湲�
	public int registReward(RewardVO reward) {
		return mapper.insertReward(reward);
	}
	// 硫��댁빱 �깅���湲�
	public int registMaker(MakerVO maker) {
		return mapper.insertMaker(maker);
	}
	// 由ъ���� 媛��� 議고�� ��湲�
	public int getRewardCount(int project_idx) {
		return mapper.selectRewardCount(project_idx);
	}
	// 由ъ���� 由ъ�ㅽ�� 議고�� ��湲�
	public List<RewardVO> getRewardList(int project_idx) {
		return mapper.selectRewardList(project_idx);
	}
	// 由ъ���� 議고����湲�
	public RewardVO getRewardInfo(Integer reward_idx) {
		return mapper.selectRewardInfo(reward_idx);
	}
	// 由ъ���� ������湲�
	public int modifyReward(RewardVO reward) {
		return mapper.updateReward(reward);
	}
	// 由ъ���� ������湲�
	public int removeReward(int reward_idx) {
		return mapper.deleteReward(reward_idx);
	}
	// 由ъ���� ���깆�� ��蹂�
	public String getRewardAuthorId(Integer reward_idx, String sId) {
		return mapper.selectRewardAuthorId(reward_idx, sId);
	}
	// ��濡����� �깅���湲�
	public int registProject(ProjectVO project) {
		return mapper.insertProject(project);
	}
	public ProjectVO getProjectInfo(int project_idx) {
		return mapper.selectProject(project_idx);
	}
	// 硫��댁빱 �깅� ���댁� ���� ��
	public int getMemberIdx(String sId) {
		return mapper.selectMemberIdx(sId);
	}
	
	public List<ProjectVO> getAllProjects() {
		return null;
	}
	
	public List<ProjectVO> getTop10ProjectsByEndDate() {
        return mapper.selectTop10ProjectsByEndDate();
    }
	
	
}
