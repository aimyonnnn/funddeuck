package com.itwillbs.test.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.service.NotificationService;
import com.itwillbs.test.service.ProjectService;
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.NotificationVO;
import com.itwillbs.test.vo.PageInfoVO;
import com.itwillbs.test.vo.ProjectVO;

@Controller
public class NotificationController {
	
	@Autowired
	private NotificationService service;
	@Autowired
	private MemberService memberService;
	@Autowired
	private ProjectService projectService;
	
	// 관리자 피드백 저장하기
	@PostMapping("saveNotification")
	@ResponseBody
	public String saveNotify(
			@RequestParam("target") String target,
			@RequestParam("subject") String subject,
            @RequestParam("content") String content,
            @RequestParam("type") String type,
            @RequestParam("url") String url) {
		
		System.out.println("출력 테스트 : " + subject);
		
	    // 메시지를 받는 회원 아이디가 존재하는지 판별해야함
		// 파라미터 - 회원 아이디(target)
		MembersVO member = memberService.isCorrectMember(target);
		if(member != null) {
			int insertCount = service.registNotification(target, subject, content);
			if(insertCount > 0) { return "true"; } return "false";
		} 
		return "false";
	}
	
	// 갯수 조회
	@GetMapping("getNotificationCount")
	@ResponseBody
	public String getNotificationCount(@RequestParam String member_id) {
		System.out.println(member_id);
		int notificationCount = service.getNotificationCount(member_id);
		if(notificationCount > 0) { return notificationCount+""; } return "false";
	}
	
	// 리스트 조회
	@GetMapping("confirmNotification")
	public String confirmNotification(
			@RequestParam(name = "project_idx", required = false) Integer project_idx,
			@RequestParam(defaultValue = "") String searchType, 
			@RequestParam(defaultValue = "") String searchKeyword, 
			@RequestParam(defaultValue = "1") int pageNum, 
			HttpSession session, Model model) {
		String sId = (String) session.getAttribute("sId");
		System.out.println("검색타입 : " + searchType);
		System.out.println("검색어 : " + searchKeyword);
		// -------------------------------------------------------------------------
		// 프로젝트 상태컬럼이 3-승인인 경우에만 결제 모달창 자동 실행
		System.out.println("프로젝트 번호 출력 테스트 : " + project_idx);
	    if (project_idx != null && project_idx > 0) {
	        ProjectVO project = projectService.getProjectInfo(project_idx);
	        if (project != null && project.getProject_approve_status() == 3) {
	        	// 세션 아이디로 member 조회하기(결제 시 구매자 전화번호 필요함)
	        	MembersVO member = memberService.getMemberInfo(sId);
	        	model.addAttribute("member", member);
	            // 프로젝트 상태가 3-승인인 경우, 결제하기 모달창을 자동으로 실행하도록 설정
	            model.addAttribute("orderModal", true);
	            model.addAttribute("project", project);
	        }
	    }
		// -------------------------------------------------------------------------
		// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
		int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
		// -------------------------------------------------------------------------
		// notificationService - getTotalList() 메서드 호출하여 게시물 목록 조회 요청
		List<NotificationVO> nList = service.getTotalListById(searchType, searchKeyword, sId, startRow, listLimit);
		// -------------------------------------------------------------------------
		// 한 페이지에서 표시할 페이지 목록(번호) 계산
		// 1. notificationService - getNotificationListCount() 메서드를 호출하여
		int listCount = service.getTotalListCountById(searchType, searchKeyword, sId);
		System.out.println("getTotalListCountById 갯수 : " + listCount);
		// 2. 한 페이지에서 표시할 목록 갯수 설정(페이지 번호의 갯수)
		int pageListLimit = 10;
		// 3. 전체 페이지 목록 갯수 계산
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		// 4. 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		// 5. 끝 페이지 번호 계산
		int endPage = startPage + pageListLimit - 1;
		// 6. 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다
	//	    클 경우 끝 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		// 페이징 처리 정보를 저장할 PageInfoVO 객체에 계산된 데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("nList", nList);
		model.addAttribute("pageInfo", pageInfo);
		return "notification/notification_list";
	}
	
	// 리워드 설계 페이지 관리자 피드백 출력하기
	// 안읽은 메시지만 출력함
	// 클릭 시 읽음 처리 됨
	@GetMapping("getNotificationByAjax")
	@ResponseBody
	public ResponseEntity<List<NotificationVO>> getNotificationByAjax(HttpSession session) {
		System.out.println("getNotificationByAjax");
	    String sId = (String) session.getAttribute("sId");
	    List<NotificationVO> nList = service.getUnreadNotificationList(sId);
	    return ResponseEntity.ok(nList);
	}
	
	// 읽음 처리
	@GetMapping("markNotificationAsRead")
	@ResponseBody
	public String markNotificationAsRead(@RequestParam int notification_idx) {
//		System.out.println("markNotificationAsRead : " + notification_idx);
		int updateCount = service.modifyNotificationStatus(notification_idx);
		if(updateCount > 0) { return "true"; } return "false";
	}
	
	// 전체 읽음 처리
	@GetMapping("markAllAsRead")
	@ResponseBody
	public ResponseEntity<String> markAllAsRead(@RequestParam String member_id) {
//		System.out.println("markAllAsRead : " + member_id);
		int updateCount = service.modifyAllNotificationStatus(member_id);
		if(updateCount > 0) { return ResponseEntity.ok("true"); } return ResponseEntity.ok("false");
	}
	
	// 삭제 처리
	@GetMapping("deleteNotification")
	@ResponseBody
	public String deleteNotification(@RequestParam int notification_idx) {
		System.out.println("deleteNotification");
		int deleteCount = service.removeNotification(notification_idx);
		if(deleteCount > 0) { return "true"; } return "false";
	}
	
	
}



