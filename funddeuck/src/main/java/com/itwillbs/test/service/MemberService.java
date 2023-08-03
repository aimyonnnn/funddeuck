package com.itwillbs.test.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.test.mapper.*;
import com.itwillbs.test.vo.*;

@Service
public class MemberService {
	@Autowired
	private MemberMapper mapper;
	
	// 회원 정보 조회하기
	public MembersVO getMemberInfo(String id) {
		return mapper.selectMember(id);
	}

	//회원 가입
	public int insertMember(MembersVO member) {
		return mapper.insertMember(member);
	}
	
	//이메일 인증
	public int emailDuplicate(String email, String authCode) {
		return mapper.insertEmailDuplicate(email,authCode);
	}
	
	//이메일 존재 여부 확인
	public int selectEmail(String email) {
		return mapper.selectEmail(email);
	}
	
	//이메일 코드 업데이트
	public int updateAuthCode(String email, String authCode) {
		return mapper.updateEmailAuthCode(email, authCode);
	}
	
	//이메일과 코드의 존재 여부 판별
	public int isAuthCode(String email, String authCode) {
		return mapper.isAuthCode(email, authCode);
	}

	public int authCodeDelete(String email, String authCode) {
		return mapper.deleteAuthCode(email,authCode);
	}
	// 프로젝트 페이지 url 판별
	public List<MembersVO> getIdx(String sId) {
		return mapper.selectIdx(sId);
	}
	
	// 로그인 실패 카운트 업데이트
	public void updateFailCount(MembersVO isMember) {
		mapper.updateFailCount(isMember);
		
	}
	
	// 피드백 메시지를 보내기 위해 member_id를 조회
	public String getMemberId(int member_idx) {
		return mapper.selectMemberId(member_idx);
	}
	
	// 휴대폰 번호 조회
	public String getMemberPhone(int member_idx) {
		return mapper.selectMemberPhone(member_idx);
	}
	
	// Members 테이블에 email 존재 여부 확인
	public int selectMemberEmail(String email) {
		return mapper.selectMemberEmail(email);
	}
	
	// email 로 member 정보 불러오기
	public MembersVO getMemberInfoEmail(String email) {
		return mapper.selectMemberInfoEmail(email);
	}
	
	// email 로 조회후 passwd 변경
	public int modifyPasswd(String passwd, String email) {
		return mapper.updatePasswd(passwd, email);
	}
	
	// 존재하는 회원인지 확인하기
	public MembersVO isCorrectMember(String target) {
		return mapper.selectCorrectMember(target);
	}
	
	// 팔로잉 리스트 뽑기
	public List<Map<String, Object>> getfallowList(String sId) {
		return mapper.selectFallowList(sId);
	}
	
	// 팔로우 알람 설정
	public int fallowingAlam(String maker_name, int is_alam, String sId) {
		return mapper.updateFallowingAlam(maker_name, is_alam, sId);
	}
	
	//팔로우 삭제
	public int deleteFallow(String maker_name, String sId) {
		return mapper.deleteFallow(maker_name, sId);
	}
	
	//팔로우 등록
	public int insertFallow(String maker_name, String sId) {
		return mapper.insertFallow(maker_name, sId);
	}
	
	// 찜 목록 가져오기
	public List<Map<String, Object>> getZimList(String sId) {
		return mapper.selectZimList(sId);
	}
	
	//찜 알람 설정
	public int zimAlam(int project_idx, int isAlam, String sId) {
		return mapper.updateZimAlam(project_idx, isAlam, sId);
	}
	
	//찜 삭제
	public int deleteZim(int project_idx, String sId) {
		return mapper.deleteZim(project_idx, sId);
	}

	// 찜등록
	public int insertZim(int project_idx, String sId) {
		return mapper.insertZim(project_idx, sId);
	}

	// 팔로우의 최근 프로젝트 가져오기
	public List<ProjectVO> getProject(String sId) {
		return mapper.selectFollowProjectList(sId);
	}

	//배송이 완료 변경 버튼(회원만)
	public int ModifyDeleveryComplete(int payment_idx) {
		return mapper.updateDeleveryComplete(payment_idx);
	}
	
	// 리뷰작성 시 리뷰 등록
	public int reivewRegistration(int payment_idx, String context, int starRating, String saveFileName) {
			return mapper.insertRevewRegistration(payment_idx, context, starRating, saveFileName);
	}
	
	// 리뷰 리스트 가져오기
	public List<Map<String, Object>> getMemberReviewList(String sId, int startRow, int listLimit) {
		return mapper.selectMemberReviewList(sId, startRow, listLimit);
	}
	
	//리뷰 카운트
	public int getMemberReveiwListCount(String sId) {
		return mapper.selectMemberReviewListCount(sId);
	}
	
	
	// 문자 메시지를 보내기 위해 project_idx로 멤버 정보 조회
	public MembersVO getMemberInfoByProjectIdx(int project_idx) {
		return mapper.selectMemberInfoByProjectIdx(project_idx);
	}
	
	// 리뷰 삭제
	public int deleteMemberReview(int num) {
		return mapper.deleteUpdateMemberReview(num);
	}
	


}
