<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<html lang="ko">

<head>
    <title>Home</title>
    <%@ include file="Header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  	<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
  	<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />  	
	<link rel="stylesheet" type="text/css" href="resources/css/mypage.css" />
	<link rel="stylesheet" type="text/css" href="resources/css/main.css" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/8.0.1/normalize.min.css">
  	<meta name="viewport" content="width=device-width, initial-scale=1">

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

<div class="container">
    <h3><b>오늘의 추천 프로젝트</b></h3>
    <p>함께 만드는 성공</p>
    <div class="row" id="projectContainer">

        <c:forEach items="${projectList}" var="project" varStatus="status">
            <c:if test="${project.project_status eq 2 && project.project_approve_status eq 5}">
                    <div class="col-md-4 mb-4">
                        <article class="card h-100 w-100 p-3 border-0" >
						<img src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}" 
						class="card-img-top object-fit-contain" alt="..." >
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
				    <p><b>요즘 유행하는 <span class="highlight">#해시태그</span>만 모아봤어요!</b></p>
					<div class="hashtags-container">
					        <c:forEach items="${hashTagMap}" var="hashTagEntry">
					            <c:set var="hashTag" value="${hashTagEntry.key}" />
					            <c:set var="projectsForTag" value="${hashTagEntry.value}" />
					
					            <c:forEach items="${projectsForTag}" var="project">
					                <a href="fundingSearchKeyword?searchKeyword=${hashTag}">
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
                            <div class="card h-100 w-100 p-3 border-0">
							<img src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}" 
							class="card-img-top object-fit-contain" alt="..." >
                                   <div class="card-body">
                                    <em class="card-title"><b>${project.project_subject}</b></em>
                                    <p class="card-text">
                                        <br>${project.project_category} | ${project.project_representative_name}
                                    </p>
                                </div>
                                <hr>
                                <a href="fundingDetail?project_idx=${project.project_idx }" class="stretched-link">
                                    <p style="text-align: center;"><b>지금 살펴보기></b></p>
                                </a>
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

	
    <!-- 팝업 컨테이너 하나만 출력할 때-->
<div id="popup" class="popup">
    <div class="popup-content">
        <span class="close-button" onclick="closePopup()">&times;</span>
        <div class="content-wrapper">
            <a href="member/coupon">
                <img src="${pageContext.request.contextPath}/resources/upload/${newCouponList[0].newCouponImage}" width="480" height="630" alt="팝업 이미지">
            </a>
            <p>유효 기간: ${newCouponList[0].newCoupon_start}부터 ${newCouponList[0].newCoupon_end}까지 사용가능</p>
            <label>
                <input type="checkbox" id="hideToday"> 오늘 하루 안보기
            </label>
        </div>
    </div>
</div>



  	<script src="resources/js/rankingList.js"></script>
  	<script src="resources/js/hashTag.js"></script>

	<script>
	    var swiper = new Swiper('.swiper-container', {
	        slidesPerView: '3', //보이게 하고싶은 수만큼 적기!
	        spaceBetween: 10,
	        pagination: {
	            el: '.swiper-pagination-custom',
	            clickable: true,
	        },
	    });
	</script>

	<script>
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
	function openPopup() {
	    var popup = document.getElementById("popup");
	    popup.style.display = "block";
	}
	
	function closePopup() {
	    var popup = document.getElementById("popup");
	    popup.style.display = "none";
	}
	
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
    document.addEventListener("DOMContentLoaded", function () {
        const popupContainer = document.getElementById("popup");
        
        // 팝업을 띄울 수 있는 날짜 범위
        const startDate = new Date("${newCouponList[0].newCoupon_start}");
        const endDate = new Date("${newCouponList[0].newCoupon_end}");

        // 현재 날짜
        const currentDate = new Date();

        // 현재 날짜가 범위 내에 있는 경우 팝업 띄우기
        if (currentDate >= startDate && currentDate <= endDate) {
            popupContainer.style.display = "block";
        }

        // 닫기 버튼 클릭 시 팝업 닫기
        const closePopupButton = document.querySelector(".close-button");
        closePopupButton.addEventListener("click", function () {
            popupContainer.style.display = "none";
        });
    });
</script>


    <%@ include file="Footer.jsp" %>
    
</body>
</html>