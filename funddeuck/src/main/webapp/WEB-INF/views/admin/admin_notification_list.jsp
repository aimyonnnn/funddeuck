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
			<form action="adminMessage" class="d-flex flex-row justify-content-end">
				<!-- 셀렉트 박스 -->
				<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
					<option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
					<option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>받는사람</option>
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
		
		<!-- 셀렉트 박스 -->
		<div class="container mt-5">
			<div class="d-flex justify-content-end row mb-3">
			    <div class="col-md-2">
			        <select class="form-select" id="filterStatus" onchange="filterNotifications()">
			            <option value="">전체</option>
			            <option value="읽지않음">읽지않음</option>
			            <option value="읽음">읽음</option>
			        </select>
			    </div>
			</div>
		</div>
			
		<div class="row">
			<div class="d-flex justify-content-center">
			
				<table class="table">
					<tr>
						<th class="text-center" style="width: 5%;">번호</th>
						<th class="text-center" style="width: 20%;">내용</th>
						<th class="text-center" style="width: 10%;">보낸시각</th>
						<th class="text-center" style="width: 5%;">받는사람</th>
						<th class="text-center" style="width: 5%;">상태</th>
						<th class="text-center" style="width: 5%;">삭제</th>
					</tr>
					
					<c:forEach var="nList" items="${nList}">
						<tr>
							<td class="text-center" style="width: 5%;">${nList.notification_idx}</td>
							<td class="text-center" style="width: 20%;">${nList.notification_content}</td>
							<td class="text-center" style="width: 10%;">
								<fmt:formatDate value="${nList.notification_regdate}" pattern="yy-MM-dd HH:mm:ss"/>
							</td>
							<td class="text-center" style="width: 10%;">${nList.member_id}</td>
							<c:choose>
								<c:when test="${nList.notification_read_status eq 1}">
									<td class="text-center text-danger" style="width: 5%;">읽지않음</td>
								</c:when>
								<c:otherwise>
									<td class="text-center" style="width: 5%;">읽음</td>
								</c:otherwise>
							</c:choose>
							<td class="text-center" style="width: 5%;">
								<input type="checkbox" class="form-check-input" onclick="deleteNotification(${nList.notification_idx})"/>
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
			                        <a class="page-link" aria-label="Previous" href="adminMessage?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
		                	<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Previous" href="adminMessage?pageNum=${pageNum - 1}">
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
	                                <li class="page-item"><a class="page-link" href="adminMessage?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a></li>
	                            </c:when>
	                            <c:otherwise>
	                                <li class="page-item"><a class="page-link" href="adminMessage?pageNum=${i}">${i}</a></li>
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
			                        <a class="page-link" aria-label="Next" href="adminMessage?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Next" href="adminMessage?pageNum=${pageNum + 1}">
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
	<!-- 페이징 처리 -->
	
	<script type="text/javascript">
	// 셀렉트 박스
    function filterNotifications() {
        let statusFilter = $("#filterStatus").val();
        $("table tr:not(:first-child)").each(function () {
            let statusCell = $(this).find("td:nth-child(5)").text().trim();
            if (statusFilter === "" || statusCell === statusFilter) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }
	// 메시지 삭제 처리
	function deleteNotification(notification_idx) {
		
		let confirmation = confirm('메시지를 삭제하시겠습니까?');
		
		if(confirmation) {
			
			$.ajax({
				method: 'get',
				url: "<c:url value='deleteNotification'/>",
				data: {
					notification_idx: notification_idx
				},
				success: function(data){
					
					if(data.trim() == 'true') {
						alert('메시지가 삭제 되었습니다!');
						location.reload();
					} else {
						alert('메시지가 삭제에 실패하였습니다.');
					}
				},
				error: function(){
					console.log('ajax 요청이 실패하였습니다!');	
				}
			});
			
			
		}
		
	}
	
	</script>
		
    <!-- bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>