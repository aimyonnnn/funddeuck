package com.itwillbs.test.service;

import java.util.*;
import java.util.concurrent.*;

import org.slf4j.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.test.vo.*;

@Service
public class FundingScheduler {
	
	@Autowired
	private FundingService fundingService;
	@Autowired
	private BankApiService bankApiService;
	@Autowired
	private BankService bankService;
	
	// 로거
	private static final Logger logger = LoggerFactory.getLogger(FundingScheduler.class);
	
	// 스케줄러
	private ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();

	public void scheduledBankTran(int payment_idx, Map<String, String> data) {
		executorService.schedule(() -> {
			// 프로젝트 상태 조회 (0-취소, 3-진행완료)
			// 2-진행중인걸로 일단함
			int project_status = fundingService.getProjectStatus(payment_idx);
			if(project_status == 2 || project_status != 0) {
				// payment 조회
				PaymentVO payment = fundingService.getPaymentInfo(payment_idx);
				
				// 프로젝트 종료일에 출금이체 API 요청 실행
				
	    		// 만약 프로젝트가 취소되면 메서드 취소, payment_confirm  프로젝트 취소로 수정 => 0번 프로젝트 취소?
				// 출금이체 API 요청(회원)
				ResponseWithdrawVO withdrawResult = bankApiService.requestWithdrawMember(payment.getTotal_amount(), data);
				logger.info("withdrawResult : " + withdrawResult);
				
				// member_id 조회
				String id = fundingService.getMemberId(payment.getMember_idx());
				
		    	// 거래내역 DB 저장(입금내역)
		    	// 거래내역 저장시 거래날짜가 엄청 과거로 불러와지는 문제해결 필요
		    	boolean isSaveFundingTranHistSuccess = bankService.saveFundingTranHist(id, payment.getProject_idx(), withdrawResult);
		    	if(isSaveFundingTranHistSuccess) { // 거래내역 DB 저장 성공시
		    		System.out.println("출금이체 후 거래내역 저장 완료!");
		    		// 결제승인여부 결제완료로 변경
		    		fundingService.ModifyPaymentConfirm(payment_idx);
		    	} else { // 거래내역 DB 저장 실패시
		    	}
				
			}
			
		}, 1, TimeUnit.MINUTES);
		
	}
}
