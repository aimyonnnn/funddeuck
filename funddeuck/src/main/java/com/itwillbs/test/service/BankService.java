package com.itwillbs.test.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.BankMapper;
import com.itwillbs.test.vo.*;

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
	
	// 토큰 삭제
	public boolean deleteToken(int member_idx) {
		if(mapper.deleteToken(member_idx) > 0) {
			return true;
		}
		return false;
	}
	
	// 계좌 정보 저장
	public boolean registBankAccount(int member_idx, BankAccountVO mostRecentBankAccount) {
		if(mapper.insertBankAccount(member_idx, mostRecentBankAccount) > 0) {
			return true;
		} else {
			// 토큰 정보 삭제
			mapper.deleteToken(member_idx);
			return false;
		}
	}
	
	// 계좌 정보 조회
	public BankAccountVO getBankAccountInfo(int member_idx) {
		return mapper.selectBankAccountInfo(member_idx);
	}
	
	// 중복된 계좌 정보 조회(핀테크이용번호 일치 여부 확인)
	public boolean getBankAccount(int member_idx, BankAccountVO mostRecentBankAccount) {
		if(mapper.selectBankAccount(member_idx, mostRecentBankAccount) == null) {
			// 계좌 정보 삭제
			mapper.deleteBankAccount(member_idx);
			return false;
		}
		
		return true;
	}
	
	
	// 정산 입금내역 등록
	public int registDepositSettlement(String member_id, int project_idx, Map<String, Object> paramMap) {
		return mapper.insertDepositSettlement(member_id, project_idx, paramMap);
	}

	// 환불 입금내역 등록
	public int registDepositRefund(String member_id, int project_idx, Map<String, Object> paramMap) {
		return mapper.insertDepositRefund(member_id, project_idx, paramMap);
	}
	
	// 펀딩 결제시(계좌) 입금내역 등록
	public boolean saveFundingTranHist(String member_id, ResponseWithdrawVO withdrawResult) {
		if(mapper.insertFundingTranHist(member_id, withdrawResult) > 0) {
			return true;
		}
		return false;
	}
	
}
