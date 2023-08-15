<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀뜩 공지 사항</title>
	<!-- 공용 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

</head>
<body>
    <!-- 헤더  -->
	<jsp:include page="../Header.jsp"></jsp:include>
	<div style="height:150px;"></div>
    <!-- 공지사항 헤더  -->
	<jsp:include page="help_notice_header.jsp"></jsp:include>
    <!-- 페이지 파라미터 저장 -->
	<c:set var="pageNum" value="1" />
	<c:if test="${not empty param.pageNum }">
		<c:set var="pageNum" value="${param.pageNum }" />
	</c:if>

    <!-- 글 목록 -->
	<div class="container text-center">
		<div class="row">
	            <div class="list-group col-6 col-md-6 mx-auto">
	            	<c:choose>
		            	<c:when test="${not empty noticeList }">
			            	<c:forEach var="notice" items="${noticeList }">
			            	
				                <a href="NoticeDetail?notice_idx=${notice.notice_idx }&pageNum=${pageNum }" class="list-group-item list-group-item-action" aria-current="true">
				                    <div class="d-flex justify-content-between">
				                    	<c:if test="${notice.notice_category eq 1}"><small>공지</small></c:if>
				                    	<c:if test="${notice.notice_category eq 2}"><small>이벤트</small></c:if>
				                    	<c:if test="${notice.notice_category eq 3}"><small>서버점검</small></c:if>
				                        
				                        <small><fmt:formatDate value="${notice.notice_date }" pattern="yy-MM-dd"/><br>조회 : ${notice.notice_readcount }</small>
				                    </div>
				                    
				                    <img src="${pageContext.request.contextPath}/resources/upload/${notice.notice_thumnail}" class="rounded float-end" alt="썸네일" width="100" height="100">
				                    <h5 class="text-center">${notice.notice_subject }</h5>
				                </a>
			            	</c:forEach>
		            	</c:when>
		            	<c:otherwise>
		            		<div class="col-6 col-md-6 mx-auto mt-4">
			            		<h3>등록된 공지사항 없음</h3>
		            		</div>
		            	</c:otherwise>
	            	</c:choose>
	            </div>
	    </div>
	</div>
	<!-- 글 목록 끝 -->
	<!-- 페이지 버튼 영역 -->
	<div class="container text-center">
		<div class="row mt-3">
			<div class="col-6 col-md-6 mx-auto">
				<nav aria-label="Page navigation">
					<ul class="pagination justify-content-center">
						<!-- 이전 버튼 -->
						<c:choose>
							<c:when test="${pageNum > 1 }">
								<li class="page-item">
									<a class="page-link text-primary" href="helpNotice?pageNum=${pageNum - 1}" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
									<a class="page-link" href="#" aria-label="Previous">
										<span aria-hidden="true">&laquo;</span>
									</a>
								</li>
							</c:otherwise>
						</c:choose>
						
						<!-- 페이지 -->
						<c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							<c:choose>
								<c:when test="${pageNum eq i}">
									<li class="page-item disabled"><a class="page-link" href="#">${i}</a></li>
								
								</c:when>
								<c:otherwise>
									<li class="page-item"><a class="page-link text-primary" href="helpNotice?pageNum=${i}">${i}</a></li>
								</c:otherwise>
							</c:choose>
						</c:forEach>					
						<!-- 다음 버튼 -->
						<c:choose>
							<c:when test="${pageNum < pageInfo.maxPage}">
								<li class="page-item">
									<a class="page-link text-primary" href="helpNotice?pageNum=${pageNum + 1}" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item disabled">
									<a class="page-link" href="#" aria-label="Next">
										<span aria-hidden="true">&raquo;</span>
									</a>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</nav>
			</div>
		</div>	
	</div>
	<!-- 페이지 버튼 영역 끝 -->
	<!-- 검색 버튼 영역 -->
	<div class="container text-center">
		<div class="row align-content-center justify-content-center">
			<div class="col-6 col-md-6 mx-auto">
				<form class="d-flex" action="helpNotice">
					<select class="form-select w-25 me-2" name="searchType" id="searchType">
						<option value="subject">제목</option>
						<option value="content">내용</option>
						<option value="subject_content">제목&내용</option>
					</select>
					<input class="form-control w-100 me-2" type="text" name="searchKeyword" id="searchKeyword">
					<input class="btn btn-primary" type="submit" value="검색">
				</form>
			</div>
		</div>
		<div class="row align-content-center justify-content-center">
			<div class="col-6 col-md-6 mx-auto mt-2">
				<c:if test="${sessionScope.sId eq 'admin' }"> 
					<input class="btn btn-primary"  type="button" value="글쓰기" onclick="location.href='NoticeForm'" />
				</c:if>
			</div>
		</div>
	</div>
	<!-- 검색 버튼 영역 끝 -->
				
</body>
</html>