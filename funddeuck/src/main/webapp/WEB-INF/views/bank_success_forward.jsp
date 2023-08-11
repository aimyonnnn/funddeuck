<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script type="text/javascript">
	// 은행 관련 요청 작업 성공 시 전달받은 메세지 출력 후 지정한 페이지로 포워딩
	alert("${msg}");
	
	if("${isClose}" == "true") {
        window.opener.document.getElementById('token_idx').value = ${token_idx}; // 부모 창의 token_idx input 값을 업데이트함
		
        // 부모 창의 본인인증 버튼 삭제
        var btnAccountAuth = window.opener.document.getElementById('btnAccountAuth');
        btnAccountAuth.style.display = 'none';
        
     	// 부모창에 있는 'isAuthenticated' input 값을 true로 변경합니다.
        window.opener.document.getElementById('isAuthenticated').value = 'true';
        
        let formElement = window.opener.document.getElementById('accountAuth');
        formElement.innerHTML = "";
        
        let output = `<div>
						<div class="form-group">
						    <input type="text" name="project_settlement_bank" class="form-control" value="${mostRecentBankAccount.bank_name}" readonly>
						</div>
						<div class="form-group mt-1">
						    <input type="text" name="project_settlement_account" class="form-control" value="${mostRecentBankAccount.account_num_masked}" readonly>
						</div>
						<div class="form-group mt-1">
						    <input type="text" name="project_settlement_name" class="form-control" value="${mostRecentBankAccount.account_holder_name}" readonly>
						    <input type="hidden" name="project_fintech_use_num" id="project_fintech_use_num" value="${mostRecentBankAccount.fintech_use_num}">
						</div>
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