package com.itwillbs.test.controller;

import java.time.*;
import java.util.*;

import javax.servlet.http.*;

import org.json.JSONObject;
import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.*;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.test.handler.*;
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
	@Autowired
	private BankService bankService;
	@Autowired
	private BankApiService bankApiService;
	
	// 로그 출력을 위한 변수 선언
	private static final Logger logger = LoggerFactory.getLogger(FundingController.class);
	
	// 펀딩 탐색 페이지
	@GetMapping("fundingDiscover")
	public String fundingDiscover(Model model,
			@RequestParam(defaultValue = "all") String category,
			@RequestParam(defaultValue = "all") String status,
			@RequestParam(defaultValue = "newest") String index
			) {
		
		// 프로젝트 리스트 조회(탐색 페이지)
		List<ProjectVO> project = fundingService.getFundingList(category, status, index);
		model.addAttribute("project", project);
		
		return "funding/funding_discover";
	}
	
	// 오픈 예정 펀딩 탐색 페이지
	@GetMapping("fundingExpected")
	public String fundingDiscover(Model model,
			@RequestParam(defaultValue = "all") String category
			) {
		
		// 오픈 예정 프로젝트 리스트 조회(탐색 페이지)
		List<ProjectVO> project = fundingService.getExpectedFundingList(category);
		model.addAttribute("project", project);
		
		return "funding/funding_expected_discover";
	}	
	
	// 펀딩 검색어 탐색 페이지
	@GetMapping("fundingSearchKeyword")
	public String fundingSearchKeyword(Model model
			, @RequestParam(defaultValue = "all") String status
			, @RequestParam(defaultValue = "newest") String index
			, @RequestParam(defaultValue = "") String searchKeyword) {
		
		// 검색어로 프로젝트 리스트 조회
		List<ProjectVO> project = fundingService.getFundingSearchKeyword(status, index, searchKeyword);
		model.addAttribute("project" ,project);
		
		return "funding/funding_search";
	}	
	
	// 펀딩 상세페이지 이동
	@GetMapping ("fundingDetail")
	public String fundingDetail(Model model
			, @RequestParam int project_idx
			, @RequestParam(defaultValue = "introduce") String category

			) {
		
		// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 정보
		ProjectVO project = fundingService.selectProjectInfo(project_idx);
		model.addAttribute("project",project);
		
		// 프로젝트 메이커 로고
		MakerVO maker = fundingService.getMakerLogo(project.getMaker_idx());
		model.addAttribute("maker", maker);
		
		// 프로젝트 상세 페이지 이동 시 조회할 리워드 정보
		List<RewardVO> reward = fundingService.selectProjectRewardInfo(project_idx);
		model.addAttribute("reward", reward);
		System.out.println(reward);
		
		// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 게시판 정보
		List<MakerBoardVO> makerBoard = fundingService.getMakerBoardInfo(project_idx);
		model.addAttribute("makerBoard", makerBoard);
		
		// 프로젝트 상세 페이지 이동 시 조회할 프로젝트 커뮤니티 게시물 정보
		List<ProjectCommunityVO> ProjectCommunity = fundingService.getProjectCommunityInfo(project_idx);
		model.addAttribute("ProjectCommunity", ProjectCommunity);
		
		// 프로젝트 상세 페이지 이동 시 조회할 총 후원자수 정보
		int supTotal = fundingService.getSupTotal(project_idx);
		model.addAttribute("supTotal", supTotal);
		
		return "funding/funding_detail";
	}
	
	// 프로젝트 상세 페이지에서 의견 남기기
	@PostMapping("commentWritePro")
	public String commentWrite(ProjectCommunityVO ProjectCommunity, HttpSession session, HttpServletRequest request, Model model) {
		
		String sId = (String)session.getAttribute("sId");
		// 미로그인시
    	if(sId == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	int insertCount = fundingService.registComment(ProjectCommunity);
    	
    	// 의견 작성 결과 판별
    	if(insertCount > 0) {
    		
    		// 작성 성공 시"의견이 등록되었습니다" 출력 후 이전 페이지로(실패 아님)
    		model.addAttribute("msg", "글이 등록되었습니다.");
    		return "fail_back";
    	} else {
    		
    		model.addAttribute("msg", "오류 발생!");
    		return "fail_back";
    	}
	}
	
	// 펀딩 주문페이지 이동
	@GetMapping ("fundingOrder")
		// 파라미터 전달, 주석 풀 부분
		public String fundingOrder(@RequestParam int project_idx, @RequestParam int reward_idx, HttpSession session, Model model) {
//		public String fundingOrder(HttpSession session, Model model) {
		
		String sId = (String)session.getAttribute("sId");
		// 미로그인 또는 주문하던 회원이 아닐경우 ****
		// 이전페이지? 아니면 로그인화면으로?
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg","잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
		// 회원 정보 불러오기
		MembersVO member = memberService.getMemberInfo(sId);
//		System.out.println("회원 정보 : " + member);

		// 프로젝트 정보 불러오기
		ProjectVO project = projectService.getProjectInfo(project_idx);
//		System.out.println("프로젝트 정보 : " + project);
		// 선택한 리워드 정보 불러오기
		RewardVO reward = projectService.getRewardInfo(reward_idx);
//		System.out.println("리워드 정보 : " + reward);
		// 리워드 리스트 불러오기(리워드 변경 모달창)
		List<RewardVO> rewardList = projectService.getRewardList(project_idx);
//		System.out.println(rewardList);
		// 로그인한 회원의 기본 배송지가 있는지 확인해서 있으면 전달
		DeliveryVO deliveryDefault = fundingService.getDeliveryDefault(sId);
//		System.out.println("기본 배송지 정보 : " + deliveryDefault);
		if(deliveryDefault != null) {
			// 기본 배송지 정보
			model.addAttribute("deliveryDefault", deliveryDefault);
		}
		
		// member_idx 조회
		int member_idx = member.getMember_idx();
		// 회원의 쿠폰 목록 중 미사용 쿠폰 목록만 조회
		List<CouponVO> couponList = couponService.getCouponsByMemberAndStatus(member_idx, 0);
//		System.out.println("회원이 보유한 미사용 쿠폰 목록 : " + couponList);
		if(couponList != null) {
			model.addAttribute("couponList", couponList);
		}
		
		// 회원의 계좌정보 조회
		BankAccountVO bankAccount = bankService.getBankAccountInfo(member_idx);
		System.out.println("bankAccount : " + bankAccount);
		if(bankAccount != null) {
			// DB에 저장된 회원의 토큰정보 확인
			ResponseTokenVO token = bankService.getTokenInfo(member_idx);
			if(token != null) { // 토큰의 정보가 있다면
				// 세션 객체에 엑세스토큰(access_token)과 사용자번호(user_seq_no) 저장
				session.setAttribute("access_token", token.getAccess_token());
				session.setAttribute("user_seq_no", token.getUser_seq_no());
				// 엑세스토큰과 사용자번호 저장
				String access_token = token.getAccess_token();
				logger.info("●●●●● access_token : " + access_token);
				String user_seq_no = token.getUser_seq_no();
				logger.info("●●●●● user_seq_no : " + user_seq_no);
				// 핀테크 이용자 정보 조회(API)
				ResponseUserInfoVO userInfo = bankApiService.requestUserInfo(access_token, user_seq_no); 
				logger.info("●●●●● userInfo : " + userInfo);
				
				String fintech_use_num = bankAccount.getFintech_use_num();
				// userInfo 중 핀테크이용번호가 일치하는 정보 조회
				List<BankAccountVO> bankAccountList = userInfo.getRes_list();
				for(BankAccountVO account : bankAccountList) {
					if (account.getFintech_use_num().equals(fintech_use_num)) {
						bankAccount = account;
					}
				}
//				System.out.println("bankAccount : " + bankAccount);
			}
			// 계좌 정보
			model.addAttribute("bankAccount", bankAccount);
		}
		// 달성률 = 실제금액 / 목표금액 x 100
		int project_target = project.getProject_target(); // 목표금액
		int project_cumulative_amount = project.getProject_cumulative_amount(); // 누적금액
		// 소수점 둘째자리 반올림
		double achievementRate = Math.round( ((double)project_cumulative_amount / project_target) * 100 * 100) / 100.0;
		model.addAttribute("achievementRate", achievementRate);
		
		// 프로젝트 남은기간 계산
		LocalDate currentDate = LocalDate.now();
		LocalDate projectEndDate = project.getProject_end_date().toLocalDate();
        // 프로젝트 종료일과 현재 날짜 사이의 남은 날짜 계산
        Period period = Period.between(currentDate, projectEndDate);
        int remainingDays = period.getDays();
        // 남은기간(출력용)
        model.addAttribute("remainingDays", remainingDays);
		
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
	
	// 펀딩 결제
	@PostMapping("fundingPayment")
	public String fundingPayment(PaymentVO payment, HttpSession session) {
		System.out.println("PaymentVO : " + payment);
		// 주문날짜 payment_date

		// 현재 날짜를 java.sql.Date 객체로 변환(VO의 데이터타입 일치시켜주기위함)
		java.sql.Date currentSqlDate = java.sql.Date.valueOf(LocalDate.now());

		// 변환된 java.sql.Date 객체를 setPayment_date 메서드에 전달합니다.
		System.out.println("현재 날짜 " + currentSqlDate);
		payment.setPayment_date(currentSqlDate);
		
		// 주문수량 payment_quantity ??? 1로 가정
	    payment.setPayment_quantity(1);
		// 결제승인여부 payment_confirm 예약완료 1
	    payment.setPayment_confirm(1);
	    
		// 결제 수단 카드(1)/ 계좌(2) payment_method
	    payment.setPayment_method(2); // 계좌라고 가정
	    
	    // 계좌면 회원 계좌에서 출금
	    // fintech_use_num access_token 필요(세션값 불러오기)
	    String fintech_use_num = (String)session.getAttribute("fintech_use_num");
	    String access_token = (String)session.getAttribute("access_token");
	    logger.info("access_token : " + access_token);
	    ResponseWithdrawVO withdrawResult = bankApiService.requestWithdrawMember(payment.getTotal_amount(), fintech_use_num, access_token);
	    logger.info("withdrawResult" + withdrawResult);
	    // DB에 출금내역(회원) 입금내역(사이트) 저장
	    // 응답데이터를 ResponseWithdrawVO 로 받음
		/*
		 * 사이트계좌(입금) 
		 * 입금기관명 dps_bank_name 
		 * 입금계좌번호(마스킹) dps_account_num_masked 
		 * 입금계좌인자내역 dps_print_content 
		 * 수취인성명 dps_account_holder_name 
		 * 거래일자 bank_tran_date 
		 * 거래금액 tran_amt
		 * 
		 * 
		 * 회원(출금) 
		 * 개설기관명 bank_name 
		 * 출금계좌번호(출력용) account_num_masked 
		 * 출금계좌인자내역 print_content
		 * 송금인성명 account_holder_name 
		 * 거래일자 bank_tran_date 
		 * 거래금액 tran_amt
		 */
	    // 입금내역
	    BankingVO dpsBankTran = new BankingVO();
	    // 입금(사이트)
	    dpsBankTran.setBanking_bank_name(withdrawResult.getDps_bank_name()); // 입금기관명
	    dpsBankTran.setBanking_account_num_masked(withdrawResult.getDps_account_num_masked()); // 입금계좌번호(마스킹)
	    dpsBankTran.setBanking_print_content(withdrawResult.getDps_print_content()); // 입금계좌인자내역
	    dpsBankTran.setBanking_account_holder_name(withdrawResult.getDps_account_holder_name()); // 수취인성명
	    dpsBankTran.setBanking_bank_tran_date(withdrawResult.getBank_tran_date()); // 거래일자
	    dpsBankTran.setBanking_tran_amt(withdrawResult.getTran_amt()); // 거래금액
	    
//	    withdrawResult.getDps_bank_name(); // 입금기관명
//	    withdrawResult.getDps_account_num_masked(); // 입금계좌번호(마스킹)
//	    withdrawResult.getDps_print_content(); // 입금계좌인자내역
//	    withdrawResult.getDps_account_holder_name(); // 수취인성명
//	    withdrawResult.getBank_tran_date(); // 거래일자
//	    withdrawResult.getTran_amt(); // 거래금액
//	    
	    // 출금금내역
	    BankingVO wdBankTran = new BankingVO();
	    // 입금(사이트)
	    wdBankTran.setBanking_bank_name(withdrawResult.getBank_name()); // 개설기관명
	    wdBankTran.setBanking_account_num_masked(withdrawResult.getAccount_num_masked()); // 출금계좌번호(마스킹)
	    wdBankTran.setBanking_print_content(withdrawResult.getPrint_content()); // 출금계좌인자내역
	    wdBankTran.setBanking_account_holder_name(withdrawResult.getAccount_holder_name()); // 송금인성명
	    wdBankTran.setBanking_bank_tran_date(withdrawResult.getBank_tran_date()); // 거래일자
	    wdBankTran.setBanking_tran_amt(withdrawResult.getTran_amt()); // 거래금액
	    // 출금(회원)
//	    withdrawResult.getBank_name(); // 개설기관명
//	    withdrawResult.getAccount_num_masked(); // 출금계좌번호(마스킹)
//	    withdrawResult.getPrint_content(); // 출금계좌인자내역
//	    withdrawResult.getAccount_holder_name(); // 송금인성명
//	    withdrawResult.getBank_tran_date(); // 거래일자
//	    withdrawResult.getTran_amt(); // 거래금액
	    
	    // 거래요청일시를 프로젝트 종료일로 전달(예약)
	    
	    // 환불
//	    ResponseDepositVO depositResult = bankApiService.requestDeposit(payment.getTotal_amount(), fintech_use_num, access_token);
//	    logger.info("depositResult" + depositResult);
	    
	    // 주문서 DB 등록
	    // 성공시 fundingResult 결제 완료페이지로 이동
	    // 실패시 fail_back
		
		// 쿠폰 사용시 쿠폰 상태 변경
	    // 리워드 수량 -1 주문수량..?
		return "";
	}
	
	// 결제 완료 페이지
	@GetMapping ("fundingResult")
	public String fundingResult(Model model, HttpSession session
			, @RequestParam int member_idx
			, @RequestParam int payment_idx
			, @RequestParam int delivery_idx
			) {

		// 세션 아이디가 존재하지 않을 때 
		String sId = (String) session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			return "fail_back";
		}
		
		// 결제 정보 조회
		List<PaymentVO> payment = paymentService.getPaymentList(payment_idx);
		model.addAttribute(payment);
		
		// 주문 정보 조회
		List<DeliveryVO> delivery = deliveryService.getDeliveryList(payment_idx);
		model.addAttribute(delivery);
		
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
