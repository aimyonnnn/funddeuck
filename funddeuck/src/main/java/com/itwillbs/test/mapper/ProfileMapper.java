package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.test.vo.ProfileVO;

@Mapper
public interface ProfileMapper {

    ProfileVO getProfileByMemberId(int memberIdx);

    void updateProfile(ProfileVO profileVO);

	int updateProfileImage(ProfileVO profile);

	void insertProfile(ProfileVO profileVO);

	void insertProfileImage(ProfileVO profile);

	Integer selectProfileImage(ProfileVO profile);
}

