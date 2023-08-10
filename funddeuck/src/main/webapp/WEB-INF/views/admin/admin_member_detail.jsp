<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style>
table {
    width: 100%; /* 테이블의 전체 너비를 100%로 설정 */
    table-layout: fixed; /* 테이블 레이아웃을 고정으로 설정 */
}
th, td {
    width: 10%; /* 각 셀의 너비를 20%로 설정 */
}
.hover-effect:hover {
 	text-decoration: underline; /* 제목 클릭 시 밑줄 효과 */
}

.card-text-container {
	height: 300px;
	overflow-y: scroll;
	padding-right: 1rem; 
	font-size: 14px;
}

.card-text-container .activity-item {
    background-color: #f8f8f8; 
    margin-bottom: 10px;
    padding: 8px;
}

.activityDate {
	font-size: 11px;
}

</style>
</head>
<body>
	<!-- sidebar -->
	<input type="checkbox" name="" id="sidebar-toggle">
	<jsp:include page="../common/admin_side.jsp"/>
	
	<!-- top -->
	<div class="main-content">
	<jsp:include page="../common/admin_top.jsp"/>
	
	<div class="container">
		<h2 class="fw-bold mt-5">회원 정보 보기</h2>
		<p class="projectContent">회원의 모든 정보를 확인하고 수정할 수 있습니다.</p>
	</div>
		
	<div class="container mt-2" style="max-width: 1000px;">
		<div class="row">
			<div class="col">

	       		<!-- 회원 정보수정 -->
	       		<div class="content-area" id="tab1">
            		<div class="row">
		                <!-- 회원 정보 테이블 -->
		                <div class="col-12 col-md-6">
		                    <!-- 폼 태그 -->
                  			<form action="adminModifyMember" method="post" id="modifyForm" enctype="multipart/form-data">
                        		<input type="hidden" name="pageNum" value="${param.pageNum}">
		                        <input type="hidden" name="member_idx" value="${member.member_idx}">
		                        <table class="table text-start">
                           			<tr>
		                                <th style="width: 30%">회원 이름</th>
		                                <td style="width: 70%"><input type="text" name="member_name" class="form-control"
		                                value="${member.member_name}"></td>
                            		</tr>
		                            <tr>
		                                <th>전화번호</th>
		                                <td><input type="text" name="member_phone" class="form-control"
		                                value="${member.member_phone}"></td>
		                            </tr>
		                            <tr>
		                                <th>이메일</th>
		                                <td><input type="text" name="member_email" class="form-control"
		                                value="${member.member_email}"></td>
		                            </tr>
		                            <tr>
		                                <th>회원 상태</th>
		                                <td><input type="text" name="member_status" class="form-control"
		                                value="${member.member_status}"></td>
		                            </tr>
		                            <tr>
		                                <th>로그인 실패</th>
		                                <td><input type="text" name="false_count" class="form-control"
		                                value="${member.false_count}"></td>
		                            </tr>
                        		</table>
		                        <div class="d-flex justify-content-center">
		                            <input type="submit" value="수정하기" class="btn btn-outline-primary">
		                        </div>
                    		</form>
                   			 <!-- 폼 태그 -->
               			</div>
                		<!-- 회원 활동내역 -->
                		<div class="col-12 col-md-6">
                   			<div class="card">
		                        <div class="card-header">
		                            회원 활동내역
		                        </div>
		                        <div class="card-body">
		                            <!-- 회원 활동내역 내용 -->
		                            <div class="card-text-container">
										<c:forEach var="activity" items="${memberActivityList}">
												<c:if test="${activity.activity_type == 'payment'}">
													<div class="activity-item">
														펀딩 <b><c:out value="${activity.content}"/></b> 원을 결제했습니다.<span class="activityDate"> | <c:out value="${activity.activity_date}"/></span>
													</div>
												</c:if>
												<c:if test="${activity.activity_type == 'review'}">
													<div class="activity-item">
														리뷰 <b><c:out value="${activity.content}"/></b>를 작성했습니다.<span class="activityDate"> | <c:out value="${activity.activity_date}"/></span>
													</div>
												</c:if>
												<c:if test="${activity.activity_type == 'project_community'}">
													<div class="activity-item">
														프로젝트 게시판에 <b><c:out value="${activity.content}"/></b>을/를 작성했습니다.<span class="activityDate"> | <c:out value="${activity.activity_date}"/></span>
													</div>
												</c:if>
												<c:if test="${activity.activity_type == 'idea'}">
													<div class="activity-item">
														아이디어 게시판에 <b><c:out value="${activity.content}"/></b>을/를 작성했습니다.<span class="activityDate"> | <c:out value="${activity.activity_date}"/></span>
													</div>
												</c:if>
									    </c:forEach>
		                            </div>
		                        </div>
                    		</div>
               			</div>
            		</div>
        		</div>
    		</div>
		</div>
	</div>
	</div>

<script>
//탭 버튼 클릭 시
$(document).ready(function() {
	$("#tab1").addClass("active");
});
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>