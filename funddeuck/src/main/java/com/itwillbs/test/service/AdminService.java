package com.itwillbs.test.service;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ProjectMapper;
import com.itwillbs.test.vo.ProjectVO;

@Service
public class AdminService {

	@Autowired
	private ProjectMapper projectMapper;
	
	private ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();

	// 프로젝트 승인 상태를 48시간 후에 체크하여 업데이트
	public void scheduleCheckApproval(int project_idx) {
		executorService.schedule(() -> {
			ProjectVO project = projectMapper.selectProject(project_idx);
			if (project != null && project.getProject_approve_status() != 5) {
				projectMapper.updateProjectStatus(project_idx, 4); // 프로젝트 상태를 4-승인거절로 변경
			}
		}, 48, TimeUnit.HOURS);
	}
	
	// 기존 스케줄러 취소
	public void cancelScheduledTask() {
		executorService.shutdown();
	}
}
