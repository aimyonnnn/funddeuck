<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펀딩</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/> --%>
<!-- header include -->
<jsp:include page="../common/main_header.jsp"></jsp:include>
<!-- 결제 연동 스크립트 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/payment.js"></script>
</head>
<body>
	<!--네비게이션 바 -->
	<!-- color: inherit; 사용시 a태그 파란색 사라짐 -->
<!-- 	<div class="container text-center"> -->
<!-- 	  <ul class="nav nav-tabs bg-white fixed-top"> -->
<!-- 	    <li class="nav-item"> -->
<!-- 	      <a class="nav-link active" aria-current="page" href="#" style="text-decoration: none;">Active</a> -->
<!-- 	      <div class="progress" style="height: 1px;"> -->
<!-- 	        <div class="progress-bar" role="progressbar" aria-label="Example 1px high" style="width: 100%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div> -->
<!-- 	      </div> -->
<!-- 	    </li> -->
<!-- 	    <li class="nav-item"> -->
<!-- 	      <a class="nav-link" href="#" style="text-decoration: none; color: inherit;">프로젝트 계획</a> -->
<!-- 	    </li> -->
<!-- 	    <li class="nav-item"> -->
<!-- 	      <a class="nav-link" href="#" style="text-decoration: none; color: inherit;">업데이트</a> -->
<!-- 	    </li> -->
<!-- 	    <li class="nav-item"> -->
<!-- 	      <a class="nav-link disabled">커뮤니티</a> -->
<!-- 	    </li> -->
<!-- 	  </ul> -->
<!-- 	</div> -->
	<!--네비게이션 바 끝 -->
	<br>
	<hr>
	<br>
	<!-- 상단 영역 -->
	<div class="container text-center">
		<!-- 해시태그 -->
		<div class="col">
			<a class="btn btn-outline-secondary btn-sm bg-secondary bg-opacity-10 text-dark-emphasis fw-bold border border-success border-opacity-10" href="#" role="button">해시태그</a>
			<br><br>
			<div class="col">
				<p class="fs-2 fw-bolder">펀딩 이름</p>
			</div>
		</div>
		<!-- 펀딩이름 -->
	
		<!-- 이미지, 펀딩 진행상태, 기본정보-->
		<div class="row p-5">
			<!--펀딩 이미지 슬라이드-->
			<div class="col-12 col-lg-6">
			  <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
			    <div class="carousel-indicators">
			      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
			      <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
			    </div>
			    <div class="carousel-inner">
			      <div class="carousel-item active">
			        <img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" class="d-block w-100" alt="...">
			      </div>
			      <div class="carousel-item">
			        <img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/a397a6ce-95bb-4a70-b7c1-039614ca4856.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=43dd7aafe0b498502d2c5ef6fb92122d" class="d-block w-100" alt="...">
			      </div>
			      <div class="carousel-item">
			        <img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/98a2d25a-dbc6-4fff-8493-5d7270bc63bf.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=94c401adb61acad990a9dfe06dfc12dd" class="d-block w-100" alt="...">
			      </div>
			    </div>
			    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			      <span class="visually-hidden">Previous</span>
			    </button>
			    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			      <span class="carousel-control-next-icon" aria-hidden="true"></span>
			      <span class="visually-hidden">Next</span>
			    </button>
			  </div>
			</div>
			<!--펀딩 이미지 슬라이드 끝-->
			<!--펀딩 진행 상태, 기본정보-->
			<div class="col-13 col-lg-6 text-start ps-5">
				<!--펀딩 진행 상태 출력-->
				<div class="row">
					<small>모인금액</small>
				</div>
				<div class="row">
					<div class="col">
						<span class="fs-2">2,259,000</span>&nbsp;
						<small>원</small>&nbsp;
						<span class="fs-5 fw-bold">112%</span>
					</div>
				</div>
				<br>
				<div class="row">
					<small>남은시간</small>
				</div>
				<div class="row">
					<div class="col">
						<span class="fs-2">24</span>&nbsp;
				  		<small>일</small>&nbsp;&nbsp;
					</div>
				</div>
				<br>
				<div class="row">
					<small>후원자</small>
				</div>
				<div class="row">
					<div class="col">
				  		<span class="fs-2">82</span>&nbsp;
				  		<small>명</small>&nbsp;
					</div>
				</div>
				<div class="row">
					<div class="col">
						<div class="progress">
							<div class="progress-bar bg-primary" role="progressbar" aria-label="Example with label" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
						</div>
					</div>
				</div>
				<!--펀딩 진행 상태 출력 끝-->
			
				 <hr>
				 <!-- 펀딩 기본 정보-->
				<table class="table-borderless">
					<tr>
				 		<th>목표금액</th>
				    	<td class="ps-3">xxxxx원</td>
				 	</tr>
				 	<tr>
				   		<th>펀딩 기간</th>
				   		<td class="ps-3">2023.07.12~ 2023.08.17</td>
				 	</tr>
				 	<tr>
						<th>결제</th>
						<td class="ps-3">목표 금액 달성시 2023.07.xx일에 결제</td>
				 	</tr>
				</table>
				 <!-- 펀딩 기본 정보 끝 -->
				<!--공유, 좋아요, 후원하기 버튼-->
				<!--화면크키 작을 때 가장 아래로 이동 -->
				<div class="row border border-warning bg-white d-lg-none fixed-bottom">
					<div class="col-12 col-lg-auto d-flex justify-content-center">
						<!-- 공유 -->
						<button class="btn btn-primary me-2">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-share" viewBox="0 0 16 16">
							  <path d="M13.5 1a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zM11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.499 2.499 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5zm-8.5 4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zm11 5.5a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3z"/>
							</svg>
						</button>
						<!-- 좋아요 -->
						<button class="btn btn-primary me-2">
							<!-- 빈 하트 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
							  <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
							</svg>
							<!-- 채워진 하트 -->
<!-- 							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"> -->
<!-- 							  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/> -->
<!-- 							</svg> -->
						</button>
						<button class="btn btn-primary me-2" onclick="request_pay()">이 프로젝트 후원하기</button>
					</div>
				</div>
				<!-- 공유, 좋아요, 후원하기 버튼 -->
				<!-- 화면크기 lg 일 때-->
				<div class="row border border-warning d-none d-lg-block">
					<div class="col-12 col-lg-auto d-flex justify-content-center">
						<!-- 공유 -->
						<button class="btn btn-primary me-2">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-share" viewBox="0 0 16 16">
							  <path d="M13.5 1a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zM11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.499 2.499 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5zm-8.5 4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zm11 5.5a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3z"/>
							</svg>
						</button>
						<!-- 좋아요 -->
						<button class="btn btn-primary me-2">
							<!-- 빈 하트 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
							  <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
							</svg>
							<!-- 채워진 하트 -->
<!-- 							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"> -->
<!-- 							  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/> -->
<!-- 							</svg> -->
						</button>
						<button class="btn btn-primary me-2" onclick="request_pay()">이 프로젝트 후원하기</button>
					</div>
				</div>
				<!--공유, 좋아요, 후원하기 버튼 끝-->
			</div>
			<!--펀딩 진행 상태, 기본정보 끝-->  
			<!-- 메이커 프로필 바-->
			<!-- 화면 작을 때 -->
			<div class="col-12 d-lg-none p-3 border border-primary">
				<!--메이커 프로필 영역-->
				<div class="row text-start p-3">
					<span class="fs-5 fw-bold">메이커 프로필</span>
				</div>
				<div class="row">
					<!-- 프로필 이미지 -->
					<div class="col-2">
					<!-- 프로필 클릭시 메이커 새탭 이동-->
						<a href="#" target="_blank">
							<img src="https://cdn-icons-png.flaticon.com/512/3135/3135707.png" class="rounded-circle" alt="..." width="40px" height="40px">
						</a>
					</div>
					<!-- 메이커명-->
					<div class="col text-start p-2">
						<span class="fs-5 fw-bold p-3">xxx메이커</span>
						<span class="fs-6 text-muted">xx시간 전 로그인</span>
					</div>
				</div>
				<!-- 팔로우, 1:1문의 버튼-->
				<div class="row">
					<div class="col d-flex justify-content-center">
						<button class="btn btn-primary me-2">팔로우</button>
						<button class="btn btn-primary me-2">1:1문의</button>
					</div>
				</div>
      			<!-- 팔로우, 1:1문의 버튼 끝-->
			</div>
			<!--메이커 프로필 영역 끝-->
			<!--화면 작을 때 -->
		  </div>
	<!-- 이미지, 펀딩 진행상태, 기본정보 끝-->          
	</div>
	<!-- 상단 영역 끝-->
	<hr>
	<!--내용 영역-->
	<div class="container text-center">
		<div class="row">
			<!-- 바뀌는 페이지 -->
			<div class="col border border-warning">
				<h1>프로젝트 내용</h1>
				<h1>프로젝트 내용</h1>
				<h1>프로젝트 내용</h1>
				<h1>프로젝트 내용</h1>
			</div>
			<!-- 메이커 프로필, 리워드 선택 바-->
			<!-- 화면 클때 -->
			<div class="col-4 d-none d-lg-block">
				<!--메이커 프로필 영역-->
				<div class="row p-3 border border-primary">
					<div class="row text-start pb-3">
						<span class="fs-5 fw-bold">메이커 프로필</span>
					</div>
					<div class="row">
						<!-- 프로필 이미지 -->
						<div class="col-lg-2">
						<!-- 프로필 클릭시 메이커 새탭 이동-->
							<a href="#" target="_blank">
								<img src="https://cdn-icons-png.flaticon.com/512/3135/3135707.png" class="rounded-circle" alt="..." width="40px" height="40px">
							</a>
						</div>
						<!-- 메이커명-->
						<div class="col text-lg-start p-2">
							<span class="fs-5 fw-bold p-3">xxx메이커</span> <br>
							&nbsp;&nbsp;<span class="fs-6 text-muted">xx시간 전 로그인</span>
						</div>
					</div>
					<!-- 팔로우, 1:1문의 버튼-->
					<div class="row">
						<div class="col d-flex justify-content-center">
							<button class="btn btn-primary me-2">팔로우</button>
							<button class="btn btn-primary me-2">1:1문의</button>
						</div>
					</div>
	      			<!-- 팔로우, 1:1문의 버튼 끝-->
				</div>
				<!--메이커 프로필 영역 끝-->
				<!-- 리워드 선택 바-->
				<!--스크롤-->
				<div class="row p-3 border border-success" style="overflow:auto;">
					<div class="row text-start pb-3">
						<span class="fs-5 fw-bold">리워드 선택</span>
					</div>
					<div class="row pb-3 d-flex justify-content-center">
						<div class="card" style="width: 18rem;">
							<div class="card-body">
								<h4 class="card-title">리워드명</h4>
								<h4 class="card-title">XXXX원</h4>
								<h6 class="card-subtitle mb-2 text-muted">xx명이 선택</h6>
								<p class="card-text">
									- 옵션1
									- 옵션2
								</p>
							</div>
						</div>
					</div>
					<div class="row pb-3 d-flex justify-content-center">
						<div class="card" style="width: 18rem;">
							<div class="card-body">
								<h4 class="card-title">리워드명2</h4>
								<h4 class="card-title">XXXX원</h4>
								<h6 class="card-subtitle mb-2 text-muted">xx명이 선택</h6>
								<p class="card-text">
									- 옵션1
									- 옵션2
								</p>
							</div>
						</div>
					</div>
				</div>
				<!-- 리워드 선택 바 끝-->
	
			</div>
		</div>
		<!-- 메이커 프로필, 리워드 선택 바 끝-->
	
	
		<div class="row">
	
		</div>
	</div>
	<!--내용 영역 끝--> 

	<!-- 부트스트랩 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>