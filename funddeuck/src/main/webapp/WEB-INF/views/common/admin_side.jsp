<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Admin Page</title>
</head>
<body>
<div class="sidebar">
	<div class="sidebar-main">
	
<!-- 		<div class="sidebar-user"> -->
<%-- 			<img src="${pageContext.request.contextPath}/resources/images/adminProfile.png" onclick="location.href='admin'"> --%>
<!-- 			<div> -->
<!-- 				<span>Admin</span> -->
<!-- 			</div> -->
<!-- 		</div> -->

		<div class="sidebar-menu">
			<div class="menu-head">
				<span></span>
			</div>
			<ul>
				<li><a href="./"><span class="las la-home"></span> 홈페이지</a></li>
				<li><a href="admin"><span class="las la-sync-alt"></span> 관리자 메인</a></li>
				<li><a href='https://github.com/aimyonnnn/funddeuck'><span class="lab la-github"></span> GitHub</a></li>
				<li><a href="adminChart"><span class="las la-chart-bar"></span> 데이터 분석</a></li>
			</ul>

			<div class="menu-head">
				<span>MENU</span>
			</div>
			<ul>
				<li><a href="adminMakerManagement"><span class="las la-tasks"></span> 메이커 관리</a></li>
				<li><a href="adminProjectManagement"><span class="las la-history"></span> 프로젝트 관리</a></li>
				<li><a href="adminProjectList"><span class="las la-check"></span> 승인 관리</a></li>
				<li><a href="adminPayment"><span class="las la-credit-card"></span> 결제 관리</a></li>
				<li><a href="adminMemberManagement"><span class="las la-user-circle"></span> 회원 관리</a></li>
				<li><a href="adminSmsManagement"><span class="las la-comments"></span> 문자 관리</a></li>
				<li><a href="adminCoupon"><span class="las la-percentage"></span> 쿠폰 관리</a></li>
			</ul>
			<div class="menu-head">
				<span>2 TEAM</span>
			</div>
			<ul>
				<li><a><span class="las la-crown"></span> 박수민</a></li>
				<li><a><span class="las la-laugh"></span> 김민진</a></li>
				<li><a><span class="las la-laugh"></span> 김보희</a></li>
				<li><a><span class="las la-laugh"></span> 이재승</a></li>
				<li><a><span class="las la-laugh"></span> 김묘정</a></li>
				<li><a><span class="las la-laugh"></span> 이건무</a></li>
			</ul>
		</div>
	</div>
</div>
</body>
</html>
