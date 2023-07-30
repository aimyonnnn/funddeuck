package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.BankMapper;
import com.itwillbs.test.vo.ResponseTokenVO;

@Service
public class BankService {
	@Autowired
	private BankMapper mapper;

	// 토큰 관련 정보를 DB에 저장
	public boolean registToken(String id, ResponseTokenVO responseToken) {
		if(mapper.insertToken(id, responseToken) > 0) {
			return true;
		} else {
			return false;
		}
	}
}
