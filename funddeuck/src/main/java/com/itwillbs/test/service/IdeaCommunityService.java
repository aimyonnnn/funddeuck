package com.itwillbs.test.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

    public IdeaCommunityVO getIdeaById(int ideaIdx) {
        return ideaCommunityMapper.getIdeaById(ideaIdx);
    }

    @Transactional
    public void incrementLikeCount(int ideaIdx) {
        IdeaCommunityVO idea = ideaCommunityMapper.getIdeaById(ideaIdx);
        if (idea != null) {
            int currentLikeCount = idea.getLikecount();
            idea.setLikecount(currentLikeCount + 1);
            ideaCommunityMapper.updateIdea(idea);
        }
    }

    @Transactional
    public void updateIdea(IdeaCommunityVO idea) {
        ideaCommunityMapper.updateIdea(idea);
    }
    
    public boolean isAllowedToLike(int ideaIdx, int memberIdx) {
        int likeCountForToday = ideaCommunityMapper.getLikeCountForToday(ideaIdx, memberIdx);
        return likeCountForToday < 3;
    }
}
