package com.itwillbs.test.service;

import java.util.Collections;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProjectMapper;
import com.itwillbs.test.vo.MakerBoardVO;
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
	public Integer getMemberIdx(String sId) {
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
	public List<ProjectVO> getAllRequestProject(String searchType, String searchKeyword, int startRow, int listLimit) {
		return mapper.selectAllRequestProject(searchType, searchKeyword, startRow, listLimit);
	}
	// project_approve_status != 1 리스트 갯수 조회
	public int getAllRequestProjectCount(String searchType, String searchKeyword) {
		return mapper.selectAllRequestProjectCount(searchType, searchKeyword);
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
	// 프로젝트 리스트 조회 
	public List<ProjectVO> getProjectList(int member_idx) {
		return mapper.selectProjectList(member_idx);
	}
	// 멤버, 메이커, 프로젝트 테이블을 조인하여 일치하는 데이터 조회
	public List<ProjectVO> getProjectsByMemberId(String sId, Integer maker_idx, Integer project_idx) {
		return mapper.selectProjectsByMemberId(sId, maker_idx, project_idx);
	}
	// 메이커 번호로 프로젝트 리스트 조회
	public List<ProjectVO> getProjectListByMakerIdx(int maker_idx) {
		return mapper.selectProjectListByMakerIdx(maker_idx);
	}
	// 프로젝트 승인여부 확인하기
	public ProjectVO getProjectApproved(int project_idx, int project_approve_status) {
		return mapper.selectProjectApproved(project_idx, project_approve_status);
	}
	// 펀딩 프로젝트 목록 조회
	public List<ProjectVO> getProjectList(String searchType, String searchKeyword, int startRow, int listLimit) {
		return mapper.getProjectList(searchType, searchKeyword, startRow, listLimit);
	}
	// 전체 펀딩 프로젝트 목록 갯수 조회 요청
	public int getProjectListCount(String searchType, String searchKeyword) {
		return mapper.selectProjectListCount(searchType, searchKeyword);
	}
	// 승인완료 된 프로젝트 리스트 조회
	public List<ProjectVO> getApprovedProjects() {
		return mapper.selectApprovedProjects();
	}
	// 프로젝트 승인 처리 시간 저장
	public void modifyProjectApprovalRequestTime(ProjectVO project) {
		mapper.updateProjectApprovalRequestTime(project);
	}
	// 전체 프로젝트 리스트 조회
	public List<ProjectVO> getAllProject(String searchKeyword, String searchType, int startRow, int listLimit) {
		return mapper.selectAllProject(searchKeyword, searchType, startRow, listLimit);
	}
	// 전체 프로젝트 갯수 조회
	public int getAllProjectCount(String searchKeyword, String searchType) {
		return mapper.selectAllProjectCount(searchKeyword, searchType);
	}
	// 프로젝트 리스트 조회
	public List<ProjectVO> getAllProjectByMakerIdx(int maker_idx) {
		return mapper.selectAllProjectByMakerIdx(maker_idx);
	}
	
	// 메이커 게시판 공지사항 작성하기
    public int registMakerBoard(MakerBoardVO makerBoard) {
		return mapper.insertMakerBoard(makerBoard);
	}
	
    // ranking system
    public List<ProjectVO> getTop10ProjectsByEndDate() {
    	return mapper.selectTop10ProjectsByEndDate();
    }
    
    // show all project
    public List<ProjectVO> getAllProjects(){
    	return mapper.getAllProjects();
    }
    
    // random
    public List<ProjectVO> getRandomProjects() {
    	List<ProjectVO> allProjects = mapper.getAllProjects();
    	if (allProjects.size() > 6) {
    		Collections.shuffle(allProjects, new Random(System.currentTimeMillis())); // 리스트를 랜덤하게 섞음
    		return allProjects.subList(0, 6); 
    	} else {
    		return allProjects; 
    	}
    }
    
    // 메이커 공지사항 리스트 조회
    public List<MakerBoardVO> getMakerBoardList(Integer maker_idx) {
    	return mapper.selectMakerBoardList(maker_idx);
    }
    
    // 프로젝트 승인상태 조회
	public Integer getProjectStatus(int project_idx) {
		return mapper.selectProjectStatus(project_idx);
	}
	
	// 관리자 - 프로젝트 정보 수정
	public int modifyProjectByAdmin(ProjectVO project) {
		return mapper.updateProjectByAdmin(project);
	}
	
	// 관리자 - 첨부파일 실시간 삭제
	public int removeProjectFile(int project_idx, String fileName, int fileNumber) {
		return mapper.deleteProjectFile(project_idx, fileName, fileNumber);
	}
	
	// 정산 완료 후 프로젝트 상태 수정
	public int updateProjectSettlementStatus(int project_idx, int final_amount) {
		return mapper.updateProjectSettlementStatus(project_idx, final_amount);
	}
    
		
		
		
		
			
	
}
