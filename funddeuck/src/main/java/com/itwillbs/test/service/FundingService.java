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
	
	// 멤버가 한 펀딩 리스트
	public List<Map<String, Object>> getMemberFunDing(String sId, int payment_confirm, int startRow, int listLimit) {
		return mapper.selectMemberFunDing(sId, payment_confirm ,startRow, listLimit);
	}
	
	// 멤버가 한 펀딩의 모달에 띄울 내용
	public Map<String, Object> getMemberModalFunding(int payment_idx) {
		return mapper.selectModalFunding(payment_idx);
	}
	
	// 페이징 처리를 위한 펀딩 갯수
	public int getMemberFunDingCount(String sId, int payment_confirm) {
		return mapper.selectMemberFunDingCoung(sId, payment_confirm);
	}
	
	// 펀딩 취소 신청
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
	
	// 검색어로 프로젝트 리스트 조회
	public List<ProjectVO> getFundingSearchKeyword(String status, String index, String searchKeyword) {
		return mapper.selectFundingSearchKeyword(status, index, searchKeyword);
	}

	// 프로젝트 메이커 로고
	public MakerVO getMakerLogo(int maker_idx) {
		return mapper.selectMakerLogo(maker_idx);
	}
	
	// 결제 후 결제서 등록
	public boolean registPayment(PaymentVO payment) {
		return mapper.insertPayment(payment);
	}
	
	// 자동으로 택배조회후 상태 변경
	public int AutoUpdateDeliveryStatus(int delivery_status, int payment_idx) {
		return mapper.AutoUpdateDeliveryStatus(delivery_status, payment_idx);
	}
	
	// 주문서번호 payment_idx 조회
	public int getPaymentIdx(PaymentVO payment) {
		return mapper.selectPaymentIdx(payment);
	}
	
	// 프로젝트 상태 조회
	public int getProjectStatus(int payment_idx) {
		return mapper.selectProjectStatus(payment_idx);
	}
	
	// 주문서 조회
	public PaymentVO getPaymentInfo(int payment_idx) {
		return mapper.selectPaymentInfo(payment_idx);
	}
	
	// 아이디 조회
	public String getMemberId(int member_idx) {
		return mapper.selectMemberId(member_idx);
	}
	
	// 출금이체 후 결제승인여부 결제완료(2)로 변경
	public void ModifyPaymentConfirmCompleted(int payment_idx) {
		mapper.updatePaymentConfirmCompleted(payment_idx);
		
	}
	
	// 리워드 수량 변경
//	public void modifyRewardAmount(int project_idx, int reward_idx, int payment_quantity) {
//		mapper.updateRewardAmount(project_idx, reward_idx, payment_quantity);
//		
//	}
	
	// 프로젝트의 누적금액 변경 
	public void modifyProjectCumulativeAmount(int project_idx, int project_cumulative_amount) {
		mapper.updateProjectCumulativeAmount(project_idx, project_cumulative_amount);
	}
	
	// 찜 여부 체크
	public int isZimProject(String sId, int project_idx) {
		return mapper.isZimProject(sId, project_idx);
	}

	// 프로젝트 상세페이지에서 남긴 의견 삭제
	public int pcCommentDeleteReq(int project_idx, int project_community_idx, String member_id) {
		return mapper.pcCommentDeleteReq(project_idx, project_community_idx, member_id);
	}
	
	//팔로우 여부 체크
	public int isFollowProject(String sId, int project_idx) {
		return mapper.isFollowProject(sId, project_idx);
	}
	

}
