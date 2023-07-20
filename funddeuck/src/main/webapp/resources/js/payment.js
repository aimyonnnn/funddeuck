/**
결제 처리 스크립트
 */
function request_pay() {
	
var IMP = window.IMP;
IMP.init("imp30787507");

// 주문번호 생성
var today = new Date();   
var hours = today.getHours();
var minutes = today.getMinutes();
var seconds = today.getSeconds();
var milliseconds = today.getMilliseconds();
var makeMerchantUid = hours +  minutes + seconds + milliseconds;

IMP.request_pay({
    pg: "html5_inicis", // PG사 선택
    pay_method: "card", // 지불 수단
    merchant_uid: "IMP" + makeMerchantUid, // 주문번호
    name: "펀딩  프로젝트명", // 상품명
    amount: 1000, // 가격
    buyer_email: "test@gmail.com",
    buyer_name: "홍길동", // 구매자 이름
    buyer_tel: "010-1234-5678", // 구매자 연락처 
    buyer_addr: "부산광역시 부산진구",// 구매자 주소지
    buyer_postcode: "01181", // 구매자 우편번호
    m_redirect_url : 'https://example.com/mobile/complete', // 모바일 결제시 사용할 url
    digital: true, // 실제 물품인지 무형의 상품인지(핸드폰 결제에서 필수 파라미터)
    app_scheme : '' // 돌아올 app scheme
  }, function (rsp) { // callback
    if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
        console.log(rsp);
        // 결제검증
        $.ajax({
			type : "POST",
			url : "/verifyIamport/" + rsp.imp_uid 
      }).done(function(data) { // 응답 처리
      		console.log(data);
      		// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
      		if(rsp.paid_amount == data.response.amount){
		        	alert("결제 및 결제검증완료");
		    } else {
	        		alert("결제 실패");
	        }
        });
    } else {
      alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
    }
  });
}