package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.MakerVO;

@Mapper
public interface MakerMapper {
	
	// 메이커 정보 조회하기
	MakerVO selectMakerInfo(Integer maker_idx);
	
	// 메이커 페이지 수정하기
	int updateMaker(MakerVO maker);
	
	// 메이커 페이지 수저하기 - 파일 실시간 삭제
	int deleteMakerFile(@Param("maker_idx") int maker_idx, @Param("fileName") String fileName, @Param("fileNumber") int fileNumber);
	
}
