package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProfileMapper;
import com.itwillbs.test.vo.ProfileVO;

@Service
public class ProfileService {
	
	@Autowired
    private ProfileMapper profileMapper;

    public void saveProfile(ProfileVO profileVO) {
        // ProfileVO에서 member_idx를 기준으로 프로필 조회
        ProfileVO existingProfile = profileMapper.getProfileByMemberIdx(profileVO.getMember_idx());

        if (existingProfile == null) {
            // 없는 프로필 정보면 새로 생성하기
            profileMapper.insertProfile(profileVO);
        } else {
            // 이미 존재하는 프로필 정보 -> 값이 비어있지 않은 경우에만 업데이트
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
            // 프로필 이미지는 항상 업데이트합니다.
            existingProfile.setProfile_img(profileVO.getProfile_img());

            profileMapper.updateProfile(existingProfile);
        }
    }
}
