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
	public int registNotification(String target, String subject, String content) {
		return mapper.insertNotification(target, subject, content);
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
	// 전체 메시지 조회 - 관리자
	public List<NotificationVO> getTotalList(String searchType, String searchKeyword, int startRow, int listLimit) {
		return mapper.selectTotalList(searchType, searchKeyword, startRow, listLimit);
	}
	// 전체 메시지 갯수 조회 - 관리자
	public int getNotificationListCount(String searchType, String searchKeyword) {
		return mapper.selectNotificationListCount(searchKeyword, searchType);
	}
	// 삭제 처리
	public int removeNotification(int notification_idx) {
		return mapper.deleteNotification(notification_idx);
	}
	// 아이디별 메시지 리스트 조회
	public List<NotificationVO> getTotalListById(String searchType, String searchKeyword, String sId, int startRow, int listLimit) {
		return mapper.selectTotalListById(searchType, searchKeyword, sId, startRow, listLimit);
	}
	// 아이디별 메시지 갯수 조회
	public int getTotalListCountById(String searchType, String searchKeyword, String sId) {
		return mapper.selectTotalListCountById(searchType, searchKeyword, sId);
	}
	// 메시지 정보 조회
	public NotificationVO getNotificationInfo(int notification_idx) {
		return mapper.selectNotificationInfo(notification_idx);
	}
	
}
