package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.test.service.HelpService;
import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.vo.*;

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
	
	// 공지사항 메인(글목록) 이동
	@GetMapping("helpNotice")
	public String helpNotice(
			@RequestParam(defaultValue = "") String searchType, 
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum, Model model) {
		
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		// 공지사항 목록 조회
		List<NoticeVO> noticeList = service.getNoticeList(searchType, searchKeyword, startRow, listLimit);
		
		// 전체 글 목록 갯수 조회
		int listCount = service.getNoticeListCount(searchType, searchKeyword);
		
		// 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;
		
		// 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		// 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 끝 페이지 번호 계산 
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이징 처리 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "help/help_notice";
	}
	
	// 공지사항 글쓰기 이동(관리자)
	@GetMapping("NoticeForm")
	public String helpNoticeForm(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		// 관리자 계정이 아닐 경우 접근 불가
		if(!sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		return "help/help_notice_form";
	}
	
	// 공지사항 글등록(관리자)
	@PostMapping("NoticeWrite")
	public String NoticeWrite(NoticeVO notice, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		// 관리자 계정이 아닐 경우 접근 불가
		if(!sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 글쓴이 사이트명으로 저장
		notice.setNotice_name("펀뜩");
		// 이미지 파일
		String uploadDir = "/resources/upload"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = ""; 
		
		try {
			// 현재 날짜
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/mm/dd");
			// 날짜 경로
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			// 실제 경로에 존재하지 않는 파일 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile = notice.getThumnail();
		MultipartFile mFile2 = notice.getFile();
		// 파일명 중복 방지
		String uuid = UUID.randomUUID().toString();
		notice.setNotice_thumnail("");
		notice.setNotice_file("");
		// 파일명 저장할 변수
		String fileName = uuid.substring(0, 8) + "_" + mFile.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		if(!mFile.getOriginalFilename().equals("")) {
			notice.setNotice_thumnail(subDir + "/" + fileName);
		}
		if(!mFile2.getOriginalFilename().equals("")) {
			notice.setNotice_file(subDir + "/" + fileName2);
		}
		
		// 공지사항 등록
		boolean isRegistSuccess = service.registNotice(notice);
		if(isRegistSuccess) { // 글등록 성공
			try {
				if(!mFile.getOriginalFilename().equals("")) {
					mFile.transferTo(new File(saveDir, fileName));
				} 
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				} 
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			return "redirect:helpNotice";
		} else {
			model.addAttribute("msg", "공지사항 등록 실패!");
			return "fail_back";
		}
	
	}
	
	// 공지사항 상세보기(비회원, 회원)
	@GetMapping("NoticeDetail")
	public String noticeDetail(@RequestParam int notice_idx, Model model) {
		
		NoticeVO notice = service.getNotice(notice_idx);
		
		model.addAttribute("notice", notice);
		
		return "help/help_notice_detail";
	}
	
	// 공지사항 수정(관리자) 폼 이동
	@GetMapping("NoticeModifyForm")
	public String modifyForm(
			@RequestParam int notice_idx, 
			@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		// 관리자 계정이 아닐 경우 접근 불가
		if(!sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		NoticeVO notice = service.getNotice(notice_idx);
		model.addAttribute("notice", notice);
		return "help/help_notice_modify";
	}
	
	// 공지사항 수정 - 파일 삭제 ajax
	@PostMapping("deleteNoticeFile")
	@ResponseBody
	public String deleteNoticeFile(int notice_idx, String fileName, int fileNumber, HttpSession session) {
		System.out.println("삭제할 파일 이름 - " + fileName);
		// 파일 삭제 요청
	    int deleteCount = service.removeNoticeFile(notice_idx, fileName, fileNumber);
	    if (deleteCount > 0) {
	        // 파일 삭제 로직
	        String uploadDir = "/resources/upload";
	        String saveDir = session.getServletContext().getRealPath(uploadDir);
	        String filePath = saveDir + "/" + fileName;
	        File file = new File(filePath);
	        if (file.exists()) {
	            if (file.delete()) {
	                return "success";
	            } else {
	                return "fail";
	            }
	        } else {
	            // 파일이 이미 삭제되어 있음
	            return "success";
	        }
	    } else {
	        return "fail";
	    }
		
	}
	
	// 공지사항 수정(관리자)
	@PostMapping("NoticeModify")
	public String modifyPro(
			NoticeVO notice, 
			@RequestParam(defaultValue = "1") int pageNum,
			HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		// 관리자 계정이 아닐 경우 접근 불가
		if(!sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 글쓴이 사이트명으로 저장
		notice.setNotice_name("펀뜩");
		// 이미지 파일
		String uploadDir = "/resources/upload"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = ""; 
		
		try {
			// 현재 날짜
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/mm/dd");
			// 날짜 경로
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			Path path = Paths.get(saveDir);
			// 실제 경로에 존재하지 않는 파일 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mFile = notice.getThumnail();
		MultipartFile mFile2 = notice.getFile();
		// 파일명 중복 방지
		String uuid = UUID.randomUUID().toString();
		notice.setNotice_thumnail("");
		notice.setNotice_file("");
		// 파일명 저장할 변수
		String fileName = null;
		String fileName2 = null;
		if(mFile != null && !mFile.getOriginalFilename().equals("")) {
			fileName = uuid.substring(0, 8) + "_" + mFile.getOriginalFilename();
			notice.setNotice_thumnail(subDir + "/" + fileName);
		}
		if(mFile2 != null && !mFile2.getOriginalFilename().equals("")) {
			fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
			notice.setNotice_file(subDir + "/" + fileName2);
		}
	
		// 공지사항 수정
		boolean isModifySuccess = service.modifyNotice(notice);
		if(isModifySuccess) { // 글등록 성공
			try {
				if(fileName != null) {
					mFile.transferTo(new File(saveDir, fileName));
				} 
				if(fileName2 != null) {
					mFile2.transferTo(new File(saveDir, fileName2));
				} 
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			return "redirect:NoticeDetail?notice_idx=" + notice.getNotice_idx() + "&pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "공지사항 수정 실패!");
			return "fail_back";
		}
	}
	
	// 공지사항 삭제 NoticeDelete
	@GetMapping ("NoticeDelete")
	public String noticeDelete(@RequestParam int notice_idx,
					@RequestParam(defaultValue = "1") int pageNum,
					HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		// 관리자 계정이 아닐 경우 접근 불가
		if(!sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}		
		
		// 공지사항 삭제
		int deleteCount = service.removeNotice(notice_idx);
		if(deleteCount == 0) {
			model.addAttribute("msg", "공지사항 삭제 실패!");
			return "fail_back"; 
		} else {
			model.addAttribute("msg", "해당 공지사항이 삭제되었습니다");
			model.addAttribute("targetURL", "helpNotice?pageNum="+ pageNum);
			return "success_forward"; 
			
		}
		
	}
	
	// 공지사항 카테고리 선택 이동
	@GetMapping("NoticeCategory")
	public String noticeCategory(
			@RequestParam int notice_category,
			@RequestParam(defaultValue = "") String searchType, 
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int pageNum, Model model) {
		pageNum = 1;
		int listLimit = 5; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		
		// 해당 카테고리의 공지사항만 조회
		List<NoticeVO> noticeList = service.getNoticeCategoryList(notice_category, searchType, searchKeyword, startRow, listLimit);
		
		// 전체 글 목록 갯수 조회
		int listCount = service.getNoticeListCount(searchType, searchKeyword);
		
		// 한 페이지에서 표시할 목록 갯수 설정
		int pageListLimit = 5;
		
		// 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		// 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 끝 페이지 번호 계산 
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이징 처리 정보 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "help/help_notice";
	}
	
	
}
