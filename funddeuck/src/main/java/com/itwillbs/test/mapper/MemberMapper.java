package com.itwillbs.test.mapper;


import java.util.List;

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

}
