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
	
	// 리워드 저장하기
	public int registReward(RewardVO reward) {
		return mapper.insertReward(reward);
	}
	// 메이커 등록하기
	public int registMaker(MakerVO maker) {
		return mapper.insertMaker(maker);
	}
	// 리워드 갯수 조회하기
	public int getRewardCount(int project_idx) {
		return mapper.selectRewardCount(project_idx);
	}
	// 리워드 리스트 조회하기
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
	// 리워드 삭제하기
	public int removeReward(int reward_idx) {
		return mapper.deleteReward(reward_idx);
	}
	// 리워드 작성자 판별
	public String getRewardAuthorId(Integer reward_idx, String sId) {
		return mapper.selectRewardAuthorId(reward_idx, sId);
	}
	// 메이커 등록 페이지 접속 시
	public int getMemberIdx(String sId) {
		return mapper.selectMemberIdx(sId);
	}
	// 프로젝트 등록하기
	public int registProject(ProjectVO project) {
		return mapper.insertProject(project);
	}
	// 프로젝트 조회하기
	public ProjectVO getProjectInfo(int project_idx) {
		return mapper.selectProject(project_idx);
	}
	// 프로젝트 승인 요청
	public int modifyStatus(int project_idx) {
		return mapper.updateStatus(project_idx);
	}
	// project_approve_status != 1 리스트 조회
	public List<ProjectVO> getAllRequestProject() {
		return mapper.selectAllRequestProject();
	}
	// 프로젝트 상태컬럼 변경
	public int modifyProjectStatus(int project_idx, int project_approve_status) {
		return mapper.updateProjectStatus(project_idx, project_approve_status);
	}
	// maker_idx 조회하기
	public MakerVO getMakerIdx(int project_idx) {
		int makerIdx = mapper.selectMakerIdx(project_idx);
		return mapper.selectMakerInfo(makerIdx);
	}
	
	//
	public List<ProjectVO> getTop10ProjectsByEndDate() {
        return mapper.selectTop10ProjectsByEndDate();
    }
	//
	public List<ProjectVO> getAllProjects() {
		return null;
	}
	// 펀딩 프로젝트 목록 조회
	public List<ProjectVO> getProjectList(String searchType, String searchKeyword, int startRow, int listLimit) {
		return mapper.selectProjectList(searchType, searchKeyword, startRow, listLimit);
	}
	// 전체 펀딩 프로젝트 목록 갯수 조회 요청
	public int getProjectListCount(String searchType, String searchKeyword) {
		return mapper.selectProjectListCount(searchType, searchKeyword);
	}
	
	
}
