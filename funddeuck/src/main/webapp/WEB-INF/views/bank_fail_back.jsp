<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	// 은행 관련 요청 작업 실패 시 전달받은 오류 메세지 출력 
	alert("${msg}");
	
	if("${isClose}" == "true") {
		window.close();		
	} else {
		window.close();	
	}
</script>
</head>
<body>
	
</body>
</html>