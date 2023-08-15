<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="container text-center">
    	<div class="row p-2 mt-3">
	        <span class="fs-1 fw-bold">공지 사항</span>
    	</div>
    </div>
    <div class="container text-center">
		<ul class="nav justify-content-center">
			<li class="nav-item">
				<a class="nav-link text-primary" aria-current="page" href="helpNotice">전체</a>
			</li>
			<li class="nav-item">
				<a class="nav-link text-primary" href="helpNoticeCategory?notice_category=1">공지</a>
			</li>
			<li class="nav-item">
				<a class="nav-link text-primary" href="helpNoticeCategory?notice_category=2">이벤트</a>
			</li>
			<li class="nav-item">
				<a class="nav-link text-primary" href="helpNoticeCategory?notice_category=3">서버 점검 안내</a>
			</li>
		</ul>    	
    </div>
</body>
</html>