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
	function checkFileExtension(event) {
		let fileInput = event.target;
		let file = fileInput.files[0];
		let allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];

		let fileName = file.name;
		let fileExtension = fileName.split('.').pop().toLowerCase();

		if (!allowedExtensions.includes(fileExtension)) {
			alert('등록이 불가능한 파일입니다.');
			fileInput.value = '';
		}
	}
	
	// 파일 실시간 삭제
	function deleteFile(notice_idx, fileName, fileNumber) {
		
		if(confirm('파일을 삭제 하시겠습니까?')) {
			
			$.ajax({
				type: 'post',
				url: "<c:url value='deleteNoticeFile'/>",
				data: {
					notice_idx: notice_idx,
					fileName: fileName,
					fileNumber: fileNumber
				},
				success: function(result){
					
					if(result.trim() === 'success') {
						// 파일 삭제 성공 시
						alert('파일이 삭제되었습니다.');
						location.reload();
					} else {
						alert('파일 삭제 실패!');
					}
				},
				error: function (error) {
					console.log(error);
				}
			});
		}
	}	
	
</script>	

<body>
    <!-- 헤더  -->
	<jsp:include page="../Header.jsp"></jsp:include>
	<div style="height:150px;"></div>
    <!-- 헤더  -->
	<div class="container text-center">
		<div class="row">
			<div class="col-6 col-md-6 col-sm-12 mx-auto">
			    <form action="NoticeModify" method="post" enctype="multipart/form-data">
					<div class="row justify-content-center">
						<div class="col">
						<!-- hidden 필드 -->
					    <input type="hidden" name="pageNum" value="${param.pageNum}">
					    <input type="hidden" name="notice_idx" value="${param.notice_idx}">
							<table class="table my-2">
				                <tr>
				                    <th class="col-2">구분</th>
				                    <td class="col">
				                    	<c:if test="${normal_category eq 1}">checked</c:if>
					                    <input type="radio" id="normal_category" value="1" name="notice_category" <c:if test="${notice.notice_category eq 1}">checked</c:if>>
					                    <label for="normal_category">일반 공지</label>
					                    <input type="radio" id="event_category" value="2" name="notice_category" <c:if test="${notice.notice_category eq 2}">checked</c:if>>
					                    <label for="event_category">이벤트</label>
					                    <input type="radio" id="maintenance_category" value="3" name="notice_category" <c:if test="${notice.notice_category eq 3}">checked</c:if>>
					                    <label for="maintenance_category">서버 점검</label>
					                    <input type="radio" id="top_category" value="4" name="notice_category" <c:if test="${notice.notice_category eq 4}">checked</c:if>>
					                    <label for="top_category">상위 고정</label>
				                    </td>
				                </tr>
				                <tr>
				                    <th class="col-2">제목</th>
				                    <td><input type="text" class="form-control" name="notice_subject" required value="${notice.notice_subject }"></td>
				                </tr>
				                <tr>
				                    <th class="col-2">내용</th>
				                    <td class="col">
				                        <textarea class="form-control" name="notice_content" rows="10" required>${notice.notice_content }</textarea>
				                    </td>
				                </tr>
				                <tr>
				                	<!-- 이미지 파일만 등록 가능 -->
				                    <th class="col-2">썸네일<small class="text-muted"> (필수)</small></th>
				                    <td class="col d-flex">
				                        <c:choose>
											<c:when test="${empty notice.notice_thumnail }">
						                        <input class="form-control" type="file" name="thumnail" accept="image/*" onchange="checkFileExtension(event)" required>
											</c:when>
											<c:otherwise>
						                    	${fn:split(notice.notice_thumnail, '_')[1] } &nbsp;&nbsp;&nbsp;
												<input class="btn btn-primary" type="button" value="삭제"
												onclick="deleteFile('${notice.notice_idx}', '${notice.notice_thumnail}', 1)">
											</c:otherwise>
										</c:choose>				                    
				                    </td>
				                </tr>
				                <tr>
				                    <th class="col-2">첨부 파일</th>
				                    <td class="col">
				                        <c:choose>
											<c:when test="${empty notice.notice_file }">
												<input class="form-control" type="file" name="file">
											</c:when>
											<c:otherwise>
												${fn:split(notice.notice_file, '_')[1] } &nbsp;&nbsp;&nbsp;
												<input class="btn btn-primary" type="button" value="삭제"
												onclick="deleteFile('${notice.notice_idx}', '${notice.notice_file}', 2)">
											</c:otherwise>
										</c:choose>				                    
				                    </td>
				                </tr>
							</table>
						</div>
		    		</div>
		    		<div class="row justify-content-center">
			        	<div class="col-3">
				            <div class="d-grid">
				                <button type="submit" class="btn btn-primary">수정</button>
				            </div>
						</div>
					</div>
				</form>
			</div>
		
	    </div>	
    </div>
</body>
</html>