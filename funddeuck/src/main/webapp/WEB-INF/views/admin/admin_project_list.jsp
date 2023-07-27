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
	<jsp:include page="../common/admin_top.jsp"/>
	<!-- pageNum 파라미터 가져와서 저장(기본값 1로 지정함) -->
	<c:set var="pageNum" value="1"/>
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>
	
	<div class="container my-5">
		<!-- 검색 버튼 -->
		<div class="d-flex flex-row justify-content-center my-3">
			<!-- form 태그 시작 -->
			<form action="adminProjectList" class="d-flex flex-row justify-content-end">
				<!-- 셀렉트 박스 -->
				<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
					<option value="subject" <c:if test="${param.searchType eq 'subject'}">selected</c:if>>제목</option>
					<option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>이름</option>
				</select>
				<!-- 검색타입, 검색어 -->
				<div class="input-group">
					<input type="text" class="form-control form-control-sm" name="searchKeyword" value="${param.searchKeyword}" id="searchKeyword"
						aria-describedby="button-addon2" style="width: 500px;">
					<button class="btn btn-outline-secondary btn-sm" type="submit" value="검색" id="button-addon2">검색</button>
				</div>
			</form>
			<!-- form 태그 끝 -->	
		</div>
		<!-- 검색 버튼 -->
		
		<!-- 셀렉트 박스 -->
		<div class="container mt-5">
			<div class="d-flex justify-content-end row mb-3">
			    <div class="col-md-2">
			        <select class="form-select" id="filterStatus" onchange="filterNotifications()">
			            <option value="">전체</option>
			            <option value="승인요청">승인요청</option>
			            <option value="승인완료">승인완료</option>
			            <option value="승인거절">승인거절</option>
			        </select>
			    </div>
			</div>
		</div>
			
		<div class="row">
			<div class="d-flex justify-content-center">
				
				<table class="table">
					<tr>
						<th class="text-center" style="width: 5%;">프로젝트 번호</th>
						<th class="text-center" style="width: 20%;">프로젝트 이름</th>
						<th class="text-center" style="width: 10%;">대표자 이름</th>
						 <!-- 프로젝트 승인 상태 1-미승인 2-승인요청 3-승인 4-반려 -->
						<th class="text-center" style="width: 5%;">상태</th>
						<th class="text-center" style="width: 5%;">승인처리</th>
						<th class="text-center" style="width: 5%;">반려처리</th>
					</tr>
					
					<c:forEach var="pList" items="${pList}">
						<tr>
							<td class="text-center" style="width: 5%;">${pList.project_idx}</td>
							<td class="text-center" style="width: 20%;">
								<a href="adminProjectDetail?project_idx=${pList.project_idx}&pageNum=${pageNum}" style="text-decoration: none; color: black;">
									${pList.project_subject}
								</a> 
							</td>
							<td class="text-center" style="width: 20%;">${pList.project_representative_name}</td>
							<c:choose>
								<c:when test="${pList.project_approve_status eq 1}">
									<td class="text-center" style="width: 5%;">미승인</td>
								</c:when>
								<c:when test="${pList.project_approve_status eq 2}">
									<td class="text-center text-danger" style="width: 5%;">승인요청</td>
								</c:when>
								<c:when test="${pList.project_approve_status eq 3}">
									<td class="text-center text-success" style="width: 5%;">승인완료</td>
								</c:when>
								<c:otherwise>
									<td class="text-center" style="width: 5%;">승인거절</td>
								</c:otherwise>
							</c:choose>
							<td class="text-center" style="width: 5%;">
								<input type="checkbox" class="form-check-input" onclick="updateProjectStatus(${pList.project_idx}, 3)"/>
							</td>
							<td class="text-center" style="width: 5%;">
								<input type="checkbox" class="form-check-input" onclick="updateProjectStatusRejection(${pList.project_idx}, 4)"/>
							</td>
						</tr>
					</c:forEach>
				</table>
		
			</div>
		</div>
	</div>		
	
	<!-- 페이징 처리 -->
	<div class="my-5">
		<nav aria-label="Page navigation example" class="d-flex flex-row justify-content-center">
		  <ul class="pagination">
		    
	    	<%--
				현재 페이지 번호(pageNum)가 1보다 클 경우에만 [이전] 버튼 동작
				=> 클릭 시 BoardList 서블릿 요청(파라미터 : 현재 페이지번호 - 1)
			--%>
			 <c:choose>
			 	<c:when test="${pageNum > 1}">
			 		<li class="page-item">	
				      <a class="page-link" aria-label="Previous" onclick="location.href='adminProjectList?pageNum=${pageNum - 1}'">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
			       </li>
			 	</c:when>
			 	<c:otherwise>
			 		<li class="page-item">
				      <a class="page-link" aria-label="Previous" onclick="alert('첫 페이지 입니다!')">
				        <span aria-hidden="true">&laquo;</span>
				      </a>
			       </li>
			 	</c:otherwise>
			 </c:choose>
			 <%-- --%>
			 
	 		<%-- 페이지번호 목록은 시작페이지(startPage) 부터 끝페이지(endPage) 까지 표시 --%>
		    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
			    <%-- 각 페이지마다 하이퍼링크 설정(단, 현재 페이지는 하이퍼링크 제거) --%>
				<c:choose>
					<c:when test="${pageNum eq i}">
					    <li class="page-item"><a class="page-link">${i}</a></li>
					</c:when>
					<c:otherwise>
					    <li class="page-item"><a class="page-link" href="adminProjectList?pageNum=${i}">${i}</a></li>
					</c:otherwise>
				</c:choose>
		    </c:forEach>
		    
		    <%--
				현재 페이지 번호(pageNum)가 최대 페이지 번호(maxPage) 보다 작을 경우에만 [다음] 버튼 동작
				=> 클릭 시 BoardList.bo 서블릿 요청(파라미터 : 현재 페이지번호 + 1)
			--%>
			<c:choose>
				<c:when test="${pageNum < pageInfo.maxPage}">
				    <li class="page-item">
				      <a class="page-link" aria-label="Next" onclick="location.href='adminProjectList?pageNum=${pageNum + 1}'">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				</c:when>
				<c:otherwise>
				    <li class="page-item">
				      <a class="page-link" aria-label="Next" onclick="alert('마지막 페이지 입니다!')">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>
				</c:otherwise>
			</c:choose>
		    
		  </ul>
		</nav>
	</div>
	<!-- 페이징 처리 -->
	
	<script type="text/javascript">
	// 셀렉트 박스
    function filterNotifications() {
        let statusFilter = $("#filterStatus").val();
        $("table tr:not(:first-child)").each(function () {
            let statusCell = $(this).find("td:nth-child(4)").text().trim();
            if (statusFilter === "" || statusCell === statusFilter) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }
	// 프로젝트 승인 처리
	function updateProjectStatus(project_idx, project_approve_status) {
		
		let confirmation = confirm('프로젝트 상태를 변경하시겠습니까?');
		
		if(confirmation) {
			
			$.ajax({
				method: 'get',
				url: "<c:url value='updateProjectStatus'/>",
				data: {
					project_idx: project_idx,
					project_approve_status: project_approve_status
				},
				success: function(data){
					
					if(data.trim() == 'true') {
						alert('프로젝트 상태가 변경되었습니다.');
						location.reload();
					} else {
						alert('프로젝트 상태 변경에 실패하였습니다.');
					}
				},
				error: function(){
					console.log('ajax 요청이 실패하였습니다!');	
				}
			});
		} else {
			// 취소 선택 시 체크박스 해제
			$('input[type=checkbox]').prop('checked', false);
		}
	}
	// 프로젝트 반려 처리
	function updateProjectStatusRejection(project_idx, project_approve_status) {
		
		let confirmation = confirm('프로젝트 반려 처리를 하시겠습니까?');
		
		if(confirmation) {
			
			$.ajax({
				method: 'get',
				url: "<c:url value='updateProjectStatus'/>",
				data: {
					project_idx: project_idx,
					project_approve_status: project_approve_status
				},
				success: function(data){
					
					if(data.trim() == 'true') {
						alert('프로젝트 반려 처리가 완료되었습니다.');
						location.reload();
					} else {
						alert('프로젝트 승인 처리 실패하였습니다.');
					}
				},
				error: function(){
					console.log('ajax 요청이 실패하였습니다!');	
				}
			});
		} else {
			// 취소 선택 시 체크박스 해제
			$('input[type=checkbox]').prop('checked', false);
		}
	}
	</script>
		
    <!-- bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>