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
	<h2 class="fw-bold mt-5">결제내역 정보 변경</h2>
	<p class="projectContent">결제내역을 수정 할 수 있습니다.</p>
</div>
		
<div class="container mt-2" style="max-width: 800px;">
	<div class="row">
		<div class="col">
	
			<div class="tab-buttons text-center">
				<button class="btn btn-outline-primary tab-button w-100 active" data-tab="tab1">결제내역 정보변경</button>
				<button class="btn btn-outline-primary tab-button w-100 " data-tab="tab2">테스트 탭</button>
			</div>
				
			<!-- 메이커 정보수정 -->
			<div class="content-area" id="tab1">
				<!-- 폼 태그 -->
				<form action="adminModifyPayment" method="post" id="paymentForm" enctype="multipart/form-data">
					<input type="hidden" name="pageNum" value="${param.pageNum}">
					<input type="hidden" name="payment_idx" value="${payment.payment_idx}">
					<input type="hidden" name="project_idx" value="${payment.project_idx}">
					<input type="hidden" name="reward_idx" value="${payment.reward_idx}">
					<input type="hidden" name="delivery_idx" value="${payment.delivery_idx}">
					<table class="table text-center">
						<tr>
				    		<th style="width: 30%">결제 번호</th>
				            <td style="width: 70%"><input type="text" class="form-control" value="${payment.payment_idx}" disabled="disabled"></td>
				        </tr>
						<tr>
				    		<th style="width: 30%">프로젝트 번호</th>
				            <td style="width: 70%"><input type="text" class="form-control" value="${payment.project_idx}" disabled="disabled"></td>
				        </tr>
						<tr>
				    		<th style="width: 30%">리워드 번호</th>
				            <td style="width: 70%"><input type="text" class="form-control" value="${payment.reward_idx}" disabled="disabled"></td>
				        </tr>
						<tr>
				    		<th style="width: 30%">배송지 번호</th>
				            <td style="width: 70%"><input type="text" class="form-control" value="${payment.delivery_idx}" disabled="disabled"></td>
				        </tr>
				        <tr>
				            <th>이메일</th>
				            <td><input type="text" name="member_email" class="form-control" value="${payment.member_email}"></td>
				        </tr>
				        <tr>
				            <th>전화번호</th>
				            <td><input type="text" name="member_phone" class="form-control" value="${payment.member_phone}"></td>
				        </tr>
				        <tr>
				            <th>리워드 금액</th>
				            <td><input type="number" name="reward_amount" class="form-control" value="${payment.reward_amount}" disabled="disabled"></td>
				        </tr>
				        <tr>
				            <th>추가 후원 금액</th>
				            <td><input type="number" name="additional_amount" class="form-control" value="${payment.additional_amount}"></td>
				        </tr>
				        <tr>
				            <th>쿠폰 금액</th>
				            <td><input type="number" name="use_coupon_amount" class="form-control" value="${payment.use_coupon_amount}"></td>
				        </tr>
				        <tr>
				            <th>최종 결제 금액</th>
				            <td><input type="number" name="total_amount" class="form-control" value="${payment.total_amount}"></td>
				        </tr>
				        <tr>
				            <th>주문 날짜</th>
				            <td><input type="date" name="payment_date" class="form-control" value="${payment.payment_date}"></td>
				        </tr>
				        <tr>
				            <th>주문 수량</th>
				            <td><input type="number" name="payment_quantity" class="form-control" value="${payment.payment_quantity}"></td>
				        </tr>
				        <tr>
				            <th>결제 승인 여부</th>
				            <td>
				                <select name="payment_confirm" class="form-control">
				                    <option value="1" ${payment.payment_confirm == 1 ? 'selected' : ''}>예약완료</option>
				                    <option value="2" ${payment.payment_confirm == 2 ? 'selected' : ''}>결제완료</option>
				                    <option value="3" ${payment.payment_confirm == 3 ? 'selected' : ''}>반환신청</option>
				                    <option value="4" ${payment.payment_confirm == 4 ? 'selected' : ''}>반환완료</option>
				                    <option value="5" ${payment.payment_confirm == 5 ? 'selected' : ''}>반환거절</option>
				                </select>
				            </td>
				        </tr>
				        <tr>
				            <th>결제 수단</th>
				            <td>
				                <select name="payment_method" class="form-control">
				                    <option value="1" ${payment.payment_method == 1 ? 'selected' : ''}>카드결제</option>
				                    <option value="2" ${payment.payment_method == 2 ? 'selected' : ''}>계좌결제</option>
				                </select>
				            </td>
				        </tr>
				        <tr>
				            <th>환급 받을 은행명</th>
				            <td><input type="text" name="refund_bank" class="form-control" value="${payment.refund_bank}"></td>
				        </tr>
				        <tr>
				            <th>환급 받을 계좌번호</th>
				            <td><input type="text" name="refund_accountnum" class="form-control" value="${payment.refund_accountnum}"></td>
				        </tr>
				        <tr>
				            <th>배송 방법</th>
				            <td><input type="text" name="delivery_method" class="form-control" value="${payment.delivery_method}"></td>
				        </tr>
				        <tr>
				            <th>택배사</th>
				            <td><input type="text" name="courier" class="form-control" value="${payment.courier}"></td>
				        </tr>
				        <tr>
				            <th>운송장 번호</th>
				            <td><input type="text" name="waybill_num" class="form-control" value="${payment.waybill_num}"></td>
				        </tr>
				        <tr>
				            <th>배송 상황</th>
				            <td>
				                <select name="delivery_status" class="form-control">
				                    <option value="1" ${payment.delivery_status == 1 ? 'selected' : ''}>미발송</option>
				                    <option value="2" ${payment.delivery_status == 2 ? 'selected' : ''}>배송중</option>
				                    <option value="3" ${payment.delivery_status == 3 ? 'selected' : ''}>배송완료</option>
				                </select>
				            </td>
				        </tr>
				        <tr>
				            <th>취소 신청시 취소 사유</th>
				            <td><input type="text" name="cancel_context" class="form-control" value="${payment.cancel_context}"></td>
				        </tr>
				        <tr>
				            <th>취소 증빙 이미지</th>
				            <c:choose>
								<c:when test="${empty payment.cancel_img}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file1" onchange="checkFileInput('file1')">
											<button type="button" id="resetBtn5" onclick="resetFileInput('file1')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(payment.cancel_img,'_')[1]}
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${payment.payment_idx}', '${payment.cancel_img}', 1)" >
										</div>
									</td>
								</c:otherwise>
							</c:choose>
				        </tr>
				    </table>
					<div class="d-flex justify-content-center">
						<input type="submit" value="수정하기" class="btn btn-outline-primary">
					</div>
				</form>
				<!-- 폼 태그 -->
			</div>
			
			<!-- 공지사항 리스트 -->
			<div class="content-area" id="tab2">
			
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
function deleteFile(payment_idx, fileName, fileNumber) {
	
	if(confirm('파일을 삭제 하시겠습니까?')) {
		
		$.ajax({
			type: 'post',
			url: "<c:url value='deletePaymentFile'/>",
			data: {
				payment_idx: payment_idx,
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

// 공지사항 게시글 삭제하기
function deleteMakerBoard(maker_board_idx) {
	
	if(confirm('공지사항을 삭제하시겠습니까?')) {
		
		$.ajax({
			method: 'post',
			url: "<c:url value='deleteMakerBoard'/>",
			data: { 
				maker_board_idx: maker_board_idx
			},
			success: function(data) {
				
				console.log(data);
				
				if(data.trim() == 'true') {
					
					alert("공지사항이 성공적으로 삭제되었습니다.");
					location.reload();
					
				}
				
			},
			error: function(){
				console.log('공지사항 삭제에 실패하였습니다.');
			}
		});
		
	}
}
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>