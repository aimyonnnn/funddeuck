<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>

<html>
<head>
    <title>Home</title>
    <%@ include file="Header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
	<link rel="stylesheet" type="text/css" href="resources/css/mypage.css" />
	<link rel="stylesheet" type="text/css" href="resources/css/moreProject.css" />
</head>

<body>
    <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://source.unsplash.com/WLUHO9A_xik/1306x384.391" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>First slide label</h5>
                    <p>Some representative placeholder content for the first slide.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://source.unsplash.com/collection/190727/1306x384.391" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Second slide label</h5>
                    <p>Some representative placeholder content for the second slide.</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://source.unsplash.com/collection/190727/1306x384.391" class="d-block w-100" alt="...">
                <div class="carousel-caption d-none d-md-block">
                    <h5>Third slide label</h5>
                    <p>Some representative placeholder content for the third slide.</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
    
   			<br>
			<div class="container">
			    <div class="row">
			        <div class="col-12">
			            <h2>오늘의 추천 프로젝트</h2>
			            <p>함께하는 성공</p>
			        </div>
			    </div>
			    <div class="row">
			        <c:forEach var="project" items="${projects}">
			            <div class="col-12 col-sm-6 col-md-4" style="margin-bottom: 20px;">
			                <div class="card-sl">
			                    <div class="card-image">
			                        <img src="<c:url value='/resources/images/beautycut${project.p_num}.jpg' />" class="img-fluid" alt="프로젝트 이미지" style="max-width: 100%;">
			                    </div>
			                    <a class="card-action" href="#"><i class="fa fa-heart"></i></a>
			                    <div class="card-heading">
			                        [${project.p_name}]
			                    </div>
			                    <div class="card-text">
			                        ${project.p_intro}
			                    </div>
			                    <div class="card-text-percent">
			                        ${project.p_percent}%
			                    </div>
			                    <a href="#" class="card-button">자세히보기</a>
			                </div>
			            </div>
			        </c:forEach>
			    </div>
			    <div style="width: 100%; text-align: right;">
			        <button id="moreButton" class="btn btn-primary" onclick="loadMoreProjects()">더보기</button>
			    </div>
			</div>
			<br>
				<div class="container" style="display: flex;">
				    <div class="col-md-3 col-sm-12" style="flex: 1; margin-right: 20px;">
				        <div class="card-sl">
				            <div class="card-body">
				                <h2 class="card-title">실시간 랭킹</h2>
				                <ul id="rankingList" class="card-text"></ul>
				            </div>
				        </div>
				    </div>
				</div>

		    <hr>
		   	<br>
    <div>
        <div class="container">
            <h2>오픈 예정 프로젝트</h2>
            <p>주목하세요! 곧 오픈할 프로젝트</p>
            <div class="card-deck">
                <c:forEach var="open_project" items="${open_projects}">
                    <div class="card">
                        <img src="/resources/images/beautycut${open_project.op_num}.jpg" class="card-img-top">
                        <div class="card-body">
                            <h5 class="card-title">${open_project.op_name}</h5>
                            <p class="card-text">${open_project.op_intro}</p>
                            <p class="card-text"><small class="text-muted">${open_project.op_date}</small></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12 text-end">
            <button class="btn btn-primary" id="prev-btn">이전</button>
            <button class="btn btn-primary" id="next-btn">다음</button>
        </div>
    </div>
    <hr>
   	<br>
   <div class="container">
   	<div style = "max-width:1440px; width:100%; overflow:hidden; margin: 0 auto;" >
	  <h2>얼리버드</h2>
	  <p>먼저 참여하는 분들께 드리는 새로운 혜택</p>
	  <div class="swiper-container" style = "width:100%;">
	    <div class="swiper-wrapper" >
	      <c:forEach var="i" begin="0" end="11">
	        <div class="swiper-slide">
	          <div>
	            <img src="resources/images/beautycut${i+1}.jpg" class="d-block w-100" alt="...">
	            <c:set var="projectId" value="${i+1}" />
	            <c:set var="project" value="${database.getProjectById(projectId)}" />
	            <p>[${project.p_name}]</p>
	            <p>${project.p_introduce}</p>
	            <p>${project.p_percent}%</p>
	            <div class="d-flex justify-content-center">
	              <button class="btn btn-primary">지금 참여하기</button>
	            </div>
	          </div>
	        </div>
	      </c:forEach>
	    </div>
	  </div>
	</div>
  </div>
	<br>
  
	<script src="resources/js/rankingList.js"></script>
    <script src="resources/js/moreButton.js"></script>
    <script src="resources/js/openProject.js"></script>
    <script src="resources/js/moreShow.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
    <%@ include file="Footer.jsp" %>
    
</body>
</html>