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
import com.itwillbs.test.vo.MembersVO;
import com.itwillbs.test.vo.ProjectVO;

import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class AdminService {

	@Autowired
	private ProjectMapper projectMapper;
	@Autowired
	private SendPhoneMessageService sendPhoneMessageService;
	@Autowired
	private MemberService memberService;
	
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

	// 48시간안에 프로젝트 요금제 결제를 하지 않았을 때 승인거절 처리하기
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
			// 테스트용
		}, 1, TimeUnit.MINUTES);
	}
	
	// 프로젝트 등록만 하고 72시간 동안 프로젝트 승인요청을 하지 않았을 때
	// 프로젝트 등록을 완료해달라는 문자 메시지 보내기 
	public void sendProjectReminder(int project_idx) {
		executorService.schedule(() -> {
			ProjectVO project = projectMapper.selectProject(project_idx);
			if(project != null && project.getProject_approve_status() == 1) { // 프로젝트 승인 상태 1-미승인일 때
				
				// 문자 메시지를 보내기 위해 project_idx로 멤버 정보 조회
				MembersVO member = memberService.getMemberInfoByProjectIdx(project_idx);
				String memberPhone = member.getMember_phone();
				String message = "[Funddeuck] 프로젝트 완성을 서둘러주세요! 지금 바로 프로젝트를 등록하고 후원을 받아보세요!";
				
				try {
					String isSendMessage = sendPhoneMessageService.SendMessage(memberPhone, message, project_idx);
					if(isSendMessage.equals("true")) {
						logger.info("■■■■■■ 문자 메시지 발송 완료");
					} else {
						logger.info("■■■■■■ 문자 메시지 발송 실패");
					}
				} catch (CoolsmsException e) {
					e.printStackTrace();
				}
			}
//		}, 72, TimeUnit.HOURS);
			// 테스트용
		}, 1, TimeUnit.MINUTES);
	}
	
	// 기존 스케줄러 취소
	public void cancelScheduledTask() {
		executorService.shutdown();
	}
	
}
