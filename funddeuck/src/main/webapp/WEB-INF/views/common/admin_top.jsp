<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- sockjs -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- line-awesome -->
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/adminDetail.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<link rel="shortcut icon" href="#">
 <!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style>
/* 페이지네이션 글자색 변경 */
.page-link {
	color: black;
}
</style>
<script>

//전역변수 설정
var socket = null;
var member_id = "${sessionScope.sId}";
	
// 페이지 로딩시 자동으로 호출
$(() => {
	getNotificationCount(); 
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
            if (!isNaN(notificationCount)) {
                $("#newNotificationCount").text(notificationCount);
            }
        },
        error: function() {
        }
    });
}
	
$(document).ready(function(){
	
    var contextPath = "${pageContext.request.contextPath}";
    var socketUrl = contextPath + "/echo-ws";
    socket = new SockJS(socketUrl);
    
    // 데이터를 전달 받았을때 
    socket.onmessage = onMessage; // toast 생성
    
});

//toast생성 및 추가
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
	
// 로그아웃
function logout() {
	let isLogout = confirm("로그아웃 하시겠습니까?");
	if(isLogout) { location.href = "LogOut"; }
}

//현재 페이지의 경로를 가져오는 함수
function getCurrentPage() {
	// window.location.pathname에서 현재 페이지의 경로를 가져옴
	var path = window.location.pathname;
	
	// 경로에서 마지막 '/' 이후의 문자열을 추출하여 현재 페이지의 이름 추출
	// 예시: /projectList -> projectList, /notificationList -> notificationList
	var currentPage = path.substring(path.lastIndexOf('/') + 1);
	
	// 페이지 이름을 리턴
	return currentPage;
}

// 리스트 업데이트 함수 정의
function updateList() {
	
    // 현재 페이지에 따라 요청 파라미터 설정
    var currentPage = getCurrentPage();
	
    if (currentPage === 'adminSentNotification') {				// 관리자 - 보낸 메시지함
    	
		setTimeout(function() {
		    location.reload();
		}, 3000);
        
    } else if (currentPage === 'adminReceivedNotification') { 	// 관리자 - 받은 메시지함
    	
    	setTimeout(function() {
		    location.reload();
		}, 3000);
    	
    }
    
}
</script>

<div id="msgStack"></div>

<nav class="navbar navbar-expand-lg navbar-light bg-dark" style="height:60px;">

    <div class="container">
        <a class="navbar-brand">
            <label for="sidebar-toggle">
            	<span class="las la-bars"></span>
            </label>
        </a>
        
        <div class="d-flex flex-row align-items-center">
            
            <c:choose>
            	<c:when test="${not empty sessionScope.sId}">
		            <a class="nav-link text-primary mx-4" href="admin">${sessionScope.sId}님</a>
		            <a class="nav-link text-primary me-4" href="javascript:logout()">로그아웃</a>
            	</c:when>
            	<c:otherwise>
            		<a class="nav-link text-primary mx-4" href="LoginForm">로그인</a>
            	</c:otherwise>
            </c:choose>
            
            <!-- 비행기 아이콘 - 메시지 전송용 -->
            <a class="nav-link py-0 me-4" href="#" data-bs-toggle="modal" data-bs-target="#notifyModal">
               <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-send-check-fill" viewBox="0 0 16 16">
				  <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 1.59 2.498C8 14 8 13 8 12.5a4.5 4.5 0 0 1 5.026-4.47L15.964.686Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
				  <path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Zm-1.993-1.679a.5.5 0 0 0-.686.172l-1.17 1.95-.547-.547a.5.5 0 0 0-.708.708l.774.773a.75.75 0 0 0 1.174-.144l1.335-2.226a.5.5 0 0 0-.172-.686Z"/>
				</svg>
            </a>
            
            <!-- 편지 아이콘 - 보낸 메시지함 -->
            <a class="nav-link py-0 me-4" href="adminSentNotification">
               <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-envelope-check-fill" viewBox="0 0 16 16">
				  	<path d="M.05 3.555A2 2 0 0 1 2 2h12a2 2 0 0 1 1.95 1.555L8 8.414.05 3.555ZM0 4.697v7.104l5.803-3.558L0 4.697ZM6.761 8.83l-6.57 4.026A2 2 0 0 0 2 14h6.256A4.493 4.493 0 0 1 8 12.5a4.49 4.49 0 0 1 1.606-3.446l-.367-.225L8 9.586l-1.239-.757ZM16 4.697v4.974A4.491 4.491 0 0 0 12.5 8a4.49 4.49 0 0 0-1.965.45l-.338-.207L16 4.697Z"/>
				  	<path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Zm-1.993-1.679a.5.5 0 0 0-.686.172l-1.17 1.95-.547-.547a.5.5 0 0 0-.708.708l.774.773a.75.75 0 0 0 1.174-.144l1.335-2.226a.5.5 0 0 0-.172-.686Z"/>
				</svg>
            </a>
            
            <!-- 종 아이콘 - 받은 메시지함 -->
            <a class="nav-link py-0" href="adminReceivedNotification">
	            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
			  		<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
				</svg>
           	</a>
            
            <span id="newNotificationCount" class="badge bg-danger rounded-pill">1</span>
            
        </div>
        
        <button class="navbar-toggler menu-toggle" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
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