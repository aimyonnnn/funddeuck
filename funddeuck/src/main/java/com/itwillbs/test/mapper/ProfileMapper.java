package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.ProfileVO;

@Mapper
public interface ProfileMapper {

    ProfileVO getProfileByMemberId(int member_idx);

    void updateProfile(ProfileVO profileVO);
}

