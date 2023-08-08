<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  
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
	
    .project-rank {
      font-weight: bold;
    }

    .project-name {
      color: #ff9300;
      font-size: 100%
	}
	/* 리스트 스타일 변경 */
    #rankingList {
      padding: 0;
      margin: 0;
    }

    /* 리스트 아이템 기호 제거 */
    #rankingList li {
      list-style-type: none;
    }

	.carousel-item img {
    max-width: 100%;
    height: auto;
	}
	
	.navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 9999;
        background-color: #fff; 
    }
  
    .carousel {
        margin-top: 70px; 
    }
	
	.light-gray-text {
        color: #aaaaaa; 
    }
    
	.slick-slide {
	    padding: 1em;
	 }   
	  
	.swiper-pagination-custom {
    	display: none;
	}
	
	.swiper-container {
    display: flex;
    align-items: flex-start;
	}
	
	.swiper-slide {
	    flex: 0 0 auto;
	}
	
	.swiper-pagination-custom {
	    margin-top: 10px;
	}
	
	.swiper-slide .card {
	    width: 100%;
	    max-width: 363.143px; /* 원하는 최대 너비 설정 */
	    margin-right: 10px;
	    box-sizing: border-box;
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
                <img src="./resources/images/banner1.png" class="d-block w-100 h-auto" alt="...">
                <div class="carousel-caption d-none d-md-block">
                </div>
            </div>
            <div class="carousel-item">
                <img src="./resources/images/banner2.png" class="d-block w-100 h-auto" alt="...">
                <div class="carousel-caption d-none d-md-block">
                </div>
            </div>
            <div class="carousel-item">
                <img src="./resources/images/banner3.png" class="d-block w-100 h-auto" alt="...">
                <div class="carousel-caption d-none d-md-block">
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


		<div class="container" >
		    <h3><b>오늘의 추천 프로젝트</b></h3>
		    <p>함께 만드는 성공</p>
		    <div class="row" id="projectContainer"  >
		        <c:forEach items="${projectList}" var="project" varStatus="status">
		            <c:if test="${status.index <= 2 && project.project_status eq 2 && project.project_approve_status eq 5}">
		                <div class="col-md-4 mb-4">
		                    <article class="card">
		                        <div class="card-thumbnail" style="background-image: url('${project.project_thumnails1}');"></div>
		                        <div class="card-body">
		                            <em class="card-title"><b>${project.project_subject}</b></em>
		                            <p class="card-text">
		                                <div class="progress" style="height: 10px">
		                                    <div class="progress-bar bg-success" id="progressbar" role="progressbar" aria-label="Success example"
		                                        style="height:10px; width: ${project.project_cumulative_amount / project.project_target * 100}%"
		                                        aria-valuenow="${project.project_cumulative_amount / project.project_target * 100}" aria-valuemin="0" aria-valuemax="100"></div>
		                                </div>
		                                <span class="light-gray-text">
		                                    <fmt:formatNumber type="number" maxFractionDigits="0" value="${project.project_cumulative_amount / project.project_target * 100}" />
		                                    %
		                                </span>
		                                <br>${project.project_category} | ${project.project_representative_name}
		                            </p>
		                        </div>
		                        <hr>
		                        <a href="fundingDetail?project_idx=${project.project_idx}" class="stretched-link"><p style="text-align: center;"><b>지금 참여하기></b></p></a>
		                    </article>
		                </div>
		            </c:if>
		        </c:forEach>
		    </div>
		</div>
		
		<div class="container mt-4 d-flex justify-content-end">
		    <button type="button" class="btn btn-light" onclick="showRandomProjects()"><b>추천받아볼까요?</b></button>
		</div>

	<br>
		<div class="container">
		  <div class="row">
		        <h3><b>트랜드</b></h3>
		    <div class="col-md-6">
		      <div class="card-body">
		        <p><b>이제는 끝날 <span class="highlight">#마감</span> 프로젝트</b></p>
		        <ul id="rankingList" class="card-text"></ul>
		      </div>
		    </div>
		    <div class="col-md-6">
		      <div class="card-body">
		        <p><b>오늘 가장 많은 <span class="highlight">#후원금액</span> 프로젝트</b><p>
		        <ul id="totalAmountList" class="card-text"></ul>
		      </div>
		    </div>
		  </div>
		</div>

 	<br>
		<div class="container">
		    <h3><b>오픈 예정 프로젝트</b></h3>
		    <p>주목하세요! 오픈할 프로젝트</p>
		    <div class="swiper-container">
		        <div class="swiper-wrapper">
		            <c:forEach items="${projectList}" var="project" varStatus="status">
		                <c:if test="${project.project_status == 1 && project.project_approve_status == 5}">
		                    <div class="swiper-slide">
		                        <div class="card">
		                            <div class="card-thumbnail" style="background-image: url('${project.project_thumnails1}');"></div>
		                            <div class="card-body">
		                                <em class="card-title"><b>${project.project_subject}</b></em>
		                                <p class="card-text">
		                                    <br>${project.project_category} | ${project.project_representative_name}
		                                </p>
		                            </div>
		                            <hr>
		                            <p style="text-align: center;"><b>지금 살펴보기></b></p>
		                        </div>
		                    </div>
		                </c:if>
		            </c:forEach>
		        </div>
		        <div class="swiper-pagination-custom swiper-pagination"></div>
		    </div>
		</div>
		
		<br>
		

  
    <script src="resources/js/showRandomProjects.js"></script>
    <script src="resources/js/showRandomunProjects.js"></script>
  	<script src="resources/js/rankingList.js"></script>
	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
	<script>
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 3.5,
        spaceBetween: 10,
        pagination: {
            el: '.swiper-pagination-custom', 
            clickable: true,
        },
    });
	</script>
	
    <%@ include file="Footer.jsp" %>
    
</body>
</html>