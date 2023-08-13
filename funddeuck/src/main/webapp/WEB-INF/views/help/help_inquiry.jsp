<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀뜩 고객센터</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<!-- line-awesome icons CDN -->
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- Jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- header include -->
<jsp:include page="../Header.jsp"></jsp:include>
<!-- 공용 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
</head>
<body>
<!-- header fixed 속성으로 인한 공백 추가 -->
<div class="container text-center">
  <div class="row">&nbsp;</div>
</div>
<div class="container text-center">
  <div class="row">&nbsp;</div>
</div>
    <section style="background-color: black;">
        <div style="height: 70px;"></div>
        <div class="page-content container note-has-grid">
            <ul class="nav nav-pills p-3 bg-white mb-3 rounded-0 align-items-center">
                <li class="nav-item">
                	<a class="fw-bold fs-2 text-dark text-decoration-none">Funddeuck 고객센터</a>
                </li>
            </ul>
            <div class="tab-content bg-transparent">
                <div id="note-full-container" class="note-has-grid row">
                </div>
            </div>
		</div>
    </section><br><br>
<div class="container-lg">
	<a class="fw-bold fs-3 text-dark text-decoration-none">1:1 문의 등록</a><div class="row">&nbsp;</div>
	<a class="text-start btn btn-outline-secondary btn-sm bg-secondary bg-opacity-10 text-dark-emphasis fw-bold border border-success border-opacity-10" href="" role="button" style="pointer-events: none; ">
	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle-fill" viewBox="0 0 16 16">
	<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
	</svg>
	안녕하세요. 펀뜩입니다! 문의 등록시, 관련된 답변은 1 영업일 이내에 답변 받으실 수 있습니다.<br>&nbsp;&nbsp;&nbsp;
	더 빠르게 답변을 확인하고 싶으시다면, 먼저 자주 묻는 질문들을 확인해보세요.
	</a>
	<form action="helpInquiry" method="post" enctype= multipart/form-data>
		<div class="row">&nbsp;</div>
		<div class="mb-3">
			<label for="exampleFormControlInput1" class="form-label">아이디</label>
			<input type="text" class="form-control" name="member_id_" placeholder="${sessionScope.sId }" disabled="disabled">
			<input type="hidden" class="form-control" name="member_id" value="${sessionScope.sId }">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput2" class="form-label">문의자 유형</label>
			<select class="form-select" aria-label="Default select example" name="qna_division">
				<option selected>문의자 유형을 선택해주세요.</option>
				<option value="1">프로젝트를 개설한 메이커입니다.</option>
				<option value="2">프로젝트에 참여한 서포터입니다.</option>
			</select>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlInput3" class="form-label">제목</label>
			<input type="text" class="form-control" name="qna_subject" placeholder="제목을 입력해주세요" required="required">
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea1" class="form-label">문의사항</label>
			<textarea class="form-control" name="qna_context" placeholder="문의사항을 입력해주세요" rows="10" required="required"></textarea>
		</div>
		<div class="mb-3">
			<label for="exampleFormControlTextarea2" class="form-label">첨부파일(선택사항)</label>
			<input type="file" class="form-control" name="file1">
		</div>
		<div class="mb-3">
			<button type="submit" class="btn btn-outline-dark" >제출</button>
		</div>
	</form>
</div>

    <%@ include file="../Footer.jsp" %>

</body>
</html>