<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<html>
<html lang="ko">

<head>
    <title>Home</title>
    <%@ include file="Header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
	<link rel="stylesheet" type="text/css" href="resources/css/mypage.css" />
	<link rel="stylesheet" type="text/css" href="resources/css/moreProject.css" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .card-thumbnail {
      width: 100%;
      height: 0;
      padding-bottom: 56.25%; /* 16:9 비율 */
      background-size: cover;
      background-position: center;
    }
    
	.container h3{
	  margin-top: 40px;
	}
  </style>
  
  <script type="text/javascript">
  	console.log("${sessionScope.sId }");
  </script>

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

	<div class="container">
	  <h3><b>오늘의 추천 프로젝트</b></h3>
	  <p>함께 만드는 성공</p>
	  <!-- 예시 데이터 틀 -->
	  <div class="row">
	    <div class="col-md-4 mb-4">
	      <article class="card">
	        <div class="card-thumbnail" style="background-image: url('https://cdn.wadiz.kr/wwwwadiz/green001/2023/0627/20230627223339159_223470.jpg/wadiz/resize/600/format/jpg/quality/85/');">
	        </div>
	        <div class="card-body">
	          <em class="card-title">짱구공식굿즈&gt; 짱구 집콕 에디션 최초 공개! 야광 잠옷 & 식기세트 & 수납함</em>
	          <p class="card-text">
	            <span class="badge badge-primary">5,875원</span>
	            캐릭터 · 굿즈
	          </p>
	        </div>
	      </article>
	    </div>
	  </div>
	<!-- 데이터베이스에서 가져와서 출력될 내용 -->
	<div class="row">
	  <c:forEach items="${projectList}" var="project" varStatus="status">
	    <div class="col-md-4 mb-4">
	      <article class="card">
	        <div class="card-thumbnail" style="background-image: url('${project.project_thumnails1}');"></div>
	        <div class="card-body">
	          <em class="card-title">${project.project_subject}</em>
	          <p class="card-text">
	            <span class="badge badge-primary">${project.project_target}원</span>
	            ${project.project_category}
	          </p>
	        </div>
	      </article>
	    </div>
	    <c:if test="${status.count % 4 == 0}"></c:if><div class="row"></div>
	  </c:forEach>
	</div>
	<div class="container mt-4">
	  <button type="button" class="btn btn-light" onclick="showRandomProjects()" ><b>자동 추천</b></button>
	</div>
	<br>
	      <div class="card-body">
	      	  <h3><b>추천 순위</b></h3>
			  <p>곧 끝나는 프로젝트를 확인하세요!</p>
	        <ul id="rankingList" class="card-text"></ul>
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

  
    <script src="resources/js/showRandomProjects.js"></script>
  	<script src="resources/js/rankingList.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
    <%@ include file="Footer.jsp" %>
    
</body>
</html>