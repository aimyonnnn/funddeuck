package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.FundingDoctorVO;
import com.itwillbs.test.vo.MakerBoardVO;
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
	Integer selectMemberIdx(String sId);

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

	// 펀딩 프로젝트 목록 조회
	List<ProjectVO> selectProjectList(String searchType, String searchKeyword, int startRow, int listLimit);

	// 전체 펀딩 프로젝트 목록 갯수 조회 요청
	int selectProjectListCount(String searchType, String searchKeyword);

	// 펀딩 프로젝트 탐색
	List<ProjectVO> getProjectList(String searchType, String searchKeyword, int startRow, int listLimit);
	
	// 승인완료 된 프로젝트 리스트 조회
	List<ProjectVO> selectApprovedProjects();
	
	// 프로젝트 승인 처리 시간 저장
	int updateProjectApprovalRequestTime(ProjectVO project);
	
	// 전체 프로젝트 리스트 조회
	List<ProjectVO> selectAllProject(
			@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType,  
			@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 전체 프로젝트 갯수 조회
	int selectAllProjectCount(@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType);		
	
	// 프로젝트 리스트 조회 
	List<ProjectVO> selectAllProjectByMakerIdx(int maker_idx);
			
	// 메이커 게시판 공지사항 작성하기
	int insertMakerBoard(MakerBoardVO makerBoard);
	
	// 메이커 공지사항 리스트 조회
	List<MakerBoardVO> selectMakerBoardList(Integer maker_idx);
	
	// show all project
	List<ProjectVO> getAllProjects();
	
	//ranking system
	List<ProjectVO> selectTop10ProjectsByEndDate();
	
	// 프로젝트 승인상태 조회
	Integer selectProjectStatus(int project_idx);
	
	// 관리자 - 프로젝트 정보 수정
	int updateProjectByAdmin(ProjectVO project);

	// 관리자 - 첨부파일 실시간 삭제
	int deleteProjectFile(@Param("project_idx") int project_idx, @Param("fileName") String fileName, @Param("fileNumber") int fileNumber);

	// 정산 완료 후 프로젝트 상태 변경
	int updateProjectSettlementStatus(@Param("project_idx") int project_idx,@Param("final_settlement") int final_settlement);

	// 정산 완료 후 환불 상태 변경
	int updateProjectRefundStatus(@Param("payment_idx") int payment_idx);

	// 작성중인 프로젝트 조회 - 현재 프로젝트는 등록했는데 리워드는 등록 안한 상태
	List<ProjectVO> selectUnapprovedList(Integer maker_idx);

	// 진행중인 프로젝트 조회
	List<ProjectVO> selectProceedingList(Integer maker_idx);

	// 진행완료된 프로젝트 조회
	List<ProjectVO> selectCompleteList(Integer maker_idx);
	
	// 프로젝트 상태컬럼 변경
	int updateProjectSatusProgress(@Param("project_idx") int project_idx, @Param("project_status") int project_status);

	// 프로젝트 펀딩닥터 신청 상태 변경
	int updateProjectStatusDoctor(int project_idx);

	// 펀딩닥터 신청 프로젝트 조회 요청
	List<ProjectVO> selectFundingDoctorProject(
												@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, 
												@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	// 펀딩닥터 신청 게시물 수 조회 요청
	int selectFundingDoctorProjectCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	// 펀딩닥터 컨설팅 등록
	int insertFundingDoctor(FundingDoctorVO doctor);

	// 펀딩닥터 컨설팅 완료로 상태 변경
	int updateDoctorStatus(int project_idx);

	// 완료된 컨설팅 조회
	FundingDoctorVO selectFundingDoctorInfo(int project_idx);

	// 메이커 번호로 조회된 펀딩 닥터 답변 리스트 조회
	List<FundingDoctorVO> selectFundingDoctorAnswerProject(
							@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, 
							@Param("startRow") int startRow, @Param("listLimit") int listLimit, 
							@Param("maker_idx") Integer maker_idx);

	// 펀딩 닥터 답변 페이지 게시물 수 조회
	int selectFundingDoctorAnswerProjectCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, @Param("maker_idx") Integer maker_idx);

	// 작성중인 프로젝트 삭제
	int deleteProject(int project_idx);
	
	// 승인된 프로젝트 리스트 조회
	List<ProjectVO> selectApprovedProjectsByMakerIdx(Integer maker_idx);
	
	// 결제완료된 프로젝트 리스트 조회 (memberIdx)
	List<ProjectVO> selectCompletedPaymentProjectList(Integer member_idx);
	
	// 결제완료된 프로젝트 리스트 조회 (makerIdx)
	List<ProjectVO> selectCompletedPaymentProjectListByMakerIdx(int maker_idx);

	// 시작일로부터 일주일간의 찜 추이
	List<ProjectVO> selectProjectsWeekStartDate(@Param("startDate") String startDate, @Param("project_idx") int project_idx);

	
}
