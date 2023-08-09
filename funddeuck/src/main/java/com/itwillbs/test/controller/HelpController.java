package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.test.service.HelpService;
import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.vo.QnaVO;

@Controller
public class HelpController {

	@Autowired
	HelpService service;
	
	// QNA 폼 요청 시
	@GetMapping("helpInquiryForm")
	public String helpInquiryForm(HttpSession session, Model model) {
		
		// 미로그인시 이전페이지로
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","로그인이 필요합니다.");
    		return "fail_back";
    	}
		
        	return "help/help_inquiry";
	}
	
	// QNA 제출 시
	@PostMapping("helpInquiry")
	public String helpInquiryPro(HttpSession session, Model model, QnaVO qna) {
		
		String uploadDir = "/resources/upload";
		
		//실제 저장 경로
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		
		String subDir = ""; //서브디렉토리(날짜구분하여 저장)
		// 설정한 날짜별로 파일 생성
		
		try {
		Date date = new Date();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		
		// sdf 로 설정된 date 를 subDir 에 저장
		subDir = sdf.format(date);
		saveDir += "/" + subDir;
		
		Path path = Paths.get(saveDir);
		
		//실제 경로에 존재하지 않는 파일을 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
			MultipartFile mFile = qna.getFile1();
			
			// 업로드 파일명 중복 불가 처리
			String uuid = UUID.randomUUID().toString();
			
			qna.setQna_file("");
			
			String fileName = uuid.substring(0,8)+"_"+mFile.getOriginalFilename();
			
			if(!mFile.getOriginalFilename().equals("")) {
				qna.setQna_file(subDir + "/" + fileName);
			}
			
		int insertCount = service.registQNA(qna);
		
		if(insertCount > 0) {
			
			if(!mFile.getOriginalFilename().equals("")) {
				try {
					mFile.transferTo(new File(saveDir,fileName));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		model.addAttribute("msg","등록이 완료되었습니다.");
		model.addAttribute("targetURL","helpInquiryForm");
		return "success_forward";
	}
}
