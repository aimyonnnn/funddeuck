package com.itwillbs.test.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProjectMapper;
import com.itwillbs.test.vo.ProjectVO;

@Service
@EnableScheduling
public class AdminService {

	@Autowired
	private ProjectMapper projectMapper;

	// 프로젝트 승인 상태 확인 및 업데이트하는 스케줄러
	@Scheduled(fixedRate = 172800000) // 두 일(48시간) 마다 실행
	public void checkAndUpdateProjectApprovalStatus() {
		// 승인 요청 상태(승인 상태가 '2-승인요청')인 프로젝트 리스트 조회
		List<ProjectVO> approvalRequestedProjects = projectMapper.selectApprovedProjects();

		LocalDateTime now = LocalDateTime.now();

		for (ProjectVO project : approvalRequestedProjects) {
			int projectIdx = project.getProject_idx();
			LocalDateTime requestDateTime = project.getProject_approval_request_time();
			if (requestDateTime != null) {
				// 승인 요청 시간으로부터 48시간이 지났고, 결제가 완료되지 않은 경우 프로젝트 승인 상태를 '4-승인거절'로 업데이트
				if (requestDateTime.plusHours(48).isBefore(now) && isPaymentNotCompleted(project)) {
					projectMapper.updateProjectStatus(projectIdx, 4);
				}
			}
		}
	}
	
	private boolean isPaymentNotCompleted(ProjectVO project) {
		return project.getProject_approve_status() != 5;
	}
}
