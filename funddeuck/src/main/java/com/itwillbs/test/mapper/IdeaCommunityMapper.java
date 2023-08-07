package com.itwillbs.test.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.IdeaCommunityVO;

@Mapper
public interface IdeaCommunityMapper {
    void insertIdea(IdeaCommunityVO ideaCommunityVO);
    
    List<IdeaCommunityVO> getAllCardData();

	IdeaCommunityVO getIdeaById(int ideaIdx);

	void updateIdea(IdeaCommunityVO idea);

	int getLikeCountForToday(int ideaIdx, int memberIdx);
        

    
}
