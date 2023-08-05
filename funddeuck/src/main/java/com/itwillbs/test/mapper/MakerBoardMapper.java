package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.MakerBoardVO;

@Mapper
public interface MakerBoardMapper {
	
	// 메이커 전체 게시물 조회
	List<MakerBoardVO> selectAllMakerBoardList(Integer maker_idx);

		
	
}
