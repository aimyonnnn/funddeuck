package com.itwillbs.test.mapper;

import java.util.List;

import com.itwillbs.test.vo.MainVO;

public interface MainMapper {
    List<MainVO> getAllProjects();

	List<MainVO> getRankingData();
}
