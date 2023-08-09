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
	    max-width: 363.143px; 
	    margin-right: 10px;
	    box-sizing: border-box;
	}
	
	a {
    text-decoration: none; /
    color: inherit;
	}
	
	.project-table {
	  text-align: center;
	}
	
	.project-table th,
	.project-table td {
	  text-align: center;
	}
	
 	.table tr:nth-child(2) td,
 	.table tr:nth-child(3) td, 
 	.table tr:nth-child(4) td,
 	.table tr:nth-child(5) td, 
 	.table tr:nth-child(6) td, 
 	.table tr:nth-child(7) td, 
 	.table tr:nth-child(8) td, 
 	.table tr:nth-child(9) td, 
 	.table tr:nth-child(10) td, 
 	.table tr:nth-child(11) td { 
 	  font-weight: bold; 
 	  font-size: 125%; 
 	} 
	
	.project-end-date {
	  color: #999; 
	}
	 
    .hashtags-container {
        position: relative;
        height: 100px;
        overflow: hidden;
    }

    .random-hashtag {
        position: absolute;
    }

    .card-body_hash {
        position: relative;
        height: 200px;
        width: 470px;
        padding: 10px;
    }
    
    .hashtags-container{
        height: 300px;
        width: 600px;
    }
    
    .random-hashtag {
        position: absolute;
        font-size: 12px; /* 초기 폰트 크기 설정 */
        transition: font-size 0.3s; /* 애니메이션 전환 효과 */
    }
    
    .random-hashtag:hover {
        font-size: 18px; /* 마우스 오버 시 크기 증가 */
        z-index: 2; /* 마우스 오버 시 다른 요소 위로 올라오도록 설정 */
    }
    
/* 모달 팝업 스타일 */
.popup {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: 1000;
}

.popup-content {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    max-width: 80%;
    text-align: right; 
}

.close-button {
    position: absolute;
    top: 10px;
    right: 10px;
    font-size: 20px;
    cursor: pointer;
    color: #999;
}

/* 추가한 부분 */
.content-wrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-top: 20px;
}

#hideToday {
    margin-bottom: 10px;
}

/* 모바일 환경에서 팝업 창 스타일 */
@media (max-width: 768px) {
    .popup-content {
        max-width: 90%;
        text-align: center;
        padding: 20px;
    }

    .popup-content img {
        max-width: 100%;
        height: auto;
    }

    .close-button {
        top: 20px;
        right: 20px;
    }

    .content-wrapper {
        margin-top: 10px;
    }
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

<br>
		<div class="container" >
		    <h3><b>오늘의 추천 프로젝트</b></h3>
		    <p>함께 만드는 성공</p>
		    <div class="row" id="projectContainer"  >
		        <c:forEach items="${projectList}" var="project" varStatus="status">
		            <c:if test="${status.index <= 3 && project.project_status eq 2 && project.project_approve_status eq 5}">
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
<hr>
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
				<div class="card-body_hash">
				    <p><b>당신이 찾고있는 <span class="highlight">#해시태그</span></b></p>
					<div class="hashtags-container">
					        <c:forEach items="${hashTagMap}" var="hashTagEntry">
					            <c:set var="hashTag" value="${hashTagEntry.key}" />
					            <c:set var="projectsForTag" value="${hashTagEntry.value}" />
					
					            <c:forEach items="${projectsForTag}" var="project">
					                <a href="fundingDetail?project_idx=${project.project_idx}">
					                    <span class="random-hashtag">
					                        ${hashTag}
					                    </span>
					                </a>
					            </c:forEach>
					        </c:forEach>
					    </div>


				</div>
		    </div>
		  </div>
		</div>
	<br>	
<hr>
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
		                            <a href="fundingDetail?project_idx=${project.project_idx }" class="stretched-link"><p style="text-align: center;"><b>지금 살펴보기></b></p></a>
		                        </div>
		                    </div>
		                </c:if>
		            </c:forEach>
		        </div>
		        <div class="swiper-pagination-custom swiper-pagination"></div>
		    </div>
		</div>
	   <br>	
<hr>		
		<br>
		
<div id="popup" class="popup">
    <div class="popup-content">
        <span class="close-button" onclick="closePopup()">&times;</span>
        <div class="content-wrapper">
            <a href="member/coupon">
                <img src="./resources/images/popup.png" width="550" height="700" alt="팝업 이미지">
            </a>
            <label>
                <input type="checkbox" id="hideToday"> 오늘 하루 안보기
            </label>
        </div>
    </div>
</div>


		
  
    <script src="resources/js/showRandomProjects.js"></script>
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
	
	<script>
	    var hashtags = document.querySelectorAll('.random-hashtag');
	    var container = document.querySelector('.hashtags-container');
	    var containerWidth = container.clientWidth;
	    var containerHeight = container.clientHeight;
	
	    hashtags.forEach(function(hashtag) {
	        var randomX = Math.random() * (containerWidth - 100);
	        var randomY = Math.random() * (containerHeight - 20);
	        hashtag.style.left = randomX + 'px';
	        hashtag.style.top = randomY + 'px';
	    });
	    
	    //----------------------------------------------------
	    
	    document.addEventListener("DOMContentLoaded", function() {
	        // 페이지 로드 시 팝업 띄우기
	        openPopup();
	    });

	    function openPopup() {
	        var popup = document.getElementById("popup");
	        popup.style.display = "block";
	    }

	    function closePopup() {
	        var popup = document.getElementById("popup");
	        popup.style.display = "none";
	    }

	    //--------------------------------------------------------
	    
	    document.addEventListener("DOMContentLoaded", function() {
        var currentDate = new Date();
        var startDate = new Date("2023-08-09");
        var endDate = new Date("2023-08-10");

        if (currentDate >= startDate && currentDate <= endDate) {
            openPopup();
        }
	    });
	
	    function openPopup() {
	        var popup = document.getElementById("popup");
	        popup.style.display = "block";
	    }
	
	    function closePopup() {
	        var popup = document.getElementById("popup");
	        popup.style.display = "none";
	    }
	    
	    //-----------------------------------------------------------
	     document.addEventListener("DOMContentLoaded", function() {
        var hideTodayCheckbox = document.getElementById("hideToday");
        var popup = document.getElementById("popup");
        var currentDate = new Date();

        var lastHiddenDate = localStorage.getItem("popupHiddenDate");

        if (lastHiddenDate) {
            var parsedLastHiddenDate = new Date(lastHiddenDate);
            if (currentDate.toDateString() === parsedLastHiddenDate.toDateString()) {
                // 이미 오늘 하루 안보기가 선택되었으면 팝업 숨기기
                popup.style.display = "none";
                hideTodayCheckbox.checked = true;
            }
        }

        hideTodayCheckbox.addEventListener("change", function() {
            if (this.checked) {
                // 체크가 선택되었을 때 현재 날짜를 localStorage에 저장
                localStorage.setItem("popupHiddenDate", currentDate.toDateString());
            } else {
                // 체크 해제되면 localStorage에서 삭제
                localStorage.removeItem("popupHiddenDate");
            }
		        });
		    });
		
		    function openPopup() {
		        var popup = document.getElementById("popup");
		        popup.style.display = "block";
		    }
		
		    function closePopup() {
		        var popup = document.getElementById("popup");
		        popup.style.display = "none";
		    }
	    
	</script>
	
	<script>
	    function calculateSimilarity(str1, str2) {
	        str1 = str1.replace(/,/g, "");
	        str2 = str2.replace(/,/g, "");
	        
	     // 최소 길이 구하기
	        var minLength = Math.min(str1.length, str2.length);
	
	        // 일치하는 문자 수 계산
	        var matchCount = 0;
	        for (var i = 0; i < minLength; i++) {
	            if (str1.charAt(i) === str2.charAt(i)) {
	                matchCount++;
	            }
	        }
	
	        // 유사도 계산 (일치하는 문자 수를 최대 길이로 나눈 값)
	        var similarity = matchCount / Math.max(str1.length, str2.length);
	
	        return similarity;
	    }
	
	    function getRandomPosition(existingPositions) {
	        var x, y;
	        do {
	            x = Math.random() * 370;
	            y = Math.random() * 180;
	        } while (isTooClose(existingPositions, x, y));
	        existingPositions.push({ x: x, y: y });
	        return { x: x, y: y };
	    }
	
	    function isTooClose(existingPositions, x, y) {
	        for (var i = 0; i < existingPositions.length; i++) {
	            var position = existingPositions[i];
	            var distance = Math.sqrt(Math.pow(position.x - x, 2) + Math.pow(position.y - y, 2));
	            if (distance < 50) {
	                return true;
	            }
	        }
	        return false;
	    }
	
	    window.onload = function () {
	        var hashtags = document.querySelectorAll('.random-hashtag');
	        var existingPositions = [];
	
	        for (var i = 0; i < hashtags.length; i++) {
	            var position = getRandomPosition(existingPositions);
	            hashtags[i].style.left = position.x + 'px';
	            hashtags[i].style.top = position.y + 'px';
	        }
	    };
	</script>

	
    <%@ include file="Footer.jsp" %>
    
</body>
</html>