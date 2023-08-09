package com.itwillbs.test.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.PaymentService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class PaymentController {
	
	@Autowired
	private PaymentService service;
	
	private IamportClient api;
	
	// 아임포트 클라이언트 검증
	public PaymentController() {
		// REST API 키와 REST API secret
		this.api = new IamportClient("3162026175407507",
				"lcNI8uNDYbiIPkE5bUhgjvamgWWvdqmpoCZMrTWvKwslV4uLjsbzjNqnJiibjF3IIFZv3okTRqFNuRYL");
	}
	
	// 결제 정보 검증
	@ResponseBody
	@RequestMapping(value = "/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(
			Model model,
			Locale locale,
			HttpSession session,
			@PathVariable(value= "imp_uid") String imp_uid) throws IamportResponseException, IOException {
				return api.paymentByImpUid(imp_uid);
	} 
	
	// 테스트 페이지로 이동(임시)
	@GetMapping("testPage")
	public String testPage(
			) {
		return "funding/test";
	}
	
}	
	
