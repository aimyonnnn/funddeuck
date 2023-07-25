/*
결제 관련 스크립트
*/

 // 결제 요청
function request_pay() {
	
var IMP = window.IMP;
IMP.init("imp30787507");

IMP.request_pay({
    pg: "html5_inicis", // PG사 선택
    pay_method: "card", // 지불 수단
    merchant_uid: "merchant_" + new Date().getTime(), // 주문번호
    name: "펀딩  프로젝트명", // 상품명
    amount: 1000, // 가격
    buyer_email: "test@gmail.com",
    buyer_name: "홍길동", // 구매자 이름
    buyer_tel: "010-1234-5678", // 구매자 연락처 
    buyer_addr: "부산광역시 부산진구",// 구매자 주소지
    buyer_postcode: "01181", // 구매자 우편번호
  }, function (rsp) { // callback
    if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
        console.log(rsp);
        // 결제검증
        $.ajax({
			type : "GET",
//			url : "/payments/" + rsp.imp_uid
			url : "<c:url value='payments/'/>" + rsp.imp_uid
      }).done(function(data) { // 응답 처리
      		console.log(data);
      		// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
      		if(rsp.paid_amount == data.response.amount){
		        	alert("결제가 완료되었습니다.");
//					location.href = "fundingResult?merchant_uid=" + merchant_uid payment 데이터 넣으면 주석 해제
					location.href = "fundingResult"
		    } else {
	        		alert("결제 실패");
	        }
        });
    } 
    else {
      alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
    }
  });
}

// 결제 취소 요청
function cancelPay() {
	jQuery.ajax({
      // 예: http://www.myservice.com/payments/cancel
	"url": "{환불정보를 수신할 가맹점 서비스 URL}", 
	"type": "POST",
	"contentType": "application/json",
	"data": JSON.stringify({
		"merchant_uid": "{결제건의 주문번호}", // 예: ORD20180131-0000011
		"cancel_request_amount": 2000, // 환불금액
		"reason": "테스트 결제 환불" // 환불사유
	}),
		"dataType": "json"
    });
}
