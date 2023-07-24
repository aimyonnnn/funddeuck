package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.ProfileVO;

@Mapper
public interface ProfileMapper {
	
	 void insertProfile(ProfileVO profileVO);
	 void updateProfile(ProfileVO profileVO);
     ProfileVO getProfileByMemberIdx(int memberIdx);	
	
}
