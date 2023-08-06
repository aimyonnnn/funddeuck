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
		<h2 class="fw-bold mt-5">프로젝트 상세보기</h2>
		<p class="projectContent">프로젝트의 모든 정보를 한 눈에 확인할 수 있습니다.</p>
	</div>

	<!--  -->
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-11">

				<div class="container mb-5">
					<div class="d-flex justify-content-end mb-1">
						<button class="btn btn-outline-primary btn-sm mx-2"
							onclick="approveProjectStatus(${project.project_idx}, ${project.project_approve_status})">승인처리</button>
						<button class="btn btn-outline-primary btn-sm"
							onclick="rejectProjectStatus(${project.project_idx}, 4)">승인거절</button>
					</div>
				</div>

				<!-- container -->
				<div class="container">

					<table class="table">
						<tr>
							<td class="align-middle text-center">프로젝트 이름</td>
							<td>${project.project_subject}</td>
							<td class="align-middle text-center">승인상태</td>
							<c:choose>
								<c:when test="${project.project_approve_status eq 2}">
									<td class="text-danger">승인요청</td>
								</c:when>
								<c:when test="${project.project_approve_status eq 3}">
									<td class="text-success">승인완료</td>
								</c:when>
								<c:when test="${project.project_approve_status eq 5}">
									<td>결제완료</td>
								</c:when>
								<c:otherwise>
									<td>승인거절</td>
								</c:otherwise>
							</c:choose>
						</tr>
						<tr>
							<td class="align-middle text-center">대표자 이름</td>
							<td>${project.project_representative_name}</td>
							<td class="align-middle text-center">프로젝트 번호</td>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${project.project_idx}</td>
						</tr>
					</table>

					<!-- 탭 버튼 -->
					<div class="tab-buttons text-center mt-5">
						<button class="btn btn-outline-primary tab-button w-100"
							data-tab="tab1">프로젝트</button>
						<button class="btn btn-outline-primary tab-button w-100"
							data-tab="tab2">리워드</button>
						<button class="btn btn-outline-primary tab-button w-100"
							data-tab="tab3">메이커</button>
					</div>
					<div class="content-area sideDescription" id="tab1">
						<div class="container">
							<table class="table text-center">
								<tr>
									<th>제목</th>
									<th>내용</th>
								</tr>
								<tr>
									<td>프로젝트 번호</td>
									<td>${project.project_idx}</td>
								</tr>
								<tr>
									<td>프로젝트 요금제</td>
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
									<td>프로젝트 카테고리</td>
									<td>${project.project_category}</td>
								</tr>
								<tr>
									<td>프로젝트 제목</td>
									<td>${project.project_subject}</td>
								</tr>
								<tr>
									<td>프로젝트 썸네일 (1)</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>프로젝트 썸네일 (2)</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails2}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>프로젝트 썸네일 (3)</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails3}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>프로젝트 내용 상세 이미지</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_image}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>프로젝트 소개</td>
									<td>${project.project_introduce}</td>
								</tr>
								<tr>
									<td>프로젝트 한줄 소개</td>
									<td>${project.project_semi_introduce}</td>
								</tr>
								<tr>
									<td>목표 금액</td>
									<td>${project.project_target}</td>
								</tr>
								<tr>
									<td>누적 금액</td>
									<td>${project.project_cumulative_amount}</td>
								</tr>
								<tr>
									<td>프로젝트 달성 금액</td>
									<td>${project.project_amount}</td>
								</tr>
								<tr>
									<td>프로젝트 시작일</td>
									<td>${project.project_start_date}</td>
								</tr>
								<tr>
									<td>프로젝트 종료일</td>
									<td>${project.project_end_date}</td>
								</tr>
								<tr>
									<td>검색용 태그</td>
									<td>${project.project_hashtag}</td>
								</tr>
								<tr>
									<td>대표자명</td>
									<td>${project.project_representative_name}</td>
								</tr>
								<tr>
									<td>대표 이메일</td>
									<td>${project.project_representative_email}</td>
								</tr>
								<tr>
									<td>대표 주민등록번호</td>
									<td>${project.project_representative_birth}</td>
								</tr>
								<tr>
									<td>세금계산서 발행 이메일</td>
									<td>${project.project_tax_email}</td>
								</tr>
								<tr>
									<td>정산받을 은행</td>
									<td>${project.project_settlement_bank}</td>
								</tr>
								<tr>
									<td>정산받을 계좌번호</td>
									<td>${project.project_settlement_account}</td>
								</tr>
								<tr>
									<td>예금주명</td>
									<td>${project.project_settlement_name}</td>
								</tr>
								<tr>
									<td>핀테크 이용번호</td>
									<td>${project.project_fintech_use_num}</td>
								</tr>
								<tr>
									<td>통장사본 이미지</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_settlement_image}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>프로젝트 승인 상태</td>
									<c:choose>
										<c:when test="${project.project_approve_status eq 2}">
											<td>승인요청</td>
										</c:when>
										<c:when test="${project.project_approve_status eq 3}">
											<td>승인완료</td>
										</c:when>
										<c:when test="${project.project_approve_status eq 4}">
											<td>승인거절</td>
										</c:when>
										<c:when test="${project.project_approve_status eq 5}">
											<td>결제완료</td>
										</c:when>
										<c:otherwise>
											<td>미승인</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<tr>
								<tr>
									<td>프로젝트 승인 요청 시간</td>
									<c:choose>
										<c:when test="${not empty project.project_approval_request_time}">
											<td>${project.project_approval_request_time}</td>
										</c:when>
										<c:otherwise>
											<td>승인 요청 전 입니다</td>
										</c:otherwise>
									</c:choose>
								</tr>
								<tr>
									<td>프로젝트 상태</td>
									<c:choose>
										<c:when test="${project.project_status eq 1}">
											<td>미진행</td>
										</c:when>
										<c:when test="${project.project_status eq 2}">
											<td>진행중</td>
										</c:when>
										<c:when test="${project.project_status eq 3}">
											<td>진행완료</td>
										</c:when>
										<c:when test="${project.project_status eq 4}">
											<td>정산신청</td>
										</c:when>
										<c:when test="${project.project_status eq 5}">
											<td>정산완료</td>
										</c:when>
									</c:choose>
								</tr>
							</table>
						</div>
					</div>

					<div class="content-area sideDescription" id="tab2">
						<div class="container">
							<table class="table text-center">
								<tr>
									<th>제목</th>
									<th>내용</th>
								</tr>
								<c:forEach var="rList" items="${rList}">
									<tr>
										<td>리워드 번호</td>
										<td>${rList.reward_idx}</td>
									</tr>
									<tr>
										<td>프로젝트 번호</td>
										<td>${rList.project_idx}</td>
									</tr>
									<tr>
										<td>리워드 가격</td>
										<td>${rList.reward_price}</td>
									</tr>
									<tr>
										<td>리워드 카테고리</td>
										<td>${rList.reward_category}</td>
									</tr>
									<tr>
										<td>리워드명</td>
										<td>${rList.reward_name}</td>
									</tr>
									<tr>
										<td>리워드 수량</td>
										<td>${rList.reward_quantity}</td>
									</tr>
									<tr>
										<td>리워드 옵션</td>
										<td>${rList.reward_option}</td>
									</tr>
									<tr>
										<td>리워드 설명</td>
										<td>${rList.reward_detail}</td>
									</tr>
									<tr>
										<td>배송여부</td>
										<td>${rList.delivery_status}</td>
									</tr>
									<tr>
										<td>배송비</td>
										<td>${rList.delivery_price}</td>
									</tr>
									<tr>
										<td>발송 시작일</td>
										<td>${rList.delivery_date}</td>
									</tr>
									<tr>
										<td>리워드 정보 제공 고시</td>
										<td>${rList.reward_info}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>

					<div class="content-area sideDescription" id="tab3">
						<div class="container">
							<table class="table text-center">
								<tr>
									<th>제목</th>
									<th>내용</th>
								</tr>
								<tr>
									<td>메이커 번호</td>
									<td>${maker.maker_idx}</td>
								</tr>
								<tr>
									<td>회원번호</td>
									<td>${maker.member_idx}</td>
								</tr>
								<tr>
									<td>메이커 유형-개인신분증</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file1}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>메이커 유형-개인사업자등록번호</td>
									<td>${maker.individual_biz_num}</td>
								</tr>
								<tr>
									<td>메이커 유형-개인사업자명</td>
									<td>${maker.individual_biz_name}</td>
								</tr>
								<tr>
									<td>메이커 유형-개인사업자등록증</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file2}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>메이커 유형-법인사업자등록번호</td>
									<td>${maker.corporate_biz_num}</td>
								</tr>
								<tr>
									<td>메이커 유형-법인사업자명</td>
									<td>${maker.corporate_biz_name}</td>
								</tr>
								<tr>
									<td>메이커 유형-법인사업자등록증</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file3}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>메이커 사진</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file4}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>메이커 로고</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file5}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<td>메이커 이름</td>
									<td>${maker.maker_name}</td>
								</tr>
								<tr>
									<td>메이커 소개</td>
									<td>${maker.maker_intro}</td>
								</tr>
								<tr>
									<td>메이커 이메일</td>
									<td>${maker.maker_email}</td>
								</tr>
								<tr>
									<td>메이커 전화번호</td>
									<td>${maker.maker_tel}</td>
								</tr>
								<tr>
									<td>메이커 홈페이지</td>
									<td>${maker.maker_url}</td>
								</tr>
								<tr>
									<td>메이커 등급</td>
									<td>${maker.maker_grade}</td>
								</tr>
							</table>
						</div>
					</div>

					<!-- 하단 버튼 -->
					<div class="d-flex justify-content-center my-3">
						<input type="button" value="목록"
							class="btn btn-outline-primary btn-sm"
<%-- 							onclick="location.href='adminProjectList?pageNum=${param.pageNum}'"> --%>
							onclick="history.back()">
					</div>

				</div>
				<!-- container -->

			</div>
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
	
<script type="text/javascript">
$(document).ready(function () {
       // 탭 1을 기본으로 활성화
       $("#tab1").addClass("active");
       $(".tab-button[data-tab='tab1']").addClass("active"); // 기본 탭 버튼에도 active 클래스 추가

       $(".tab-button").click(function (e) {
           e.preventDefault(); // form 태그와의 충돌 방지
           var tabId = $(this).data("tab");
           $(".content-area").removeClass("active");
           $("#" + tabId).addClass("active");

           // 탭 버튼에도 active 클래스 추가 (활성화된 탭 표시)
           $(".tab-button").removeClass("active");
           $(this).addClass("active");
       });
})

// 프로젝트 승인 처리
function approveProjectStatus(project_idx, project_approve_status) {
	
	// 프로젝트 승인여부 조회하기
	// 승인완료, 결제완료 된 경우 false가 콜백으로 전달됨
	// 승인요청, 거절처리 된 경우 true가 콜백으로 전달됨
   	isProjectApproved(project_idx, project_approve_status, function(isApproved) {
   		
  			if (isApproved) {
  				
			Swal.fire({
				title: '프로젝트 상태 변경',
				text: '프로젝트 승인 처리를 하시겠습니까?',
				icon: 'question',
				showCancelButton: true,
				confirmButtonText: '예',
				cancelButtonText: '아니오'
			}).then((result) => {
				
				if (result.isConfirmed) {
					
					$.ajax({
						method: 'get',
						url: "<c:url value='approveProjectStatus'/>",
						data: {
							member_idx: ${maker.member_idx},
							project_idx: project_idx,
							project_approve_status: project_approve_status
						},
						success: function(data) {
							
							console.log("여기까지옴");
							
							if (data.trim() == 'true') {
								Swal.fire({
									icon: 'success',
									title: '프로젝트 승인처리 완료.',
									text: '프로젝트 상태가 성공적으로 변경되었습니다.'
								}).then(function() {
									let memberPhone = "${memberPhone}";
									let message = "프로젝트 승인이 완료되었습니다.";
									sendNotificationMessage(memberPhone, message);
								});
							} else {
								Swal.fire({
									icon: 'error',
									title: '프로젝트 승인처리 실패.',
									text: '프로젝트 상태 변경에 실패하였습니다.'
								});
							}
						},
						error: function() {
							console.log('ajax 요청이 실패하였습니다!222');	
						}
					});
				} 
			});
			
		} else {
			
			if(project_approve_status == 5) {
				Swal.fire({
					icon: 'error',
					title: '이미 결제가 완료된 프로젝트!',
					text: '이미 결제완료된 프로젝트 입니다.'
				})
			} else if (project_approve_status == 3){
				Swal.fire({
					icon: 'error',
					title: '이미 승인이 완료된 프로젝트!',
					text: '이미 승인처리된 프로젝트 입니다.'
				})
			}
	    }
	});
} // function 
  	
// 문자 보내기
function sendNotificationMessage(memberPhone, message) {
	
	$.ajax({
	    method: 'post',
	    url: "<c:url value='/sendPhoneMessage'/>",
	    data: {
	    	memberPhone: memberPhone,
		    message: message,
		    projectIdx: ${project.project_idx},
		    memberIdx: ${maker.member_idx}
	    },
	    success: function(data) {
	    	
	    	if(data.trim() == 'true') {
		    	Swal.fire({
					icon: 'success',
					title: '알림문자 발송 완료.',
					text: '알림문자가 성공적으로 전송되었습니다.'
				}).then(function() {
			    	location.reload();
				});
	    	}
	    },
	    error: function() {
	      Swal.fire({
	    	 icon: 'error',
	    	 title: '알림문자 발송 실패',
	    	 text: '알림문자 전송에 실패하였습니다.'
	      });
	    }
  });
}

// 프로젝트 거절 처리
function rejectProjectStatus(project_idx, project_approve_status) {
	
	Swal.fire({
		title: '프로젝트 상태 변경',
		text: '프로젝트 거절 처리를 하시겠습니까?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonText: '예',
		cancelButtonText: '아니오'
	})
	.then((result) => {
		
		if (result.isConfirmed) {
		
			$.ajax({
				method: 'get',
				url: "<c:url value='rejectProjectStatus'/>",
				data: {
					project_idx: project_idx,
					project_approve_status: project_approve_status
				},
				success: function(data){
					
					if(data.trim() == 'true') {
						Swal.fire({
						      icon: 'success',
						      title: '프로젝트 거절처리 완료.',
						      text: '프로젝트 상태가 성공적으로 변경되었습니다.',
					    }).then(function(){
						    location.reload();
					    });
					} else {
						Swal.fire({
						      icon: 'error',
						      title: '프로젝트 거절처리 실패.',
						      text: '프로젝트 상태 변경에 실패하였습니다.',
					    });
					}
					
				},
				error: function(){
					console.log('ajax 요청이 실패하였습니다!');	
				}
			});
		} else {
			// 취소 선택 시 체크박스 해제
			$('input[type=checkbox]').prop('checked', false);
		}
	});
}

// 프로젝트 승인여부 조회하기
function isProjectApproved(project_idx, project_approve_status, callback) {
	
	$.ajax({
		method: 'get',
		url: '<c:url value="isProjectApproved"/>',
		data: {
			project_idx: project_idx,
			project_approve_status: project_approve_status
		},
		success: function(data) {
			
			if(data.trim() == 'false') {
                callback(false); // 이미 승인된 경우 false를 콜백으로 전달
			} else {
				callback(true); // 승인되지 않았을 경우 true를 콜백으로 전달
			}
			
		}
	});
}
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>