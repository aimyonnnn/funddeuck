package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProjectMapper;
import com.itwillbs.test.vo.ProjectVO;

@Service
public class AdminService {

	@Autowired
	private ProjectMapper projectMapper;

	// 프로젝트 승인 상태 확인 및 업데이트하는 스케줄러
	@Scheduled(cron = "0 0 0 * * *") // 매일 자정에 실행
	public void checkAndUpdateProjectApprovalStatus() {
		// 승인 상태가 '3-승인완료'인 프로젝트 리스트 조회
		List<ProjectVO> approvedProjects = projectMapper.selectApprovedProjects();

		for (ProjectVO project : approvedProjects) {
			int projectIdx = project.getProject_idx();
			// 결제가 완료되지 않은 경우 프로젝트 승인 상태를 '4-승인거절'로 업데이트
			if (isPaymentNotCompleted(project)) {
				projectMapper.updateProjectStatus(projectIdx, 4);
			}
		}
	}
	
	private boolean isPaymentNotCompleted(ProjectVO project) {
		return project.getProject_approve_status() != 5;
	}
}
