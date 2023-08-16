<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ include file="../Header.jsp" %>
<style>
table {
    width: 100%; /* 테이블의 전체 너비를 100%로 설정 */
    table-layout: fixed; /* 테이블 레이아웃을 고정으로 설정 */
}
th, td {
    width: 5%; /* 각 셀의 너비를 20%로 설정 */
    font-size: 1.2rem;
}
.hover-effect:hover {
 	text-decoration: underline; /* 제목 클릭 시 밑줄 효과 */
}
</style>
</head>
<body>
<div style="height:150px;"></div>
<div class="container">
	<h2 class="fw-bold mt-5">펀딩 닥터 답변</h2>
	<p class="projectContent">펀딩 닥터의 1:1 컨설팅을 확인할 수 있습니다.</p>
</div>

<div class="container mt-2">
	<div class="d-flex justify-content-start">
		<div class="content-area" id="tab1">
			<div class="table-responsive">
				<table class="table text-start mt-4">
					<tr>
						<th style="background-color: #f8f9fa;">제목</th>
						<td style="width: 30%;">${doctor.doctor_subject }</td>
					</tr>
					<tr>
						<th style="background-color: #f8f9fa;">작성자</th>
						<td style="width: 30%;">펀딩 닥터</td>
					</tr>
					<tr>
						<th style="background-color: #f8f9fa;">내용</th>
						<td>${doctor.doctor_content }</td>
					</tr>
					<tr>
						<th style="background-color: #f8f9fa;">첨부파일</th>
						<td><img
							src="${pageContext.request.contextPath}/resources/upload/${doctor.doctor_file}"
							alt="첨부파일 없음"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
					
	<!-- 하단 버튼 -->
	<div class="d-flex justify-content-center my-3">
		<input type="button" value="목록" class="btn btn-outline-primary btn-sm" onclick="history.back()">
	</div>
</div>

<!-- 모달창 -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">이미지 보기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img src="" alt="이미지" id="modalImage" style="max-width: 100%;">
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    // 기본적으로 활성화될 탭 설정 (여기선 1번 탭으로 설정)
    $(".tab-button[data-tab='tab1']").addClass("active");
    $(".content-area").removeClass("active");
    $("#tab1").addClass("active");
});

//이미지 클릭 시 모달 창에 이미지 보여주기
$(document).ready(function () {
    $("tr td img").click(function () {
        var src = $(this).attr("src");
        $("#modalImage").attr("src", src);
        $("#imageModal").modal("show");
    });
});
    
// 이미지 크기를 50px x 50px로 조절
$(document).ready(function () {
    $("tr td img").css({
        "width": "50px",
        "height": "50px"
    });
    $("tr td img").attr("title", "클릭 시 이미지를 크게 볼 수 있습니다");
});

</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>