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
	<!-- 글 영역 -->
	<div class="container text-center">
		<div class="row">
			<div class="col-6 col-md-6 col-sm-12 mx-auto">
			    <form action="helpNoticeWrite" method="post" enctype="multipart/form-data">
					<div class="row justify-content-center">
						<div class="col">
							<table class="table my-2">
				                <tr>
				                    <th class="col-2">구분</th>
				                    <td class="col">
				                    	<c:if test="${notice.notice_category eq 1}">
				                    		일반 공지
				                    	</c:if>
				                    	<c:if test="${notice.notice_category eq 2}">
				                    		이벤트
				                    	</c:if>
				                    	<c:if test="${notice.notice_category eq 3}">
				                    		서버 점검
				                    	</c:if>
				                    	<c:if test="${notice.notice_category eq 4}">
				                    		상위 고정
				                    	</c:if>
				                    </td>
				                </tr>
				                <tr>
				                    <th class="col-2">제목</th>
				                    <td>${notice.notice_subject }</td>
				                </tr>
				                <tr>
				                    <th class="col-2">내용</th>
				                    <td class="col">
				                    	${notice.notice_content }
				                    </td>
				                </tr>
<!-- 				                <tr> -->
<!-- 				                	이미지 파일만 등록 가능 -->
<!-- 				                    <th class="col-2">썸네일<small class="fs-6 text-muted">*10MB이하</small></th> -->
<!-- 				                    <td class="col"> -->
<!-- 				                        <input type="file" class="form-control" name="file" accept="image/*" onchange="checkFileExtension(event)" required> -->
<!-- 				                    </td> -->
<!-- 				                </tr> -->
							</table>
						</div>
		    		</div>
		    		<div class="row justify-content-center">
			        	<div class="col-3">
				            <div class="d-grid gap-2">
				            </div>
						</div>
					</div>
				</form>
			</div>
		
	    </div>	
    </div>
    
	<!-- 버튼 영역 -->
	<div class="container text-center">
		<div class="row">
			<div class="col-6 col-md-6 col-sm-12 mx-auto">
                <button type="button" class="btn btn-primary" onclick="location.href='helpNotice'">목록</button>
                <c:if test="${sessionScope.sId eq 'admin' }">
                <a href="NoticeModifyForm?notice_idx=${param.notice_idx}&pageNum=${param.pageNum}" class="btn btn-primary">수정</a>
                <a href="NoticeModifyForm?notice_idx=${param.notice_idx}&pageNum=${param.pageNum}" class="btn btn-primary">삭제</a>
<!--                 <button type="button" class="btn btn-primary" onclick="location.href='helpNoticeModifyForm?'">수정</button> -->
<!--                 <button type="button" class="btn btn-primary" onclick="location.href='helpNotice'">삭제</button> -->
                </c:if>
			</div>
		</div>
	</div>	
</body>
</html>