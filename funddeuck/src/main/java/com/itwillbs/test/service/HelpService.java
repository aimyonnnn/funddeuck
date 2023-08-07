package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.QnaMapper;
import com.itwillbs.test.vo.QnaVO;

@Service
public class HelpService {
	@Autowired
	QnaMapper mapper;
	
	// QNA 등록
	public int registQNA(QnaVO qna) {
		return mapper.registQNA(qna);
	}

}
