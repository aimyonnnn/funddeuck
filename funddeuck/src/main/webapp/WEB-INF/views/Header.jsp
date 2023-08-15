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
<!-- 채널톡 API 시작 -->
<script>
	(function(){var w=window;if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement("script");s.type="text/javascript";s.async=true;s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";var x=document.getElementsByTagName("script")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState==="complete"){l();}else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}})();
	  	ChannelIO('boot', {
	    "pluginKey": "1389a4f2-b052-41e3-8f07-442396576322"
  	});
</script>
<!-- 채널톡 API 끝 -->
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
		font-size: 1.5em;
		fill: #ff9300; 
	 	position: relative; 
  		display: inline-block;
	}

    
		.navbar-nav.left,
		.navbar-nav.right {
		  display: flex;
		  align-items: center;
		  padding: 5px; 
		}
		
		.navbar-brand {
		  padding-left: 50px; /* 원하는 여백 값으로 조절 */
		}
		
		/* 모바일 환경 */
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
	  display: flex;
	  justify-content: space-between;
	  align-items: center; 
	  padding: 0 10px; 
	}
	
	
	/* 검색 입력 요소에 여백 추가 */
	.form-inline {
	  margin-left: auto; 
	}
	
	.navbar-nav.right {
	  display: flex;
	  align-items: center;
	  gap: 10px;
	}
  	
  	.nav-link {
  	width: auto; 
	}
	
	/* 위로 가기 버튼 */
    #go-top {
		display: none;
        position: fixed;
        bottom: 120px;
        right: 100px;
        z-index: 99;
        border: none;
        background: none;
        padding: 0;
    }
    
	
	.nav-item {
    display: inline-block;
    vertical-align: top;
    margin-right: 10px; /* 조절해서 간격을 설정하세요 */
 	 }
 	 
	/* 모바일 환경 */
	@media (max-width: 767px) {
	    .navbar-nav.left,
	    .navbar-nav.right {
	        display: none;
	    }
	
	    .navbar-toggler {
	        margin-left: auto;
	    }
	
	    .navbar-collapse.show .navbar-nav.mobile {
	        display: flex;
	        flex-direction: column;
	        align-items: center;
	    }
	
	    .navbar-nav.mobile .nav-item {
	        width: 100%;
	        text-align: center;
	        margin-bottom: 10px;
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
	
	/* 창이 작아질 때 */
	@media (max-width: 991px) {
	    .navbar-collapse.show .navbar-nav {
	        display: flex;
	        flex-direction: column;
	        align-items: center;
	    }
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

	<!-- 위로 가기 버튼 -->
    <button id="go-top"><img src="${pageContext.request.contextPath }/resources/images/topbtn.png" style="width: 56px; height: 56px;"></button>

<nav class="navbar navbar-expand-lg navbar-light bg-light rounded fixed-top">
    <a class="navbar-brand" href='<c:url value="/" />'><img src="${pageContext.request.contextPath }/resources/images/logo.png" style="width: 90px; height: 90px;"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExample09">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link me-4" href="fundingExpected?category=all">오픈예정</a>
            </li>
            <li class="nav-item">
                <a class="nav-link me-4" href="fundingDiscover?category=all&status=all&index=newest">펀딩+</a>
            </li>
            <li class="nav-item">
                <a class="nav-link me-4" href="helpNotice">고객센터</a>
            </li>
            <li class="nav-item">
                <a class="nav-link me-4" href="memberideacommunity">커뮤니티</a>
            </li>
            <c:choose>
                <c:when test="${sessionScope.sId eq 'admin'}">
                    <!-- 비행기 아이콘 - 메시지 전송용 -->
                    <li class="nav-item">
                        <a class="nav-link py-0 me-4" href="#" data-bs-toggle="modal" data-bs-target="#notifyModal">
                            <img src="${pageContext.request.contextPath }/resources/images/icon/letter.png" style="width: 32px; height: 32px;">
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link py-0 me-6" href="confirmNotification">
                            <img src="${pageContext.request.contextPath }/resources/images/icon/bell.png" style="width: 30px; height: 30px;">
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <!-- 종 아이콘 - 받은 메시지함 -->
                    <li class="nav-item">
                        <a class="nav-link py-0 me-6" href="confirmNotification">
                            <img src="${pageContext.request.contextPath }/resources/images/icon/bell.png" style="width: 30px; height: 30px;">
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
            <li class="nav-item">
                <span id="newNotificationCount" class="badge bg-danger rounded-pill">1</span>
            </li>
		    <c:choose>
		        <c:when test="${sessionScope.sId eq 'admin'}">
		            <li class="nav-item">
		                    <a class="nav-link me-4" href="admin"><b>${sessionScope.sId}님</b></a>
		            </li>
		            <li class="nav-item">        
		                    <a class="nav-link me-4" href="javascript:logout()">로그아웃</a>
		            </li>
		        </c:when>
		        <c:when test="${sessionScope.sId != 'admin' && not empty sessionScope.sId}">
		            <!-- Other navigation items -->
		            <li class="nav-item">
		                    <a class="nav-link me-4" href="memberMypage"><b>${sessionScope.sId}님</b></a>
		            </li>
		            <li class="nav-item">        
		                    <a class="nav-link me-4" href="javascript:logout()">로그아웃</a>
		            </li>
		        </c:when>
		        <c:otherwise>
		            <li class="nav-item">
		                <a class="nav-link me-4" href="LoginForm">로그인</a>
		            </li>
		        </c:otherwise>
		    </c:choose>
		    <li class="nav-item">
		        <a class="nav-link me-4" href="projectManagement">프로젝트 생성</a>
		    </li>
		</ul>


        <form class="form-inline my-2 my-md-0" action="fundingSearchKeyword?searchKeyword=${param.searchKeyword }&status=all&index=newest" method="get">
            <input class="form-control" type="text" placeholder="프로젝트를 검색하세요!" aria-label="Search" name="searchKeyword" id="searchKeyword" value="${searchKeyword}" required="required">
        </form>
    </div>
</nav>


<script type="text/javascript">
//위로가기 버튼
var backToTop = () => {
    // Scroll | button show/hide
    window.addEventListener('scroll', () => {
        if (document.querySelector('html').scrollTop > 100) {
            document.getElementById('go-top').style.display = "block";
        } else {
            document.getElementById('go-top').style.display = "none";
        }
    });

    // back to top
    document.getElementById('go-top').addEventListener('click', () => {
        window.scroll({
            top: 0,
            left: 0,
            behavior: 'smooth'
        });
    });
};
backToTop();
// 위로 가기 버튼 끝


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
