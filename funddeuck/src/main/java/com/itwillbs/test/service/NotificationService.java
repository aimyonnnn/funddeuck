package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.NotificationMapper;
import com.itwillbs.test.vo.NotificationVO;

@Service
public class NotificationService {

	@Autowired
	private NotificationMapper mapper;
	
	// 저장
	public int registNotification(String target, String content) {
		return mapper.insertNotification(target, content);
	}
	// 갯수 조회
	public int getNotificationCount(String member_id) {
		return mapper.selectNotificationCount(member_id) ;
	}
	// 리스트 조회
	public List<NotificationVO> getNotificationList(String sId) {
		return mapper.selectNotificationList(sId);
	}
	// 읽음 처리
	public int modifyNotificationStatus(int notification_idx) {
		return mapper.updateNotificationStatus(notification_idx);
	}
	// 전체 읽음 처리
	public int modifyAllNotificationStatus(String member_id) {
		return mapper.updateAllNotificationStatus(member_id);
	}
	// 안읽은 메시지 조회
	public List<NotificationVO> getUnreadNotificationList(String sId) {
		return mapper.selectUnreadNotificationList(sId);
	}
	
}
