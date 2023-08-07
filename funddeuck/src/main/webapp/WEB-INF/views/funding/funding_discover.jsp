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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
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
<input type="hidden" value="${param.status }" id="statusVal">
<input type="hidden" value="${param.index }" id="indexVal">
<!-- 상단 이동 버튼 -->
	<button type="button" class="btn btn-dark position-fixed bottom-0 end-0" id="go-top">
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-arrow-up-square-fill" viewBox="0 0 16 16">
	<path d="M2 16a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2zm6.5-4.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 1 0z"/>
	</svg>&nbsp;상단으로
	</button>
<!-- 상위 노출 슬라이드 이미지 영역 -->
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
<!-- 카테고리 바 영역 -->
<div class="container-lg">
	<ul class="nav justify-content-center">
		<li class="nav-item 
		<c:if test="${param.category eq 'all' }">
			border-info border-bottom border-2
		</c:if>">
			<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingDiscover?category=all&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-stack" viewBox="0 0 16 16">
			<path d="m14.12 10.163 1.715.858c.22.11.22.424 0 .534L8.267 15.34a.598.598 0 0 1-.534 0L.165 11.555a.299.299 0 0 1 0-.534l1.716-.858 5.317 2.659c.505.252 1.1.252 1.604 0l5.317-2.66zM7.733.063a.598.598 0 0 1 .534 0l7.568 3.784a.3.3 0 0 1 0 .535L8.267 8.165a.598.598 0 0 1-.534 0L.165 4.382a.299.299 0 0 1 0-.535L7.733.063z"/>
			<path d="m14.12 6.576 1.715.858c.22.11.22.424 0 .534l-7.568 3.784a.598.598 0 0 1-.534 0L.165 7.968a.299.299 0 0 1 0-.534l1.716-.858 5.317 2.659c.505.252 1.1.252 1.604 0l5.317-2.659z"/>
			</svg>전체</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'tech' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=tech&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-tools" viewBox="0 0 16 16">
			<path d="M1 0 0 1l2.2 3.081a1 1 0 0 0 .815.419h.07a1 1 0 0 1 .708.293l2.675 2.675-2.617 2.654A3.003 3.003 0 0 0 0 13a3 3 0 1 0 5.878-.851l2.654-2.617.968.968-.305.914a1 1 0 0 0 .242 1.023l3.27 3.27a.997.997 0 0 0 1.414 0l1.586-1.586a.997.997 0 0 0 0-1.414l-3.27-3.27a1 1 0 0 0-1.023-.242L10.5 9.5l-.96-.96 2.68-2.643A3.005 3.005 0 0 0 16 3c0-.269-.035-.53-.102-.777l-2.14 2.141L12 4l-.364-1.757L13.777.102a3 3 0 0 0-3.675 3.68L7.462 6.46 4.793 3.793a1 1 0 0 1-.293-.707v-.071a1 1 0 0 0-.419-.814L1 0Zm9.646 10.646a.5.5 0 0 1 .708 0l2.914 2.915a.5.5 0 0 1-.707.707l-2.915-2.914a.5.5 0 0 1 0-.708ZM3 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026L3 11Z"/>
			</svg>테크·가전</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'fashion' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=fashion&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-basket2-fill" viewBox="0 0 16 16">
			<path d="M5.929 1.757a.5.5 0 1 0-.858-.514L2.217 6H.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h.623l1.844 6.456A.75.75 0 0 0 3.69 15h8.622a.75.75 0 0 0 .722-.544L14.877 8h.623a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1.717L10.93 1.243a.5.5 0 1 0-.858.514L12.617 6H3.383L5.93 1.757zM4 10a1 1 0 0 1 2 0v2a1 1 0 1 1-2 0v-2zm3 0a1 1 0 0 1 2 0v2a1 1 0 1 1-2 0v-2zm4-1a1 1 0 0 1 1 1v2a1 1 0 1 1-2 0v-2a1 1 0 0 1 1-1z"/>
			</svg>패션·잡화</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'living' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=living&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-add-fill" viewBox="0 0 16 16">
			<path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7Zm.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 1 1-1 0v-1h-1a.5.5 0 1 1 0-1h1v-1a.5.5 0 0 1 1 0Z"/>
			<path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5Z"/>
			<path d="m8 3.293 4.712 4.712A4.5 4.5 0 0 0 8.758 15H3.5A1.5 1.5 0 0 1 2 13.5V9.293l6-6Z"/>
			</svg>홈·리빙</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'beauty' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=beauty&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-stars" viewBox="0 0 16 16">
			<path d="M7.657 6.247c.11-.33.576-.33.686 0l.645 1.937a2.89 2.89 0 0 0 1.829 1.828l1.936.645c.33.11.33.576 0 .686l-1.937.645a2.89 2.89 0 0 0-1.828 1.829l-.645 1.936a.361.361 0 0 1-.686 0l-.645-1.937a2.89 2.89 0 0 0-1.828-1.828l-1.937-.645a.361.361 0 0 1 0-.686l1.937-.645a2.89 2.89 0 0 0 1.828-1.828l.645-1.937zM3.794 1.148a.217.217 0 0 1 .412 0l.387 1.162c.173.518.579.924 1.097 1.097l1.162.387a.217.217 0 0 1 0 .412l-1.162.387A1.734 1.734 0 0 0 4.593 5.69l-.387 1.162a.217.217 0 0 1-.412 0L3.407 5.69A1.734 1.734 0 0 0 2.31 4.593l-1.162-.387a.217.217 0 0 1 0-.412l1.162-.387A1.734 1.734 0 0 0 3.407 2.31l.387-1.162zM10.863.099a.145.145 0 0 1 .274 0l.258.774c.115.346.386.617.732.732l.774.258a.145.145 0 0 1 0 .274l-.774.258a1.156 1.156 0 0 0-.732.732l-.258.774a.145.145 0 0 1-.274 0l-.258-.774a1.156 1.156 0 0 0-.732-.732L9.1 2.137a.145.145 0 0 1 0-.274l.774-.258c.346-.115.617-.386.732-.732L10.863.1z"/>
			</svg>
			</svg>뷰티</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'publish' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=publish&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-vector-pen" viewBox="0 0 16 16">
			<path fill-rule="evenodd" d="M10.646.646a.5.5 0 0 1 .708 0l4 4a.5.5 0 0 1 0 .708l-1.902 1.902-.829 3.313a1.5 1.5 0 0 1-1.024 1.073L1.254 14.746 4.358 4.4A1.5 1.5 0 0 1 5.43 3.377l3.313-.828L10.646.646zm-1.8 2.908-3.173.793a.5.5 0 0 0-.358.342l-2.57 8.565 8.567-2.57a.5.5 0 0 0 .34-.357l.794-3.174-3.6-3.6z"/>
			<path fill-rule="evenodd" d="M2.832 13.228 8 9a1 1 0 1 0-1-1l-4.228 5.168-.026.086.086-.026z"/>
			</svg>출판</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'green' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingDiscover?category=green&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-tree-fill" viewBox="0 0 16 16">
			<path d="M8.416.223a.5.5 0 0 0-.832 0l-3 4.5A.5.5 0 0 0 5 5.5h.098L3.076 8.735A.5.5 0 0 0 3.5 9.5h.191l-1.638 3.276a.5.5 0 0 0 .447.724H7V16h2v-2.5h4.5a.5.5 0 0 0 .447-.724L12.31 9.5h.191a.5.5 0 0 0 .424-.765L10.902 5.5H11a.5.5 0 0 0 .416-.777l-3-4.5z"/>
			</svg>
			</svg>친환경</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'donate' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingDiscover?category=donate&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-gift-fill" viewBox="0 0 16 16">
			<path d="M3 2.5a2.5 2.5 0 0 1 5 0 2.5 2.5 0 0 1 5 0v.006c0 .07 0 .27-.038.494H15a1 1 0 0 1 1 1v1a1 1 0 0 1-1 1H1a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h2.038A2.968 2.968 0 0 1 3 2.506V2.5zm1.068.5H7v-.5a1.5 1.5 0 1 0-3 0c0 .085.002.274.045.43a.522.522 0 0 0 .023.07zM9 3h2.932a.56.56 0 0 0 .023-.07c.043-.156.045-.345.045-.43a1.5 1.5 0 0 0-3 0V3zm6 4v7.5a1.5 1.5 0 0 1-1.5 1.5H9V7h6zM2.5 16A1.5 1.5 0 0 1 1 14.5V7h6v9H2.5z"/>
			</svg>
			</svg>기부</a>
		</li>
		<li class="nav-item
		<c:if test="${param.category eq 'savAnimal' }">
			border-info border-bottom border-2
		</c:if>">
	    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingDiscover?category=savAnimal&status=${param.status }&index=${param.index }">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
			<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
			</svg>
			</svg>동물보호</a>
		</li>
	</ul>
	<br>
	<div class="col float-end" >
		<select class="text-dark-emphasis fw-bold" id="selectBox" onchange="chageLangSelect()">
			<option class="text-dark-emphasis fw-bold" value="all" <c:if test="${param.status eq 'all' }">selected</c:if>>전체</option>
			<option class="text-dark-emphasis fw-bold" value="active" <c:if test="${param.status eq 'active' }" >selected</c:if>>진행중</option>
			<option class="text-dark-emphasis fw-bold" value="end" <c:if test="${param.status eq 'end' }" >selected</c:if>>종료된</option>
		</select>
		<a class="text-decoration-none text-dark-emphasis fw-bold <c:if test="${param.index eq 'newest' }">border-info border-bottom border-2</c:if>" href="fundingDiscover?category=${param.category }&status=${param.status }&index=newest">최신순</a>&nbsp;
		<a class="text-decoration-none text-dark-emphasis fw-bold <c:if test="${param.index eq 'lastMin' }">border-info border-bottom border-2</c:if>" href="fundingDiscover?category=${param.category }&status=${param.status }&index=lastMin">마감임박순</a>&nbsp;
		<a class="text-decoration-none text-dark-emphasis fw-bold <c:if test="${param.index eq 'amount' }">border-info border-bottom border-2</c:if>" href="fundingDiscover?category=${param.category }&status=${param.status }&index=amount">모집금액순</a>&nbsp;
		<a class="text-decoration-none text-dark-emphasis fw-bold <c:if test="${param.index eq 'target' }">border-info border-bottom border-2</c:if>" href="fundingDiscover?category=${param.category }&status=${param.status }&index=target">목표금액순</a>
	</div>
	<br>
<!-- 프로젝트 리스트 영역 -->
	<div class="col with .gy-5 gutters">
		<small class="text-danger">${project.size() }</small><small>개의 프로젝트가 있습니다.</small>
		<div class="row row-cols-3 row-cols-sm-4 g-3">
		<!-- 페이징 처리 -->
		<c:forEach items="${project}" var="project" varStatus="status">
			<div class="col" id="projectListArea">
				<div class="card h-100 w-100 p-3 border-0">
					<img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" 
					class="card-img-top object-fit-contain" alt="..." >
					<div class="card-body">
						<small class="card-title opacity-75">${project.project_hashtag } | ${project.project_representative_name }</small>
						<p class="card-text fw-bold text-start">${project.project_subject }</p>
						<small class="card-title opacity-75">${project.project_semi_introduce }</small>
					</div>
						<a href="fundingDetail?project_idx=${project.project_idx }" class="stretched-link"></a>
					<div class="card-footer bg-white">
		      			<small class="fw-bold text-success">
		      			<fmt:formatNumber type="number" maxFractionDigits="0"  value="${project.project_cumulative_amount/project.project_target * 100 }" />%
		      			</small>&nbsp;
		      			<small class="opacity-75"><fmt:formatNumber value="${project.project_cumulative_amount }" pattern="#,###" />원
		      			<small class="fw-bold float-end">
			      			<fmt:parseDate value="${project.project_end_date }" var="projectEndDate" pattern="yyyy-MM-dd"/>
							<fmt:parseNumber value="${projectEndDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
							<fmt:parseDate value="${project.project_start_date }" var="projectStartDate" pattern="yyyy-MM-dd"/>
							<fmt:parseNumber value="${projectStartDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
							${endDate - strDate }
			      			일 남음
			      		</small></small>
		        	<div class="progress" style="height: 10px">
	  					<div class="progress-bar bg-success" id="progressbar" role="progressbar" aria-label="Success example" 
	  					style="height:10px; width: ${project.project_cumulative_amount/project.project_target * 100}%" 
	  					aria-valuenow="${project.project_cumulative_amount/project.project_target * 100}" aria-valuemin="0" aria-valuemax="100"></div>
					</div>
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
    var status = langSelect.options[langSelect.selectedIndex].value;
    var category = document.getElementById("categoryVal").value;
    var index = document.getElementById("indexVal").value;
    console.log()

    location.href = "fundingDiscover?category=" + category + "&status=" + status + "&index=" + index;
}

</script>
</body>
</html>