<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/project_top.css" rel="stylesheet" type="text/css">
<!-- jQuery -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script>
	// 로그아웃
	function logout() {
		let isLogout = confirm("정말 나가시겠습니까?");
		
		if(isLogout) {
			location.href = "./";
		}
	}
</script>
	
<!-- toast -->
<div id="msgStack"></div>

<!-- nav -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	
	<!-- container -->
	<div class="container">
  
	    <a class="navbar-brand">
	    	<img src="${pageContext.request.contextPath }/resources/images/logo.png" width="40px" height="40px">
	    </a>
	    
	    <div class="d-flex flex-row align-items-center">
		  <a class="nav-link" href="MemberInfo">${sessionScope.sId} 님</a>
		  <a class="nav-link" href="javascript:logout()">나가기</a>
		  <!-- 종 모양 알림 -->
		  <a class="nav-link py-0" href="confirmNotification">
		    <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-bell" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
		      <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2z"/>
		      <path fill-rule="evenodd" d="M8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
		    </svg>
		  </a>
		  <span id="newNotificationCount" class="badge bg-primary rounded-pill">1</span>
		</div>

	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	    	<span class="navbar-toggler-icon"></span>
	    </button>
	    
	  </div>
  	  <!-- container -->
</nav>
<!-- nav -->
