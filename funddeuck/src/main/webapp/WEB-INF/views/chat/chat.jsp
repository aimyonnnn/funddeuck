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
	position: sticky;
	bottom: 0;
}
</style>
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<script type="text/javascript">
	
	function openNewWindow(projectIdx) {
	    var url = "fundingDetail?project_idx=" + projectIdx;
	    var width = 500;
	    var height = 800;
	    window.open(url, '_blank', 'width=' + width + ', height=' + height);
	}
	
	let pageNum = 1; // 기본 페이지 번호 미리 저장
	let maxPage = 1; // 최대 페이지 번호 미리 저장
	let room_id = "${param.room_id}".split("=")[0];
	
	$(function() {
	lodechatList();
	
    // 스크롤을 맨 아래로 이동
    setTimeout(function() {
        $(window).scrollTop($(document).height());
    }, 100); // 100밀리초 후에 이동시킴
	
	    $(window).on("scroll", function() { // 스크롤 동작 시 이벤트 처리
	        let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
	        let x = 1;
	        
	        if (scrollTop <= x) { // 스크롤이 맨 위에 도달했을 때
	            if (pageNum < maxPage) {
	                pageNum++;
	                lodechatList();
	        	}
	        }
	    });
	});

	function lodechatList() {
		
		$.ajax({
			type:"post",
			url:"lodeChatList",
			data:{pageNum:pageNum, room_id:room_id},
			dataType:"json",
			success: function(data) {
				console.log(JSON.stringify(data));
				maxPage = data.maxPage;
				
				for(let chat of data.chatList){
					if(chat.sender == "${sessionScope.sId}"){
				        var str = "<div class='col-12 d-flex justify-content-end'>";
				        str += "<div class='col-7 alert alert-secondary text-end'>";
				        str += "<b>" + chat.content + "</b>";
				        str += "</div></div>";
				        $("#msgArea").prepend(str);
					} else {
				        var str = "<div class='col-12 d-flex justify-content-start'>";
				        str += "<div class='col-7 alert alert-warning'>";
				        str += "<b>" + chat.sender + "</b>";
				        str += "<div><b>" + chat.content + "</b></div>";
				        str += "</div></div>";
				        $("#msgArea").prepend(str);
					}
				}
				
				
				
			},
			error: function() {
				alert("오류");
			}
		});
		
	}
	
	
	</script>
</head>
<body>
	<div class="container">
		<div class="col-6">
			<label><b></b></label>
		</div>
		<div id="msgArea" class="col-12" style="padding-bottom: 50px;">

		</div>
		<div class="col-12" id="fixed-to-bottom" style="position: fixed; bottom: 0;left:0; right: 0; background-color: white;">
<!-- 		style="position: fixed; bottom: 0;left:0; right: 0;" -->
			<div class="input-group mb-3" >
				<input type="text" id="msg" class="form-control" aria-label="Recipient's username" aria-describedby="button-addon2"
				oninput="countChatText()">
				<div class="input-group-append">
					<button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
				</div>
			</div>
		</div>
		<div class="col-6"></div>
	</div>
	<!-- websocket javascript -->
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
	
	if($("#msg").val().length == 0){
		return false;
	}
	
	sock.send("message,"+"${sessionScope.sId}," + $("#msg").val() + ",chat?room_id=${param.room_id }" + "=${sessionScope.sId}");
}
//서버에서 메시지를 받았을 때
function onMessage(msg) {
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람
	var message = "";
	
	if(data == "이미 창이 열려있습니다."){
		onClose(data);
	}
	
	var arr = data.split(",");
	
	for(var i=0; i<arr.length; i++){
		console.log('arr[' + i + ']: ' + arr[i]);
	}
	
	var cur_session = '${sessionScope.sId}'; //현재 세션에 로그인 한 사람
	console.log("cur_session : " + cur_session);
	
	sessionId = arr[0];
	
	
	for(let mes of arr){
		if(mes != sessionId){
			message = message + mes;
		}
	}
	
    //로그인 한 클라이언트와 타 클라이언트를 분류하기 위함
	if(sessionId == cur_session){
		
        var str = "<div class='col-12 d-flex justify-content-end'>";
        str += "<div class='col-7 alert alert-secondary text-end'>";
        str += "<b>" + message + "</b>";
        str += "</div></div>";
		
		$("#msgArea").append(str);
		
		setTimeout(function() {
	        $(window).scrollTop($(document).height());
	    }, 100);
	}
	else{
		
        var str = "<div class='col-12 d-flex justify-content-start'>";
        str += "<div class='col-7 alert alert-warning'>";
        str += "<b>" + sessionId + "</b>";
        str += "<div><b>" + message + "</b></div>";
        str += "</div></div>";
		
		$("#msgArea").append(str);
		
		setTimeout(function() {
	        $(window).scrollTop($(document).height());
	    }, 100);
	}
	
}
//채팅창에서 나갔을 때
function onClose(evt) {
	
	if(evt == "이미 창이 열려있습니다."){
		alert("이미 채팅창이 열려있습니다.");
		
	} else {
		
		alert("잘못된 접근입니다.");
	}
	
	
	window.close();
}
//채팅창에 들어왔을 때
function onOpen(evt) {
	
	var project_idx = "${param.project_idx}";
	
	
	if(project_idx != ""){
		sock.send("project,"+"${sessionScope.sId},"+project_idx);
	}
	
// 	console.log(evt);
	
// 	var user = '${sessionScope.id}';
// 	var str = user + "님이 입장하셨습니다.";
	
// 	$("#msgArea").append(str);
}


	function countChatText() {
        var textarea = $('#msg');
        var maxLength = 200; // 최대 글자 수
        
        var currentLength = textarea.val().length;
        if (currentLength > maxLength) {
            textarea.val(textarea.val().slice(0, maxLength)); // 최대 글자 수까지만 남기고 잘라냄
            currentLength = maxLength; // 현재 글자 수를 최대 글자 수로 설정
            alert("최대 100글자만 작성가능합니다.");
        }
	}

</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
		crossorigin="anonymous"></script>
</body>
</html>