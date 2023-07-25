package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProfileMapper;
import com.itwillbs.test.vo.ProfileVO;

@Service
public class ProfileService {

    private final ProfileMapper profileMapper;

    @Autowired
    public ProfileService(ProfileMapper profileMapper) {
        this.profileMapper = profileMapper;
    }

    public ProfileVO getProfileByMemberId(int member_idx) {
        return profileMapper.getProfileByMemberId(member_idx);
    }

    public void updateProfile(ProfileVO profileVO) {
        profileMapper.updateProfile(profileVO);
    }
}
