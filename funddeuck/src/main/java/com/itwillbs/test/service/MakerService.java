package com.itwillbs.test.service;

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
	
}
