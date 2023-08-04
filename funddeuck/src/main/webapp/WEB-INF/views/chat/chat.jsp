<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Simple Chat</title>
<script
	src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<style type="text/css">
#fixed-to-bottom {
	position: fixed;
	bottom: 0;
	left: 0;
	width: 100%;
	padding: 10px;
	background: white;
}

#msgArea {
	background: white;
}
</style>
</head>
<body>
	<div class="container">
		<div class="col-6">
			<label><b></b></label>
		</div>
		<div id="msgArea" class="col">
			<c:forEach items="${chatList }" var="chat">
				<c:choose>
					<c:when test="${chat.sender eq sessionScope.sId }">
						<div class='col-7 float-end'>
							<div class='alert alert-secondary text-end'>
								<b> ${chat.content} </b>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class='col-7' style="clear: both;">
							<div class='alert alert-warning'>
								<b>${chat.receiver}<br>${chat.content}</b>
							</div>
						</div>
					</c:otherwise>
				</c:choose>

			</c:forEach>
		</div>
		<div class="col-12" id="fixed-to-bottom">
			<div class="input-group mb-3">
				<input type="text" id="msg" class="form-control"
					aria-label="Recipient's username" aria-describedby="button-addon2">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button"
						id="button-send">전송</button>
				</div>
			</div>
		</div>
		<div class="col-6"></div>
	</div>
	<!-- websocket javascript -->
	<script
		src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<script type="text/javascript">

//전송 버튼 누르는 이벤트
$("#button-send").on("click", function(e) {
	sendMessage();
	$('#msg').val('')
});


var contextPath = "${pageContext.request.contextPath}";
var socketUrl = contextPath + "/echo-ws?room_id="+"${param.room_id }";
var sock = new SockJS(socketUrl);
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen = onOpen;

function sendMessage() {
	
	sock.send("message,"+"${sessionScope.sId}," + $("#msg").val() + ",chat?room_id=${param.room_id }" + "=${sessionScope.sId}");
}
//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = null;
	
	var arr = data.split(",");
	
	for(var i=0; i<arr.length; i++){
		console.log('arr[' + i + ']: ' + arr[i]);
	}
	
	var cur_session = '${sessionScope.sId}'; //현재 세션에 로그인 한 사람
	console.log("cur_session : " + cur_session);
	
	sessionId = arr[0];
	message = arr[1];
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		
		var str = "<div class='col-7'>";
		str += "<div class='alert alert-secondary text-end'>";
		str += "<b>" + message + "</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	else{
		
		var str = "<div class='col-7' style='clear: both;'>";
		str += "<div class='alert alert-warning'>";
		str += "<b>" + sessionId + "<br>" + message + "</b>";
		str += "</div></div>";
		
		$("#msgArea").append(str);
	}
	
}
//채팅창에서 나갔을 때
function onClose(evt) {
	
	alert("잘못된 접근입니다.");
	
	history.back();
}
//채팅창에 들어왔을 때
function onOpen(evt) {
	
// 	console.log(evt);
	
// 	var user = '${sessionScope.id}';
// 	var str = user + "님이 입장하셨습니다.";
	
// 	$("#msgArea").append(str);
}


</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
		crossorigin="anonymous"></script>
</body>
</html>