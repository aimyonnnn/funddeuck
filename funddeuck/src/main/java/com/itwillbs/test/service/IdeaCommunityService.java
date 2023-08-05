package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.IdeaCommunityMapper;
import com.itwillbs.test.vo.IdeaCommunityVO;

@Service
public class IdeaCommunityService {

    private final IdeaCommunityMapper ideaCommunityMapper;

    @Autowired
    public IdeaCommunityService(IdeaCommunityMapper ideaCommunityMapper) {
        this.ideaCommunityMapper = ideaCommunityMapper;
    }

    public void saveIdea(IdeaCommunityVO ideaCommunityVO) {
        ideaCommunityMapper.insertIdea(ideaCommunityVO);
    }

    public List<IdeaCommunityVO> getAllCardData() {
        return ideaCommunityMapper.getAllCardData();
    }
}
