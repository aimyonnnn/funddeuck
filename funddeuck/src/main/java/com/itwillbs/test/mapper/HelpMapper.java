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
	int selectNoticeListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);
	
	// 공지사항 상세 조회
	NoticeVO selectNotice(int notice_idx);
	
	// 조회수 증가
	void updateReadcount(NoticeVO notice);
	
	// 공지사항 수정 - 파일 삭제 ajax
	int deleteNoticeFile(@Param("notice_idx") int notice_idx, @Param("fileName") String fileName, @Param("fileNumber") int fileNumber);
	
	// 공지사항 수정
	int updateNotice(NoticeVO notice);
	
	// 공지사항 삭제
	int deleteNotice(int notice_idx);
	
	// 공지사항 카테고리 선택 조회
	List<NoticeVO> selectNoticeCategoryList(@Param("notice_category") int notice_category, @Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword, @Param("startRow") int startRow, @Param("listLimit") int listLimit);

}
