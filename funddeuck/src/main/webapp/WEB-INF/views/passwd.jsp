<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(function() {
	

	$("#btn").click(function() {
		let passwd = $("#passwd").val();
		
		
		if(passwd.length == 0){
			$("#passwd").focus();
			return false;
		}
		
		$.ajax({
			type:"get",
			url:"passwd",
			data:{passwd:passwd},
			dataType:"text",
			success: function(data) {
				alert(data);
			},
			error: function() {
				alert("실패");
			}
		});
	});
});
</script>
<body>

<input type="text" id="passwd" placeholder="원하는 비번 입력">
<input type="button" id="btn" value="암호화 생성">


</body>
</html>