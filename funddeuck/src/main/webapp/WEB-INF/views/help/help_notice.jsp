<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀뜩 공지 사항</title>
	<!-- 공용 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

</head>
<body>
    <!-- 헤더  -->
		<jsp:include page="../Header.jsp"></jsp:include>
    <div class="container text-center mb-4">
    	<p>
    		&nbsp;&nbsp;<br>
    		&nbsp;&nbsp;<br>
    	</p>
    </div>
    <div class="container text-center">
    	<div class="row p-2 mt-3">
	        <span class="fs-1 fw-bold">공지 사항</span>
    	</div>
    </div>
    <div class="container text-center">
		<ul class="nav justify-content-center">
			<li class="nav-item">
				<a class="nav-link active" aria-current="page" href="#">전체</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">공지</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">이벤트</a>
			</li>
			<li class="nav-item">
				<a class="nav-link disabled" aria-disabled="true">서버 점검 안내</a>
			</li>
		</ul>    	
    </div>
    <div class="container text-center ml-10 mr-10">
		 <div class="list-group">
			<a href="#" class="list-group-item list-group-item-action active" aria-current="true">
				<div class="d-flex justify-content-between">
					<small>공지</small>
					<small>2023-08-13</small>
				</div>
				<img src="..." class="rounded float-end" alt="썸네일" width="100" height="100">
				<h5 class="text-start align-content-center">공지사항 제목1</h5>
			</a>
			<a href="#" class="list-group-item list-group-item-action">
				<div class="d-flex justify-content-between">
					<small>이벤트</small>
					<small>2023-08-13</small>
				</div>
				<h5 class="mb-1">이벤트 제목1</h5>
				<small>And some small print.</small>
			</a>
		</div>   
    </div>
</body>
</html>