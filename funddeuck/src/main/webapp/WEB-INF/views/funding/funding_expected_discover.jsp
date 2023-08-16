<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩</title>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<!-- fundingDiscover page CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/funding_discover.css">
<!-- 공용 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<!-- line-awesome icons CDN -->
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- header include -->
<jsp:include page="../Header.jsp"></jsp:include>
<!-- Jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- fundingDiscover page JS -->
<script src="${pageContext.request.contextPath }/resources/js/funding_discover.js"></script>
</head>
<body>
<!-- 요청 파라미터 값 저장 -->
<input type="hidden" value="${param.category }" id="categoryVal">
<!-- 현재 날짜 정보 저장 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<!-- 상단 이동 버튼 -->
	<button type="button" class="btn btn-dark position-fixed bottom-0 end-0" id="go-top">
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-arrow-up-square-fill" viewBox="0 0 16 16">
	<path d="M2 16a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2zm6.5-4.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 1 0z"/>
	</svg>&nbsp;상단으로
	</button>
<!-- 상위 노출 슬라이드 이미지 영역 -->
<div style="height:100px;"></div>
  <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-indicators">
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
          <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="3" aria-label="Slide 4"></button>
      </div>
      <div class="carousel-inner">
          <div class="carousel-item active">
          <a href="fundingDiscover?category=all&status=all&index=newest">
              <img src="./resources/images/banner1.png" class="d-block w-100 h-auto" alt="...">
              <div class="carousel-caption d-none d-md-block"></div>
          </a>
          </div>
          <div class="carousel-item">
          <a href="fundingExpected?category=all">
              <img src="./resources/images/banner2.png" class="d-block w-100 h-auto" alt="...">
              <div class="carousel-caption d-none d-md-block">
              </div>
          </a>
          </div>
          <div class="carousel-item">
          <a href="fundingSearchKeyword?searchKeyword=장마&status=all&index=newest">
              <img src="./resources/images/banner3.png" class="d-block w-100 h-auto" alt="...">
              <div class="carousel-caption d-none d-md-block">
              </div>
          </a>
          </div>
          <div class="carousel-item">
          <a href="coupon">
              <img src="./resources/images/banner4.png" class="d-block w-100 h-auto" alt="...">
              <div class="carousel-caption d-none d-md-block">
              </div>
          </a>
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
<!-- 카테고리 바 영역 -->
<div class="container-lg">
	<ul class="nav justify-content-center">
		<li class="nav-item 
		<c:if test="${param.category eq 'all' }">
			border-primary border-bottom border-2
		</c:if>">
			<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingExpected?category=all">
			<img src="${pageContext.request.contextPath }/resources/images/icon/shop.png" style="width: 25px; height: 25px;">
			전체</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'tech' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingExpected?category=tech">
			<img src="${pageContext.request.contextPath }/resources/images/icon/tech.png" style="width: 25px; height: 25px;">
			테크·가전</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'fashion' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingExpected?category=fashion">
			<img src="${pageContext.request.contextPath }/resources/images/icon/fashion.png" style="width: 25px; height: 25px;">
			패션·잡화</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'living' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingExpected?category=living">
			<img src="${pageContext.request.contextPath }/resources/images/icon/home.png" style="width: 25px; height: 25px;">
			홈·리빙</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'beauty' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingExpected?category=beauty">
			<img src="${pageContext.request.contextPath }/resources/images/icon/beauty.png" style="width: 25px; height: 25px;">
			뷰티</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'publish' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingExpected?category=publish">
			<img src="${pageContext.request.contextPath }/resources/images/icon/publish.png" style="width: 25px; height: 25px;">
			출판</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'green' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingExpected?category=green">
			<img src="${pageContext.request.contextPath }/resources/images/icon/echo.png" style="width: 25px; height: 25px;">
			친환경</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'donate' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingExpected?category=donate">
			<img src="${pageContext.request.contextPath }/resources/images/icon/donation.png" style="width: 25px; height: 25px;">
			기부</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'savAnimal' }">
			border-primary border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingExpected?category=savAnimal">
			<img src="${pageContext.request.contextPath }/resources/images/icon/pet.png" style="width: 25px; height: 25px;">
			동물보호</a>
		</li>
	</ul>
	<br>
<!-- 프로젝트 리스트 영역 -->
	<div class="col with .gy-5 gutters">
		<small class="text-primary">${project.size() }</small><small>개의 오픈 예정인 프로젝트가 있습니다.</small>
		<div class="row row-cols-3 row-cols-sm-4 g-3">
		<!-- 페이징 처리 -->
		<c:forEach items="${project}" var="project" varStatus="status">
			<div class="col" id="projectListArea">
				<div class="card h-100 w-100 p-3 border-0">
					<img src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}" 
					class="card-img-top" style="width:274px; height:341.52px; object-fit:cover;" alt="...">
					<div class="card-body">
						<small class="card-title opacity-75">${project.project_hashtag } | ${project.project_representative_name }</small>
						<p class="card-text fw-bold text-start">${project.project_subject }
						<c:if test="${project.project_category eq '친환경' || project.project_category eq '기부' || project.project_category eq '동물보호'}">
							<img src="https://cdn.pixabay.com/photo/2020/08/05/13/28/eco-5465473_1280.png" style="width: 40px; height: 40px;">
						</c:if>
						</p>
						<small class="card-title opacity-75">${project.project_semi_introduce }</small>
					</div>
						<a href="fundingDetail?project_idx=${project.project_idx }" class="stretched-link"></a>
					<div class="card-footer bg-white">
		      			<small class="text-dark">오픈까지
			      			<small class="text-primary fw-bold">
							<fmt:parseNumber value="${today.time / (1000*60*60*24)}" integerOnly="true" var="nowDate"></fmt:parseNumber>
							<fmt:parseDate value="${project.project_start_date }" var="projectStartDate" pattern="yyyy-MM-dd"/>
							<fmt:parseNumber value="${projectStartDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
							${strDate - nowDate }</small>일 남았어요!
			      		</small>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
	</div>
</div>
<br>
<script type="text/javascript">
// 셀렉트 박스 이벤트 스크립트
function chageLangSelect(){
    var langSelect = document.getElementById("selectBox");
     
    // select element에서 선택된 option의 value가 저장된다.
    var category = document.getElementById("categoryVal").value;
    console.log()

    location.href = "fundingDiscover?category=" + category;
}
</script>
</body>
</html>