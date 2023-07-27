package com.itwillbs.test.service;


import java.util.List;

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
	


}
