<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Maker</title>
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="styleSheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<style>
.maker-img {
  max-height: 200px; /* 원하는 높이 값으로 변경 */
  object-fit: cover; /* 이미지가 캐러셀 영역에 꽉 차도록 조절 */
}
</style>
<script type="text/javascript">
	$(function() {
		isFollow();
	});
	
	function isFollow() {
		
		var sId = "";
		
		sId = "${sessionScope.sId}";
		
		if(sId != ""){
			$.ajax({
				type:"Post",
				url:"makerDetailFollow",
				data:{maker_idx:${param.maker_idx}},
				dataType:"text",
				success: function(data) {
					
					if(data == "true"){
						
						$("#follow").empty();
						$("#follow").append(
								'<button class="btn btn-primary w-100" onclick="follow(0)">'
								+'Following'
								+'</button>');
					} else {
						$("#follow").empty();
						$("#follow").append(
								'<button class="btn btn-outline-primary w-100" onclick="follow(1)">'
								+'+Follow'
								+'</button>');
					}
					
				},
				error: function() {
						alert("완전실패");
				}
			});
		} else {
			$("#follow").empty();
			$("#follow").append(
					'<button class="btn btn-outline-primary w-100">'
					+'로그인 후 팔로잉 하실 수 있습니다.'
					+'</button>');
		}
	}
	
	function follow(num) {
var sId = "";
		
		sId = "${sessionScope.sId}";
		
		if(sId != ""){
			$.ajax({
				type:"Post",
				url:"makerDetailFollowCheck",
				data:{maker_name:"${maker.maker_name}"
					, isFollow:num},
				dataType:"text",
				success: function(data) {
					
					if(data == "true"){
						
						if(num == 1){
							$("#follow").empty();
							$("#follow").append(
									'<button class="btn btn-primary w-100" onclick="follow(0)">'
									+'Following'
									+'</button>');
						} else {
							$("#follow").empty();
							$("#follow").append(
									'<button class="btn btn-outline-primary w-100" onclick="follow(1)">'
									+'+Follow'
									+'</button>');
						}
					}
					
				},
				error: function() {
						alert("완전실패");
				}
			});
		} else {
			
		}
	}
	
</script>
</head>
<body>
<jsp:include page="../Header.jsp"></jsp:include>
<div class="container" style="max-width: 600px;">
	<div class="row">
		<div class="col">

			<!-- 메이커 이미지 -->
			<div class="d-flex justify-content-center my-2">
				<img
					src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file4}"
					alt="메이커 사진을 업로드 해주세요" class="img-fluid" style="max-height: 400px;">
			</div>
			
			<div class="my-4">

				<div class="container">
					<div class="row">
						<div class="col-sm-12">
							<div>
								<h4><b>${maker.maker_name}</b><br></h4>
								<span>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-check" viewBox="0 0 16 16">
									  	<path d="M7.293 1.5a1 1 0 0 1 1.414 0L11 3.793V2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v3.293l2.354 2.353a.5.5 0 0 1-.708.708L8 2.207l-5 5V13.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 1 0 1h-4A1.5 1.5 0 0 1 2 13.5V8.207l-.646.647a.5.5 0 1 1-.708-.708L7.293 1.5Z"/>
									 	<path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7Zm1.679-4.493-1.335 2.226a.75.75 0 0 1-1.174.144l-.774-.773a.5.5 0 0 1 .708-.707l.547.547 1.17-1.951a.5.5 0 1 1 .858.514Z"/>
									</svg>
									${maker.maker_intro}
								</span>
							</div>
						
							<div class="supporters">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16">
								   <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/>
								</svg>
	          					서포터 수&nbsp;:&nbsp;
	          					<c:choose>
		          					<c:when test="${empty totalAcmlSupporters}">
		          						0명
		          					</c:when>
		          					<c:otherwise>
			          					${totalAcmlSupporters}명
		          					</c:otherwise>
	          					</c:choose>
							</div>
							
						</div>
					</div>
				</div>
				
				<%-- maker 테이블의 member_idx와 세션아이디로 조회한 member_idx가 같을 때 수정하기 버튼 출력 --%>
				<c:if test="${sessionScope.sId != null && (maker.member_idx eq member_idx)}">
				    <div class="d-flex justify-content-end">
				        <form action="modifyMakerForm" method="get">
				            <input type="hidden" name="maker_idx" value="${maker.maker_idx}" />
				            <input type="hidden" name="tab" value="1" />
				            <button type="submit" class="btn btn-outline-primary">공지사항 작성하기</button>
				        </form>
				    </div>
				</c:if>
				
				<!-- 팔로우 -->
				<div class="text-center my-2" id="follow">

				</div>

				<!-- 탭 -->
				<div class="tab-buttons text-center">
					<button class="btn btn-outline-primary tab-button w-100 active"
						data-tab="tab1">프로젝트</button>
					<button class="btn btn-outline-primary tab-button w-100"
						data-tab="tab2">메이커정보</button>
				</div>

				<!-- 메이커의 프로젝트 리스트 출력 -->
				<div class="content-area" id="tab1">
					<div>
						<c:forEach var="pList" items="${pList}">
							<div class="container mb-4">
								<div class="row">
									<div class="card col-md-6 col-lg-12">
									  <img src="${pageContext.request.contextPath}/resources/upload/${pList.project_image}"
											 alt="project_image를 업로드 해주세요" class="img-fluid maker-img mt-2">
									  <div class="card-body">
									    <div class="card-text makerSubject">${pList.project_subject}</div>
									    <div class="card-text">${pList.project_semi_introduce}</div>
									    <div>
									    	<button type="button" class="btn btn-primary w-100 mt-2"
									    	onclick="location.href='fundingDetail?project_idx=${pList.project_idx}'">프로젝트 후원하기</button>
									    </div>
									  </div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				
				<!-- 메이커 정보 -->
				<div class="content-area" id="tab2">
					<table class="table text-center">
						<tr>
							<th>상호명</th>
							<td>${maker.maker_name}</td>
						</tr>
						<tr>
							<th>메이커 소개</th>
							<td>${maker.maker_intro}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${maker.maker_email}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${maker.maker_tel}</td>
						</tr>
						<tr>
							<th>홈페이지</th>
							<td>${maker.maker_url}</td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td>120-88-00767</td>
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${not empty maker.corporate_biz_num or not empty maker.individual_biz_num}"> --%>
<%-- 									<c:if test="${not empty maker.corporate_biz_num && empty maker.individual_biz_num}"> --%>
<%-- 										<td>${maker.corporate_biz_num}</td> --%>
<%-- 									</c:if> --%>
<%-- 									<c:if test="${empty maker.corporate_biz_num && not empty maker.individual_biz_num}"> --%>
<%-- 										<td>${maker.individual_biz_num}</td> --%>
<%-- 									</c:if> --%>
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<!-- 										<td>사업자등록번호 없음</td> -->
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
// 탭 버튼 클릭 시
$(document).ready(function() {
	
	$("#tab1").addClass("active");
	$(".tab-button").click(function() {
		
		var tabId = $(this).data("tab");
		$(".content-area").removeClass("active");
		$("#" + tabId).addClass("active");
		
	});
	
});

// 탭 버튼 클릭시 active 효과
$(document).ready(function() {
	
	// 버튼1 클릭 시
	$(".tab-button[data-tab='tab1']").click(function() {
		$(".tab-button[data-tab='tab1']").addClass("active");
	  	$(".tab-button[data-tab='tab2']").removeClass("active");
	});
	
	// 버튼2 클릭 시
	$(".tab-button[data-tab='tab2']").click(function() {
	  	$(".tab-button[data-tab='tab1']").removeClass("active");
	  	$(".tab-button[data-tab='tab2']").addClass("active");
	});
	
});

// 수정하기 버튼 클릭 시 메이커 수정하기 폼으로 이동
function redirectToModifyMakerForm(makerIdx) {
	var newUrl = 'modifyMakerForm?maker_idx=' + makerIdx;
	window.location.href = newUrl;
}
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
