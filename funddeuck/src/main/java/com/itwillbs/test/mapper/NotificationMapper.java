package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.NotificationVO;


@Mapper
public interface NotificationMapper {

	// 저장
	int insertNotification(@Param("target") String target, @Param("content") String content);
	
	// 갯수 조회
	int selectNotificationCount(String member_id);
	
	// 리스트 조회
	List<NotificationVO> selectNotificationList(String sId);
	
	// 읽음 처리
	int updateNotificationStatus(int notification_idx);
	
	// 전체 읽음 처리
	int updateAllNotificationStatus(String member_id);
	
	// 안읽은 메시지 조회
	List<NotificationVO> selectUnreadNotificationList(String sId);
	
	// 전체 메시지 조회 - 관리자
	List<NotificationVO> selectTotalList(
			@Param("searchType") String searchType,
			@Param("searchKeyword") String searchKeyword,
			@Param("startRow") int startRow,
			@Param("listLimit") int listLimit);
	
	// 전체 메시지 갯수 조회 - 관리자
	int selectNotificationListCount(String searchKeyword, String searchType);
	
	// 삭제 처리
	int deleteNotification(int notification_idx);
	
}
