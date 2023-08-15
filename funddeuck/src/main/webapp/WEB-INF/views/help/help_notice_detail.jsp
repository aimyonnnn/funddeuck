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
<script>
// 	function goBackAndRefresh() {
// 	  const prevUrl = document.referrer;
// 	  window.location.href = prevUrl;
// 	}

	function confirmDelete() {
		let isDelete = confirm("정말 삭제하시겠습니까?");
		
		if(isDelete) {
			location.href='NoticeDelete?notice_idx=${notice.notice_idx}&pageNum=${param.pageNum}';
		}
	}	
	
</script>
<body>
    <!-- 헤더  -->
	<jsp:include page="../Header.jsp"></jsp:include>
	<div style="height:150px;"></div>
    <!-- 공지사항 헤더  -->
	<jsp:include page="help_notice_header.jsp"></jsp:include>
	<!-- 글 영역 -->
	<div class="container text-center">
		<div class="row mt-3">
			<div class="col-6 col-md-6 col-sm-12 mx-auto">
				<div class="row">
					<span class="fs-3 fw-bold">${notice.notice_subject }</span>
				</div>
				<div class="row">
					<div class="col-4">
						<img src="${pageContext.request.contextPath }/resources/images/logo.png" style="width: 90px; height: 90px;">
					</div>
					<div class="col-8 text-start align-self-center">
						${notice.notice_name } <br>
						<fmt:formatDate value="${notice.notice_date }" pattern="yy-MM-dd"/>
					</div>
				</div>
				<div class="row">
					<p class="fs-6">${notice.notice_content }<p>
				</div>
				
				<c:if test="${not empty notice.notice_file}">
					<div class="row">
						<div class="col">
							파일 첨부 : 
							    <a href="${pageContext.request.contextPath }/resources/upload/${notice.notice_file }" download="${notice.notice_file }">${fn:split(notice.notice_file, '_')[1] }</a><br>
						</div>
					</div>
				
				</c:if>
			</div>
		
	    </div>	
    </div>
    
	<!-- 버튼 영역 -->
	<div class="container text-center">
		<div class="row mt-4">
			<div class="col-6 col-md-6 col-sm-12 mx-auto">
                <button type="button" class="btn btn-primary" onclick="location.href='helpNotice?pageNum=${param.pageNum}'">목록</button>
                <c:if test="${sessionScope.sId eq 'admin' }">
                <a href="NoticeModifyForm?notice_idx=${param.notice_idx}&pageNum=${param.pageNum}" class="btn btn-primary">수정</a>
                <button type="button" class="btn btn-primary" onclick="confirmDelete()">삭제</button>
                </c:if>
			</div>
		</div>
	</div>	
</body>
</html>