package com.itwillbs.test.service;

import java.io.IOException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.controller.BankController;
import com.itwillbs.test.handler.EchoHandler;
import com.itwillbs.test.mapper.ProjectMapper;
import com.itwillbs.test.vo.ProjectVO;

@Service
public class AdminService {

	@Autowired
	private ProjectMapper projectMapper;
	
	private EchoHandler echoHandler;
	@Autowired
	public AdminService(EchoHandler echoHandler) {
		this.echoHandler = echoHandler;
	}
	@Autowired
	private NotificationService notificationService;
	
	// 로거 출력을 위한 변수 선언
	private static final Logger logger = LoggerFactory.getLogger(BankController.class);
	// 스케줄러
	private ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();

	// 프로젝트 승인 상태를 48시간 후에 체크하여 업데이트
	public void scheduleCheckApproval(int project_idx, String memberId) {
		executorService.schedule(() -> {
			ProjectVO project = projectMapper.selectProject(project_idx);
			if (project != null && project.getProject_approve_status() != 5) {
				projectMapper.updateProjectStatus(project_idx, 4); // 프로젝트 상태를 4-승인거절로 변경
				
				// 메이커에게 승인이 거절 되었다는 toast 알림 보내기
				String url = "confirmNotification";
				String target = memberId;
				String notification = 
						"<a href='" + url + "' style='text-decoration: none; color: black;'>[프로젝트 거절 알림] 프로젝트 승인이 거절되었습니다. 프로젝트 승인신청을 다시 해주세요.</a>";
				try {
					echoHandler.sendNotificationToUser(target, notification);
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				int insertCount = notificationService.registNotification(target, notification);
				if(insertCount > 0) {
					logger.info("■■■■■ 프로젝트 거절 메시지 발송 성공");
				}
			}
//		}, 48, TimeUnit.HOURS);
		}, 1, TimeUnit.MINUTES);
	}
	
	// 기존 스케줄러 취소
	public void cancelScheduledTask() {
		executorService.shutdown();
	}
	
	
}
