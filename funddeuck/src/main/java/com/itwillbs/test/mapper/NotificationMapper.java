package com.itwillbs.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.NotificationVO;


@Mapper
public interface NotificationMapper {

	// 알림 갯수 조회
	int selectNotificationCount(String member_id);
	// 알림 저장
	int insertNotification(@Param("target") String target, @Param("content") String content);
	// 읽지않은 알림 조회
	List<NotificationVO> selectNotificationList(String sId);
	// 알림 확인 시 notification_read_status를 2-읽음으로 변경
	int updateNotificationStatus(int notification_idx);
	
}
