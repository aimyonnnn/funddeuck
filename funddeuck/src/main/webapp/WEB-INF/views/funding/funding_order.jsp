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
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/> --%>
</head>
<body>
	<!-- 이미지, 프로젝트 정보 -->
	<div class="container text-center">
		<div class="row p-2">
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
				<span class="fs-2 fw-bold">프로젝트 명</span> <br>
				<span class="fs-4 fw-bold">xxxx원</span>&nbsp;&nbsp;
				<span class="fs-5 text-primary fw-bold">xx%</span> &nbsp; 
				<span class="fs-6 text-muted">xx일 남음</span>
			</div>
			<!-- 프로젝트 정보 영역 끝 -->
		</div>
	</div>
	<!-- 이미지, 프로젝트 정보 끝 -->
	<!-- 리워드, 서포터, 배송지, 쿠폰, 결제확인 영역 -->
	<div class="container text-center">
		<div class="row">
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
										선택한 옵션
									</td>
								</tr>
								<tr>
									<th>리워드 금액</th>
									<td>xxx원</td>
								</tr>
								<tr>
									<th>예상 전달일</th>
									<td>23년 xx월 xx일</td>
								</tr>
							</table>
						</div>
						<!-- 변경 버튼 -->
						<!--변경 버튼 클릭시 모달창 => 리워드 변경-->
					    <div class="col-lg-2 col-md-6">
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
									<td>010-1234-5678</td>
								</tr>
								<tr>
									<th>이메일</th>
									<td>funddeuck@itwill.co.kr</td>
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
<!-- 						<div class="row text-center"> -->
<!-- 							<button class="btn btn-primary">추가</button> -->
<!-- 						</div> -->
						<!-- 기본 배송지 등록 X 끝 -->
						<!-- 기본 배송지 등록 O -->
						<!-- 변경 버튼 클릭시 모달창 => 배송지 정보 -->
						<div class="col">
							<div class="row-12">
								<span class="fs-6 fw-bold">수취인</span>
								<span class="bg-danger text-white">기본</span>
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
						<div class="col-2">
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
			<div class="col-lg-6 col-md-12 border border-danger">
				<!-- 후원 금액 -->
				<div class="row border">
					<div class="col text-start">
						<span class="fs-4 fw-bold text-primary">최종 후원 금액</span>
					</div>
					<div class="col-4 text-end">
						<span class="fs-4 fw-bold">xxxx원</span>
					</div>
				</div>
				<div class="row">
					<div class="col text-start">
						<span class="fs-5 fw-bold">리워드 금액</span>
					</div>
					<div class="col-4 text-end">
						<span class="fs-5 fw-bold">xxxx원</span>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<span class="fs-5 fw-bold">추가 후원 금액</span>
					</div>
					<div class="col-4">
						<span class="fs-5 fw-bold">xxxx원</span>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<span class="fs-5 fw-bold">쿠폰 사용</span>
					</div>
					<div class="col-4">
						<span class="fs-5 fw-bold">-xxxx원</span>
					</div>
				</div>
				<!-- 후원 금액 끝-->
				<!-- 결제전 체크 사항-->
				<div class="row">
					<!-- 개인정보 동의, 유의사항 체크박스 -->
					<div class="col p-5 text-start">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
							<label class="form-check-label text-start" for="flexCheckDefault">
								개인정보 제3자 제공 동의
							</label>
						</div>
					</div>
					<!-- 개인정보 동의, 유의사항 체크박스 끝 -->
					<!-- a태그 내용보기 -->
					<!-- 모달창으로 개인정보 동의 내용 보여주기 -->
					<div class="col p-5">
						<a href="#">내용보기</a>
					</div>
					<!-- a태그 내용보기 끝 -->
				</div>
				<!-- 결제전 체크 사항 끝-->
				<!-- 후원하기 버튼 영역 -->
				<!-- 클릭시 결제 페이지로 이동 -->
				<div class="row">
					<button class="btn btn-primary">이 프로젝트 후원하기</button>
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