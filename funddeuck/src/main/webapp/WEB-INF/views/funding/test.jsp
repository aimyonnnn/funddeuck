<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩</title>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<!-- fundingDiscover page CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/funding_discover.css">
<!-- 공용 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
<!-- line-awesome icons CDN -->
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- header include -->
<jsp:include page="../Header.jsp"></jsp:include>
<!-- Jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fundingDiscover page JS -->
<script src="${pageContext.request.contextPath }/resources/js/funding_discover.js"></script>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
<button onclick="request_pay()">결제 테스트
</button>
<script type="text/javascript">
//아임포트 결제 스크립트 ---------------------------------------------
function request_pay() {
	var IMP = window.IMP;
	IMP.init("imp30787507");
	console.log(IMP.init)
	
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
// 				url : "/payments/" + rsp.imp_uid
				url : "<c:url value='payments/'/>" + rsp.imp_uid
	      }).done(function(data) { // 응답 처리
	      		console.log(data);
	      		// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
	      		if(rsp.paid_amount == data.response.amount){
			        	alert("결제가 완료되었습니다.");
//						location.href = "fundingResult?merchant_uid=" + merchant_uid payment 데이터 넣으면 주석 해제
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
//--------------------------------------------------------------------
</script>
</body>
</html>