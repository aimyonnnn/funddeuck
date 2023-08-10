<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Header</title>

	<!-- css -->
<link rel="stylesheet" href="path/to/normalize.css">
<link rel="stylesheet" href="path/to/your-custom-styles.css">	
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- sockjs -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

    <style>
    /* 알림 css */
    #msgStack{
	width: 280px;
	right: 10px;
	bottom: 10px;
	position: fixed;
	z-index: 9999;
	}
	
	.toast{
		cursor: pointer;
	}
	
	/* 아이콘의 스타일링 */
	.bi-bell {
	  width: 28px;
	  height: 28px;
	  fill: currentColor;
	}
	
	/* 배지의 스타일링 */
	#newNotificationCount {
	  position: relative; 
	  top: -10px; 
	  right: 19px; 
	  z-index: 100; 
	  background-color: red; 
	  color: white; 
	  padding: 4px 8px; 
	  border-radius: 50%; 
	}

	
	/* 종 모양 아이콘 크기 설정 */
	.nav-link svg {
		font-size: 1.7em;
		fill: #ff9300; 
	 	position: relative; 
  		display: inline-block;
	}

    
      .navbar-nav.left,
      .navbar-brand{
        display: flex;
        align-items: center; 
        padding-left: 70px; 
      }

      .navbar-nav.right {
        display: flex;
        align-items: center; 
        padding-right: 70px; 
      }

      @media (max-width: 767px) {
        .navbar-nav.left,
        .navbar-nav.right {
          display: none; 
        }

        .navbar-toggler {
          margin-right: 15px; 
        }

        .navbar-nav.mobile {
          display: flex;
          flex-direction: column;
          padding-left: 15px; 
        }

        .navbar-collapse.show .navbar-nav.mobile {
          display: flex;
        }

        .navbar-toggler {
          position: absolute;
          right: 15px;
          top: 5px;
        }
        
        .banner {
          display: none; 
        }

        .navbar {
          padding-top: 70px;
        }

        .container {
          padding-top: 80px; 
        }
      }
      
     .form-inline .form-control {
        width: 300px;
        min-width: 500px;
        max-width: 500px;
    }
    
   .navbar {
    justify-content: space-between;
    position: relative;
    left: 0; 
  	}
      
    </style>
    
  
    <script>
	//전역변수 설정
	var socket = null;
	var member_id = "${sessionScope.sId}";
	var member_idx = "${sessionScope.sIdx}";
	
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
	
	//로그아웃
	function logout() {
		let isLogout = confirm("로그아웃 하시겠습니까?");
		if(isLogout) { location.href = "LogOut"; }
	}
		
	// 나가기
// 	function exit() {
		
// 		let exit = confirm("정말 나가시겠습니까?");
// 		if(exit) { location.href = "./"; }
		
// 	}
	
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
    
</head>
<body>
<div id="msgStack"></div>

<!-- <div class="container"> -->

  <!-- 배너 -->

  <nav class="navbar navbar-expand-lg navbar-light bg-light rounded fixed-top">
    <a class="navbar-brand" href ='<c:url value="/" />'>LOGO</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExample09">

      <!-- 데스크 -->
      <ul class="navbar-nav left">
        <li class="nav-item">
          <a class="nav-link me-4" href="fundingExpected?category=all">오픈예정</a>
        </li>
        <li class="nav-item">
          <a class="nav-link me-4" href="fundingDiscover?category=all&status=all&index=newest">펀딩+</a>
        </li>
        <li class="nav-item">
          <a class="nav-link me-4" href="helpInquiryForm">고객센터</a>
        </li>
        <li class="nav-item">
          <a class="nav-link me-4" href ="memberideacommunity" >커뮤니티</a>
        </li>
      </ul>

      <!-- 모바일 환경-->
      <ul class="navbar-nav mobile">
      	<div class="d-flex flex-row align-items-center" style="margin-left: 250px;">
        
        	<c:choose>
        	
        		<%-- 세션아이디가 admin 일 때 --%>
        		<c:when test="${sessionScope.sId eq 'admin'}">
        		
		            <a class="nav-link  me-6" href="admin"><b>${sessionScope.sId}님</b></a>
<!-- 		            <a class="nav-link  me-6" href="javascript:exit()">나가기</a> -->
		            <a class="nav-link  me-6" href="javascript:logout()">로그아웃</a>
		            
            	 	<%-- 비행기 아이콘 - 메시지 전송용 --%>
		            <a class="nav-link py-0 me-6" href="#" data-bs-toggle="modal" data-bs-target="#notifyModal">
		               <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-send-check-fill" viewBox="0 0 16 16">
						  <path d="M15.964.686a.5.5 0 0 0-.65-.65L.767 5.855H.766l-.452.18a.5.5 0 0 0-.082.887l.41.26.001.002 4.995 3.178 1.59 2.498C8 14 8 13 8 12.5a4.5 4.5 0 0 1 5.026-4.47L15.964.686Zm-1.833 1.89L6.637 10.07l-.215-.338a.5.5 0 0 0-.154-.154l-.338-.215 7.494-7.494 1.178-.471-.47 1.178Z"/>
						  <path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Zm-1.993-1.679a.5.5 0 0 0-.686.172l-1.17 1.95-.547-.547a.5.5 0 0 0-.708.708l.774.773a.75.75 0 0 0 1.174-.144l1.335-2.226a.5.5 0 0 0-.172-.686Z"/>
						</svg>
		            </a>
		            
		            <%-- 종 아이콘 - 받은 메시지함 --%>
		            <a class="nav-link py-0 me-6" href="confirmNotification">
			            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
					  		<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
						</svg>
		           	</a>
		            <span id="newNotificationCount" class="badge bg-danger rounded-pill">1</span>
        		</c:when>
        		
        		<%-- 세션아이디가 admin이 아니고, 세션아이디가 존재 할 때 --%>
        		<c:when test="${sessionScope.sId != 'admin' && not empty sessionScope.sId}">
		            <a class="nav-link me-4" href="memberMypage"><b>${sessionScope.sId}님</b></a>
<!-- 		            <a class="nav-link me-4" href="javascript:exit()">나가기</a> -->
        		    <a class="nav-link me-4" href="javascript:logout()">로그아웃</a>
        		    
        		    <%-- 종 아이콘 - 받은 메시지함 --%>
		            <a class="nav-link py-0" href="confirmNotification">
			            <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
					  		<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
						</svg>
		           	</a>
		            <span id="newNotificationCount" class="badge bg-danger rounded-pill">1</span>
        		</c:when>
        		
        		<c:otherwise>
        			<a class="nav-link me-4" href="LoginForm">로그인</a>
        		</c:otherwise>
        		
        	</c:choose>
            
     		    <li class="nav-item">
		          <a class="nav-link me-4" href="projectManagement">프로젝트 생성</a>
		        </li>
        </div>
      </ul>

	<div style="display: flex; justify-content: center;">
	  <form class="form-inline my-2 my-md-0" action="fundingSearchKeyword?searchKeyword=${param.searchKeyword }&status=all&index=newest" method="get">
	    <input class="form-control" type="text" placeholder="프로젝트를 검색하세요!" aria-label="Search" name="searchKeyword" id="searchKeyword" value="${searchKeyword}" required="required">
	  </form>
      </div>

      </div>
  
  </nav>
<!-- </div> -->


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
<div class="modal fade" id="notifyModal" tabindex="-1" role="dialog" aria-labelledby="notifyModalLabel" style="display: none;" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
       <div class="modal-content border-0">
           <div class="modal-header bg-primary text-white">
               <h5 class="modal-title text-white">메시지 보내기</h5>
           </div>
           <div class="modal-body">
               <div class="notes-box">
                   <div class="notes-content">
                       <form id="sendMessageForm">
                           <div class="col-md-12 mb-3">
                               <div class="ideatitle">
                                   <label>제목</label>
								   <input id="message_subject" type="text" class="form-control" placeholder="제목을 입력하세요">
                               </div>
                           </div>
                           
                           <div class="col-md-12 mb-3">
                               <div class="ideatitle">
                                   <label>ID</label>
								   <input id="message_receiver" type="text" class="form-control" placeholder="아이디를 입력하세요">
                               </div>
                           </div>

                           <div class="col-md-12">
                               <div class="ideadescription">
                                   <label>내용</label>
                                   <textarea id="message_content" class="form-control" placeholder="내용을 입력하세요" rows="3"></textarea>
                               </div>
                           </div>
                        </form>
                     	<div class="modal-footer">
	                        <button id="notifySendBtn" class="btn btn-primary">전송</button>
	                        <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>

</html>
