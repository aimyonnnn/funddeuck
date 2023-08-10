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
<script>
	$(document).ready(function() {
		var project_target = Number(${project.project_target}).toLocaleString();
		$("#target").text(project_target + '원');
		
		var cumulative_amount = Number(${project.project_cumulative_amount}).toLocaleString();
		$("#cumulativeAmount").text(cumulative_amount + '원');
		
		var settlement_amount = Number(${project.settlement_amount}).toLocaleString();
		$("#settlementAmount").text(settlement_amount + '원');
	});
</script>
</head>
<body>
<!-- sidebar -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<!-- top -->
<div class="main-content">
<jsp:include page="../common/admin_top.jsp"/>

	<div class="container">
		<h2 class="fw-bold mt-5">프로젝트 상세보기</h2>
		<p class="projectContent">정산한 프로젝트의 모든 정보를 한 눈에 확인할 수 있습니다.</p>
	</div>

	<!--  -->
	<div class="container">
		<div class="row justify-content-start">
			<div class="col-lg-7">

				<!-- container -->
				<div class="container">
						<div class="table-responsive">
							<table class="table text-start mt-4">
								<tr>
									<th style="background-color: #f8f9fa;">메이커 번호</th>
									<td style="width: 30%;">${project.maker_idx}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 번호</th>
									<td>${project.project_idx}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 요금제</th>
									<c:choose>
										<c:when test="${project.project_plan eq 1}">
											<td>기본 요금제</td>
										</c:when>
										<c:when test="${project.project_plan eq 2}">
											<td>인플루언서 요금제</td>
										</c:when>
									</c:choose>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 카테고리</th>
									<td>${project.project_category}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 제목</th>
									<td><a href="fundingDetail?project_idx=${project.project_idx }">${project.project_subject}</a></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">목표 금액</th>
									<td id="target"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 누적 금액</th>
									<td id="cumulativeAmount"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">누적 정산금액</th>
									<td id="settlementAmount"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 시작일</th>
									<td>${project.project_start_date}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 종료일</th>
									<td>${project.project_end_date}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">대표자명</th>
									<td>${project.project_representative_name}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">대표 이메일</th>
									<td>${project.project_representative_email}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">대표 주민등록번호</th>
									<td>${project.project_representative_birth}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">세금계산서 발행 이메일</th>
									<td>${project.project_tax_email}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">정산받을 은행</th>
									<td>${project.project_settlement_bank}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">정산받을 계좌번호</th>
									<td>${project.project_settlement_account}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">예금주명</th>
									<td>${project.project_settlement_name}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">통장사본 이미지</th>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_settlement_image}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 상태</th>
									<c:choose>
										<c:when test="${project.project_status eq 4}">
											<td>1차정산완료</td>
										</c:when>	
										<c:when test="${project.project_status eq 5}">
											<td>최종정산진행가능</td>
										</c:when>	
										<c:when test="${project.project_status eq 6}">
											<td>최종정산완료</td>
										</c:when>
									</c:choose>								
								</tr>
							</table>
						</div>
					</div>

					<!-- 하단 버튼 -->
					<div class="d-flex justify-content-center my-3">
						<input type="button" value="목록" class="btn btn-outline-primary btn-sm" onclick="history.back()">
					</div>

				</div>
				<!-- container -->

			</div>
	</div>
</div>

<!-- 모달창 -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
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
// 이미지 클릭 시 모달 창에 이미지 보여주기
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

// 비행기 아이콘 클릭 시 아이디를 자동으로 입력
$(document).ready(function() {
	// 아이디 입력 필드 찾기
	let receiver = $('#message_receiver');
	
	// memberId 값을 가져와서 입력 필드의 value로 설정하고 readonly로 만들기
	let memberId = '${memberId}';
	receiver.val(memberId);
	receiver.prop('readonly', true);
});

</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>