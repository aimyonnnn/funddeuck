<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>펀딩</title>
<!-- 헤더  -->
<jsp:include page="../common/main_header.jsp"></jsp:include>
<!-- 부트스트랩 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> -->
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 부트스트랩 5.3.0 CSS 추가 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
<!-- 부트스트랩 5.3.0 JS 추가 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>


<!-- 공용 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<script type="text/javascript">
	// 배송지 등록을 위한 ajax 요청
	$(document).on("click", "#deliveryAdd", function() {
        $("#deliveryChangeModalClose").click();
		
		// 폼 데이터 가져오기
		var formData = $("#deliveryAddModal form").serialize();
		console.log(formData);
		// ajax 요청
		$.ajax({
			type: "POST",
			url: "deliveryAdd",
			data: formData,
			success: function(msg) {
				if($.trim(msg) == "success") {
					console.log("배송지 등록 완료!");
					// 배송지 추가 모달창의 입력된 데이터 지우기
					$("#deliveryAddModal input").val("");
					// 배송지 추가 모달창 닫힘(부트스트랩 5.3.0에서는 X)
// 					$('#deliveryAddModal').modal('hide');
			        // 배송지 추가 모달창 닫기 버튼 클릭 발생
			        $("#deliveryAddModalClose").click();
					
					// 배송지 변경 모달창 열림
					$("#deliveryChangeModal").modal("show");
				} else {
					console.log("배송지 등록 실패!");
				}
			},
			error: function (xhr, status, error) {
				console.error("오류 발생!" , error);
			}
		});
		
			
	});
	
	$(document).ready(function() {
		// 리워드 변경 모달창
		// 리워드 변경 버튼 클릭시 라디오박스에 해당하는 리워드 번호 전달하는 ajax
		$("#rewardChange").on("click", function()  {
			// 체크된 라디오 박스
			let checkedRadio = $('input[name="rewardCheck"]:checked');
			
			// 체크된 라디오 버튼 있는지 확인
			if(checkedRadio.length > 0) {
				// 선택한 라디오 버튼의 상위 row 요소 선택
				let rewardRow = checkedRadio.closest('.row');
				// 리워드 번호 가져오기
				let reward_idx = rewardRow.find('input[type="hidden"]').val();
				
				// ajax 요청 컨트롤러 전달
				$.ajax({
					type: "POST",
					url: "rewardChange",
					data: {reward_idx: reward_idx},
					success: function(reward) {
						// 전달받은 RewardVO 출력
						console.log(reward);
						// 리워드 변경 모달창 닫기
						$("#rewardListModalClose").click();
						// 기존 HTML 지우기
						$('#rewardContainer').html('');
						
						
						// HTML 출력할 내용
						let output = '<input type="hidden" value="' + reward.reward_idx + '"name="reward_idx">'
						            + '<table class="table table-borderless" style="table-layout: fixed">'
						            +  '<tr>'
						            +   '<th>리워드 구성</th>'   
						            +   '<td>'
						            +     reward.reward_name + '<br>'
						            +     reward.reward_option
						            +   '</td>'
						            +  '</tr>' 
						            +  '<tr>'
						            +   '<th>리워드 금액</th>'
						            +   '<td>' + reward.reward_price + '원</td>'
						            +  '</tr>'
						            +  '<tr>'
						            +   '<th>배송비</th>'
						            +   '<td>' + reward.delivery_price + '원</td>'
						            +  '</tr>'
						            +  '<tr>'
						            +   '<th>발송 시작일</th>'
						            +   '<td>' + reward.delivery_date + '</td>'
						            +  '</tr>'
						            + '</table>';				
			            // 출력하기
			            $('#rewardContainer').html(output);
						
					},
					error: function(xhr, status, error) {
						 console.error("Error:", error);
					}
					
				});
				
			} else {
				alert("리워드를 선택하세요");
			}
		});
		// 리워드 변경 모달창 끝
		// 배송지 목록을 가져오는 ajax 요청
	    $('#deliveryChangeModal').on('show.bs.modal', function (event) {
	        var modal = $(this);
	        $.ajax({
	            type: "GET",
	            url: "getDeliveryList",
	            dataType: "json",
	            success: function(data) {
					console.log(data);
					var deliveryListElem = $('#deliveryList');
					deliveryListElem.empty(); // 배송지 목록 삭제
					if (data.length > 0) {
						// 반복문을 사용하여 각 데이터를 배송지 목록에 추가
						data.forEach(function(delivery) {
							var html = '';
							html += '<div class="row border">';
							html += '<span class="fs-6 fw-bold text-start">' + delivery.delivery_reciever + '</span>';
							html += '<span class="fs-6 text-start">' + delivery.delivery_phone + '</span>';
							html += '<span class="fs-6 text-start">[' + delivery.delivery_zipcode + ']' 
								+ delivery.delivery_add + '&nbsp;&nbsp;' + delivery.delivery_detailadd + '</span>' ;
							html += '</div>';
							deliveryListElem.append(html);
						});
					}
	            	
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
	        });
	    });
	    
	    // 배송지 추가 모달 열릴때 배송지 변경 모달 닫힘
	    $("#deliveryAddModal").on("show.bs.modal", function() {
	    	$("#deliveryChangeModalClose").click();
	    });
	    
	});	
	
	
	
</script>

</head>
<body>
	<!-- 이미지, 프로젝트 정보 -->
	<div class="container text-center">
		<div class="row p-2 m-3">
			<!-- 프로젝트 이미지 영역 -->
			<!-- 프로젝트 이미지 불러오기 -->
			<div class="col-lg-2 col-4">
				<img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" class="img-fluid" alt="...">
			</div>
			<!-- 프로젝트 이미지 영역 끝 -->
			<!-- 프로젝트 정보 영역 -->
			<div class="col p-2 text-start">
				<!-- form으로 전달할 project_idx-->
				<input type="hidden" value="${project.project_idx }" name="project_idx">
				<span class="fs-2 fw-bold">${project.project_subject }</span> <br>
				<!-- 목표금액 + 후원한 사람들의 총금액 -->
				<span class="fs-4 fw-bold">xxxx원</span>&nbsp;&nbsp;
				<!-- 목표금액까지의 % -->
				<span class="fs-5 text-primary fw-bold">xx%</span> &nbsp; 
				<!-- 프로젝트 종료일 - 현재시간 -->
				<span class="fs-6 text-muted">xx일 남음</span>
			</div>
			<!-- 프로젝트 정보 영역 끝 -->
		</div>
	</div>
	<!-- 이미지, 프로젝트 정보 끝 -->
	<!-- 리워드, 서포터, 배송지, 쿠폰, 결제확인 영역 -->
	<div class="container text-center">
		<div class="row m-3">
			<!--왼쪽 영역-->
			<div class="col-lg-6 col-md-12 text-start">
				<!--리워드 정보-->
				<div class="row">
					<span class="fs-4 fw-bold">리워드 정보</span>
					<div class="row m-2 p-2 border">
						<div class="col" id="rewardContainer">
							<input type="hidden" value="${reward.reward_idx }" name="reward_idx">
							<table class="table table-borderless"  style="table-layout: fixed">
								<tr>
									<th>리워드 구성</th>
									<td>
										${reward.reward_name } <br>
										${reward.reward_option }
									</td>
								</tr>
								<tr>
									<th>리워드 금액</th>
									<td>${reward.reward_price }원</td>
								</tr>
								<tr>
									<th>배송비</th>
									<td>${reward.delivery_price }원</td>
								</tr>
								<tr>
									<th>발송 시작일</th>
									<td>${reward.delivery_date }</td>
								</tr>
							</table>
						</div>
						<!-- 변경 버튼 -->
						<!-- 변경 버튼 클릭시 모달창 => 리워드 변경 -->
					    <div class="col-lg-2 col-sm-12 d-flex justify-content-center align-self-center">
							<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#rewardListModal">변경</button>
					    </div>
						<!-- 변경 버튼 끝 -->
					</div>
				</div>
				<!--리워드 정보 끝-->
				<!--서포터 정보-->
				<div class="row">					
					<span class="fs-4 fw-bold">서포터 정보</span>
					<div class="row m-2 p-2 border">
						<div class="col">
							<table class="table table-borderless">
								<tr>
									<th>연락처</th>
									<td>${member.member_phone }</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>${member.member_email}</td>
								</tr>
							</table>
							<span class="fs-6 text-muted">* 위 연락처와 이메일로 후원 관련 소식이 전달됩니다.</span> <br>
							<span class="fs-6 text-muted">* 연락처 및 이메일 변경은 설정 > 계정 설정에서 가능합니다.</span>
						</div>
					</div>
				</div>
				<!--서포터 정보 끝--> 
				<!--배송지-->     
				<div class="row">
					<span class="fs-4 fw-bold">배송지</span>
					<div class="row m-2 p-2 border">
						<c:choose>
							<c:when test=""></c:when>
						</c:choose>
						<!-- 기본 배송지 등록 X -->
<!-- 						<div class="col d-flex justify-content-center align-self-center"> -->
<!-- 							<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryAddModal">배송지 추가</button> -->
<!-- 						</div> -->
						<!-- 기본 배송지 등록 X 끝 -->
						<!-- 기본 배송지 등록 O -->
						<!-- 변경 버튼 클릭시 모달창 => 배송지 정보 -->
						<div class="col">
							<div class="row-12">
								<span class="fs-6 fw-bold">수취인</span>
								<span class=" badge bg-danger text-white">기본</span>
							</div>
							<div class="row-12">
								<span class="fs-6">[우편번호]</span>
								<span class="fs-6">수취인주소</span>
								<span class="fs-6">수취인상세주소</span>
							</div>
							<div class="row-12">
								<span class="fs-6">수취인연락처</span>
							</div>
						</div>
						<div class="col-lg-2 col-sm-12 d-flex justify-content-center align-self-center">
							<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryChangeModal">변경</button>
						</div>
						<!-- 기본 배송지 등록 O 끝 -->
					</div>
				</div>
				<!--배송지 끝--> 
				<!--쿠폰-->     
				<div class="row">
					<span class="fs-4 fw-bold">쿠폰</span>
					<div class="row m-2 p-2 border">
						<div class="col text-start">
							<span class="fs-6 fw-bold">보유 쿠폰</span>
						</div>
						<div class="col-8">
							<!-- 드롭다운으로 가지고있는 쿠폰 선택 -->
							<div class="row">
								<div class="dropdown">
									<button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
										쿠폰을 선택해주세요.
									</button>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#">쿠폰1</a></li>
										<li><a class="dropdown-item" href="#">쿠폰2</a></li>
										<li><a class="dropdown-item" href="#">쿠폰3</a></li>
									</ul>
								</div>
							</div>
							<!-- 쿠폰 선택시 할인금액 출력 -->
							<div class="row p-2">
								<span class="fs-6 fw-bold">10,000원 할인</span>			
							</div>
						</div>
					</div>
				</div>
				<!--쿠폰 끝-->          
			</div>
			<!--왼쪽 영역 끝-->
			<!-- 결제 확인 영역-->
			<div class="col-lg-6 col-md-12 p-4">
				<!-- 후원 금액 -->
				<div class="row border ms-2 me-2">
					<div class="col text-start">
						<span class="fs-4 fw-bold text-primary">최종 후원 금액</span>
					</div>
					<div class="col-4 text-end">
						<span class="fs-4 fw-bold">xxxx원</span>
					</div>
				</div>
				<!-- 최종금액 외 금액들 -->
				<div class="row border ms-2 me-2">
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">리워드 금액</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold">${reward.reward_price }원</span>
						</div>
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">배송비</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold">${reward.delivery_price }원</span>
						</div>
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">추가 후원 금액</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold">xxxx원</span>
						</div>
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">쿠폰 사용</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold">-xxxx원</span>
						</div>
				</div>
				<!-- 후원 금액 끝-->
				<!-- 결제 예정일 안내 -->
				<div class="row pt-2 text-start ms-2 me-2">
					<p>
						프로젝트 성공시 결제는 <span class="fw-bold text-danger">23.xx.xx</span>에 진행 예정입니다.<br>
						프로젝트가 취소됬을 경우, 예약된 결제는 자동으로 결제가 취소됩니다.
					</p>
				</div>
				<!-- 결제 예정일 안내 끝 -->
				<!-- 개인정보 동의, 유의사항 -->
				<div class="row ms-2 me-2">
					<div class="col pt-2 text-start">
						<div class="form-check fs-6">
							<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							<label class="form-check-label" for="flexCheckDefault">
								개인정보 제3자 제공 동의
							</label>
						</div>
					</div>
					<!-- a태그 내용보기 -->
					<!-- 모달창으로 개인정보 동의 내용 보여주기 -->
					<div class="col-4 pt-2 fs-6">
						<a href="#">내용보기</a>
					</div>
					<!-- a태그 내용보기 끝 -->
				</div>
				<!-- 후원 유의사항 체크 -->
				<div class="row ms-2 me-2">
					<div class="col pt-2 text-start">
						<div class="form-check fs-6">
							<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							<label class="form-check-label" for="flexCheckDefault">
								후원 유의사항 확인
							</label>
						</div>
					</div>
					<!-- 열기 닫기 버튼으로 보이고 안보이고?-->
					<div class="col-4 pt-2 fs-6">
						<button>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M8 1a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L7.5 13.293V1.5A.5.5 0 0 1 8 1z"/>
							</svg>							
							열기
						</button>
<!-- 						<button> -->
<!-- 							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up" viewBox="0 0 16 16"> -->
<!-- 							  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5z"/> -->
<!-- 							</svg>							 -->
<!-- 							닫기 -->
<!-- 						</button> -->
					</div>
					<!-- a태그 내용보기 끝 -->
				</div>
				<div class="row ms-2 me-2 pt-2 text-start">
					<p>
						펀딩은 일반 쇼핑과 달리 메이커에게 투자하고, 투자의 보상으로 제품이나 서비스를 받는 구조입니다.<br>
						따라서 단숨 변심으로 인한 환불은 신청하실 수 없습니다. 
					</p>
<!-- 					<ul class="list-group"> -->
<!-- 						<li class="list-group-item"></li> -->
<!-- 					</ul> -->
				</div>
				<!-- 개인정보 동의, 유의사항 끝 -->
				<!-- 후원하기 버튼 영역 -->
				<!-- 클릭시 결제 페이지로 이동 -->
				<div class="row ms-2 me-2 pt-3">
					<button class="btn btn-primary fs-3">이 프로젝트 후원하기</button>
				</div>
				<!-- 후원하기 버튼 영역 끝-->
			</div>
			<!-- 결제 확인 영역 끝-->
		</div>
	</div>
	<!-- 리워드, 서포터, 배송지, 쿠폰, 결제확인 영역 끝 -->
	<!-- 리워드 변경 모달창 -->
	<div class="modal" id="rewardListModal" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header d-flex justify-content-center">
					<h5 class="modal-title">리워드 변경</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="rewardListModalClose"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<!-- 반복문사용하여 리워드 리스트 뿌리기 -->
						<c:forEach var="reward" items="${rewardList }" varStatus="loop">
							<hr>
							<div class="row">
								<div class="col-2 d-flex justify-content-center align-self-center">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="rewardCheck" id="rewardCheck_${loop.index }">
									</div>
								</div>
								<div class="col text-start">
									<!-- hidden 값으로 리워드 번호 전달 -->
									<input type="hidden" value="${reward.reward_idx }">
									<span class="fs-4 fw-bold">${reward.reward_price }</span><br>
									<span class="fs-6">${reward.reward_name }</span><br>
									<span class="fs-6">${reward.reward_option }</span>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="rewardChange">변경</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="rewardListModalClose">닫기</button>
				</div>
			</div>
		</div>
	</div>	
	<!-- 리워드 변경 모달창 끝 -->
	<!-- 배송지 추가 모달창 -->
	<div class="modal" id="deliveryAddModal" tabindex="-1">
		<!-- modal-fullscreen -->
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header d-flex justify-content-center">
					<h5 class="modal-title">배송지 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="deliveryAddModalClose"></button>
				</div>
				<div class="modal-body">
					<!-- 배송지 추가 작업 요청 -->
					<form action="deliveryAdd" method="post">
						<div class="container text-start">
							<div class="row p-1">
								<span class="fs-5 fw-bold">받는 사람</span>
								<input type="text" class="form-control"  name="delivery_reciever">
							</div>
							<div class="row p-1">
								<span class="fs-5 fw-bold">받는 사람 연락처</span>
								<input type="text" class="form-control"  name="delivery_phone">
							</div>
							<div class="row p-1">
								<div class="col">
									<span class="fs-5 fw-bold text-start">주소</span>
									&nbsp;&nbsp;
									<button type="button" class="btn btn-primary " onclick="findPostcode()">찾기</button>
								</div>
							</div>
							<div class="row p-2">
								<span class="fs-6">우편번호</span>
								<input type="text" class="form-control" id="postcode" name="delivery_zipcode" placeholder="우편번호">
								<span class="fs-6">도로명 주소</span>
								<input type="text" class="form-control" id="address"  name="delivery_add" placeholder="주소"><br>
								<span class="fs-6">상세주소</span>
								<input type="text" class="form-control" id="detailAddress" name="delivery_detailadd" placeholder="상세주소">
								<span class="fs-6">참고항목</span>
								<input type="text" class="form-control" id="extraAddress" placeholder="참고항목">
								<!-- 주소찾기 영역 -->
								<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
									<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
								</div>							
								<!-- 주소찾기 영역 끝 -->
							
								<div class="form-check text-start ms-3 mt-2"> 
									<input class="form-check-input text-start" type="checkbox" value="1" name="delivery_default" id="deliveryDefaultCheck">
									<label class="form-check-label" for="deliveryDefaultCheck">기본 배송지 설정</label>
								</div>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" id="deliveryAdd">등록</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="deliveryAddModalClose">닫기</button>
				</div>
			</div>
		</div>
	</div>	
	<!-- 배송지 추가 모달창 끝 -->
	<!-- 카카오 API -->	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    // 우편번호 찾기 찾기 화면을 넣을 element
	    var element_wrap = document.getElementById('wrap');
	
	    function foldDaumPostcode() {
	        // iframe을 넣은 element를 안보이게 한다.
	        element_wrap.style.display = 'none';
	    }
	
	    function findPostcode() {
	        // 현재 scroll 위치를 저장해놓는다.
	        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	
	                // iframe을 넣은 element를 안보이게 한다.
	                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	                element_wrap.style.display = 'none';
	
	                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
	                document.body.scrollTop = currentScroll;
	            },
	            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
	            onresize : function(size) {
	                element_wrap.style.height = size.height+'px';
	            },
	            width : '100%',
	            height : '100%'
	        }).embed(element_wrap);
	
	        // iframe을 넣은 element를 보이게 한다.
	        element_wrap.style.display = 'block';
	    }
	</script>
	<!-- 카카오 API 끝 -->	
	<!-- 배송지 변경 모달창 -->
	<div class="modal" id="deliveryChangeModal" tabindex="-1">
		<!-- modal-fullscreen -->
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header d-flex justify-content-center">
					<h5 class="modal-title">배송지 변경</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="deliveryChangeModalClose"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<div class="row">
							<div class="col">
								<span class="fs-6">개의 배송지가 있습니다</span>
							</div>
							<div class="col text-end">
								<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryAddModal">추가</button>
							</div>
						</div>
						<!-- 배송지 목록 뿌리기 -->
						<div class="row" id="deliveryList">
<!-- 							<span class="fs-6 fw-bold text-start">수취인명</span> -->
<!-- 							<span class="fs-6 text-start">수취인연락처</span> -->
<!-- 							<span class="fs-6 text-start">[우편번호]&nbsp;&nbsp;주소&nbsp;&nbsp;상세주소</span> -->
							
						</div>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">선택</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="deliveryChangeModalClose">닫기</button>
				</div>
			</div>
		</div>
	</div>	
	<!-- 배송지 변경 모달창 끝 -->
	<!-- 부트스트랩 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=001f863eaaba2072ed70014e7f424f2f&libraries=services"></script>
</body>
</html>