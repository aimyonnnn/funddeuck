package com.itwillbs.test.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.test.vo.*;

@Mapper
public interface FundingMapper {
	
	// 배송지 등록
	int insertDelivery(DeliveryVO delivery);
	
	// 배송지 목록 조회
	List<DeliveryVO> selectDeliveryList(String id);
	
	// 기본 배송지 조회
	DeliveryVO selectDeliveryDefault(String id);
	
	// 변경한 배송지 조회
	DeliveryVO selectDelivery(@Param(value = "id") String id,@Param(value = "delivery_idx") int changeDelivery_idx);
	
	// 기존의 기본 배송지 설정 변경
	void updateDeliveryDefault();
	
	// 멤버가 한 펀딩 리스트 가져오기
	List<Map<String, Object>> selectMemberFunDing(@Param("sId") String sId, @Param("payment_confirm") int payment_confirm , @Param("startRow") int startRow, @Param("listLimit") int listLimit);
	
	//모달창에 띄울 내용 가져오기
	Map<String, Object> selectModalFunding(int payment_idx);
	
	// 멤버가 한 펀딩의 카운트(페이징 처리)
	int selectMemberFunDingCoung(@Param("sId") String sId, @Param("payment_confirm") int payment_confirm);
	
	// 펀딩 취소 신청
	int requestMemberCancellcation(@Param("payment_idx") int cancel_idx,@Param("context") String context,@Param("saveFileName") String saveFileName);
	
	// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 정보
	ProjectVO selectProjectInfo(@Param("project_idx") int project_idx);

	// 프로젝트 상세 페이지 이동 시 조회할 리워드 정보
	List<RewardVO> selectProjectRewardInfo(int project_idx);
	
	// 프로젝트 리스트 조회(탐색 페이지)
	List<ProjectVO> selectFundingList(@Param("category") String category,@Param("status") String status,@Param("index") String index);
	
	// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 게시판 정보
	List<MakerBoardVO> selectMakerBoardInfo(int project_idx);

	// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 커뮤니티 게시물 정보
	List<ProjectCommunityVO> selectProjectCommunityInfo(int project_idx);
	
	// 프로젝트 상세 페이지에서 의견 남기기
	int insertComment(ProjectCommunityVO projectCommunity);

	// 오픈 예정 프로젝트 리스트 조회(탐색 페이지)
	List<ProjectVO> selectExpectedFundingList(String category);

	// 프로젝트 상세 페이지 이동 시 조회할 총 후원자수 정보
	int selectSupTotal(int project_idx);
	
	// 검색어로 프로젝트 리스트 조회
	List<ProjectVO> selectFundingSearchKeyword(@Param("status") String status, @Param("index") String index, @Param("searchKeyword") String searchKeyword);

	// 프로젝트 메이커 로고
	MakerVO selectMakerLogo(int maker_idx);

	// 자동으로 택배조회후 상태 변경
	int AutoUpdateDeliveryStatus(@Param("delivery_status") int delivery_status,@Param("payment_idx") int payment_idx);
	
	// 결제 후 결제서 등록
	boolean insertPayment(PaymentVO payment);
	
	// 주문서번호 payment_idx 조회
	int selectPaymentIdx(PaymentVO payment);
	
	// 프로젝트 상태 조회 
	int selectProjectStatus(int payment_idx);
	
	// 주문서 조회 
	PaymentVO selectPaymentInfo(int payment_idx);
	
	// 아이디 조회
	String selectMemberId(int member_idx);
	
	// 출금이체 후 결제승인여부 결제완료(2)로 변경
	void updatePaymentConfirmCompleted(int payment_idx);
	
//	// 리워드 수량 변경
//	void updateRewardAmount(@Param("project_idx") int project_idx, @Param("reward_idx") int reward_idx, @Param("payment_quantity") int payment_quantity);
	
	// 프로젝트의 누적금액 변경 
	void updateProjectCumulativeAmount(@Param("project_idx") int project_idx,@Param("project_cumulative_amount") int project_cumulative_amount);
	
	// 찜 여부 체크
	int isZimProject(@Param("sId") String sId, @Param("project_idx") int project_idx);

	// 프로젝트 상세페이지에서 남긴 의견 삭제
	int pcCommentDeleteReq(@Param("project_idx") int project_idx, @Param("project_community_idx") int project_community_idx, @Param("member_id") String member_id);
	
	// 팔로우 여부 체크
	int isFollowProject(@Param("sId") String sId, @Param("project_idx") int project_idx);
}
