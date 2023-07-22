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
	


}
