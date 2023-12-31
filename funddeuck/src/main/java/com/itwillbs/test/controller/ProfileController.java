package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
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
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.test.service.ProfileService;
import com.itwillbs.test.vo.ProfileVO;

@Controller
@RequestMapping
public class ProfileController {

    private final ProfileService profileService;

    @Autowired
    public ProfileController(ProfileService profileService) {
        this.profileService = profileService;
    }

    @GetMapping("/profile")
    public String showProfilePage(Model model, HttpSession session) {

        Integer memberIdx = (Integer) session.getAttribute("sIdx");
        if (memberIdx == null) {
            return "redirect:/"; 
        }

        ProfileVO profile = profileService.getProfileByMemberId(memberIdx.intValue());
        boolean isProfileSaved = profileService.isProfileSaved(memberIdx.intValue());

        System.out.println("Session attribute sIdx: " + memberIdx);
        model.addAttribute("profile", profile);
        model.addAttribute("isProfileSaved", isProfileSaved); 
        return "member/member_profile";
    }
    
    @PostMapping("/insert")
    @ResponseBody
    	public ModelAndView insertProfile(@ModelAttribute ProfileVO profileVO) {
    	System.out.println("테스트 : " + profileVO);
    		
    	profileService.insertProfile(profileVO);

        ModelAndView mv = new ModelAndView("redirect:/");
        return mv;
    }

    @PostMapping("/profile")
    @ResponseBody
    public ResponseEntity<String> updateProfile(@ModelAttribute ProfileVO profileVO) {
        try {
            profileService.updateProfile(profileVO);
            return ResponseEntity.ok("프로필이 저장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("프로필 저장에 실패했습니다.");
        }
    }

    	
    @PostMapping("updateProfileImage")
    public String updateProfileImage(ProfileVO profile, HttpSession session, Model model) {
    	
    	System.out.println(profile);
    	
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = "";
		
		try {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 파일 업로드 폴더 경로 출력
		System.out.println("실제 업로드 폴더 경로: " + saveDir);
		
		MultipartFile mFile1 = profile.getFile();
		
		System.out.println("파일 출력 테스트 : " + mFile1);
		
		String uuid = UUID.randomUUID().toString();
		profile.setProfile_img("");
		
		String fileName1 = null;

		if (mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
		    fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		    profile.setProfile_img(subDir + "/" + fileName1);
		}


		System.out.println("실제 업로드 파일명 : " + profile.getProfile_img());
		// -----------------------------------------------------------------------------------
		
//		int updateCount = profileService.modifyProfileImage(profile);
		
		Integer checkmember_idx = profileService.selectProfileImage(profile);
		System.out.println(checkmember_idx);
		System.out.println(checkmember_idx);
		System.out.println(checkmember_idx);
		
		if(checkmember_idx != null) {
			System.out.println(profile);
			profileService.modifyProfileImage(profile);
		}else {profileService.insertProfileImage(profile);}
		
			// 파일 업로드 처리
			try {
			    if (fileName1 != null) {
			        mFile1.transferTo(new File(saveDir, fileName1));
			    }
			} catch (IllegalStateException e) {
			    e.printStackTrace();
			} catch (IOException e) {
			    e.printStackTrace();
			}
			String targetURL = "profile";
			model.addAttribute("msg", "프로필 사진 수정이 완료되었습니다.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		}
    
    
    }
    
    


