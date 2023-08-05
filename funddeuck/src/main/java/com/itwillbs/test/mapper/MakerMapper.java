package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.MakerBoardVO;
import com.itwillbs.test.vo.MakerVO;

@Mapper
public interface MakerMapper {
	
	// 메이커 정보 조회하기
	MakerVO selectMakerInfo(Integer maker_idx);
	
	// 메이커 페이지 수정하기
	int updateMaker(MakerVO maker);
	
	// 메이커 페이지 수저하기 - 파일 실시간 삭제
	int deleteMakerFile(@Param("maker_idx") int maker_idx, @Param("fileName") String fileName, @Param("fileNumber") int fileNumber);
	
	// 메이커 idx 조회하기
	Integer selectMakerIdx(String sId);
	
	// 공지사항 삭제하기
	int deleteMakerBoard(int maker_board_idx);
	
	// 공지사항 조회하기
	MakerBoardVO selectMakerBoardInfo(int maker_board_idx);
	
	// 전체 메이커 조회
	List<MakerVO> selectAllMakerList(
			@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType,
			@Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 전체 메이커 갯수 조회
	int selectAllMakerListCount(@Param("searchKeyword") String searchKeyword, @Param("searchType") String searchType);
	
	// 관리자 - 메이커 정보 수정
	int updateMakerByAdmin(MakerVO maker);
	
}
