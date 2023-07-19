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
	
	// 알림 개수 조회
	public int getNotificationCount(String member_id) {
		return mapper.selectNotificationCount(member_id) ;
	}
	// 알림 저장
	public int registNotification(String target, String content) {
		return mapper.insertNotification(target, content);
	}
	// 읽지 않은 알림 조회
	public List<NotificationVO> getNotificationList(String sId) {
		return mapper.selectNotificationList(sId);
	}
	// 알림 확인 시 notification_read_status를 2-읽음으로 변경
	public int modifyNotificationStatus(int notification_idx) {
		return mapper.updateNotificationStatus(notification_idx);
	}
	
}
