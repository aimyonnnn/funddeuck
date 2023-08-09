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
<input type="hidden" value="${param.searchKeyword }" id="searchKeywordVal">
<input type="hidden" value="${param.status }" id="statusVal">
<input type="hidden" value="${param.index }" id="indexVal">
<!-- 상단 이동 버튼 -->
	<button type="button" class="btn btn-dark position-fixed bottom-0 end-0" id="go-top">
    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-arrow-up-square-fill" viewBox="0 0 16 16">
	<path d="M2 16a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2zm6.5-4.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 1 0z"/>
	</svg>&nbsp;상단으로
	</button>
<br>
<!-- 카테고리 바 영역(화면 클때) -->
<div class="container-lg">
	<span class="fs-2 text-info fw-bold">${param.searchKeyword }</span><span class="fs-2 fw-bold">&nbsp;검색결과</span>&nbsp;
	<small class="text-info fw-bold">${project.size() }</small><small class="fw-bold">개</small>
	<br>
	<div class="col float-end" >
		<select class="text-dark-emphasis fw-bold" id="selectBox" onchange="chageLangSelect()">
			<option class="text-dark-emphasis fw-bold" value="all" <c:if test="${param.status eq 'all' }">selected</c:if>>전체</option>
			<option class="text-dark-emphasis fw-bold" value="noStart" <c:if test="${param.status eq 'noStart' }">selected</c:if>>진행전</option>
			<option class="text-dark-emphasis fw-bold" value="active" <c:if test="${param.status eq 'active' }" >selected</c:if>>진행중</option>
			<option class="text-dark-emphasis fw-bold" value="end" <c:if test="${param.status eq 'end' }" >selected</c:if>>종료된</option>
		</select>
		<a class="text-decoration-none text-dark-emphasis fw-bold <c:if test="${param.index eq 'newest' or empty param.index }">border-info border-bottom border-2</c:if>" href="fundingSearchKeyword?searchKeyword=${param.searchKeyword }&status=${param.status }&index=newest">최신순</a>&nbsp;
		<a class="text-decoration-none text-dark-emphasis fw-bold <c:if test="${param.index eq 'amount' }">border-info border-bottom border-2</c:if>" href="fundingSearchKeyword?searchKeyword=${param.searchKeyword }&status=${param.status }&index=amount">모집금액순</a>&nbsp;
		<a class="text-decoration-none text-dark-emphasis fw-bold <c:if test="${param.index eq 'target' }">border-info border-bottom border-2</c:if>" href="fundingSearchKeyword?searchKeyword=${param.searchKeyword }&status=${param.status }&index=target">목표금액순</a>
	</div>
	<br>
	<div>&nbsp;</div>
	<hr><br>
	
	<!--  -->
	<div class="container-lg col with .gy-5 gutters">
		<c:if test="${not empty project}">
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
			      			<fmt:parseDate value="${project.project_end_date }" var="projectEndDate" pattern="yyyy-MM-dd"/>
							<fmt:parseNumber value="${projectEndDate.time / (1000*60*60*24)}" integerOnly="true" var="endDate"></fmt:parseNumber>
							<fmt:parseDate value="${project.project_start_date }" var="projectStartDate" pattern="yyyy-MM-dd"/>
							<fmt:parseNumber value="${projectStartDate.time / (1000*60*60*24)}" integerOnly="true" var="strDate"></fmt:parseNumber>
			      			<!-- 아직 진행되지 않은 프로젝트의 경우 -->
			      			<c:if test="${project.project_status eq 1 }">
			      			<small class="fw-bold float-end text-danger">
								미진행
			      			</small>
			      			</c:if>
			      			<!-- 프로젝트가 진행중이며, 아직 진행일이 남아있을 경우 -->
			      			<c:if test="${project.project_status eq 2 && endDate - strDate ne 0 }">
			      			<small class="fw-bold float-end">
								${endDate - strDate }
				      			일 남음
			      			</small>
			      			</c:if>
			      			<!-- 프로젝트가 진행중이지만, 오늘 종료될 경우 -->
			      			<c:if test="${project.project_status eq 2 && endDate - strDate eq 0 }">
			      			<small class="fw-bold float-end text-danger">
								오늘 종료
			      			</small>
			      			</c:if>
			      			<!-- 이미 종료된 프로젝트의 경우 -->
			      			<c:if test="${project.project_status eq 3 || project.project_status eq 4 || project.project_status eq 5 }">
			      			<small class="fw-bold float-end text-danger">
								종료됨
			      			</small>
			      			</c:if>
			      		</small>
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
		</c:if>
		<c:if test="${empty project}">
			<div class="page-content container-fluid note-has-grid">
				<ul class="nav nav-pills p-3 bg-white mb-3 rounded-0 align-items-center">
					<li class="nav-item">
						<a class="fw-bold fs-2 text-dark text-decoration-none">검색 결과가 없어요</a><br>
						<small class="fw-bold opacity-75">새 프로젝트를 아래의 카테고리에서 찾아보세요</small>
					</li>
				</ul>
				<ul class="nav justify-content-start">
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=tech&status=${param.status }&index=${param.index }">
						테크·가전</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=fashion&status=${param.status }&index=${param.index }">
						패션·잡화</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=living&status=${param.status }&index=${param.index }">
						홈·리빙</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=beauty&status=${param.status }&index=${param.index }">
						뷰티</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" href="fundingDiscover?category=publish&status=${param.status }&index=${param.index }">
						출판</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingDiscover?category=green&status=${param.status }&index=${param.index }">
						친환경</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingDiscover?category=donate&status=${param.status }&index=${param.index }">
						기부</a>
					</li>
					<li class="nav-item">
				    	<a class="nav-link active text-decoration-none text-dark fw-bold fs-6" aria-current="page" href="fundingDiscover?category=savAnimal&status=${param.status }&index=${param.index }">
						동물보호</a>
					</li>
				</ul>
			</div>
		</c:if>
	</div>
</div>
<br>
<script type="text/javascript">
// 셀렉트 박스 이벤트 스크립트
function chageLangSelect(){
    var langSelect = document.getElementById("selectBox");
     
    // select element에서 선택된 option의 value가 저장된다.
    var searchKeyword = document.getElementById("searchKeywordVal").value;
    var status = langSelect.options[langSelect.selectedIndex].value;
    var index = document.getElementById("indexVal").value;

    location.href = "fundingSearchKeyword?searchKeyword=" + searchKeyword + "&status=" + status + "&index=" + index;
}
</script>
</body>
</html>