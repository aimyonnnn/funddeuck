<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	// 은행 관련 요청 작업 성공 시 전달받은 메세지 출력 후 지정한 페이지로 포워딩
	alert("${msg}");
	
	if("${isClose}" == "true") {
		
		// 부모창(펀딩 주문페이지의 결제수단 영역)에 출력
		let formElement = window.opener.document.getElementById('paymentMethodForm');
		// 기존의 출력 지우기
		formElement.innerHTML = "";
		// 계좌 정보 출력
		let output = 			
					`<div class="col-12">
						<span class="fs-6 fw-bold">은행명</span>&nbsp;&nbsp;
						<span class="fs-6">${mostRecentBankAccount.bank_name}</span>
					</div>
					<div class="col-12">
						<span class="fs-6 fw-bold">예금주명</span>&nbsp;&nbsp;
						<span class="fs-6">${mostRecentBankAccount.account_holder_name}</span>
					</div>
					<div class="col-12">
						<span class="fs-6 fw-bold">계좌번호</span>&nbsp;&nbsp;
						<span class="fs-6">${mostRecentBankAccount.account_num_masked}</span>
					</div>`;
		formElement.innerHTML = output;
		window.close();		
		
		
	} else {
		history.back();
	}
</script>
</head>
<body>
	
</body>
</html>