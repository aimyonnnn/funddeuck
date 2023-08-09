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
</style>
</head>
<body>
<!-- 페이징 처리를 위한 pageNum 셋팅 -->
<c:set var="pageNum" value="1"/>
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }" />
</c:if>

<!-- sidebar -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<!-- top -->
<div class="main-content">
<jsp:include page="../common/admin_top.jsp"/>

	<div class="container my-5">
	<div class="container">
		<h2 class="fw-bold mt-5">프로젝트 관리</h2>
		<p class="projectContent">전체 프로젝트를 확인 할 수 있습니다.</p>
	</div>

	<!-- 검색 버튼 -->
	<div class="d-flex flex-row justify-content-center my-5">
		<!-- form 태그 시작 -->
		<form action="adminProjectManagement" class="d-flex flex-row justify-content-end">
			<!-- 셀렉트 박스 -->
			<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
				<option value="subject" <c:if test="${param.searchType eq 'subject'}">selected</c:if>>프로젝트</option>
				<option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>대표자</option>
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
	
	<div class="d-flex justify-content-end">
		<button class="btn btn-outline-primary btn-sm mb-2" onclick="location.href='excelDownload?searchType=${searchType}&searchKeyword=${searchKeyword}&pageNum=${pageNum}&listLimit=${listLimit}'">엑셀 다운로드</button>
	</div>
		
	<div class="row">
		<div class="d-flex justify-content-center">
			
			<table class="table">
				<tr>
					<th class="text-center" style="width: 5%;">번호</th>
					<th class="text-center" style="width: 5%;">카테고리</th>
					<th class="text-center" style="width: 20%;">프로젝트 이름</th>
					<th class="text-center" style="width: 5%;">대표자</th>
					<th class="text-center" style="width: 5%;">요금제</th>
					<th class="text-center" style="width: 5%;">목표금액</th>
					<th class="text-center" style="width: 10%;">기간</th>
					<th class="text-center" style="width: 5%;">상태</th>
					<th class="text-center" style="width: 5%;">상세정보</th>
				</tr>
				
				<c:forEach var="pList" items="${pList}">
					<tr>
						<td class="text-center" >${pList.project_idx}</td>
						<td class="text-center">${pList.project_category}</td>
						<td class="text-center">
							<a href="adminProjectManagementDetail?project_idx=${pList.project_idx}&pageNum=${pageNum}" style="text-decoration: none; color: black;">
								${pList.project_subject}
							</a> 
						</td>
						<td class="text-center">${pList.project_representative_name}</td>
						<td class="text-center">
							<c:choose>
								<c:when test="${pList.project_plan eq 1}">
									기본
								</c:when>
								<c:otherwise>
									인플루언서
								</c:otherwise>
							</c:choose>
						</td>
						<td class="text-center">${pList.project_target}</td>
						<td class="text-center">
   							<fmt:formatDate value="${pList.project_start_date}" pattern="yy/MM/dd" />~<fmt:formatDate value="${pList.project_end_date}" pattern="yy/MM/dd" />
						</td>
						<c:choose>
							<c:when test="${pList.project_approve_status eq 1}">
								<td class="text-center">미승인</td>
							</c:when>
							<c:when test="${pList.project_approve_status eq 2}">
								<td class="text-center text-danger">승인요청</td>
							</c:when>
							<c:when test="${pList.project_approve_status eq 3}">
								<td class="text-center text-success">승인완료</td>
							</c:when>
							<c:when test="${pList.project_approve_status eq 5}">
								<td class="text-center">결제완료</td>
							</c:when>
							<c:otherwise>
								<td class="text-center">승인거절</td>
							</c:otherwise>
						</c:choose>
						<td class="text-center" style="width: 5%;">
							<button class="btn btn-outline-primary btn-sm" 
							onclick="location.href='adminProjectManagementDetail?project_idx=${pList.project_idx}&pageNum=${pageNum}'">상세보기</button>
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
	            <%-- 현재 페이지 번호(pageNum)가 1보다 클 경우 [이전] 버튼 활성화 --%>
	            <c:choose>
	                <c:when test="${pageNum > 1}">
	                	<c:choose>
	                		<c:when test="${not empty param.searchType and not empty param.searchKeyword}">
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Previous" href="adminProjectManagement?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Previous" href="adminProjectManagement?pageNum=${pageNum - 1}">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
	                		</c:otherwise>
	                	</c:choose>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item">
	                        <a class="page-link" aria-label="Previous" onclick="alert('첫 페이지 입니다!')">
	                            <span aria-hidden="true">&laquo;</span>
	                        </a>
	                    </li>
	                </c:otherwise>
	            </c:choose>
	
	            <%-- 페이지번호 목록은 시작페이지(startPage) 부터 끝페이지(endPage) 까지 표시 --%>
	            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	                <c:choose>
	                    <%-- 현재 페이지면 하이퍼링크 제거 --%>
	                    <c:when test="${pageNum eq i}">
	                        <li class="page-item"><a class="page-link">${i}</a></li>
	                    </c:when>
	                    <c:otherwise>
	                        <%-- 검색 키워드가 있을 때와 없을 때를 구분하여 페이지 이동 URL 생성 --%>
	                        <c:choose>
	                            <c:when test="${not empty param.searchType and not empty param.searchKeyword}">
	                                <li class="page-item"><a class="page-link" href="adminProjectManagement?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a></li>
	                            </c:when>
	                            <c:otherwise>
	                                <li class="page-item"><a class="page-link" href="adminProjectManagement?pageNum=${i}">${i}</a></li>
	                            </c:otherwise>
	                        </c:choose>
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>
	
	            <c:choose>
	                <%-- 현재 페이지 번호(pageNum)가 최대 페이지 번호(maxPage) 보다 작을 경우 [다음] 버튼 활성화 --%>
	                <c:when test="${pageNum < pageInfo.maxPage}">
	                	<c:choose>
	                		<c:when test="${not empty param.searchType and not empty param.searchKeyword}">
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Next" href="adminProjectManagement?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Next" href="adminProjectManagement?pageNum=${pageNum + 1}">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
	                		</c:otherwise>
	                	</c:choose>
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
</div>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>