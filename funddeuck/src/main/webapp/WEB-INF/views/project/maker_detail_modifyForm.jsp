<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>project_detail</title>
	<!--bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- css -->
	<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="styleSheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
</head>
<body>
	<jsp:include page="../common/main_header.jsp"/>
	
	<div class="container" style="max-width: 600px;">
	  <div class="row">
	    <div class="col">
		<!--  -->
		
		  <!-- 이미지 -->
	      <div class="d-flex justify-content-center my-2">
	        <img src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file4}" alt="메이커사진" class="img-fluid" style="max-height: 400px;">
	      </div>
		
		  <!-- 기업소개 -->
	      <div class="my-4">
	        <h4><b>${maker.maker_name }</b></h4>
	        <p>차량용품 제조&판매 기업입니다.</p>
	        
			  <div class="container">
			    <div class="row">
			      <div class="col-sm-6">
			        <!-- 만족도 정보 -->
			        <a class="star-rating">
			          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
			            <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
			          </svg>만족도:&nbsp;<span>4.0</span>
			        </a>
			        <br>
			        <!-- 서포터 정보 -->
			        <a class="supporters">
			          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-plus-fill" viewBox="0 0 16 16">
			            <path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
			            <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z"/>
			          </svg>서포터:&nbsp;<span>19명</span>
			        </a>
			      </div>
			      <div class="col-sm-6 d-flex justify-content-end align-items-center">
			      </div>
			    </div>
			  </div>

			  <!-- Follow 버튼 -->
		      <div class="text-center my-2">
		        <button class="btn btn-primary w-100">+ Follow<span>239</span></button>
		      </div>
				
			  <!-- Tab 버튼 -->
		      <div class="tab-buttons text-center">
		      	<button class="btn btn-outline-primary tab-button w-100 active" data-tab="tab1">프로젝트</button>
		      	<button class="btn btn-outline-primary tab-button w-100" data-tab="tab2">메이커정보</button>
		      </div>
				
			  <!-- 프로젝트 -->
		      <div class="content-area" id="tab1">
		        <p>메이커의 프로젝트 리스트를 출력</p>
		      </div>
	      	  <!-- 메이커 정보 -->
		      <div class="content-area" id="tab2">
		      	  <!-- 폼 태그 -->
		      	  <form action="" method="post" id="modifyForm" enctype="multipart/form-data"> 	
				  <table class="table text-center">
				    <tr>
				      <th>상호명</th>
				      <td><input type="text" name="maker_name" value="${maker.maker_name }" ></td>
				    </tr>
				    <tr>
				      <th>이메일</th>
				      <td><input type="text" name="maker_email" value="${maker.maker_email }" ></td>
				    </tr>
				    <tr>
				      <th>전화번호</th>
				      <td><input type="text" name="maker_tel" value="${maker.maker_tel }" ></td>
				    </tr>
				    <tr>
				      <th>홈페이지</th>
				      <td><input type="text" name="maker_url" value="${maker.maker_url }" ></td>
				    </tr>
				    <tr>
				      <th>메이커 사진</th>
				      <td><input type="file" name="file4"></td>
				    </tr>
				    <tr>
				      <th>메이커 로고</th>
				      <td><input type="file" name="file5"></td>
				    </tr>
				    <c:choose>
				      <c:when test="${not empty maker.corporate_biz_num or not empty maker.individual_biz_num}">
				        <tr>
				          <th>사업자등록번호</th>
				          <td>${maker.corporate_biz_num} ${maker.individual_biz_num}</td>
				        </tr>
				      </c:when>
				      <c:otherwise>
				        <tr>
				          <th>사업자등록번호</th>
				          <td>120-88-00767</td>
				        </tr>
				      </c:otherwise>
				    </c:choose>
				  </table>
				  </form>
				  <!-- 폼 태그 -->
				  <button class="btn btn-primary btn-sm" onclick="modifyMaker(${param.maker_idx})">수정하기</button>
			  </div>
	      </div>
	      
    	<!--  -->  
	    </div>
	  </div>
	</div>

	<script>
	// 탭 버튼 클릭 시
	$(document).ready(function () {
    	$("#tab1").addClass("active");
	    $(".tab-button").click(function () {
		    var tabId = $(this).data("tab");
		    $(".content-area").removeClass("active");
		    $("#" + tabId).addClass("active");
	    });
	 });
	 // 탭 버튼 클릭시 active 효과
	 $(document).ready(function() {
	    // 버튼1 클릭 시
	    $(".tab-button[data-tab='tab1']").click(function() {
		   	$(".tab-button[data-tab='tab2']").removeClass("active");
		   	$(".tab-button[data-tab='tab1']").addClass("active");
	    });
		// 버튼2 클릭 시
	 	$(".tab-button[data-tab='tab2']").click(function() {
		    $(".tab-button[data-tab='tab1']").removeClass("active");
		    $(".tab-button[data-tab='tab2']").addClass("active");
	    });
	});

	// maker 수정하기
	function modifyMaker(maker_idx) {
		
		let confirmation = confirm('메이커를 정보를 수정 하시겠습니까?')
		
		if(confirmation) {
			$.ajax({
			    type: "post",
			    url: "<c:url value='modifyMaker'/>",
		        data: $("#modifyForm").serialize() + "&maker_idx=" + maker_idx,
			    dataType: "text",
			    success: function (response) {
			    	
			    	if(response.trim() == 'true') {
				        alert("성공적으로 수정되었습니다!");
				        location.href = '<c:url value="modifyMakerForm?maker_idx="/>' + maker_idx;
			    	} else {
			    		alert("수정에 실패했습니다.");
			    	}
			    },
			    error: function (error) {
			        console.error(error);
			        alert("수정에 실패했습니다.");
			    }
			}); // ajax
		}
    }
	 
	</script>

	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
  
</body>
</html>
