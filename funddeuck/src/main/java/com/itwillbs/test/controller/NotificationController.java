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

import com.itwillbs.test.service.NotificationService;
import com.itwillbs.test.vo.NotificationVO;

@Controller
public class NotificationController {
	
	@Autowired
	private NotificationService service;
	
	// 관리자 피드백 저장하기
	@PostMapping("saveNotification")
	@ResponseBody
	public String saveNotify(
			@RequestParam("target") String target,
            @RequestParam("content") String content,
            @RequestParam("type") String type,
            @RequestParam("url") String url) {
		System.out.println(
				"Target: " + target + ", Content: " + content + ", Type: " + type + ", URL: " + url);
	    // 피드백을 받는 회원 아이디가 존재하는지 판별해야함
	    int insertCount = service.registNotification(target, content);
	    System.out.println(insertCount);
	    if(insertCount > 0) {
	    	System.out.println("메세지가 발송되었습니다!");
	    	return "true";
	    }
	    return "false";
	}
	
	// 카운트 조회
	@GetMapping("getNotificationCount")
	@ResponseBody
	public String getNotificationCount(@RequestParam String member_id) {
		System.out.println(member_id);
		int notificationCount = service.getNotificationCount(member_id);
		System.out.println(notificationCount);
		if(notificationCount > 0) return notificationCount+"";
		return "false";
	}
	
	// 관리자 피드백 리스트 조회
	@GetMapping("confirmNotification")
	public String confirmNotification(HttpSession session, Model model) {
		String sId = (String) session.getAttribute("sId");
		// 세션아이디로 읽지않은 알림 조회하기
		List<NotificationVO> nList = service.getNotificationList(sId);
		model.addAttribute("nList", nList);
		return "notification/notification_list";
	}
	
	// 리워드 설계 페이지 관리자 피드백 출력하기
	@GetMapping("getNotificationByAjax")
	@ResponseBody
	public ResponseEntity<List<NotificationVO>> getNotificationByAjax(HttpSession session) {
		System.out.println("getNotificationByAjax");
	    String sId = (String) session.getAttribute("sId");
	    List<NotificationVO> nList = service.getNotificationList(sId);
	    return ResponseEntity.ok(nList);
	}
	
	// 관리자 피드백 읽음 처리
	@GetMapping("markNotificationAsRead")
	@ResponseBody
	public String markNotificationAsRead(@RequestParam int notification_idx) {
		System.out.println("알림번호 : " + notification_idx);
		int updateCount = service.modifyNotificationStatus(notification_idx);
		if(updateCount >0 ) return "true";
		return "false";
	}
		
	
}
