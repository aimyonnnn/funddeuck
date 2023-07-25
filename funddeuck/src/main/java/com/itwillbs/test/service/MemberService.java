package com.itwillbs.test.service;

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

	public void updateFailCount(MembersVO isMember) {
		mapper.updateFailCount(isMember);
		
	}
	


}
