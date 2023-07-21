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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
</head>
<body>
	<!-- 이미지, 프로젝트 정보 -->
	<div class="container text-center">
		<div class="row p-2 m-3">
			<!-- 프로젝트 이미지 영역 -->
			<!-- 화면 작을 때 이미지 크기 설정필요 -->
			<div class="col-lg-2 col-4">
				<img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" class="img-fluid" alt="...">
			</div>
<!-- 			<div class="col-12 d-lg-none"> -->
<!-- 				<img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" class="img-fluid" alt="..."> -->
<!-- 			</div> -->
			<!-- 프로젝트 이미지 영역 끝 -->
			<!-- 프로젝트 정보 영역 -->
			<div class="col p-2 text-start">
				
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
						<div class="col">
							<table class="table table-borderless">
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
									<th>발송 시작일</th>
									<!-- 날짜 사이 하이픈 제거하고 .으로 변경 -->
									<td>${reward.delivery_date }</td>
								</tr>
							</table>
						</div>
						<!-- 변경 버튼 -->
						<!--변경 버튼 클릭시 모달창 => 리워드 변경-->
					    <div class="col-lg-2 col-sm-12 d-flex justify-content-center align-self-center">
							<button class="btn btn-primary">변경</button>
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
						<!-- 기본 배송지 등록 X -->
<!-- 						<div class="col d-flex justify-content-center align-self-center"> -->
<!-- 							<button class="btn btn-primary">추가</button> -->
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
							<button class="btn btn-primary">변경</button>
						</div>
						<!-- 기본 배송지 등록 O 끝 -->
					</div>
				</div>
				<!--배송지 끝--> 
				<!--쿠폰-->     
				<div class="row">
					<span class="fs-4 fw-bold">쿠폰</span>
					<div class="row m-2 p-2 border">
						<div class="col-3 text-start">
							<span class="fs-6 fw-bold">보유 쿠폰</span>
						</div>
						<div class="col">
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
							<span class="fs-6 fw-bold">xxxx원</span>
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
	<div class="container text-center">
		<div class="row">
		</div>
		
	</div>

  <!-- 부트스트랩 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>