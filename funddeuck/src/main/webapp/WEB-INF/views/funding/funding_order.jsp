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
<!-- 부트스트랩 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"> -->
<!-- 부트스트랩 5.3.0 CSS 추가 -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css"> -->
<!-- 부트스트랩 5.3.0 JS 추가 -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script> -->
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- funding_order.js -->
<script src="${pageContext.request.contextPath }/resources/js/funding_order.js"></script>
<!-- 공용 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
//===========================================================
//===========================================================
// 아임포트 결제 스크립트
$(()=>{
	   
	   let IMP = window.IMP;
	   IMP.init("imp30787507");
	   
	    $('#requestPay').on('click', function() {
	    	
	        IMP.request_pay({
	        	
				pg: "html5_inicis", // PG사 선택
				pay_method: "card", // 지불 수단
				merchant_uid: "merchant_" + new Date().getTime(), // 주문번호
				name: "펀딩  프로젝트명", // 상품명
				amount: 1000 // 가격
	       },
	       function(rsp) { // callback
	       console.log(rsp);
	         
	         // ================= 결제 성공 시 =================
	       		if(rsp.success) {
		     		console.log('결제가 완료되었습니다.');
		        	var formData = ${'#fundingPaymentForm'}.serialize();
		     		
		       		let payment_method = 1; 					    // 결제수단(1:카드결제)
		       		let payment_confirm = 2; 					    // 결제상태(2:결제완료)
			        // ================= DB 작업 =================
			        // 1. project_approve_status = 5일 경우 결제테이블 결제 정보 저장하기
			        // 2. 프로젝트 상태컬럼을 5-결제완료 상태로 변경(펀딩+ 페이지에 출력 가능한 상태)
			        
			        $.ajax({
						method: 'post',
						url: "<c:url value='fundingPayment'/>",
						dataType: 'text',
						data: {
							FormData,
							payment_method: payment_method,
							payment_confirm: payment_confirm
							
						},
						success: function(data){
						},
						error: function(){
							console.log('ajax 요청이 실패하였습니다!');	
						}
					});
			    	// ================= DB 작업 =================
		        // ================= 결제 실패 시 =================
		        } else {
		            var msg = '결제에 실패하였습니다.';
		            msg += '에러내용: ' + rsp.error_msg;
		            alert(msg);
	         	}
	      });
	   });
	}); // ready
//===========================================================
</script>	

</head>
<body>
	<!-- 헤더  -->
	<jsp:include page="../Header.jsp"></jsp:include>
	<!-- 이미지, 프로젝트 정보 -->
	<div class="container text-center">
		<div class="row p-2 m-3">
			<!-- 프로젝트 이미지 영역 -->
			<!-- 프로젝트 이미지 불러오기 -->
			<div class="col-lg-2 col-4">
				<img src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}" class="d-block w-100" alt="project_thumnails1">
<!-- 				<img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" class="img-fluid" alt="..."> -->
			</div>
			<!-- 프로젝트 이미지 영역 끝 -->
			<!-- 프로젝트 정보 영역 -->
			<div class="col p-2 text-start">
				<span class="fs-2 fw-bold">${project.project_subject }</span> <br>
				<!-- 누적금액 -->
				<span class="fs-4 fw-bold">${project.project_cumulative_amount }원</span>&nbsp;&nbsp;
				<!-- 달성률 -->
				<span class="fs-5 text-primary fw-bold">${achievementRate }%</span> &nbsp; 
				<!-- 남은 프로젝트 기간 -->
				<span class="fs-6 text-muted">${remainingDays }일 남음</span>
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
									<td><span id="reward">${reward.reward_price }</span>원</td>
								</tr>
								<tr>
									<th>리워드 수량</th>
									<td class="d-flex align-items-center">
										<a class="text-primary fs-4 w-20 d-block " role="button" id="rewardQuantityUp">
											<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-up-circle fs-6" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
											</svg>										
										</a> &nbsp;&nbsp;
										<input type="hidden" id="maxRewardQuantity" value="${reward.reward_quantity }">
										<input class="form-control form-inline w-10" id="rewardQuantity" type="number" value="1" min="1" max="${reward.reward_quantity }">&nbsp;&nbsp;
										<a class="text-primary fs-4 w-20 d-block" role="button" id="rewardQuantityDown">
											<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
											</svg>									
										</a>
									</td>
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
				<!-- 기본배송지 유무 판별 -->
				<!-- 기본 배송지 정보 아무것도 없을 경우 배송지 추가 버튼만 -->
				<!-- 기본 배송지 정보 있을 경우 기본 배송지 출력 -->
				<div class="row">
					<span class="fs-4 fw-bold">배송지</span>
					<div class="row m-2 p-2 border" id="deliveryContainer">
						<c:choose>
							<c:when test="${not empty deliveryDefault}">
								<div class="col">
									<div class="row-12">
										<span class="fs-6 fw-bold">${deliveryDefault.delivery_reciever }</span>
										<span class="badge bg-danger text-white">기본</span>
									</div>
									<div class="row-12">
										<span class="fs-6">[${deliveryDefault.delivery_zipcode }]</span>
										<span class="fs-6">${deliveryDefault.delivery_add }</span>
										<c:if test="${not empty deliveryDefault.delivery_detailadd}">
											<span class="fs-6">${deliveryDefault.delivery_detailadd }</span>
										</c:if>
									</div>
									<div class="row-12">
										<span class="fs-6">${deliveryDefault.delivery_phone }</span>
									</div>
								</div>
								
								<div class="col-lg-2 col-sm-12 d-flex justify-content-center align-self-center">
									<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryChangeModal">변경</button>
								</div>
							</c:when>
							<c:otherwise>
								<div class="col d-flex justify-content-center align-self-center">
									<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryNewAddModal">배송지 추가</button>
								</div>
							</c:otherwise>
						</c:choose>
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
								<!-- 쿠폰이 없을 경우 -->
								<!-- 보유한 쿠폰 중 사용 가능한 쿠폰 목록만 출력 -->
								<select class="form-select" id="couponSelect" onchange="updateCouponSale()">
									<option value="">쿠폰을 선택해주세요.</option>
									<c:choose>
										<c:when test="${empty couponList }">
											<option class="fs-6 text-muted" disabled>보유하신 쿠폰이 없습니다</option>
										</c:when>
										<c:when test="${not empty couponList }">
											<c:forEach var="coupon" items="${couponList }">
												<option value="${coupon.coupon_sale }">${coupon.coupon_name }</option>
											</c:forEach>
										</c:when>
									</c:choose>
								</select>							
							
							
							</div>
							<!-- 쿠폰 선택시 할인금액 출력 -->
							<div class="row p-2">
								<span class="fs-6 fw-bold" id="couponSale"></span>			
							</div>
						</div>
					</div>
				</div>
				<!-- 쿠폰 끝 -->       
				<!-- 추가 후원금 -->
				<div class="row">
					<span class="fs-4 fw-bold">추가 후원금</span>
					<div class="row m-2 p-2 border">
						<div class="row">
							<!-- ${addDonationAmount } -->
							<div class="col">
								<input class="form-control" type="text" id="addDonationAmountInput" placeholder="숫자만 입력">
							</div>
							<div class="col-4">
								<span class="fs-6 fw-bold">원</span>
							</div>
						</div>
						<div class="row p-2">
							<span class="fs-6 text-muted">후원을 더 많이 해주시면 프로젝트가 더 빨리 성공적으로 완료될 수 있습니다.</span>			
						</div>
					</div>
				</div>
				<!-- 추가 후원금 끝-->   
				<!-- 결제 수단 선택 -->
				<div class="row">
					<span class="fs-4 fw-bold">결제 수단</span>
					<div class="row m-2 p-2 border d-flex align-content-center">
						<div class="form-check col ms-4">
							<input class="form-check-input" type="radio" name="paymentCheck" id="card_payment" checked>
							<label class="form-check-label fs-6" for="card_payment">
								카드로 결제하기(기본 결제)
							</label>
						</div>
						<div class="form-check col">
							<input class="form-check-input" type="radio" name="paymentCheck" id="account_payment">
							<label class="form-check-label fs-6" for="account_payment">
								계좌로 결제하기
							</label>
						</div>					
					</div>
				</div>
				<div class="row">
				
					<div class="row d-none" id="card_payment_area">
					<!-- 카드결제 -->
<!-- 						카드결제 체크시 보여줄 영역 -->
<!-- 						<input class="btn btn-primary" type="button" value="카드결제" name="requestPay"> -->
					<!-- 최초등록 / 계좌변경 -->
					</div>
					<div class="row d-none" id="account_payment_area">
						<c:if test="${not empty bankAccount }">
							<div class="col-12">
								<span class="fs-6 fw-bold">은행명</span>&nbsp;&nbsp;
								<span class="fs-6">${bankAccount.bank_name}</span>
							</div>
							<div class="col-12">
								<span class="fs-6 fw-bold">예금주명</span>&nbsp;&nbsp;
								<span class="fs-6">${bankAccount.account_holder_name}</span>
							</div>
							<div class="col-12">
								<span class="fs-6 fw-bold">계좌번호</span>&nbsp;&nbsp;
								<span class="fs-6">${bankAccount.account_num_masked}</span>
							</div>
							<div class="col-12 d-flex align-content-center mt-2">
	<!-- 								<input class="btn btn-primary" type="button" value="계좌변경" id="btnAccountAuth"> -->
								<input class="btn btn-primary" type="button" value="계좌변경" onclick="window.open('authMember', 'authWindow', 'width=600, height=800');">
							</div>								
						</c:if>
						<c:if test="${empty bankAccount }">
							<div class="col-12 d-flex justify-content-center align-self-center mt-2">
	<!-- 								<input class="btn btn-primary" type="button" value="계좌등록" id="btnAccountAuth"> -->
								<input class="btn btn-primary" type="button" value="계좌등록" onclick="window.open('authMember', 'authWindow', 'width=600, height=800');">
							</div>
						</c:if>
					</div>
					</div>
				<!-- 결제 수단 선택 끝-->   
			</div>
			<!-- 왼쪽 영역 끝 -->
			<!-- 결제 확인 영역-->
			<div class="col-lg-6 col-md-12 p-4 mt-4">
				<!-- 후원 금액 -->
				<div class="row border ms-2 me-2">
					<div class="col text-start">
						<span class="fs-4 fw-bold text-primary">최종 후원 금액</span>
					</div>
					<div class="col-4 text-end">
						<span class="fs-4 fw-bold" id="totalPrice">${reward.reward_price + reward.delivery_price}</span><span class="fs-6 fw-bold">원</span>
					</div>
				</div>
				<!-- 최종금액 외 금액들 -->
				<div class="row border ms-2 me-2">
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">리워드 총금액</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold" id="rewardPrice">${reward.reward_price }</span><span class="fs-6 fw-bold">원</span>
						</div>
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">배송비</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold" id="rewardDeliveryPrice">${reward.delivery_price }</span><span class="fs-6 fw-bold">원</span>
						</div>
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">쿠폰 사용</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold" id="minus"></span><span class="fs-6 fw-bold" id="couponPrice">0</span><span class="fs-6 fw-bold">원</span>
						</div>
						<div class="col-6 text-start">
							<span class="fs-6 fw-bold">추가 후원 금액</span>
						</div>
						<div class="col-6 text-end">
							<span class="fs-6 fw-bold" id="addDonationAmount">0</span><span class="fs-6 fw-bold">원</span>
						</div>
				</div>
				<!-- 후원 금액 끝-->
				<!-- 결제 예정일 안내 -->
				<div class="row pt-2 text-start ms-2 me-2">
					<p><!-- 결제일 => 프로젝트 종료일  -->
						프로젝트 성공시 결제는 <span class="fw-bold text-danger">${project.project_end_date }</span>에 진행 예정입니다.<br>
						프로젝트가 취소됬을 경우, 예약된 결제는 자동으로 결제가 취소됩니다.
					</p>
				</div>
				<!-- 결제 예정일 안내 끝 -->
				<!-- 개인정보 동의, 유의사항 -->
				<div class="row ms-2 me-2">
					<div class="col pt-2 text-start">
						<div class="form-check fs-6">
							<input class="form-check-input" type="checkbox" value="" id="personalInfoAgree">
							<label class="form-check-label" for="personalInfoAgree">
								개인정보 제3자 제공 동의
							</label>
						</div>
					</div>
					<!-- a태그 내용보기 -->
					<!-- 모달창으로 개인정보 동의 내용 보여주기 -->
					<div class="col-4 pt-2 fs-6">
						<button class="btn btn-primary" id="personalInfoAgreeModalOpen" data-bs-toggle="modal" data-bs-target="#personalInfoAgreeModal">내용보기</button>
					</div>
					<!-- a태그 내용보기 끝 -->
				</div>
				<!-- 후원 유의사항 체크 -->
				<div class="row ms-2 me-2">
					<div class="col pt-2 text-start">
						<div class="form-check fs-6">
							<input class="form-check-input" type="checkbox" value="" id="notesCheck">
							<label class="form-check-label" for="notesCheck">
								후원 유의 사항 확인
							</label>
						</div>
					</div>
					<!-- 열기 닫기 버튼으로 보이고 안보이고?-->
					<div class="col-4 pt-2 fs-6">
						<a id="notesOpen" role="button" style="display:block;">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-down" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M8 1a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L7.5 13.293V1.5A.5.5 0 0 1 8 1z"/>
							</svg>							
							열기
						</a>
						<a id="notesClose" role="button" style="display:none;">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-up" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5z"/>
							</svg>							
							닫기
						</a>
					</div>
					<!-- a태그 내용보기 끝 -->
				</div>
				<!-- 후원 유의사항 -->
				<div class="row ms-2 me-2 pt-2 text-start" id="notesContainer">
<!-- 					<ul class="list-group"> -->
<!-- 						<li class="list-group-item"></li> -->
<!-- 					</ul> -->
				</div>
				<!-- 후원 유의사항 끝 -->
				<!-- 개인정보 동의, 유의사항 끝 -->
				<!-- 후원하기 버튼 영역 -->
				<!-- 클릭시 결제 페이지로 이동 -->
				<!-- 체크박스 다 체크했을경우 이동가능 -->
				<div class="row ms-2 me-2 pt-3">
					<form action="fundingPayment" method="post" onsubmit="return validateForm()" id="fundingPaymentForm">
						<input type="text" name="project_idx" value="${project.project_idx }">
						<input type="text" name="member_idx" value="${member.member_idx }">
						<!-- ajax로 바뀜 -->
						<input type="text" name="reward_idx" value="${reward.reward_idx }" id="reward_idx">
						<input type="text" name="reward_amount" value="${reward.reward_price }" id="reward_amount">
						<input type="text" name="delivery_idx" id="delivery_idx" value="<c:if test="${not empty deliveryDefault }">${deliveryDefault.delivery_idx }</c:if>">
						<input type="text" name="delivery_idx" id="delivery_zipcode" value="<c:if test="${not empty deliveryDefault }">${deliveryDefault.delivery_zipcode }</c:if>">
						<input type="text" name="delivery_idx" id="delivery_add" value="<c:if test="${not empty deliveryDefault }">${deliveryDefault.delivery_add }</c:if>">
						<input type="text" name="member_email" value="${member.member_email }">
						<input type="text" name="member_phone" value="${member.member_phone }">
						<input type="text" name="additional_amount" id="additional_amount" value="0">
						<input type="text" name="use_coupon_amount" id="use_coupon_amount" value="0">
						<input type="text" name="total_amount" id="total_amount" value="${reward.reward_price + reward.delivery_price}">
						<input type="text" name="payment_quantity" id="payment_quantity" value="1">
						<!-- 결제수단(1:카드 2:계좌) -->
						<input type="text" name="payment_method" id="payment_method" value="1">
						<input type="text" name="project_end_date" id="project_end_date" value="${project.project_end_date }">
<!-- 						<input type="text" name="coupon_idx" id="coupon_idx" value=""> -->
						<button type="submit" id="fundingPaymentSubmitButton" class="btn btn-primary fs-3">이 프로젝트 후원하기</button>
					</form>
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
	<!-- 배송지 추가 모달창(기본배송지 있을 경우) -->
	<div class="modal" id="deliveryAddModal" tabindex="-1">
		<!-- modal-fullscreen -->
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header d-flex justify-content-center">
					<h5 class="modal-title">배송지 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="deliveryAddModalClose"></button>
				</div>
				<form action="deliveryAdd" method="post">
					<div class="modal-body">
						<!-- 배송지 추가 작업 요청 -->
							<div class="container text-start">
								<div class="row p-1">
									<span class="fs-5 fw-bold">받는 사람</span>
									<input type="text" class="form-control" name="delivery_reciever" pattern="[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]+" placeholder="한글 또는 영어만 입력 가능" required>
								</div>
								<div class="row p-1">
									<span class="fs-5 fw-bold">받는 사람 연락처</span>
									<input type="text" class="form-control delivery_phone" name="delivery_phone" placeholder="하이픈('-')제외 숫자만 입력" maxlength="13" required>
								</div>
								<div class="row p-1">
									<div class="col">
										<span class="fs-5 fw-bold text-start">주소</span>
										&nbsp;&nbsp;
										<button type="button" class="btn btn-primary " onclick="findPostcode(wrap)">찾기</button>
									</div>
								</div>
								<div class="row p-2">
									<span class="fs-6">우편번호</span>
									<input type="text" class="form-control" id="postcode" name="delivery_zipcode" placeholder="우편번호" onfocus="findPostcode(wrap)" required>
									<span class="fs-6">도로명 주소</span>
									<input type="text" class="form-control" id="address"  name="delivery_add" placeholder="주소" onfocus="findPostcode(wrap)" required><br>
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
										<label class="form-check-label" for="deliveryDefaultCheck"><span class="fs-6">기본 배송지 설정</span></label>
									</div>
								</div>
							</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary" id="deliveryAdd">추가</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="deliveryAddModalClose">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>	
	<!-- 배송지 추가 모달창(기본배송지 있을 경우) 끝 -->
	<!-- 배송지 신규 등록 모달창(배송지 없을 경우 기본 배송지로 등록) -->
	<div class="modal" id="deliveryNewAddModal" tabindex="-1">
		<!-- modal-fullscreen -->
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header d-flex justify-content-center">
					<h5 class="modal-title">배송지 신규 등록</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="deliveryAddModalClose"></button>
				</div>
				<form action="deliveryNewAdd" method="post">
					<div class="modal-body">
						<!-- 배송지 등록 작업 요청 -->
							<div class="container text-start">
								<div class="row p-1">
									<span class="fs-5 fw-bold">받는 사람</span>
									<input type="text" class="form-control" name="delivery_reciever" pattern="[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z]+" placeholder="한글 또는 영어만 입력 가능" required>
								</div>
								<div class="row p-1">
									<span class="fs-5 fw-bold">받는 사람 연락처</span>
									<input type="text" class="form-control delivery_phone" name="delivery_phone" placeholder="하이픈('-')제외 숫자만 입력" maxlength="13" required>
								</div>
								<div class="row p-1">
									<div class="col">
										<span class="fs-5 fw-bold text-start">주소</span>
										&nbsp;&nbsp;
										<button type="button" class="btn btn-primary " onclick="findPostcode(wrap2)">찾기</button>
									</div>
								</div>
								<div class="row p-2">
									<span class="fs-6">우편번호</span>
									<input type="text" class="form-control" id="postcode2" name="delivery_zipcode" placeholder="우편번호" onfocus="findPostcode(wrap2)" required>
									<span class="fs-6">도로명 주소</span>
									<input type="text" class="form-control" id="address2"  name="delivery_add" placeholder="주소" onfocus="findPostcode(wrap2)" required><br>
									<span class="fs-6">상세주소</span>
									<input type="text" class="form-control" id="detailAddress2" name="delivery_detailadd" placeholder="상세주소">
									<span class="fs-6">참고항목</span>
									<input type="text" class="form-control" id="extraAddress2" placeholder="참고항목">
									<!-- 주소찾기 영역 -->
									<div id="wrap2" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
										<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
									</div>							
									<!-- 주소찾기 영역 끝 -->
								</div>
							</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary">등록</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="deliveryNewAddModalClose">닫기</button>
					</div>
				</form>
			</div>
		</div>
	</div>	
	<!-- 배송지 신규 등록 모달창 끝 -->
	<!-- 카카오 API -->	
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    // 우편번호 찾기 찾기 화면을 넣을 element
	    var element_wrap = document.getElementById('wrap');
	    var element_wrap2 = document.getElementById('wrap2');
	
	    function foldDaumPostcode() {
	        // iframe을 넣은 element를 안보이게 한다.
	        element_wrap.style.display = 'none';
	        element_wrap2.style.display = 'none';
	    }
	
	    function findPostcode(targetElement) {
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
	                    if(targetElement === element_wrap) {
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("extraAddress").value = extraAddr;
	                    	
	                    } else if(targetElement === element_wrap2) { 
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("extraAddress2").value = extraAddr;
	                    	
	                    }
	                
	                } else {
	                    if(targetElement === element_wrap) {
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("extraAddress").value = '';
	                    	
	                    } else if(targetElement === element_wrap2) { 
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("extraAddress2").value = '';
	                    	
	                    }
	                	
	                }
	
	
	                // iframe을 넣은 element를 안보이게 한다.
	                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
	                if(targetElement === element_wrap) { // 배송지 추가 등록
		                element_wrap.style.display = 'none';
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('postcode').value = data.zonecode;
		                document.getElementById("address").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("detailAddress").focus();
	                } else if(targetElement === element_wrap2) { // 신규 배송지 등록
		                element_wrap2.style.display = 'none';
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('postcode2').value = data.zonecode;
		                document.getElementById("address2").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("detailAddress2").focus();
	                }
	
	                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
	                document.body.scrollTop = currentScroll;
	            },
	            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
	            onresize : function(size) {
	                if(targetElement === element_wrap) {
		                element_wrap.style.height = size.height+'px';
	                } else if(targetElement === element_wrap2) {
		                element_wrap2.style.height = size.height+'px';
	                }
	            },
	            width : '100%',
	            height : '100%'
	        }).embed(targetElement);
	
	        // iframe을 넣은 element를 보이게 한다.
	        targetElement.style.display = 'block';
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
						<div class="row mb-2">
							<div class="col">
								<span class="fs-6 fw-bold" id="deliveryCount"></span>
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
						<!-- 체크된 배송지의 delivery_idx를 넣기 -->
						<form action="deliveryChange" method="post">
							<input type="hidden" value="" name="changeDelivery_idx" id="changeDelivery_idx">
						</form>
					</div>
					
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" id="deliveryChange">선택</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="deliveryChangeModalClose">닫기</button>
				</div>
			</div>
		</div>
	</div>	
	<!-- 배송지 변경 모달창 끝 -->
	<!-- 내용보기 클릭시 개인정보 동의 안내문 모달창 -->
	<div class="modal" id="personalInfoAgreeModal" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
	 			<div class="modal-header">
					<h4 class="modal-title fw-bold">개인정보 제3자 제공 동의</h4>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p class="fs-6" style="white-space: pre-line">개인정보 제3자 제공 동의 안내
					
					<span class="fw-bold">[펀뜩]</span>은 고객님의 개인정보를 소중하게 여기며, 개인정보보호법, 정보통신망 이용 촉진 및 정보보호 등에 관한 법률 등 관련 법령에 따라 원칙적으로 고객님의 개인정보를 제3자에게 제공하지 않습니다. 
					
					그러나 회원님께 더 나은 서비스를 제공하기 위해, 배송 등의 필요한 업무처리를 위하여 아래와 같은 범위 내에서 개인정보를 제공할 수 있습니다.
					
					1. 제공 받는 자: [배송업체명]
					2. 제공되는 개인정보: 성명, 주소, 연락처 등 배송에 필요한 정보
					3. 제공목적: 상품 배송을 위한 정보 전달 및 상품/서비스 제공과 관련한 업무 처리
					4. 보유 및 이용기간: 회원탈퇴 시 혹은 제3자 제공 동의 철회 요청 시까지
					
					단, 고객님께서 동의하지 않으시더라도 서비스 이용에 지장은 없으며, 언제든지 동의를 철회할 수 있습니다.
					동의를 철회하는 방법은 <span class="fw-bold">[펀뜩]</span> 고객센터로 연락하시거나, 개인정보 변경 화면에서 설정을 변경하실 수 있습니다.
					
					위 내용을 숙지하시고 동의하신 경우, 
					[개인정보 제3자 제공 동의] 버튼을 눌러주세요.</p>		
				</div>
			</div>
		</div>
	</div>	
	<!-- 내용보기 클릭시 개인정보 동의 안내문 모달창 끝 -->

	
	<!-- 부트스트랩 -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=001f863eaaba2072ed70014e7f424f2f&libraries=services"></script>
</body>
</html>