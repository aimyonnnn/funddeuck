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
        window.opener.document.getElementById('token_idx').value = ${token_idx}; // 부모 창의 token_idx input 값을 업데이트함
		window.close();		
	} else {
		history.back();
	}
</script>
</head>
<body>
	
</body>
</html>