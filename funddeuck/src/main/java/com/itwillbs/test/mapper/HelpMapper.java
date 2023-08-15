package com.itwillbs.test.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.test.vo.*;

@Mapper
public interface HelpMapper {
	
	// 공지사항 글등록
	int insertNotice(NoticeVO notice);
	
	// 공지사항 목록 조회
	List<NoticeVO> selectNoticeList(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, @Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	// 전체 글 목록 갯수 조회
	int selectNoticeListCount(@Param("searchType") String searchType,@Param("searchKeyword") String searchKeyword);
	
	// 공지사항 상세 조회
	NoticeVO selectNotice(int notice_idx);
	
	// 조회수 증가
	void updateReadcount(NoticeVO notice);

}
