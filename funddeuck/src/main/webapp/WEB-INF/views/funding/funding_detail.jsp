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
<!-- header include -->
<jsp:include page="../Header.jsp"></jsp:include>
<!-- 결제 연동 스크립트 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/funding_detail.css">
<!-- 카카오 공유하기 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<!-- 공용 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
</head>
<body>
<!-- 요청 파라미터 값 저장 -->
<fmt:parseDate value="${project.project_end_date }" var="projectEndDate" pattern="yyyy-MM-dd"/>
<fmt:parseNumber value="${projectEndDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
<fmt:parseDate value="${project.project_start_date }" var="projectStartDate" pattern="yyyy-MM-dd"/>
<fmt:parseNumber value="${projectStartDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
<input type="hidden" value="${param.category }" id="categoryVal">
<c:set var="currentTime" value="<%= new java.util.Date() %>" />  
	<br>
	<hr>
	<br>
	<!-- 상단 영역 -->
	<div class="container text-center">
		<!-- 해시태그 -->
		<div class="col">
			<a class="btn btn-outline-secondary btn-sm bg-secondary bg-opacity-10 text-dark-emphasis fw-bold border border-success border-opacity-10" href="" role="button" style="pointer-events: none; ">${project.project_hashtag }</a>
			<br><br>
			<div class="col">
				<p class="fs-2 fw-bolder">${project.project_subject }</p>
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
						<span class="fs-2"><fmt:formatNumber value="${project.project_cumulative_amount }" pattern="#,###" /></span>&nbsp;
						<small>원</small>&nbsp;
						<span class="fs-5 fw-bold"><fmt:formatNumber type="number" value="${project.project_cumulative_amount/project.project_target * 100 }" maxFractionDigits="0"></fmt:formatNumber>%</span>
					</div>
				</div>
				<br>
				<div class="row">
					<small>남은시간</small>
				</div>
				<div class="row">
					<div class="col">
						<!-- 프로젝트가 아직 진행 되지 않았을 경우 -->
						<c:if test="${project.project_status eq 1}">
							<span class="fs-2 text-danger fw-bold">
								미진행
							</span>
						</c:if>
						<!-- 프로젝트가 진행중인 경우 -->
						<c:if test="${project.project_status eq 2 && endDate - strDate ne 0}">
							<span class="fs-2">
								${endDate - strDate }
							</span>&nbsp;
				  			<small>일</small>&nbsp;&nbsp;
						</c:if>
						<!-- 프로젝트가 진행중이지만 종료가 임박한 프로젝트(남은 일자가 없을 경우) -->
						<c:if test="${project.project_status eq 2 && endDate - strDate eq 0}">
						<span class="fs-2 text-danger fw-bold">
							오늘 종료
						</span>&nbsp;
						</c:if>
						<!-- 종료된 프로젝트인 경우 -->
						<c:if test="${project.project_status eq 3 || project.project_status eq 4 || project.project_status eq 5}">
						<span class="fs-2 text-danger fw-bold">
							종료된 프로젝트
						</span>&nbsp;
						</c:if>
					</div>
				</div>
				<br>
				<div class="row">
					<small>후원자</small>
				</div>
				<div class="row">
					<div class="col">
				  		<span class="fs-2">${supTotal }</span>&nbsp;
				  		<small>명</small>&nbsp;
					</div>
				</div>
				<!--펀딩 진행 상태 출력 끝-->
			
				 <hr>
				 <!-- 펀딩 기본 정보-->
				<table class="table-borderless">
					<tr>
				 		<th><small>목표금액</small></th>
				 		<td>&nbsp;&nbsp;&nbsp;</td>
				    	<td><small>
				    	<fmt:formatNumber value="${project.project_target }" pattern="#,###" />원</small></td>
				 	</tr>
				</table>
				<div class="row">
					<div class="col">
						<div class="progress">
							<div class="progress-bar bg-success" id="progressbar" role="progressbar" aria-label="Example with label" 
		  					style="width: ${project.project_cumulative_amount/project.project_target * 100}%" 
							aria-valuenow="${project.project_cumulative_amount/project.project_target * 100 }" aria-valuemin="0" aria-valuemax="100">${project.project_cumulative_amount/project.project_target * 100 }%</div>
						</div>
					</div>
					</div>
				<br>
				<table class="table-borderless">
				 	<tr>
				   		<th><small>펀딩 기간</small></th>
				   		<td></td>
				   		<!-- 아직 진행되지 않은 프로젝트의 경우 -->
				   		<c:if test="${project.project_status eq 1 }">
					   		<td><small>
					   		${project.project_start_date }
					   		~
					   		${project.project_end_date }
					   		</small>&nbsp;&nbsp;&nbsp;
					   		<span class="badge text-danger text-bg-danger bg-opacity-10">
					   		미진행
					   		</span>
					   		</td>
				   		</c:if>
				   		<!-- 프로젝트가 진행중이며, 아직 진행일이 남아있을 경우 -->
				   		<c:if test="${project.project_status eq 2 && endDate - strDate ne 0 }">
					   		<td><small>
					   		${project.project_start_date }
					   		~
					   		${project.project_end_date }
					   		</small>&nbsp;&nbsp;&nbsp;
					   		<span class="badge text-danger text-bg-danger bg-opacity-10">
					   		${endDate - strDate } 일 남음
					   		</span>
					   		</td>
				   		</c:if>
				   		<!-- 프로젝트가 진행중이지만, 오늘 종료될 경우 -->
				   		<c:if test="${project.project_status eq 2 && endDate - strDate eq 0 }">
					   		<td><small>
					   		${project.project_start_date }
					   		~
					   		${project.project_end_date }
					   		</small>&nbsp;&nbsp;&nbsp;
					   		<span class="badge text-danger text-bg-danger bg-opacity-10">
					   		오늘 종료
					   		</span>
					   		</td>
				   		</c:if>
				   		<!-- 이미 종료된 프로젝트의 경우 -->
				   		<c:if test="${project.project_status eq 3 || project.project_status eq 4 || project.project_status eq 5 }">
					   		<td><small>
					   		${project.project_start_date }
					   		~
					   		${project.project_end_date }
					   		</small>&nbsp;&nbsp;&nbsp;
					   		<span class="badge text-danger text-bg-danger bg-opacity-10">
					   		종료됨
					   		</span>
					   		</td>
				   		</c:if>
				 	</tr>
				 	<tr>
						<th><small>결제</small></th>
						<td>&nbsp;&nbsp;&nbsp;</td>
						<td><small>목표 금액 달성시 
						${project.project_end_date }에 결제 진행</small></td>
				 	</tr>
				</table>
				</div>
				<br>
				<br>
				 <!-- 펀딩 기본 정보 끝 -->
				<!--공유, 좋아요, 후원하기 버튼-->
				<!--화면크키 작을 때 가장 아래로 이동 -->
				<div class="row border border-warning bg-white d-lg-none fixed-bottom">
					<div class="col-12 col-lg-auto d-flex justify-content-center">
						<!-- 공유 -->
						<button class="btn btn-primary me-2" id="btnKakao">
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
						<button class="btn btn-primary me-2" onclick="focusOnReward()">이 프로젝트 후원하기</button>
					</div>
				</div>
				<!-- 공유, 좋아요, 후원하기 버튼 -->
				<!-- 화면크기 lg 일 때-->
				<div class="row d-none d-lg-block" id="focusArea">
					<div class="col-12 col-lg-auto d-flex justify-content-end">
						<!-- 공유 -->
						<button class="btn btn-primary me-2 bg-white border border-secondary border-opacity-25 rounded-0" id="kakao-link-btn" onclick="javascript:kakaoShare()">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="secondary" class="bi bi-share" viewBox="0 0 16 16">
							  <path d="M13.5 1a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zM11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.499 2.499 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5zm-8.5 4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3zm11 5.5a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3z"/>
							</svg>
							<small class="text-secondary"><br>공유</small>
						</button>
						<!-- 좋아요 -->
						<button class="btn btn-primary me-2 bg-white border border-secondary border-opacity-25 rounded-0" onclick="location.href='ZimForm'">
							<!-- 빈 하트 -->
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="secondary" class="bi bi-heart" viewBox="0 0 16 16">
							  <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
							</svg>
							<!-- 채워진 하트 -->
<!-- 							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"> -->
<!-- 							  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/> -->
<!-- 							</svg> -->
							<small class="text-secondary"><br>찜</small>
						</button>
						<button class="btn btn-success me-8" onclick="focusOnReward()"><span class="text-center text-white fw-bold">이 프로젝트 후원하기</span></button>
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
						<span class="fs-5 fw-bold p-3">${project.project_representative_name }</span>
					</div>
				</div>
				<!-- 팔로우, 1:1문의 버튼-->
				<div class="row">
					<div class="col d-flex justify-content-center">
						<button class="btn btn-primary me-2" onclick="FallowingForm">팔로우</button>
						<button class="btn btn-primary me-2" onclick="projectInquiry()">1:1문의</button>
					</div>
				</div>
      			<!-- 팔로우, 1:1문의 버튼 끝-->
			</div>
			<!--메이커 프로필 영역 끝-->
			<!--화면 작을 때 -->
		  </div>
	<!-- 이미지, 펀딩 진행상태, 기본정보 끝-->          
	<!-- 상단 영역 끝-->
	<hr>
	<!--내용 영역-->
	<div class="container text-center">
		<div class="row">
			<!-- 바뀌는 페이지 -->
			<div class="col">
<!-- 		네비게이션 바 -->
		<div class="container text-center">
		  <ul class="nav nav-tabs bg-white">
		    <li class="nav-item 
				<c:if test="${param.category eq 'introduce' or param.category eq null}">border-dark border-bottom border-4</c:if>">
				<a class="text-dark nav-link text-decoration-none border border-0 fw-bold
				<c:if test="${param.category ne 'introduce'}">text-opacity-50</c:if>" aria-current="page" href="fundingDetail?project_idx=${param.project_idx }&category=introduce">프로젝트 소개</a>
		    </li>
		    <li class="nav-item 
				<c:if test="${param.category eq 'update'}">border-dark border-bottom border-4</c:if>">
				<a class="text-dark nav-link text-decoration-none border border-0 fw-bold
				<c:if test="${param.category ne 'update'}">text-opacity-50</c:if>" href="fundingDetail?project_idx=${param.project_idx }&category=update">업데이트</a>
		    </li>
		    <li class="nav-item 
				<c:if test="${param.category eq 'community'}">border-dark border-bottom border-4</c:if>">
				<a class="text-dark nav-link text-decoration-none border border-0 fw-bold 
				<c:if test="${param.category ne 'community'}">text-opacity-50</c:if>" href="fundingDetail?project_idx=${param.project_idx }&category=community">커뮤니티</a>
		    </li>
		  </ul>
		</div>	
		<br>
<!-- 		네비게이션 바 끝 -->
		<div class="container text-center">
			<div class="row">
				<!-- 카테고리 - 프로젝트 소개 선택 시 출력 -->
				<c:if test="${param.category eq 'introduce' or param.category eq null}">
				<div class="col">
					<article>
						<p class="text-justify">${project.project_introduce }</p>
					</article>
				</div>
				</c:if>
				<!-- 카테고리 - 업데이트 선택 시 게시물이 있을 경우 출력  -->
				<c:if test="${param.category eq 'update' && not empty makerBoard}">
					<div class="accordion">
						<c:forEach items="${makerBoard }" var="makerBoard" varStatus="status">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse${makerBoard.maker_board_idx }" aria-expanded="false" aria-controls="collapse${makerBoard.maker_board_idx }">
							<span class="text-dark text-decoration-none">
								<fmt:formatDate value="${makerBoard.maker_board_regdate }" pattern="yyyy.MM.dd"/>
							</span>&nbsp;&nbsp;&nbsp;
								<span class="text-dark text-decoration-none fw-bold">${makerBoard.maker_board_subject }</span>
								</button>
							</h2>
							<div id="collapse${makerBoard.maker_board_idx }" class="accordion-collapse collapse show">
								<div class="accordion-body">
									<p class="text-start">${makerBoard.maker_board_content }</p>
								</div>
							</div>
						</div>
					</c:forEach>
					</div>
				</c:if>
				<!-- 카테고리 - 업데이트 선택 시 게시물이 없을 경우 "게시물이 없습니다" 출력 -->
				<c:if test="${param.category eq 'update' && empty makerBoard}">
				<div class="col">
					<article>
						<h3>
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
						<path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/></svg>
						게시물이 없습니다</h3>
					</article>
				</div>
				</c:if>
				<!-- 카테고리 - 커뮤니티 선택 시 게시물 작성 폼 추가 -->
				<!-- 미 로그인시 -->
				<c:if test="${param.category eq 'community' && empty sessionScope.sId}">
					<span class="fs-5 fw-bold text-start">응원 · 의견 · 체험리뷰<span class="fs-5 fw-bold text-start text-info">${ProjectCommunity.size() }</span></span><br>
					<small class="text-start opacity-75">회원님들이 남긴 의견입니다.</small>
					<div>&nbsp;</div>
						<div class="mb-3">
							<textarea class="form-control" disabled readonly placeholder="로그인 하셔야 의견을 작성하실 수 있습니다." rows="3"></textarea>
						</div>
					<div>&nbsp;</div>
					<div>&nbsp;</div>
				</c:if>
				<!-- 로그인시 -->
				<c:if test="${param.category eq 'community' && not empty sessionScope.sId}">
					<form action="commentWritePro" method="post" name="commentWrite">
					<input type="hidden" name="member_id" value="작성테스트">
					<input type="hidden" name="project_idx" value="${param.project_idx }">
					<span class="fs-5 fw-bold text-start">응원 · 의견 · 체험리뷰<span class="fs-5 fw-bold text-start text-info">${ProjectCommunity.size() }</span></span><br>
					<small class="text-start opacity-75">회원님들이 남긴 의견입니다.</small>
					<div>&nbsp;</div>
						<div class="mb-3">
  							<textarea name="project_community_subject" class="form-control" aria-label="With textarea" placeholder="제목을 작성해주세요." rows="1"></textarea><br>
  							<textarea name="project_community_content" class="form-control" aria-label="With textarea" placeholder="의견을 작성해주세요." rows="3"></textarea>
						</div>
					<div>&nbsp;</div>
					<!-- 게시물 작성 버튼 -->
						<div class="col-lg-12 col-sm-12">
							<button type="submit" class="btn btn-outline-info float-end" >의견 남기기</button>
						</div>
					</form>
					<div>&nbsp;</div>
				</c:if>
				<!-- 카테고리 - 커뮤니티 선택 시 게시물이 있을 경우 리스트 출력  -->
				<c:if test="${param.category eq 'community' && not empty ProjectCommunity}">
					<c:forEach items="${ProjectCommunity }" var="ProjectCommunity" varStatus="status">
						<div class="card border border-0 mb-3">
							<div class="card-header text-start">${ProjectCommunity.member_id }</div>
							<div class="card-body">
							<h5 class="card-title text-start">${ProjectCommunity.project_community_subject }</h5>
							<p class="card-text text-start">${ProjectCommunity.project_community_content }</p>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<!-- 카테고리 - 커뮤니티 선택 시 게시물이 없을 경우 "게시물이 없습니다" 출력 -->
				<c:if test="${param.category eq 'community' && empty ProjectCommunity}">
				<div class="col">
					<article>
						<h3>
						<svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" fill="currentColor" class="bi bi-pencil-fill" viewBox="0 0 16 16">
						<path d="M12.854.146a.5.5 0 0 0-.707 0L10.5 1.793 14.207 5.5l1.647-1.646a.5.5 0 0 0 0-.708l-3-3zm.646 6.061L9.793 2.5 3.293 9H3.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.207l6.5-6.5zm-7.468 7.468A.5.5 0 0 1 6 13.5V13h-.5a.5.5 0 0 1-.5-.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.5-.5V10h-.5a.499.499 0 0 1-.175-.032l-.179.178a.5.5 0 0 0-.11.168l-2 5a.5.5 0 0 0 .65.65l5-2a.5.5 0 0 0 .168-.11l.178-.178z"/></svg>
						게시물이 없습니다</h3>
					</article>
				</div>
				</c:if>
			</div>
		</div>
			</div>
			<!-- 메이커 프로필, 리워드 선택 바-->
			<!-- 화면 클때 -->
			<div class="col-4 d-none d-lg-block">
				<!--메이커 프로필 영역-->
				<div class="row p-3 border border-secondary-subtle shadow-sm">
					<div class="row">
						<span class="text-dark text-decoration-none fw-bold text-start pb-1" onclick="location.href='#'" style="cursor:pointer;">${project.project_representative_name }
						<button class="btn btn-outline-success rounded-0 btn-sm btn float-end">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-lg" viewBox="0 0 16 16">
						<path fill-rule="evenodd" d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2Z"/>
						</svg>팔로우</button>	
						</span>
					</div>
					<div class="row">
						<!-- 프로필 이미지 -->
						<div class="col-lg-8 text-start">
						<!-- 프로필 클릭시 메이커 새탭 이동-->
							<a href="#" target="_blank">
								<img src="https://cdn-icons-png.flaticon.com/512/3135/3135707.png" class="rounded-circle" alt="..." width="40px" height="40px"></a>
						</div>
						<br>
						<small class="text-start pb-3">${project.project_semi_introduce }</small>
						<!-- 메이커명-->
					</div>
					<!-- 팔로우, 1:1문의 버튼-->
					<div class="row">
						<button class="btn btn-outline-success me-2 rounded-0 btn-block" id="projectInquiry">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left-dots" viewBox="0 0 16 16">
						<path d="M14 1a1 1 0 0 1 1 1v8a1 1 0 0 1-1 1H4.414A2 2 0 0 0 3 11.586l-2 2V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12.793a.5.5 0 0 0 .854.353l2.853-2.853A1 1 0 0 1 4.414 12H14a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
						<path d="M5 6a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
						</svg>
						문의하기</button>
					</div>
	      			<!-- 팔로우, 1:1문의 버튼 끝-->
				</div>
				<!--메이커 프로필 영역 끝-->
				<!-- 리워드 선택 바-->
				<div class="row">
					<span class="fs-5 fw-bold p-3 text-start" id="rewardSelect">리워드 선택</span>
				</div>
				<!--스크롤-->
				<div class="row fixed-right" id="scrollBar">
					<!-- 리워드 카드 영역 -->
					<div class="row pb-3 d-flex text-start">
						<c:forEach items="${reward }" var="reward" varStatus="status">
							<div class="card">
								<div class="card-body">
									<span class="card-subtitle mb-2 text-muted">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check" viewBox="0 0 16 16">
									<path d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z"/>
									</svg>
									<small>${reward.reward_quantity - reward.reward_residual_quantity }개 선택</small>
									<a class="btn disabled btn btn-outline-danger rounded-0 btn-sm btn float-end" aria-disabled="true" role="button" data-bs-toggle="button">
									${reward.reward_residual_quantity }개 남음</a>
									</span><br>
									<span class="fs-4 card-title fw-bold"><fmt:formatNumber value="${reward.reward_price }" pattern="#,###" />원 +</span><br>
									<small class="card-text opacity-75">${reward.reward_name }</small><br>
									<small class="card-text opacity-75">${reward.reward_detail }</small>
									<!-- 기본 공백(클릭시 장바구니 카드로 확장하기 위함) -->
									<div>&nbsp;</div>
									<!-- 프로젝트가 진행되지 않은 상태일 경우(주문 불가능) -->
									<c:if test="${project.project_status eq 1 }">
										<a href="javascript:nrReward()" class="stretched-link"></a>
									</c:if>
									<!-- 프로젝트가 진행중인 경우(주문 가능) -->
									<c:if test="${project.project_status eq 2 }">
										<a href="fundingOrder?project_idx=${project.project_idx }&reward_idx=${reward.reward_idx }" class="stretched-link"></a>
									</c:if>
									<!-- 프로젝트가 종료된 경우(주문 불가능) -->
			      					<c:if test="${project.project_status eq 3 || project.project_status eq 4 || project.project_status eq 5 }">
										<a href="javascript:endReward()" class="stretched-link"></a>
									</c:if>
								</div>
							</div>
							<div>&nbsp;</div>
						</c:forEach>
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

	<script type="text/javascript">
// 아임포트 결제 스크립트 ---------------------------------------------
	function request_pay() {
		
		var IMP = window.IMP;
		IMP.init("imp30787507");

		IMP.request_pay({
		    pg: "html5_inicis", // PG사 선택
		    pay_method: "card", // 지불 수단
		    merchant_uid: "merchant_" + new Date().getTime(), // 주문번호
		    name: "펀딩  프로젝트명", // 상품명
		    amount: 1000, // 가격
		    buyer_email: "test@gmail.com",
		    buyer_name: "홍길동", // 구매자 이름
		    buyer_tel: "010-1234-5678", // 구매자 연락처 
		    buyer_addr: "부산광역시 부산진구",// 구매자 주소지
		    buyer_postcode: "01181", // 구매자 우편번호
		  }, function (rsp) { // callback
		    if (rsp.success) { // 결제 성공 시: 결제 승인 또는 가상계좌 발급에 성공한 경우
		        console.log(rsp);
		        // 결제검증
		        $.ajax({
					type : "GET",
//					url : "/payments/" + rsp.imp_uid
					url : "<c:url value='payments/'/>" + rsp.imp_uid
		      }).done(function(data) { // 응답 처리
		      		console.log(data);
		      		// 위의 rsp.paid_amount 와 data.response.amount를 비교한후 로직 실행 (import 서버검증)
		      		if(rsp.paid_amount == data.response.amount){
				        	alert("결제가 완료되었습니다.");
//							location.href = "fundingResult?merchant_uid=" + merchant_uid payment 데이터 넣으면 주석 해제
							location.href = "fundingResult"
				    } else {
			        		alert("결제 실패");
			        }
		        });
		    } 
		    else {
		      alert("결제에 실패하였습니다. 에러 내용: " +  rsp.error_msg);
		    }
		  });
		}
// --------------------------------------------------------------------

// 카카오톡 공유하기 스크립트 -----------------------------------------
	
	  // SDK 초기화
	  Kakao.init('86b7cd36bb5e30664d978742e039e68a');
	
	  function kakaoShare() {
	    Kakao.Link.sendDefault({
	      objectType: 'feed',
	      content: {
	        title: '펀뜩 사이트를 공유합니다!',
	        description: '펀뜩 사이트로 바로가기',
	        imageUrl: 'https://images.unsplash.com/photo-1424593463432-4104fa2c015a?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=384&ixid=MnwxfDB8MXxyYW5kb218MHwxOTA3Mjd8fHx8fHx8MTY5MDc5MTEwMQ&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1306',
	        link: {
	          mobileWebUrl: 'http://localhost:8080/test',
	          webUrl: 'http://localhost:8080/test',
	        },
	      },
	      buttons: [
	        {
	          title: '웹으로 보기',
	          link: {
	            mobileWebUrl: 'http://localhost:8080/test',
	            webUrl: 'http://localhost:8080/test',
	          },
	        },
	      ],
	      // 카카오톡 미설치 시 카카오톡 설치 경로이동
	      installTalk: true,
	    })
	  }
// --------------------------------------------------------------------
// 후원하기 버튼 클릭 시 리워드 선택 영역으로 화면 이동
function focusOnReward(){
	document.getElementById('rewardSelect').scrollIntoView();
}
	
// 카테고리 선택 시 자동 포커스 이동
// 진행 바 값 가져오기
window.onload = function(){
	var location = document.querySelector("#focusArea").offsetTop;
	var category = document.getElementById("categoryVal").value;
	
	// 카테고리 선택 시 자동 포커스 이동
	if(category != ""){
		window.scrollTo({top:location, behavior:'instant'});
	}
}


// 웹 소켓 채팅방
	$("#projectInquiry").click(function() {
		
		let maker_idx = ${project.maker_idx};
		let member = '<%= session.getAttribute("sId") %>';
		
		if(member == "null"){
			alert("로그인 후 문의가 가능합니다!");
		return false;
		}
		
		$.ajax({
			type:"post",
			url:"createRoom",
			dataType:"json",
			data: {maker_idx: maker_idx},
			success: function (data) {
				console.log(data);
				
				if (window.name !== 'newWindow') {
					  sessionStorage.setItem('origin', true);
					} else {
					  sessionStorage.setItem('new', true);
					}
				
				window.open("chat?room_id="+data.room_id + "=" +data.maker_member_id , "_blank", "width=500, height=800");
			},
		   error : function(request, status, error) {
		        console.log(error)
		    }
		});				
	});

// 프로젝트가 진행되지 않은 상태에서 리워드 주문 버튼 클릭 시
function nrReward(){
	alert("아직 주문이 불가능합니다!\n오픈을 기다려주세요!");
}

// 프로젝트가 종료된 상태에서 리워드 주문 버튼 클릭 시
function endReward(){
	alert("이미 종료된 프로젝트입니다!\n다음 기회에 이용해주세요!");	
}
</script>
<br>
<jsp:include page="../Footer.jsp"></jsp:include>
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>