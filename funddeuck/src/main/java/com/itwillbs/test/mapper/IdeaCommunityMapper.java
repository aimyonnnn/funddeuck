package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.itwillbs.test.vo.IdeaCommunityVO;

@Mapper
public interface IdeaCommunityMapper {
    void insertIdea(IdeaCommunityVO ideaCommunityVO);
    
    List<IdeaCommunityVO> getAllCardData();
}
