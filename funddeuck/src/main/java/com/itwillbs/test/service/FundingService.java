package com.itwillbs.test.service;

import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.test.mapper.*;
import com.itwillbs.test.vo.*;

@Service
public class FundingService {
	@Autowired 
	private FundingMapper mapper;
	
	// 배송지 등록
	public int registDelivery(DeliveryVO delivery) {
		return mapper.insertDelivery(delivery);
	}
	
	// 배송지 목록 조회
	public List<DeliveryVO> getDeliveryList(String id) {
		return mapper.selectDeliveryList(id);
	}
	
	// 기본 배송지 조회
	public DeliveryVO getDeliveryDefault(String id) {
		return mapper.selectDeliveryDefault(id);
	}
	
	// 선택한 배송지 조회
	public DeliveryVO getDeliveryInfo(String id, int changeDelivery_idx) {
		return mapper.selectDelivery(id, changeDelivery_idx);
	}
	
	
	// 기존의 기본 배송지 설정 변경
	public void modifyDeliveryDefault() {
		mapper.updateDeliveryDefault();
		
	}
	
	//멤버가 한 펀딩 리스트
	public List<Map<String, Object>> getMemberFunDing(String sId, int payment_confirm, int startRow, int listLimit) {
		return mapper.selectMemberFunDing(sId, payment_confirm ,startRow, listLimit);
	}
	
	//멤버가 한 펀딩의 모달에 띄울 내용
	public Map<String, Object> getMemberModalFunding(int payment_idx) {
		return mapper.selectModalFunding(payment_idx);
	}
	
	//페이징 처리를 위한 펀딩 갯수
	public int getMemberFunDingCount(String sId, int payment_confirm) {
		return mapper.selectMemberFunDingCoung(sId, payment_confirm);
	}
	
	//펀딩 취소 신청
	public int requestMemberCancellation(int cancel_idx, String context, String saveFileName) {
		return mapper.requestMemberCancellcation(cancel_idx, context, saveFileName);
	}
	
	// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 정보
	public ProjectVO selectProjectInfo(int project_idx) {
		return mapper.selectProjectInfo(project_idx);
	}

	// 프로젝트 상세 페이지 이동 시 조회할 리워드 정보
	public List<RewardVO> selectProjectRewardInfo(int project_idx) {
		return mapper.selectProjectRewardInfo(project_idx);
	}
	
	// 프로젝트 리스트 조회(탐색 페이지)
	public List<ProjectVO> getFundingList(@Param("category") String category,@Param("status") String status,@Param("index") String index) {
		return mapper.selectFundingList(category, status, index);
	}
	
	// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 게시판 정보
	public List<MakerBoardVO> getMakerBoardInfo(int project_idx) {
		return mapper.selectMakerBoardInfo(project_idx);
	}

	// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 커뮤니티 게시물 정보
	public List<ProjectCommunityVO> getProjectCommunityInfo(int project_idx) {
		return mapper.selectProjectCommunityInfo(project_idx);
	}
	
	// 프로젝트 상세 페이지에서 의견 남기기
	public int registComment(ProjectCommunityVO projectCommunity) {
		return mapper.insertComment(projectCommunity);
	}

	// 오픈 예정 프로젝트 리스트 조회(탐색 페이지)
	public List<ProjectVO> getExpectedFundingList(String category) {
		return mapper.selectExpectedFundingList(category);
	}

	// 프로젝트 상세 페이지 이동 시 조회할 총 후원자수 정보
	public int getSupTotal(int project_idx) {
		return mapper.selectSupTotal(project_idx);
	}
}
