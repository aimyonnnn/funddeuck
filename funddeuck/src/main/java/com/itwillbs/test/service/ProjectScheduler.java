package com.itwillbs.test.service;

import com.itwillbs.test.mapper.PaymentMapper;
import com.itwillbs.test.vo.PaymentVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Service
public class ProjectScheduler {

	@Autowired
	private PaymentMapper mapper;

	private ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();

	// 송장번호 입력 후 일주일 후 '배송완료'로 상태변경
	public void modifyDeliveryStatus(int payment_idx) {
        executorService.schedule(() -> {
        	
        	// 일주일 후에 조회를 실행
            List<PaymentVO> paymentList = mapper.selectPaymentList(payment_idx);
            
            boolean deliveryStatusCheck = false; // delivery_status가 배송완료인지 체크
            
            for (PaymentVO payment : paymentList) {
                if (payment.getDelivery_status() != 3) { // 배송완료가 아닐 시 
                	deliveryStatusCheck = true;
                    break;
                }
            }
        	
            if (deliveryStatusCheck) { // 배송완료가 아니라면
                mapper.updateDeliveryStatusPaymentList(payment_idx); // 일주일 후 배송완료로 상태변경 업데이트 실행
            }
        }, 1, TimeUnit.MINUTES);
	}

	// 미발송 및 배송중이 없다면 2주 후 최종정산 가능으로 프로젝트 상태 변경
	public void modifyProjectStatus(int payment_idx) {
		executorService.schedule(() -> {
			mapper.updateProjectStatus(payment_idx); // 2주 후 배송완료로 상태변경 업데이트 실행
        }, 14, TimeUnit.DAYS);
	}
	
	
	
	// ========== 반복 작업 시 @Scheduled 어노테이션 후 사용하시면 됩니다. ============

	
}