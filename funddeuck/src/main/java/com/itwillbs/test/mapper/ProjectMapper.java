package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
	int selectRewardCount(@Param("project_idx") int project_idx);
	
	// 리워드 리스트 조회하기
	List<RewardVO> selectRewardList(int project_idx);
	
	// 리워드 조회하기
	RewardVO selectRewardInfo(Integer reward_idx);
	
	// 리워드 수정하기
	int updateReward(RewardVO reward);
	
	// 리워드 삭제하기
	int deleteReward(int reward_idx);
	
	// 리워드 작성자 판별
	String selectRewardAuthorId(@Param("reward_idx") Integer reward_idx, @Param("sId") String sId);
	
	// 메이커 등록 페이지 접속 시
	int selectMemberIdx(String sId);

	// 프로젝트 등록하기
	int insertProject(ProjectVO project);
	
	// 프로젝트 조회하기
	ProjectVO selectProject(int project_idx);
	
	// 프로젝트 승인 요청
	int updateStatus(int project_idx);
	
	// project_approve_status != 1 리스트 조회
	List<ProjectVO> selectAllRequestProject(
			@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, 
			@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// project_approve_status != 1 리스트 갯수 조회
	int selectAllRequestProjectCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	
	// 프로젝트 상태컬럼 변경
	int updateProjectStatus(@Param("project_idx") int project_idx, @Param("project_approve_status") int project_approve_status);
	
	// maker_idx 조회하기
	int selectMakerIdx(int project_idx);
	
	// 메이커 조회
	MakerVO selectMakerInfo(int makerIdx);
	
	// 프로젝트 리스트 조회
	List<ProjectVO> selectProjectList(int member_idx);
	
	// 멤버, 메이커, 프로젝트 테이블을 조인하여 일치하는 데이터 조회
	List<ProjectVO> selectProjectsByMemberId(
			@Param("sId") String sId,
			@Param("maker_idx") Integer maker_idx,
			@Param("project_idx") Integer project_idx);
	
	// 메이커 번호로 프로젝트 리스트 조회
	List<ProjectVO> selectProjectListByMakerIdx(int maker_idx);
	
	// 프로젝트 승인여부 확인하기
	ProjectVO selectProjectApproved(
			@Param("project_idx") int project_idx, @Param("project_approve_status") int project_approve_status);
	
	//
	List<ProjectVO> selectTop10ProjectsByEndDate();

	// 펀딩 프로젝트 목록 조회
	List<ProjectVO> selectProjectList(String searchType, String searchKeyword, int startRow, int listLimit);

	// 전체 펀딩 프로젝트 목록 갯수 조회 요청
	int selectProjectListCount(String searchType, String searchKeyword);

	// 펀딩 프로젝트 탐색
	List<ProjectVO> getProjectList(String searchType, String searchKeyword, int startRow, int listLimit);

	
	


	
}
