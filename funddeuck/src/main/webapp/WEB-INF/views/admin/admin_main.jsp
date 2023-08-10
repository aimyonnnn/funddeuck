<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Admin</title>
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1">
	<!--bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jquery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- line-awesome -->
	<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
	<!-- css -->
	<link href="${pageContext.request.contextPath}/resources/css/adminDetail.css" rel="stylesheet" type="text/css"/>
	<link rel="shortcut icon" href="#">
</head>
<body>
<!-- side include -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<div class="main-content">
	<!-- top include -->
	<jsp:include page="../common/admin_top.jsp" />

	<main>
		<div class="page-header">
			<div>
				<h2 class="fw-bold mt-2">관리자 페이지</h2>
				<p class="projectContent">프로젝트 관리 및 데이터 수정을 할 수 있습니다.</p>
			</div>
		</div>

		<div class="cards">
			<div class="card-single">
				<div class="card-flex">
					<div class="card-into">
						<div class="card-head">
							<span>MEMBER</span> <small>총 회원 수</small>
						</div>

						<h2>${totalMembersCount}명</h2>
						<small><a style="color: red;">활동 정지된 회원을 포함한</a> 총 회원
							수입니다.</small>
					</div>
					<div class="card-chart danger">
						<span class="las la-chart-line"></span>
					</div>
				</div>
			</div>

			<div class="card-single">
				<div class="card-flex">
					<div class="card-into">
						<div class="card-head">
							<span>Project</span> <small>총 프로젝트 수</small>
						</div>

						<h2>${totalProjectCount}개</h2>

						<small>현재 등록된 총 프로젝트 수입니다.</small>
					</div>
					<div class="card-chart success">
						<span class="las la-chart-line"></span>
					</div>
				</div>
			</div>

			<div class="card-single">
				<div class="card-flex">
					<div class="card-into">
						<div class="card-head">
							<span>SUPPORTER</span> <small>오늘 등록된 서포터 수</small>
						</div>

						<h2>${todaySupporterCount}명</h2>

						<small><a style="color: red;">취소된 서포터를 포함한</a> 총 서포터
							수입니다.</small>
					</div>
					<div class="card-chart yellow">
						<span class="las la-chart-line"></span>
					</div>
				</div>
			</div>
		</div>

		<div class="jobs-grid">
			<div class="analytics-card">
				<div class="analytics-head">
					<h3>오늘 가입한 회원 수</h3>
				</div>

				<form method="post" class="analytics-chart">
					<div class="chart-circle">
						<h1>${todayMembersCount }명</h1>
					</div>
					<small>회원가입일이<a style="color: blue;"> 오늘</a>인 회원수를 카운팅합니다.
					</small>
				</form>
			</div>

			<div class="jobs">
				<h3>최근 프로젝트</h3>
				<small>
					<a href="adminProjectManagement">전체 프로젝트 확인하기</a>
					<span class="las la-arrow-right"></span>
				</small>
				
				<div class="table-responsive">
					
					<table class="table text-center">
						<tr>
							<th style="width: 5%">번호</th>
							<th style="width: 10%">카테고리</th>
							<th style="width: 15%">프로젝트명</th>
							<th style="width: 7%">대표자명</th>
							<th style="width: 15%">프로젝트 기간</th>
						</tr>
						<c:forEach var="pList" items="${pList}">
							<tr>
								<td>${pList.project_idx}</td>
								<td>${pList.project_category}</td>
								<td>${pList.project_subject}</td>
								<td>${pList.project_representative_name}</td>
								<td>${pList.project_start_date}~${pList.project_end_date}</td>
							</tr>
						</c:forEach>
					</table>
					<!--  -->
					
				</div>
			</div>
		</div>
	</main>
</div>

<label for="sidebar-toggle" class="body-label"></label>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>