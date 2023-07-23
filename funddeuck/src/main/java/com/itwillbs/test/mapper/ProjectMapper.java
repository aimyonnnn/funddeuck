package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.ProjectVO;
import com.itwillbs.test.vo.RewardVO;

@Mapper
public interface ProjectMapper {
	
	// 由ъ���� ���ν��湲�
	int insertReward(RewardVO reward);
	
	// 硫��댁빱 �깅���湲�
	int insertMaker(MakerVO maker);
	
	// 由ъ���� 媛��� 議고����湲�
	int selectRewardCount(@Param("project_idx") int project_idx);
	
	// 由ъ���� 由ъ�ㅽ�� 議고����湲�
	List<RewardVO> selectRewardList(int project_idx);
	
	// 由ъ���� 議고����湲�
	RewardVO selectRewardInfo(Integer reward_idx);
	
	// 由ъ���� ������湲�
	int updateReward(RewardVO reward);
	
	// 由ъ���� ������湲�
	int deleteReward(int reward_idx);
	
	// 由ъ���� ���깆�� ��蹂�
	String selectRewardAuthorId(@Param("reward_idx") Integer reward_idx, @Param("sId") String sId);

	// ��濡����� �깅���湲� 
	int insertProject(ProjectVO project);
	
	// ��濡����� 議고����湲�
	ProjectVO selectProject(int project_idx);
	
	// 硫��댁빱 �깅� ���댁� ���� ��
	int selectMemberIdx(String sId);

	List<ProjectVO> selectTop10ProjectsByEndDate();

}
