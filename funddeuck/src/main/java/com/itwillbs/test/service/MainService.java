package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.MainMapper;
import com.itwillbs.test.vo.MainVO;

import java.util.List;

@Service
public class MainService {

    private final MainMapper mainMapper;

    @Autowired
    public MainService(MainMapper mainMapper) {
        this.mainMapper = mainMapper;
    }

    public List<MainVO> getAllProjects() {
        return mainMapper.getAllProjects();
    }

    public List<MainVO> getRankingData() {
    	System.out.println("ranking");
        return mainMapper.getRankingData();
    }
}
