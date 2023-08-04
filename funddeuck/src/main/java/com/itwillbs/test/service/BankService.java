package com.itwillbs.test.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.BankMapper;
import com.itwillbs.test.vo.ResponseTokenVO;

@Service
public class BankService {
	@Autowired
	private BankMapper mapper;

	// 토큰 관련 정보를 DB에 저장
	public boolean registToken(int member_idx, ResponseTokenVO responseToken) {
		if(mapper.insertToken(member_idx, responseToken) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 토큰 정보 조회
	public ResponseTokenVO getTokenInfo(int member_idx) {
		return mapper.selectToken(member_idx);
	}

	// 토큰 갱신
	public boolean updateTokenInfo(int member_idx, ResponseTokenVO token) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("member_idx", member_idx);
		paramMap.put("token", token);
		
		if(mapper.updateToken(member_idx, token) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
}
