package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.NotificationVO;


@Mapper
public interface NotificationMapper {

	// 저장
	int insertNotification(
			@Param("target") String target,
			@Param("subject") String subject,
			@Param("content")String content);
	
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
			@Param("listLimit") int listLimit
			);
	
	// 전체 메시지 갯수 조회 - 관리자
	int selectNotificationListCount(
			@Param("searchKeyword") String searchKeyword,
			@Param("searchType") String searchType);
	
	// 삭제 처리
	int deleteNotification(int notification_idx);
	
	// 아이디별 메시지 리스트 조회
	List<NotificationVO> selectTotalListById(
			@Param("searchType") String searchType,
			@Param("searchKeyword") String searchKeyword,
			@Param("sId") String sId,
			@Param("startRow") int startRow,
			@Param("listLimit") int listLimit
			);
	
	// 아이디별 메시지 갯수 조회
	int selectTotalListCountById(
			@Param("searchKeyword") String searchKeyword,
			@Param("searchType") String searchType,
			@Param("sId") String sId
			);
	
}
