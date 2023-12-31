package com.itwillbs.test.mapper;


import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.*;

import com.itwillbs.test.vo.*;

@Mapper
public interface MemberMapper {
	
	// 회원 정보 조회하기 
	MembersVO selectMember(String id);
	
	// 회원 가입
	int insertMember(MembersVO member);
	
	// 이메일 인증
	int insertEmailDuplicate(@Param("email") String email, @Param("authCode") String authCode);
	
	//이메일 존재여부
	int selectEmail(String email);
	
	//인증코드 업데이트
	int updateEmailAuthCode(@Param("email") String email, @Param("authCode") String authCode);
	
	// 존재 여부
	int isAuthCode(@Param("email") String email, @Param("authCode") String authCode);
	
	// 이메일 인증 데이터 삭제
	int deleteAuthCode(@Param("email") String email, @Param("authCode") String authCode);
	
	// url 판별
	List<MembersVO> selectIdx(String sId);

	// 실패 카운트
	void updateFailCount(MembersVO member);
	
	// 피드백 메시지를 보내기 위해 member_id를 조회
	String selectMemberId(int member_idx);
	
	// 휴대폰 번호 조회
	String selectMemberPhone(int member_idx);
	
	// Member 테이블에 email 존재 여부 확인
	int selectMemberEmail(String email);
	
	//email 로 Member정보 불러오기
	MembersVO selectMemberInfoEmail(String email);
	
	//email 로 조회후 passwd 변경
	int updatePasswd(@Param("passwd") String passwd, @Param("email") String email);
	
	// 존재하는 회원인지 확인하기
	MembersVO selectCorrectMember(String target);
	
	//팔로우 리스트 조회
	List<Map<String, Object>> selectFallowList(@Param("sId")String sId,@Param("startRow") int startRow,@Param("listLimit") int listLimit, @Param("maker_name") String maker_name);

	//팔로우 알람 설정
	int updateFallowingAlam(@Param("maker_name") String maker_name, @Param("is_alam") int is_alam,@Param("sId") String sId);
	
	//팔로우 삭제
	int deleteFallow(@Param("maker_name") String maker_name,@Param("sId") String sId);
	
	//팔로우 추가
	int insertFallow(@Param("maker_name") String maker_name,@Param("sId") String sId);
	
	//찜 목록 가져오기
	List<Map<String, Object>> selectZimList(@Param("sId")String sId,@Param("startRow") int startRow,@Param("listLimit") int listLimit, @Param("zimType") String zimType, @Param("zimContent") String zimContent);
	
	// 찜 알람 설정
	int updateZimAlam(@Param("project_idx") int project_idx, @Param("isAlam") int isAlam, @Param("sId") String sId);

	// 찜 삭제
	int deleteZim(@Param("project_idx") int project_idx, @Param("sId") String sId);
	
	// 찜 하기
	int insertZim(@Param("project_idx") int project_idx, @Param("sId") String sId);
	
	//팔로우 게시판
	List<ProjectVO> selectFollowProjectList(@Param("sId")String sId,@Param("startRow") int startRow,@Param("listLimit") int listLimit);
	
	// 문자 메시지를 보내기 위해 project_idx로 멤버 정보 조회
	MembersVO selectMemberInfoByProjectIdx(int project_idx);
	
	//배달 완료 체크
	int updateDeleveryComplete(int payment_idx);
	
	//리뷰 작성
	int insertRevewRegistration(@Param("payment_idx") int payment_idx, @Param("context") String context, @Param("starRating") int starRating, @Param("saveFileName")String saveFileName);

	// 회원 목록 조회 요청
	List<MembersVO> selectAllMemberList(
			@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType,
			@Param("startRow") int startRow, @Param("listLimit") int listLimit);

	// 전체 회원 갯수 조회
	int selectAllMemberListCount(@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType);

	// 회원 상세정보 보기
	MembersVO selectMemberInfo(Integer member_idx);

	// 회원 정보 변경 비즈니스 로직 처리
	int updateMemberByAdmin(MembersVO member);

	// 회원 활동내역 목록 조회
	List<ActivityListVO> selectMemberActivityList(@Param("member_idx") Integer member_idx, @Param("listLimit") int listLimit);
	
	//리뷰 목록 가져오기
	List<Map<String, Object>> selectMemberReviewList(@Param("sId") String sId, @Param("startRow")int startRow, @Param("listLimit") int listLimit);
	
	//리뷰 갯수
	int selectMemberReviewListCount(String sId);
	
	//리뷰 삭제
	int deleteUpdateMemberReview(int num);

	String getMakerMemberId(int maker_idx);
	
	//찜한 리스트의 최근 포스트 가져오기
	List<Map<String, Object>> selectZimPostList(@Param("sId") String sId,@Param("startRow") int startRow,@Param("listLimit") int listLimit);
	
	//찜한 리스트의 포트스 카운트
	int selectZimPostListCount(String sId);

	// 전체 회원 조회
	List<MembersVO> selectAllmemberList();

	// 오늘 가입한 회원 수 조회
	int selectMembersCountByToday();
	
	//팔로잉 리스트이 카운트
	int selectFollowingCount(@Param("sId") String sId, @Param("maker_name") String maker_name);
	
	//찜 리스트 카운트
	int selectZimCount(@Param("sId") String sId, @Param("zimType") String zimType, @Param("zimContent") String zimContent);

	// 누적 회원 수 조회
	List<MembersVO> selectMemberCountsByDate(@Param("startDate") LocalDate startDate,@Param("endDate") LocalDate endDate);
	
	// 팔로우 여부 확인
	int getIsFollow(@Param("maker_idx") int maker_idx, @Param("sId") String sId);
	
	// 팔로우 한 메이커가 작성한 공지사항 카운트
	int selectFollowBoardListCount(String sId);
	
	//전화번호가 존재하는지 여부를 확인
	int selectPhoneNumber(String phoneNumber);
	
	//전화번호와 코드가 일치한지 여부 확인
	int selectPhoneNumberEquelCode(@Param("phoneNumber") String phoneNumber,@Param("authCode") String authCode);
	
	//전화번호가 일치시 phone 테이블에서 데이터 삭제
	int deletePhoneNUmberCode(String phoneNumber);
	
	//회원 정보 변경
	int updateMemberInfo(MembersVO member);
	
	//회원 탈퇴
	int updateMemberDeleteStatus(String sId);
	

}
