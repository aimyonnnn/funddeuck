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
		<h2 class="fw-bold mt-5">결제 관리</h2>
		<p class="projectContent">전체 결제 내역을 확인 할 수 있습니다.</p>
	</div>

	<!-- 검색 버튼 -->
	<div class="d-flex flex-row justify-content-center my-5">
		<!-- form 태그 시작 -->
		<form action="adminPayment" class="d-flex flex-row justify-content-end">
			<!-- 셀렉트 박스 -->
			<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
				<option value="phone" <c:if test="${param.searchType eq 'phone'}">selected</c:if>>연락처</option>
				<option value="email" <c:if test="${param.searchType eq 'email'}">selected</c:if>>이메일</option>
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
		
	<!-- pc사이즈에서만 보임 -->
	<div class="row col-md-12 d-none d-md-block">
		<div class="d-flex justify-content-center">
			<table class="table">
				<tr>
					<th class="text-center" style="width: 5%;">번호</th>
					<th class="text-center" style="width: 8%;">연락처</th>
					<th class="text-center" style="width: 13%;">이메일</th>
					<th class="text-center" style="width: 5%;">리워드금액</th>
					<th class="text-center" style="width: 5%;">주문수량</th>
					<th class="text-center" style="width: 5%;">최종금액</th>
					<th class="text-center" style="width: 5%;">주문날짜</th>
					<th class="text-center" style="width: 5%;">승인여부</th>
					<th class="text-center" style="width: 5%;">상세정보</th>
				</tr>
				<c:forEach var="pList" items="${pList}">
					<tr>
						<td class="text-center" >${pList.payment_idx}</td>
						<td class="text-center">${pList.member_phone}</td>
						<td class="text-center">${pList.member_email}</td>
						<td class="text-center">
							<fmt:formatNumber pattern="#,##0" value="${pList.reward_amount}" var="rewardAmount" />
							${rewardAmount}원						
						</td>
						<td class="text-center">${pList.payment_quantity}</td>
						<td class="text-center">
							<fmt:formatNumber pattern="#,##0" value="${pList.total_amount}"  var="paymentQuantity"/>
							${paymentQuantity}원
						</td>
						<td class="text-center">
							<fmt:formatDate value="${pList.payment_date}" pattern="yy-MM-dd"/>
						</td>
						<td class="text-center">
							<c:choose>
								<c:when test="${pList.payment_confirm eq 1}">예약완료</c:when>
								<c:when test="${pList.payment_confirm eq 2}">결제완료</c:when>
								<c:when test="${pList.payment_confirm eq 3}">반환신청</c:when>
								<c:when test="${pList.payment_confirm eq 4}">반환완료</c:when>
								<c:when test="${pList.payment_confirm eq 5}">반환거절</c:when>
							</c:choose>
						</td>
						<td class="text-center" style="width: 5%;">
							<button class="btn btn-outline-primary btn-sm" 
							onclick="location.href='adminPaymentDetail?payment_idx=${pList.payment_idx}&pageNum=${pageNum}'">상세보기</button>
						</td>
					</tr>
				</c:forEach>
			</table>
			</div>
		</div>
		
	<!-- 모바일 사이즈에서만 보임 -->
	<div class="row col-md-12 d-md-none">
		<div class="d-flex justify-content-center">
			<table class="table">
				<tr>
					<th class="text-center" style="width: 5%;">번호</th>
					<th class="text-center" style="width: 12%;">이메일</th>
					<th class="text-center" style="width: 5%;">최종금액</th>
					<th class="text-center" style="width: 5%;">주문날짜</th>
					<th class="text-center" style="width: 5%;">상세정보</th>
				</tr>
				<c:forEach var="pList" items="${pList}">
					<tr>
						<td class="text-center" >${pList.payment_idx}</td>
						<td class="text-center">${pList.member_email}</td>
						<td class="text-center">
							<fmt:formatNumber pattern="#,##0" value="${pList.total_amount}"  var="paymentQuantity"/>
							${paymentQuantity}원
						</td>
						<td class="text-center">
							<fmt:formatDate value="${pList.payment_date}" pattern="yy-MM-dd"/>
						</td>
						<td class="text-center" style="width: 5%;">
							<button class="btn btn-outline-primary btn-sm" 
							onclick="location.href='adminPaymentDetail?payment_idx=${pList.payment_idx}&pageNum=${pageNum}'">보기</button>
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
			                        <a class="page-link" aria-label="Previous" href="adminPayment?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Previous" href="adminPayment?pageNum=${pageNum - 1}">
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
	                                <li class="page-item"><a class="page-link" href="adminPayment?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a></li>
	                            </c:when>
	                            <c:otherwise>
	                                <li class="page-item"><a class="page-link" href="adminPayment?pageNum=${i}">${i}</a></li>
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
			                        <a class="page-link" aria-label="Next" href="adminPayment?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Next" href="adminPayment?pageNum=${pageNum + 1}">
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