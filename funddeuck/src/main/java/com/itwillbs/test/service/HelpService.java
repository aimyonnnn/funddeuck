package com.itwillbs.test.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.*;
import com.itwillbs.test.vo.*;

@Service
public class HelpService {
	@Autowired
	QnaMapper qnaMapper;
	
	@Autowired
	HelpMapper helpMapper;
	
	// QNA 등록
	public int registQNA(QnaVO qna) {
		return qnaMapper.registQNA(qna);
	}
	
	// 공지사항 등록
	public boolean registNotice(NoticeVO notice) {
		if(helpMapper.insertNotice(notice) > 0) {
			return true;
		}
		return false;
	}

	// 공지사항 목록 조회
	public List<NoticeVO> getNoticeList(String searchType, String searchKeyword, int startRow, int listLimit) {
		return helpMapper.selectNoticeList(searchType, searchKeyword, startRow, listLimit);
	}
	
	// 전체 글 목록 갯수 조회
	public int getNoticeListCount(String searchType, String searchKeyword) {
		return helpMapper.selectNoticeListCount(searchType, searchKeyword);
	}

	public NoticeVO getNotice(int notice_idx) {
		NoticeVO notice = helpMapper.selectNotice(notice_idx);
		
		// 조회수 증가
		if(notice != null) {
			helpMapper.updateReadcount(notice);
			
		}
		
		return notice;
	}
	

}
