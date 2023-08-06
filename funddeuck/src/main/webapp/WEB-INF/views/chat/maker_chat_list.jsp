<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <%@ include file="../Header.jsp" %>
   	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
    <script type="text/javascript">
		let pageNum = 1; // 기본 페이지 번호 미리 저장
		let maxPage = 1; // 최대 페이지 번호 미리 저장
		
	$(function() {
		
		makerChatList();
		
		$(window).on("scroll", function() { // 스크롤 동작 시 이벤트 처리
			
			let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
			let windowHeight = $(window).height(); // 브라우저 창의 높이
			let documentHeight = $(document).height(); // 문서의 높이(창의 높이보다 크거나 같음)
			let x = 1;
			if(scrollTop + windowHeight + x >= documentHeight) {
				if(pageNum < maxPage) {
					pageNum++;
					makerChatList();
				} else {
				}
			}
			
		});
	});
		
	function makerChatList() {
		
		$.ajax({
			type:"post",
			url:"makerChatRoomList",
			data:{pageNum:pageNum},
			dataType:"json",
			success: function(data) {
				console.log(JSON.stringify(data));
				maxPage = data.maxPage;
				
				let id = "${sessionScope.sId}";
				
				for(let chatRoom of data.makerChatRoomList){
					$("#makerChatRoomList").after(
						'<div class="row my-2 align-items-center">'
				        +    '<div class="col-1 me-5 h5 text-primary">'
				        +        '<img class="center" style="width: 50px; height: 50px; border-radius: 50%;">'
				        +    '</div>'
				        +    '<div class="col-2">'
				        +        chatRoom.member_name
				        +    '</div>'
				       	+   	'<div class="col">'
				        + 			(chatRoom.sender == id ? '나 : ' : chatRoom.sender + " : ") 
				        + 			chatRoom.content
				        +    '</div>'
				        +    '<div class="col text-end">'
				        +        '<button class="btn btn-outline-primary" onclick="window.open(\'chat?room_id=' + chatRoom.room_id + '=' + chatRoom.member_id + '\', \'_blank\', \'width=500, height=800\')">1대1채팅</button>'
				        +    '</div>'
				        +'</div>'
					);
				}
				
				
			},
			error: function() {
				alert(에러);
			}
			
			
		});
		
	}
    </script>
    <style type="text/css">
    	footer {
    		position: fixed;
			bottom: 0;
			left: 0;
			width: 100%;
			padding: 10px;
    	}
    </style>
  </head>
  <body>
    <!--  채팅방 페이지 시작 -->
<div class="row">
    <div class="col"></div>
    <div class="col-12 col-md-5">
        <div class="row mb-5" style="margin-top: 100px" id="makerChatRoomList">
            <h2 style="border-bottom: 1px solid #ff9300;" class="pb-3"><b>메이커 문의 채팅방</b></h2>
        </div>
    </div>
    <div class="col">
    </div>
</div>
	<footer>
		<%@ include file="../Footer.jsp" %>
	</footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>