package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.MakerBoardMapper;
import com.itwillbs.test.vo.MakerBoardVO;

@Service
public class MakerBoardService {
	
	@Autowired
	private MakerBoardMapper mapper;
	
	// 메이커 전체 게시물 조회
	public List<MakerBoardVO> getAllMakerBoardList(Integer maker_idx) {
		return mapper.selectAllMakerBoardList(maker_idx);
	}
	
	
	
}
