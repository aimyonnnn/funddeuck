<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>

</head>
<body>

	<button id="createChatRoom" class="btn btn-primary">1대1 문의하기</button>
	
	<table>
		<c:forEach items="${RoomList }" var="chatRoom">
			<tr>
				<td><button class="btn btn-outline-primary" onclick="location.href='chat?roomId=${chatRoom.roomId}=${chatRoom.id_1 }'">${chatRoom.id_1 }</button></td>
			</tr>
		</c:forEach>
	</table>
	
	<script type="text/javascript">
			$("#createChatRoom").click(function() {
				$.ajax({
					type:"post",
					url:"createRoom",
					dataType:"text",
					data: {id:"admin"},
					success: function (result) {
						console.log(result);
						alert("성공");
						location.href="chat?roomId="+result;
					},
				   error : function(request, status, error) {
				        console.log(error)
				    }
				});				
			}
			);
    </script>




	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
		crossorigin="anonymous"></script>
</body>
</html>