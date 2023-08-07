package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.QnaVO;

@Mapper
public interface QnaMapper {

	// QNA 제출 시
	int registQNA(QnaVO qna);

}
