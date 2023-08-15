package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.MakerMapper;
import com.itwillbs.test.vo.MakerBoardVO;
import com.itwillbs.test.vo.MakerVO;

@Service
public class MakerService {
	
	@Autowired
	private MakerMapper mapper;
	
	// 메이커 정보 조회
	public MakerVO getMakerInfo(Integer maker_idx) {
		return mapper.selectMakerInfo(maker_idx);
	}
	// 메이커 페이지 수정하기
	public int modifyMaker(MakerVO maker) {
		return mapper.updateMaker(maker);
	}
	// 메이커 페이지 수정하기 - 파일 실시간 삭제
	public int removeMakerFile(int maker_idx, String fileName, int fileNumber) {
		return mapper.deleteMakerFile(maker_idx, fileName, fileNumber);
	}
	// 메이커 idx 조회하기
	public Integer getMakerIdx(String sId) {
		return mapper.selectMakerIdx(sId);
	}
	// 공지사항 삭제하기
	public int removeMakerBoard(int maker_board_idx) {
		return mapper.deleteMakerBoard(maker_board_idx);
	}
	// 공지사항 조회하기
	public MakerBoardVO getMakerBoardInfo(int maker_board_idx) {
		return mapper.selectMakerBoardInfo(maker_board_idx);
	}
	// 전체 메이커 조회
	public List<MakerVO> getAllMakerList(String searchKeyword, String searchType, int startRow, int listLimit) {
		return mapper.selectAllMakerList(searchKeyword, searchType, startRow, listLimit);
	}
	// 전체 메이커 갯수 조회
	public int getAllMakerListCount(String searchKeyword, String searchType) {
		return mapper.selectAllMakerListCount(searchKeyword, searchType);
	}
	// 관리자 - 메이커 정보 수정
	public int ModifyMakerByAdmin(MakerVO maker) {
		return mapper.updateMakerByAdmin(maker);
	}
	
	// 개인사업자 등록번호 조회 
	public MakerVO getBizNumCheck(String individual_biz_num) {
		return mapper.selectBizNumCheck(individual_biz_num);
	}
	
	// 법인사업자 등록번호 조회
	public MakerVO getBizNumCheck2(String corporate_biz_num) {
		return mapper.selectBizNumCheck2(corporate_biz_num);
	}
	
	// 메이커 인지 아닌지 파악
	public int getMakerCount(String sId) {
		return mapper.selectMakerCount(sId);
	}
	
	
}
