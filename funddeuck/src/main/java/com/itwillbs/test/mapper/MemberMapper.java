package com.itwillbs.test.mapper;


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
	List<Map<String, Object>> selectFallowList(String sId);

	//팔로우 알람 설정
	int updateFallowingAlam(@Param("maker_name") String maker_name, @Param("is_alam") int is_alam,@Param("sId") String sId);
	
	//팔로우 삭제
	int deleteFallow(@Param("maker_name") String maker_name,@Param("sId") String sId);
	
	//팔로우 추가
	int insertFallow(@Param("maker_name") String maker_name,@Param("sId") String sId);
	
	//찜 목록 가져오기
	List<Map<String, Object>> selectZimList(String sId);
	
	// 찜 알람 설정
	int updateZimAlam(@Param("project_idx") int project_idx, @Param("isAlam") int isAlam, @Param("sId") String sId);

	// 찜 삭제
	int deleteZim(@Param("project_idx") int project_idx, @Param("sId") String sId);
	
	// 찜 하기
	int insertZim(@Param("project_idx") int project_idx, @Param("sId") String sId);
	
	//팔로우 게시판
	List<ProjectVO> selectFollowProjectList(String sId);
	
	// 문자 메시지를 보내기 위해 project_idx로 멤버 정보 조회
	MembersVO selectMemberInfoByProjectIdx(int project_idx);
	
	//배달 완료 채크
	int updateDeleveryComplete(int payment_idx);
	
	//리뷰 작성
	int insertRevewRegistration(@Param("payment_idx") int payment_idx, @Param("context") String context, @Param("starRating") int starRating, @Param("saveFileName")String saveFileName);
	
	//리뷰 목록 가져오기
	List<Map<String, Object>> selectMemberReviewList(@Param("sId") String sId, @Param("startRow")int startRow, @Param("listLimit") int listLimit);
	
	//리뷰 갯수
	int selectMemberReviewListCount(String sId);
	
	//리뷰 삭제
	int deleteUpdateMemberReview(int num);
	

}
