package com.itwillbs.test.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.test.service.MakerService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.MakerBoardVO;
import com.itwillbs.test.vo.MakerVO;
import com.itwillbs.test.vo.ProjectVO;

@Controller
public class MakerController {
	
	@Autowired
	private MakerService makerService;
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService memberService;
	
	// 메이커 등록 페이지
	@GetMapping("projectMaker")
	public String makerInfo(HttpSession session, Model model) {
	    String sId = (String) session.getAttribute("sId");
	    if (sId == null) {
	        model.addAttribute("msg", "잘못된 접근입니다.");
	        return "fail_back";
	    }

	    int member_idx = projectService.getMemberIdx(sId);
	    Integer maker_idx = makerService.getMakerIdx(sId);
	    
	    if (maker_idx != null && maker_idx > 0) {
	        String targetURL = "projectManagement?maker_idx=" + makerService.getMakerIdx(memberService.getMemberId(member_idx));
	        model.addAttribute("msg", "메이커는 계정 당 1개만 만들 수 있습니다. \\n프로젝트 등록 페이지로 이동합니다.");
	        model.addAttribute("targetURL", targetURL);
	        return "success_forward";
	    } else {
	    	model.addAttribute("member_idx", member_idx);
	    	return "project/project_maker";
	    }

	}
	
	// 메이커 등록 비즈니스 로직 처리
	@PostMapping("projectMakerPro")
	public String projectMaker(MakerVO maker, Model model, HttpSession session, HttpServletRequest request) {
		
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
		
		MultipartFile mFile1 = maker.getFile1();
		MultipartFile mFile2 = maker.getFile2();
		MultipartFile mFile3 = maker.getFile3();
		MultipartFile mFile4 = maker.getFile4();
		MultipartFile mFile5 = maker.getFile5();
		
		String uuid = UUID.randomUUID().toString();
		
		maker.setMaker_file1("");
		maker.setMaker_file2("");
		maker.setMaker_file3("");
		maker.setMaker_file4("");
		maker.setMaker_file5("");
		
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		String fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		String fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
		String fileName4 = uuid.substring(0, 8) + "_" + mFile4.getOriginalFilename();
		String fileName5 = uuid.substring(0, 8) + "_" + mFile5.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			maker.setMaker_file1(subDir + "/" + fileName1);
		}
		if(!mFile2.getOriginalFilename().equals("")) {
			maker.setMaker_file2(subDir + "/" + fileName2);
		}
		if(!mFile3.getOriginalFilename().equals("")) {
			maker.setMaker_file3(subDir + "/" + fileName3);
		}
		if(!mFile4.getOriginalFilename().equals("")) {
			maker.setMaker_file4(subDir + "/" + fileName4);
		}
		if(!mFile5.getOriginalFilename().equals("")) {
			maker.setMaker_file5(subDir + "/" + fileName5);
		}
		
		System.out.println("실제 업로드 파일명1 : " + maker.getMaker_file1());
		System.out.println("실제 업로드 파일명2 : " + maker.getMaker_file2());
		System.out.println("실제 업로드 파일명3 : " + maker.getMaker_file3());
		System.out.println("실제 업로드 파일명4 : " + maker.getMaker_file4());
		System.out.println("실제 업로드 파일명5 : " + maker.getMaker_file5());
		
		// -----------------------------------------------------------------------------------
		int insertCount = projectService.registMaker(maker);
		
		if(insertCount > 0) { // 성공
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
				
				if(!mFile3.getOriginalFilename().equals("")) {
					mFile3.transferTo(new File(saveDir, fileName3));
				}
				
				if(!mFile4.getOriginalFilename().equals("")) {
					mFile4.transferTo(new File(saveDir, fileName4));
				}
				
				if(!mFile5.getOriginalFilename().equals("")) {
					mFile5.transferTo(new File(saveDir, fileName5));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			// 메이커 등록 성공 시 프로젝트 등록 페이지로 이동
			String targetURL = "projectManagement?maker_idx=" + maker.getMaker_idx();
			System.out.println("메이커 등록 성공 시 메이커 번호 조회 : " + maker.getMaker_idx());
			model.addAttribute("msg", "메이커 등록에 성공하였습니다. 프로젝트 등록 페이지로 이동합니다.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else { // 실패
			model.addAttribute("msg", "메이커 등록 실패!");
			return "fail_back";
		}
	}
	
	// 메이커 페이지
	@GetMapping("makerDetail")
	public String makerDetail(@RequestParam(required = false) Integer maker_idx, HttpSession session, Model model) {
	    String sId = (String) session.getAttribute("sId");
	    MakerVO maker = null;

	    if (maker_idx != null) {
	        maker = makerService.getMakerInfo(maker_idx);

	        if (maker == null) {
	            model.addAttribute("msg", "메이커 정보를 찾을 수 없습니다.");
	            return "fail_back";
	        }

	        // 프로젝트 리스트 조회
	        List<ProjectVO> pList = projectService.getAllProjectByMakerIdx(maker_idx);
	        model.addAttribute("pList", pList);
	        // 메이커 공지사항 리스트 조회
	        List<MakerBoardVO> mList = projectService.getMakerBoardList(maker_idx);
	        model.addAttribute("mList", mList);
	    }

	    if (sId != null) {
	        int member_idx = projectService.getMemberIdx(sId);
	        Integer loggedInMakerIdx = makerService.getMakerIdx(sId); // Integer로 변경

	        // 본인의 메이커인지 여부를 체크
	        boolean isMyMaker = loggedInMakerIdx != null && maker_idx != null && loggedInMakerIdx.equals(maker_idx);

	        if (isMyMaker && maker == null) {
	            // 로그인한 사용자의 메이커 정보를 가져옵니다. 이미 가져왔다면 다시 가져오지 않습니다.
	            maker = makerService.getMakerInfo(loggedInMakerIdx);

	            if (maker == null) {
	                model.addAttribute("msg", "메이커 정보를 찾을 수 없습니다.");
	                return "fail_back";
	            }

	            // 로그인한 사용자의 프로젝트 리스트 조회
	            List<ProjectVO> pList = projectService.getAllProjectByMakerIdx(loggedInMakerIdx);
	            model.addAttribute("pList", pList);
	            // 로그인한 사용자의 메이커 공지사항 리스트 조회
	            List<MakerBoardVO> mList = projectService.getMakerBoardList(loggedInMakerIdx);
	            model.addAttribute("mList", mList);
	        }

	        model.addAttribute("member_idx", member_idx);
	        model.addAttribute("isMyMaker", isMyMaker); // 본인의 메이커인지 여부를 모델에 추가
	    }

	    // maker 정보가 있다면 모델에 추가합니다.
	    if (maker != null) {
	        model.addAttribute("maker", maker);
	    }

	    return "project/maker_detail";
	}

	// 메이커 정보 변경
	@PostMapping("modifyMakerForm")
	public String modifyMakerForm(@RequestParam int maker_idx, HttpSession session, Model model) {
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		int memberIdx = projectService.getMemberIdx(sId);
		MakerVO maker = makerService.getMakerInfo(maker_idx);
		List<MakerBoardVO> mList = projectService.getMakerBoardList(maker_idx);
		
		if(maker == null || memberIdx != maker.getMember_idx()) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		model.addAttribute("maker", maker);
		model.addAttribute("mList", mList);
		model.addAttribute("maker_idx", maker_idx);
		
		return "project/maker_detail_modifyForm";
	}
	
	// 메이커 페이지 수정하기 비즈니스 로직 처리
	@PostMapping("modifyMaker")
	public String modifyMaker(MakerVO maker, HttpSession session, Model model) {
		System.out.println("modifyMaker");
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
		
		MultipartFile mFile1 = maker.getFile4();
		MultipartFile mFile2 = maker.getFile5();
		
		String uuid = UUID.randomUUID().toString();
		maker.setMaker_file4("");
		maker.setMaker_file5("");
		
		String fileName1 = null;
		String fileName2 = null;

		if (mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
		    fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		    maker.setMaker_file4(subDir + "/" + fileName1);
		}

		if (mFile2 != null && !mFile2.getOriginalFilename().equals("")) {
		    fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
		    maker.setMaker_file5(subDir + "/" + fileName2);
		}

		System.out.println("실제 업로드 파일명1 : " + maker.getMaker_file4());
		System.out.println("실제 업로드 파일명2 : " + maker.getMaker_file5());
		// -----------------------------------------------------------------------------------
		int updateCount = makerService.modifyMaker(maker);
		
		if(updateCount > 0) {
			// 파일 업로드 처리
			try {
			    if (fileName1 != null) {
			        mFile1.transferTo(new File(saveDir, fileName1));
			    }
			    if (fileName2 != null) {
			        mFile2.transferTo(new File(saveDir, fileName2));
			    }
			} catch (IllegalStateException e) {
			    e.printStackTrace();
			} catch (IOException e) {
			    e.printStackTrace();
			}
			
			// 메이커 수정 성공 시 makerDetail로 이동
			String targetURL = "makerDetail?maker_idx=" + maker.getMaker_idx();
			System.out.println("메이커 idx : " + maker.getMaker_idx());
			model.addAttribute("msg", "메이커 정보 수정이 완료되었습니다.");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else {
			model.addAttribute("msg", "글 수정 실패!");
			return "fail_back";
		}
	}

	// 메이커 수정하기 - 첨부파일 실시간 삭제
	@PostMapping("deleteFile")
	@ResponseBody
	public String deleteFile(int maker_idx,	String fileName, int fileNumber, HttpSession session) {
		System.out.println("deleteFile() - fileName : " + fileName);
		// 파일 삭제 요청
	    int deleteCount = makerService.removeMakerFile(maker_idx, fileName, fileNumber);
	    if (deleteCount != 0) {
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
	
	// MakerDeatil - 공지사항 작성하기
	@PostMapping("makerBoardWritePro")
	public String makerBoardWritePro(MakerBoardVO makerBoard, Model model, HttpSession session, HttpServletRequest request) {
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
		
		MultipartFile mFile1 = makerBoard.getFile1();
		String uuid = UUID.randomUUID().toString();
		makerBoard.setMaker_board_file1("");
		String fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
		
		if(!mFile1.getOriginalFilename().equals("")) {
			makerBoard.setMaker_board_file1(subDir + "/" + fileName1);
		}
		System.out.println("실제 업로드 파일명1 : " + makerBoard.getMaker_board_file1());
		// -----------------------------------------------------------------------------------
		int insertCount = projectService.registMakerBoard(makerBoard);
		if(insertCount > 0) { // 성공
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			String targetURL = "makerDetail?maker_idx=" + makerBoard.getMaker_idx();
			model.addAttribute("msg", "공지사항 작성이 성공적으로 완료되었습니다!");
			model.addAttribute("targetURL", targetURL);
			return "success_forward";
		} else { // 실패
			model.addAttribute("msg", "공지사항 작성이 실패하였습니다.");
			return "fail_back";
		}
	}
	
	// MakerDeatil - 공지사항 삭제하기
	@PostMapping("deleteMakerBoard")
	@ResponseBody
	public String deleteMakerBoard(@RequestParam int maker_board_idx) {
		int deleteCount = makerService.removeMakerBoard(maker_board_idx);
		if(deleteCount > 0) return "true";
		return "false";
	}
	
	// MakerDeatil - 공지사항 조회하기
	@PostMapping("getMakerBoardInfo")
	@ResponseBody
	public MakerBoardVO getMakerBoardInfo(@RequestParam int maker_board_idx) {
		MakerBoardVO makerBoard = makerService.getMakerBoardInfo(maker_board_idx);
		return makerBoard;
	}

	
}
