<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <%session.setAttribute("sId", "admin");%> --%>
<%-- <%session.setAttribute("sId", "test");%> --%>
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	//전역변수 설정
	var socket = null;
	var member_id = "${sessionScope.sId}";
	// 페이지 로딩시 자동으로 호출
	$( () => { getNotificationCount(); });
	// 알림 갯수 조회하기
	function getNotificationCount() {
	    $.ajax({
	        type: "get",
	        url: "<c:url value='getNotificationCount'/>",
	        data: {
	            member_id: member_id
	        },
	        dataType: "text",
	        success: function(data) {   
	       	 	let notificationCount = parseInt(data);
	            if (!isNaN(notificationCount)) {
	                $("#newNotificationCount").text(notificationCount);
	            }
	        },
	        error: function() {
// 	            alert("알림 갯수 조회 실패!");
	        }
	    });
	}
	
	$(document).ready(function(){
// 	    socket = new SockJS("http://localhost:8080/mvc_board/echo-ws");
	    var contextPath = "${pageContext.request.contextPath}";
	    var socketUrl = contextPath + "/echo-ws";
	    socket = new SockJS(socketUrl);
	    // 데이터를 전달 받았을때 
	    socket.onmessage = onMessage; // toast 생성
	});
	// toast생성 및 추가
	var toastCount = 0; // 알림 카운트 변수
	//toast 생성 및 추가
	function onMessage(evt) {
		// 알림을 전달 받았을 때 알림 갯수 조회하는 함수 호출
		getNotificationCount();
		// 관리자 피드백 메시지 업데이트
		getNotifications();
		var data = evt.data;
	    // 고유한 ID 생성
	    var toastId = 'toast-' + toastCount;
	    toastCount++;
		// toast
		let toast = "<div id='" + toastId + "' class='toast' role='alert' aria-live='assertive' aria-atomic='true'>";
		toast += "<div class='toast-header'><i class='bi bi-bell-fill mr-2'></i><strong class='me-auto'>알림</strong>";
		toast += "<small class='text-muted'>just now</small><button type='button' class='btn-close' data-bs-dismiss='toast' aria-label='Close'></button>";
		toast += "</div> <div class='toast-body'>" + data + "</div></div>";
		// msgStack div에 생성한 toast 추가
		$("#msgStack").append(toast);
		new bootstrap.Toast(document.getElementById(toastId)).show();
		// 알림 닫기 버튼 클릭 시 제거
		$("#" + toastId + " .btn-close").click(function () {
			$("#" + toastId).toast('hide');
		});
	}
	
	// 나가기
	function logout() {
		let isLogout = confirm("정말 나가시겠습니까?");
		if(isLogout) { location.href = "./"; }
	}
</script>
	
<div id="msgStack"></div>
<nav class="navbar navbar-expand-lg navbar-light bg-light" style="height:60px;">
	<div class="container">
	    <a class="navbar-brand">
	    		<img src="${pageContext.request.contextPath}/resources/images/logo.png" width="30px" height="30px" onclick="location.href='projectMaker'">
	    </a>
	    <div class="d-flex flex-row align-items-center">
	    	<button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#notifyModal">Admin Feedback</button>
		  	<a class="nav-link text-primary mx-4" href="#">${sessionScope.sId} 님</a>
		  	<a class="nav-link text-primary me-4" href="javascript:logout()">나가기</a>
		  	<a class="nav-link py-0" href="confirmNotification">
			    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-bell" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
			    	<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2z"/>
			      	<path fill-rule="evenodd" d="M8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
			    </svg>
		  	</a>
		  	<span id="newNotificationCount" class="badge bg-danger rounded-pill">1</span>
		</div>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	    	<span class="navbar-toggler-icon"></span>
	    </button>
	  </div>
</nav>
<script type="text/javascript">
		$(()=>{
			
			$('#notifySendBtn').click(function(e){
				
				let modal = $('.modal-content').has(e.target);
				let type = 'message';
				let target = modal.find('.modal-body input').val();
				let content = modal.find('.modal-body textarea').val();
				let url = '<c:url value="confirmNotification"/>';
				
				// db저장을 위한 ajax요청	
				$.ajax({
					type: 'post',
					url: '<c:url value="saveNotification"/>',
					data: {
						target: target,
						content: content,
						type: type,
						url: url
					},
					dataType: 'text',
					success: function(data){
						console.log(data);
						if(data == 'true') { alert('메시지가 발송 되었습니다!'); }
						socket.send(type + "," + target + "," + content + "," + url);
					}, error: function() {
						alert("메시지 발송 실패!");
					}
				});
				// 메시지 입력창 비우기
				modal.find('.modal-body textarea').val('');
				modal.find('.modal-body input').val('');
			});
			
		});
	</script>	
	
<!-- 모달창 -->
<div class="modal fade" id="notifyModal" tabindex="-1" aria-labelledby="notifyModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="pointModalLabel">관리자 피드백</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
          	<label for="notifyId" class="form-label">받는 사람</label>
            <input type="text" class="form-control mb-2" id="notifyId" placeholder="메이커 아이디를 입력해주세요">
            <label for="message-text" class="form-label">내용</label>
            <textarea class="form-control" id="message-text" cols="10" rows="5" placeholder="메이커에게 전달할 피드백 메시지를 작성해주세요"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button id="notifySendBtn" type="button" class="btn btn-outline-primary">전송</button>
        <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>