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
</head>
<body>
<!-- sidebar -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<!-- top -->
<div class="main-content">
<jsp:include page="../common/admin_top.jsp"/>

<div class="container">
	<h2 class="fw-bold mt-5">프로젝트 정보 변경</h2>
</div>

<div class="container mt-2" style="max-width: 800px;">
	<div class="row">
		<div class="col">
	
			<div class="tab-buttons text-center">
				<button class="btn btn-outline-primary tab-button w-100 active" data-tab="tab1">프로젝트 정보 변경</button>
				<button class="btn btn-outline-primary tab-button w-100 " data-tab="tab2">리워드 정보 변경</button>
			</div>
				
				<!-- 프로젝트 정보수정 -->
				<div class="content-area" id="tab1">
				<form action="adminModifyProject" method="post" id="modifyForm" enctype="multipart/form-data">
				    <!-- hidden 필드 -->
				    <input type="hidden" name="pageNum" value="${param.pageNum}">
				    <input type="hidden" name="project_idx" value="${project.project_idx}">
				    <table class="table text-center">
				        <tr>
				            <th style="width: 30%">프로젝트 번호</th>
				            <td style="width: 70%">
				                <input type="text" class="form-control" value="${project.project_idx}" disabled="disabled">
				            </td>
				        </tr>
				        <tr>
				            <th style="width: 30%">프로젝트 요금제</th>
				            <td style="width: 70%">
				                <input type="text" name="project_plan" class="form-control" value="${project.project_plan}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 카테고리</th>
				            <td>
				                <input type="text" name="project_category" class="form-control" value="${project.project_category}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 제목</th>
				            <td>
				                <input type="text" name="project_subject" class="form-control" value="${project.project_subject}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 썸네일 (1)</th>
				            <c:choose>
								<c:when test="${empty project.project_thumnails1}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file1" onchange="checkFileInput('file1')">
											<button type="button" id="resetBtn4" onclick="resetFileInput('file1')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(project.project_thumnails1, '_')[1] }
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${project.project_idx}', '${project.project_thumnails1}', 1)">
										</div>
									</td>
								</c:otherwise>										
							</c:choose>
				        </tr>
				        <tr>
				            <th>프로젝트 썸네일 (2)</th>
				            <c:choose>
								<c:when test="${empty project.project_thumnails2}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file2" onchange="checkFileInput('file2')">
											<button type="button" id="resetBtn4" onclick="resetFileInput('file2')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(project.project_thumnails2, '_')[1] }
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${project.project_idx}', '${project.project_thumnails2}', 2)">
										</div>
									</td>
								</c:otherwise>										
							</c:choose>
				        </tr>
				        <tr>
				            <th>프로젝트 썸네일 (3)</th>
				            <c:choose>
								<c:when test="${empty project.project_thumnails3}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file3" onchange="checkFileInput('file3')">
											<button type="button" id="resetBtn4" onclick="resetFileInput('file3')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(project.project_thumnails3, '_')[1] }
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${project.project_idx}', '${project.project_thumnails3}', 3)">
										</div>
									</td>
								</c:otherwise>										
							</c:choose>
				        </tr>
				        <tr>
				            <th>프로젝트 내용 상세 이미지</th>
				            <c:choose>
								<c:when test="${empty project.project_image}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file4" onchange="checkFileInput('file4')">
											<button type="button" id="resetBtn4" onclick="resetFileInput('file4')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(project.project_image, '_')[1] }
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${project.project_idx}', '${project.project_image}', 4)">
										</div>
									</td>
								</c:otherwise>										
							</c:choose>
				        </tr>
				        <tr>
				            <th>프로젝트 소개</th>
				            <td>
				                <input type="text" name="project_introduce" class="form-control" value="${project.project_introduce}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 한줄 소개</th>
				            <td>
				                <input type="text" name="project_semi_introduce" class="form-control" value="${project.project_semi_introduce}">
				            </td>
				        </tr>
				        <tr>
				            <th>목표 금액</th>
				            <td>
				                <input type="text" name="project_target" class="form-control" value="${project.project_target}">
				            </td>
				        </tr>
				        <tr>
				            <th>누적 금액</th>
				            <td>
				                <input type="text" name="project_cumulative_amount" class="form-control" value="${project.project_cumulative_amount}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 시작일</th>
				            <td>
				                <input type="date" name="project_start_date" class="form-control" value="${project.project_start_date}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 종료일</th>
				            <td>
				                <input type="date" name="project_end_date" class="form-control" value="${project.project_end_date}">
				            </td>
				        </tr>
				        <tr>
				            <th>검색용 태그</th>
				            <td>
				                <input type="text" name="project_hashtag" class="form-control" value="${project.project_hashtag}">
				            </td>
				        </tr>
				        <tr>
				            <th>대표자명</th>
				            <td>
				                <input type="text" name="project_representative_name" class="form-control" value="${project.project_representative_name}">
				            </td>
				        </tr>
				        <tr>
				            <th>대표 이메일</th>
				            <td>
				                <input type="text" name="project_representative_email" class="form-control" value="${project.project_representative_email}">
				            </td>
				        </tr>
				        <tr>
				            <th>대표 주민등록번호</th>
				            <td>
				                <input type="text" name="project_representative_birth" class="form-control" value="${project.project_representative_birth}">
				            </td>
				        </tr>
				        <tr>
				            <th>세금계산서 발행 이메일</th>
				            <td>
				                <input type="text" name="project_tax_email" class="form-control" value="${project.project_tax_email}">
				            </td>
				        </tr>
				        <tr>
				            <th>정산받을 은행</th>
				            <td>
				                <input type="text" name="project_settlement_bank" class="form-control" value="${project.project_settlement_bank}">
				            </td>
				        </tr>
				        <tr>
				            <th>정산받을 계좌번호</th>
				            <td>
				                <input type="text" name="project_settlement_account" class="form-control" value="${project.project_settlement_account}">
				            </td>
				        </tr>
				        <tr>
				            <th>예금주명</th>
				            <td>
				                <input type="text" name="project_settlement_name" class="form-control" value="${project.project_settlement_name}">
				            </td>
				        </tr>
				        <tr>
				            <th>핀테크이용번호</th>
				            <td>
				                <input type="text" name="project_fintech_use_num" class="form-control" value="${project.project_fintech_use_num}">
				            </td>
				        </tr>
				        <tr>
				            <th>통장사본 이미지</th>
				            <c:choose>
								<c:when test="${empty project.project_settlement_image}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file5" onchange="checkFileInput('file5')">
											<button type="button" id="resetBtn4" onclick="resetFileInput('file5')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(project.project_settlement_image, '_')[1] }
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${project.project_idx}', '${project.project_settlement_image}', 5)">
										</div>
									</td>
								</c:otherwise>										
							</c:choose>
				        </tr>
				        <tr>
				            <th>프로젝트 승인 상태</th>
				            <td>
				                <input type="text" name="project_approve_status" class="form-control" value="${project.project_approve_status}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 상태</th>
				            <td>
				                <input type="text" name="project_status" class="form-control" value="${project.project_status}">
				            </td>
				        </tr>
				        <tr>
				            <th>프로젝트 승인 요청 시간</th>
				            <td>
				                <input type="datetime" name="project_approval_request_time" class="form-control" value="${project.project_approval_request_time}">
				            </td>
				        </tr>
				         <tr>
				            <th>메이커 번호</th>
				            <td>
				                <input type="text" name="maker_idx" class="form-control" value="${project.maker_idx}" disabled="disabled">
				            </td>
				        </tr>
				        <tr>
				            <th>토큰 번호</th>
				            <td>
				                <input type="text" name="token_idx" class="form-control" value="${project.token_idx}" disabled="disabled">
				            </td>
				        </tr>
				        <tr>
				            <th>1차 정산금액</th>
				            <td>
				                <input type="text" name="first_amount" class="form-control" value="${project.first_amount}">
				            </td>
				        </tr>
				        <tr>
				            <th>정산 상태</th>
				            <td>
				                <input type="text" name="settlement_status" class="form-control" value="${project.settlement_status}">
				            </td>
				        </tr>
				    </table>
				    <div class="d-flex justify-content-center">
						<input type="submit" value="수정하기" class="btn btn-outline-primary">
					</div>
				</form>
			</div>
			
			<!-- 리위드 -->
			<div class="content-area" id="tab2">
				<div class="accordion" id="accordionExample">
				
				    <c:forEach var="mList" items="${mList}">
				        <div class="accordion-item">
				            <h2 class="accordion-header" id="heading${mList.maker_board_idx}">
				                <button class="accordion-button" type="button" data-bs-toggle="collapse"
				                    data-bs-target="#collapse${mList.maker_board_idx}" aria-expanded="true"
				                    aria-controls="collapse${mList.maker_board_idx}">
				                    ${mList.maker_board_subject}
				                </button>	
				            </h2>
				            <div id="collapse${mList.maker_board_idx}" class="accordion-collapse collapse show"
				                aria-labelledby="heading${mList.maker_board_idx}" data-bs-parent="#accordionExample">
				                <div class="accordion-body">
				                	<table class="table text-center">
				                		<tr>
				                			<td style="width: 20%">작성내용</td>
				                			<td style="width: 80%">${mList.maker_board_content}</td>
				                		</tr>
				                		<tr>
				                			<td>작성일자</td>
				                			<td><fmt:formatDate value="${mList.maker_board_regdate}" pattern="yy-MM-dd HH:mm" /></td>
				                		</tr>
				                		<tr>
				                			<td>첨부파일</td>
				                			<td>
				                				<c:choose>
				                					<c:when test="${not empty mList.maker_board_file1}">
						                				<a href="${pageContext.request.contextPath}/resources/upload/${mList.maker_board_file1}" download="${fn:split(mList.maker_board_file1, '_')[1]}">
											                ${fn:split(mList.maker_board_file1, '_')[1]}
											            </a>
				                					</c:when>
				                					<c:otherwise>
				                						첨부파일 없음
				                					</c:otherwise>
				                				</c:choose>
				                			</td>
				                		</tr>
				                		<tr>
				                			<td colspan="2" class="text-center">
					                			<input type="button" value="삭제하기" class="btn btn-outline-danger btn-sm"
												onclick="deleteMakerBoard(${mList.maker_board_idx})">
				                			</td>
				                		<tr>
				                	</table>
				                </div>
				            </div>
				        </div>
				    </c:forEach>
				    
				</div>
			</div>
			
				
			</div>
		</div>
	</div>
</div>

<script>
//탭 버튼 클릭 시
$(document).ready(function() {
	
	$("#tab1").addClass("active");
	$(".tab-button").click(function() {
		
		var tabId = $(this).data("tab");
		$(".content-area").removeClass("active");
		$("#" + tabId).addClass("active");
		
	});
	
});

// 탭 버튼 클릭시 active 효과
$(document).ready(function() {
	
	// 버튼1 클릭 시
	$(".tab-button[data-tab='tab1']").click(function() {
		$(".tab-button[data-tab='tab1']").addClass("active");
	  	$(".tab-button[data-tab='tab2']").removeClass("active");
	});
	
	// 버튼2 클릭 시
	$(".tab-button[data-tab='tab2']").click(function() {
	  	$(".tab-button[data-tab='tab1']").removeClass("active");
	  	$(".tab-button[data-tab='tab2']").addClass("active");
	});
	
});

// 파일 실시간 삭제
function deleteFile(project_idx, fileName, fileNumber) {
	
	if(confirm('파일을 삭제 하시겠습니까?')) {
		
		$.ajax({
			type: 'post',
			url: "<c:url value='deleteProjectFile'/>",
			data: {
				project_idx: project_idx,
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

// 개별 파일 첨부 입력 필드 초기화 함수
function resetFileInput(inputName) {
	let fileInput = $('input[name="' + inputName + '"]');
	fileInput.val(null);
	alert('파일이 삭제되었습니다.');
	fileInput.next().hide(); // "지우기" 버튼 숨김
}

// 파일 첨부 입력 필드 상태 감지 함수
function checkFileInput() {
	let fileInputs = $('input[type="file"]');
	
	fileInputs.each(function() {
		
	   	if (this.files.length > 0) {
	     	$(this).next().show(); // "지우기" 버튼 표시
	   	} else {
	     	$(this).next().hide(); // "지우기" 버튼 숨김
	  	}
	   	
	});
}

// 페이지 로드 시 파일 첨부 입력 필드 상태 감지 함수 호출
$(document).ready(function() {
	checkFileInput();
});
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>