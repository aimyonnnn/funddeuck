<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- sockjs -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script>
//전역변수 설정
var socket = null;
var member_id = "${sessionScope.sId}";

// 페이지 로드 후 실행하는 함수 모음
$(() => {
	getNotificationCount(); // 알림 갯수 조회하기 
});

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
       	 	
            if (!isNaN(notificationCount)) {	// 주어진 값이 숫자가 아니라면 true를 리턴
            	
                $("#newNotificationCount").text(notificationCount);
                
            }
            
        },
        error: function() {
        }
    });
}
	
$(document).ready(function() {
	
	// socket = new SockJS("http://localhost:8080/mvc_board/echo-ws");
    var contextPath = "${pageContext.request.contextPath}";
    var socketUrl = contextPath + "/echo-ws";
    socket = new SockJS(socketUrl);
    
    // 데이터를 전달 받았을때 
    socket.onmessage = onMessage; 	// toast 생성
    
});

// toast생성 및 추가
var toastCount = 0; 	// 알림 카운트 변수
	
//toast 생성 및 추가
function onMessage(evt) {
	
	getNotificationCount(); 	// 알림을 전달 받았을 때 알림 갯수 조회하는 함수 호출
	
	var data = evt.data;
	
    var toastId = 'toast-' + toastCount;  	// 고유한 ID 생성
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
	
	// 리스트 업데이트 하기
	updateList();
	
}
	
// 나가기
function exit() {
	
	let exit = confirm("정말 나가시겠습니까?");
	if(exit) { location.href = "./"; }
	
}

// 현재 페이지의 경로를 가져오는 함수
function getCurrentPage() {
	// window.location.pathname에서 현재 페이지의 경로를 가져옴
	var path = window.location.pathname;
	
	// 경로에서 마지막 '/' 이후의 문자열을 추출하여 현재 페이지의 이름 추출
	// 예시: /projectList -> projectList, /notificationList -> notificationList
	var currentPage = path.substring(path.lastIndexOf('/') + 1);
	
	// 테스트
// 	alert(currentPage);
	
	// 페이지 이름을 리턴
	return currentPage;
}

// 리스트 업데이트 함수 정의
function updateList() {
    // 현재 페이지에 따라 요청 파라미터 설정
    var currentPage = getCurrentPage();

    if (currentPage === 'confirmNotification') {		// 받은 메시지함
    	
    	setTimeout(function() {
		    location.reload();
		}, 3000);
        
    } else if (currentPage === 'projectReward') {		// 리워드 등록
    	
    	getNotifications();
    }
    
}

</script>
	
<div id="msgStack"></div>

<nav class="navbar navbar-expand-lg navbar-light bg-light" style="height:60px;">
    <div class="container">
        <a class="navbar-brand">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" width="30px" height="30px" onclick="location.href='./'">
        </a>
        <div class="d-flex flex-row align-items-center">
        	<c:choose>
        		<c:when test="${sessionScope.sId eq 'admin'}">
		            <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#notifyModal">Message</button>
		            <a class="nav-link text-primary mx-4" href="admin">${sessionScope.sId}님</a>
        		</c:when>
        		<c:otherwise>
		            <a class="nav-link text-primary mx-4" href="./">${sessionScope.sId}님</a>
        		</c:otherwise>
        	</c:choose>
            <a class="nav-link text-primary me-4" href="javascript:exit()">나가기</a>
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
$(() => {
	
    $('#notifySendBtn').click(function(e) {
    	
   	  	e.preventDefault();

   	  	if ($('#message_subject').val() === '') {
			alert('제목을 입력해주세요');
	   	    $('#message_subject').focus();
	   	    return;
   	  	}

   	  	if ($('#message_receiver').val() === '') {
	   	    alert('아이디를 입력해주세요');
	   	    $('#message_receiver').focus();
	   	    return;
   	  	}

   	  	if ($('#message_content').val() === '') {
	   	    alert('내용을 입력해주세요');
	  	    $('#message_content').focus();
	   	    return;
   	  	}
    	
        let modal = $('.modal-content').has(e.target);	// 클릭 이벤트(e)의 target이 속한 모달창을 찾기
        let type = 'message';
        let target = modal.find('.modal-body input[id="message_receiver"]').val();
        let subject = modal.find('.modal-body input[id="message_subject"]').val();
        let content = modal.find('.modal-body textarea').val();
        let url = '<c:url value="confirmNotification"/>';

       	// 메시지 DB 저장하기
        $.ajax({
            type: 'post',
            url: '<c:url value="saveNotification"/>',
            data: {
            	
                type: type,
                target: target,
                subject: subject,
                content: content,
                url: url
                
            },
            dataType: 'text',
            success: function(data) {
            	
                console.log(data);
                
                if (data == 'true') { 
                	
                    alert('메시지가 발송 되었습니다!');
                    socket.send(type + "," + target + "," + subject + "," + content + "," + url);
                    
                 	// 메시지 보내기 입력창 비우기
                    modal.find('.modal-body textarea').val('');
                    modal.find('.modal-body input').val('');
                    
                } else {
                	
                    alert('존재하지 않는 회원입니다.');
                    modal.find('.modal-body input[id="message_receiver"]').focus();
                    
                } 
                
            },
            error: function() {
                alert("메시지 발송 실패!");
            }
        });
        
    });
});
</script>	
<!-- 메시지 모달창 -->
<div class="modal fade" id="notifyModal" tabindex="-1" aria-labelledby="notifyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="notifyModalLabel">메시지 보내기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="sendMessageForm">
                   	<table class="table">
						<tr>
							<td class="text-center" style="width:15%">제목</td>
							<td style="width:85%">
								<input type="text" class="form-control" id="message_subject" placeholder="제목을 입력해주세요">
							</td>
						</tr>
						<tr>
							<td class="text-center">아이디</td>
							<td>
								<input type="text" class="form-control" id="message_receiver" placeholder="아이디를 입력해주세요">
							</td>
						</tr>
						<tr>
							<td class="text-center">내용</td>
							<td>
								<textarea class="form-control" id="message_content" cols="10" rows="7" placeholder="내용을 작성해주세요"></textarea>
							</td>
						</tr>
					</table>
                </form>
	                <button type="button" class="btn btn-primary w-100" id="notifySendBtn">메시지 전송하기</button>
            </div>
        </div>
    </div>
</div>