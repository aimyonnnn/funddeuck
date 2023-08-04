package com.itwillbs.test.controller;

import java.util.*;

import javax.servlet.http.*;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.test.service.*;
import com.itwillbs.test.vo.*;

@Controller
public class FundingController {
	
	@Autowired
	private ProjectService projectService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private FundingService fundingService;
	@Autowired
	private PaymentService paymentService;
	@Autowired
	private DeliveryService deliveryService;
	@Autowired
	private CouponService couponService;
	
	// 펀딩 탐색 페이지
	@GetMapping("fundingDiscover")
	public String fundingDiscover(Model model) {
		
		List<ProjectVO> project = projectService.getAllProjects();
		model.addAttribute("project", project);
		
		// 프로젝트 현재 펀딩 금액 조회
		
		return "funding/funding_discover";
	}
	
	// 펀딩 상세페이지 이동
	@GetMapping ("fundingDetail")
	public String fundingDetail(Model model
			, @RequestParam int project_idx 
			) {
		
		// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 정보
		ProjectVO project = fundingService.selectProjectInfo(project_idx);
		model.addAttribute("project",project);
		
		// 프로젝트 상세 페이지 이동 시 조회할 리워드 정보
//		List<RewardVO> reward = fundingService.selectProjectRewardInfo(project_idx);
//		model.addAttribute(reward);
		
		return "funding/funding_detail";
	}
	
	// 펀딩 탐색 페이지 리스트
	@GetMapping("fundingDiscoverList")
	public String fundingDiscoverList() {
		return "";
	}
	
	// 펀딩 주문페이지 이동
	@GetMapping ("fundingOrder")
		// 파라미터 전달, 주석 풀 부분
//		public String fundingOrder(@RequestParam int project_idx, @RequestParam int reward_idx, HttpSession session, Model model) {
		public String fundingOrder(HttpSession session, Model model) {
		
		String sId = (String)session.getAttribute("sId");
		// 미로그인 또는 주문하던 회원이 아닐경우 ****
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	//------------------------------ 프로젝트, 리워드 가데이터
    	int project_idx = 1;
    	int reward_idx = 1;
    	//------------------------------ 프로젝트, 리워드 가데이터
    	
    	
		// 회원 정보 불러오기
		MembersVO member = memberService.getMemberInfo(sId);
		System.out.println("회원 정보 : " + member);
		// 프로젝트 정보 불러오기
		ProjectVO project = projectService.getProjectInfo(project_idx);
		System.out.println("프로젝트 정보 : " + project);
		// 선택한 리워드 정보 불러오기
		RewardVO reward = projectService.getRewardInfo(reward_idx);
		System.out.println("리워드 정보 : " + reward);
		// 리워드 리스트 불러오기(리워드 변경 모달창)
		List<RewardVO> rewardList = projectService.getRewardList(project_idx);
		System.out.println(rewardList);
		// 로그인한 회원의 기본 배송지가 있는지 확인해서 있으면 전달
		DeliveryVO deliveryDefault = fundingService.getDeliveryDefault(sId);
		System.out.println("기본 배송지 정보 : " + deliveryDefault);
		if(deliveryDefault != null) {
			// 기본 배송지 정보
			model.addAttribute("deliveryDefault", deliveryDefault);
		}
		
		// member_idx 조회
		int member_idx = projectService.getMemberIdx(sId);
		// 회원의 쿠폰 목록 중 미사용 쿠폰 목록만 조회
		List<CouponVO> couponList = couponService.getCouponsByMemberAndStatus(member_idx, 0);
		System.out.println("회원이 보유한 미사용 쿠폰 목록 : " + couponList);
		if(couponList != null) {
			model.addAttribute("couponList", couponList);
		}
		
		
		// 회원 정보
		model.addAttribute("member", member);
		// 프로젝트 정보
		model.addAttribute("project", project);
		// 리워드 정보
		model.addAttribute("reward", reward);
		// 리워드리스트(리워드 변경 모달창)
		model.addAttribute("rewardList", rewardList);
		return "funding/funding_order";
	}
	
	// 결제 완료 페이지
	@GetMapping ("fundingResult")
	public String fundingResult(Model model, HttpSession session
			, @RequestParam int member_idx
			, @RequestParam int payment_idx
			, @RequestParam int delivery_idx
//			 테이블 데이터 추가 시 주석 해제
			) {

		// 결제 정보 조회
		List<PaymentVO> payment = paymentService.getPaymentList(payment_idx);
		model.addAttribute(payment);
		
		// 주문 정보 조회
		List<DeliveryVO> delivery = deliveryService.getDeliveryList(payment_idx);
		model.addAttribute(delivery);
		
		// 세션 아이디가 존재하지 않을 때 
//		String sId = (String) session.getAttribute("sId");
//		if(sId == null) {
//			model.addAttribute("msg", "잘못된 접근입니다.");
//			return "fail_back";
//		}
		
		
		return "funding/funding_result";
	}	
	
	// 배송지 신규 등록 모달 ajax
	@PostMapping("deliveryNewAdd")
	@ResponseBody
	public DeliveryVO deliveryNewAdd(DeliveryVO delivery, HttpSession session) {
		//세션아이디 가져와서 DeliveryVO에 저장
//		String id = (String)session.getAttribute("sId");
		// 멤버 아이디 필요(가데이터)
		String id = "kim1234";
		delivery.setMember_id(id);
		
		// 신규 등록시 자동으로 기본배송지로 등록
		delivery.setDelivery_default(true);
		
		// 배송지 등록 DB 작업
		int insertCount = fundingService.registDelivery(delivery);
		if(insertCount > 0) {
			// 기본 배송지 조회 후 전달
			DeliveryVO saveDelivery = fundingService.getDeliveryDefault(id);
			return saveDelivery;
			
		} else {
			DeliveryVO saveDelivery = null;
			return saveDelivery;
			
		}
		
	}
	// 배송지 추가 모달 ajax
	@PostMapping("deliveryAdd")
	@ResponseBody
	public String deliveryAdd(DeliveryVO delivery, HttpSession session) {
		System.out.println(delivery);
		//세션아이디 가져와서 DeliveryVO에 저장
//		String id = (String)session.getAttribute("sId");
		// 멤버 아이디 필요(가데이터)
		String id = "kim1234";
		delivery.setMember_id(id);
		
		// 기본배송지로 설정시 기존의 기본배송지 0으로 변경
		if(delivery.isDelivery_default()) {
			fundingService.modifyDeliveryDefault();
		}
		
		// 배송지 등록 DB 작업
		int insertCount = fundingService.registDelivery(delivery);
		
		if(insertCount > 0) {
			return "success";
			
		} else {
			return "fail";
		}
		
	}
	
	// 배송지 목록 가져오기 ajax
	// produces = "application/json" => JSON 형식의 응답
	@GetMapping(value = "getDeliveryList", produces = "application/json")
	@ResponseBody
	public List<DeliveryVO> getDeliveryList(HttpSession session) {
		// 세션 아이디 가져오기
//		String id = (String)session.getAttribute("sId");
		String id = "kim1234";
		// 배송지 목록을 가져오는 DB 작업
		List<DeliveryVO> deliveryList = fundingService.getDeliveryList(id);
		System.out.println(deliveryList);
		
		return deliveryList;
	}
	
	// 리워드 변경 요청 ajax
	@PostMapping("rewardChange")
	@ResponseBody
	public RewardVO rewardChange(int reward_idx) {
		System.out.println("ajax로 요청받은 reward_idx" + reward_idx);
		// 전달받은 reward_idx 로 RewardVO 조회
		RewardVO reward = projectService.getRewardInfo(reward_idx);
		
		// 조회한 RewardVO 전달
		return reward;
	}
	
	// 배송지 변경 모달 ajax
	@PostMapping("deliveryChange")
	@ResponseBody
	public DeliveryVO deliveryChange(int changeDelivery_idx, HttpSession session) {
		System.out.println("전달받은 delivery_idx = " + changeDelivery_idx);
		// 세션 아이디 가져오기
//		String id = (String)session.getAttribute("sId");
		String id = "kim1234";
		// 해당 회원 아이디와 배송지 번호가 전달받은 changeDelivery_idx 인 배송지 조회
		DeliveryVO delivery = fundingService.getDeliveryInfo(id, changeDelivery_idx);
		System.out.println("조회한 delivery : " + delivery);
		
		return delivery;
	}
		
}
