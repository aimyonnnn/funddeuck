package com.itwillbs.test.mapper;

import com.itwillbs.test.vo.ProfileVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProfileMapper {

    ProfileVO getProfileData(int memberIdx);

    void saveProfileData(ProfileVO profileVO);
}