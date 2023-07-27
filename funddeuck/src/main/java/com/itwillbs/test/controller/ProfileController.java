package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.test.service.ProfileService;
import com.itwillbs.test.vo.ProfileVO;

@Controller
@RequestMapping("/member")
public class ProfileController {

    private final ProfileService profileService;

    @Autowired
    public ProfileController(ProfileService profileService) {
        this.profileService = profileService;
    }

//    @GetMapping("/profile")
//    public String showProfilePage(Model model, HttpSession session) {
//        Integer memberIdx = (Integer) session.getAttribute("member_idx");
//        if (memberIdx == null) {
//            return "member/member_profile"; // �α��� �������� �����̷�Ʈ ����
//        }
//
//        ProfileVO profile = profileService.getProfileByMemberId(memberIdx.intValue());
//        model.addAttribute("profile", profile);
//        return "member/member_profile";
//    }
    
    public String showProfilePage(Model model) {
        int memberIdx = 1; // ������ �α��� ���� member_idx�� 1�� �־����ٰ� ����
        ProfileVO profile = profileService.getProfileByMemberId(memberIdx);
        model.addAttribute("profile", profile);
        return "member/member_profile";
    }


    @PostMapping("/profile")
    @ResponseBody
    public ResponseEntity<String> saveProfile(@ModelAttribute ProfileVO profileVO,
                                              @RequestParam(value = "profile_img", required = false) MultipartFile profileImage) {
        try {
            if (profileImage != null && !profileImage.isEmpty()) {
                String profileImagePath = saveProfileImage(profileImage);
                profileVO.setProfile_img(profileImagePath);
            }

            profileService.updateProfile(profileVO);
            return ResponseEntity.ok("�������� ����Ǿ����ϴ�.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("���忡 �����߽��ϴ�. �ٽ� �õ����ּ���.");
        }
    }

    private String saveProfileImage(MultipartFile profileImage) throws IOException {
        if (profileImage == null || profileImage.isEmpty()) {
            return null; 
        }

        String profileImageDirectory = "/path/to/save/images/";
        String originalFilename = profileImage.getOriginalFilename();
        String profileImagePath = profileImageDirectory + UUID.randomUUID().toString() + "_" + originalFilename;

        try {
            File directory = new File(profileImageDirectory);
            if (!directory.exists()) {
                directory.mkdirs(); 
            }

            File profileImageFile = new File(profileImagePath);
            profileImage.transferTo(profileImageFile);

            return profileImagePath;
        } catch (IOException e) {
            throw new IOException("���� ������ �����߽��ϴ�.", e);
        }
    }

}


