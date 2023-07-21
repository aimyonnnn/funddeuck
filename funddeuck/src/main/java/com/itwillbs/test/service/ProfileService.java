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

    public ProfileVO getProfileData(int memberIdx) {
        return profileMapper.getProfileData(memberIdx);
    }

    public void saveProfileData(ProfileVO profileVO) {
        ProfileVO existingProfile = profileMapper.getProfileData(profileVO.getMember_idx());

        if (existingProfile != null) {
            if (profileVO.getProfile_job1() != null && !profileVO.getProfile_job1().isEmpty()) {
                existingProfile.setProfile_job1(profileVO.getProfile_job1());
            }
            if (profileVO.getProfile_job2() != null && !profileVO.getProfile_job2().isEmpty()) {
                existingProfile.setProfile_job2(profileVO.getProfile_job2());
            }
            if (profileVO.getProfile_school1() != null && !profileVO.getProfile_school1().isEmpty()) {
                existingProfile.setProfile_school1(profileVO.getProfile_school1());
            }
            if (profileVO.getProfile_school2() != null && !profileVO.getProfile_school2().isEmpty()) {
                existingProfile.setProfile_school2(profileVO.getProfile_school2());
            }
            if (profileVO.getProfile_text() != null && !profileVO.getProfile_text().isEmpty()) {
                existingProfile.setProfile_text(profileVO.getProfile_text());
            }

            profileMapper.saveProfileData(existingProfile);
        } else {
            profileMapper.saveProfileData(profileVO);
        }
    }
}
