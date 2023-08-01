package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProfileMapper;
import com.itwillbs.test.vo.ProfileVO;

@Service
public class ProfileService {
	
	@Autowired
    private final ProfileMapper profileMapper;

    @Autowired
    public ProfileService(ProfileMapper profileMapper) {
        this.profileMapper = profileMapper;
    }

    public ProfileVO getProfileByMemberId(int memberIdx) {
        return profileMapper.getProfileByMemberId(memberIdx);
    }

    public void updateProfile(ProfileVO profileVO) {
        profileMapper.updateProfile(profileVO);
    }

	public int modifyProfileImage(ProfileVO profile) {
		return profileMapper.updateProfileImage(profile);
	}
}
