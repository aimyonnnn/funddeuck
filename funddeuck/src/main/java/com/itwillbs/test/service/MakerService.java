package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.MakerMapper;
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

	
}
