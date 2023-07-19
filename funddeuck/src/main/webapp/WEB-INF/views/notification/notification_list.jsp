<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- bootstrap -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
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
	</style>
</head>
<body>
	<jsp:include page="../common/project_top.jsp"/>
	
	<div class="container my-5">
		<div class="row">
			<div class="d-flex justify-content-center">
			
				<table class="table">
					<tr>
						<th class="text-center" style="width: 5%;">번호</th>
						<th class="text-center" style="width: 20%;">내용</th>
						<th class="text-center" style="width: 10%;">받은시각</th>
						<th class="text-center" style="width: 5%;">상태</th>
						<th class="text-center" style="width: 5%;">읽음처리하기</th>
					</tr>
					
					<c:forEach var="nList" items="${nList}">
						<tr>
							<td class="text-center" style="width: 5%;">${nList.notification_idx}</td>
							<td class="text-center" style="width: 20%;">${nList.notification_content}</td>
							<td class="text-center" style="width: 10%;">
								<fmt:formatDate value="${nList.notification_regdate}" pattern="yy-MM-dd HH:mm:ss"/>
							</td>
							<c:choose>
								<c:when test="${nList.notification_read_status eq 1}">
									<td class="text-center" style="width: 5%;">읽지않음</td>
								</c:when>
								<c:otherwise>
									<td class="text-center" style="width: 5%;">읽음</td>
								</c:otherwise>
							</c:choose>
							<td class="text-center" style="width: 5%;">
								<input type="checkbox" class="form-check-input" onclick=""/>
							</td>
						</tr>
					</c:forEach>
					
				</table>
		
			</div>
		</div>
	</div>		
	
   <!-- bootstrap -->
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>