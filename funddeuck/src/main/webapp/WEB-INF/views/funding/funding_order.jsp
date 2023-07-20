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
			<div class="col-lg-2">
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
			<div class="col text-start">
				<!--리워드 정보-->
				<div class="row">
					<span class="fs-4 fw-bold">리워드 정보</span>
					<div class="row p-2 border">
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
									<td></td>
								</tr>
								<tr>
									<th>예상 전달일</th>
									<td></td>
								</tr>
							</table>
						</div>
						<!-- 변경 버튼 -->
						<!--변경 버튼 클릭시 모달창 => 리워드 변경-->
					    <div class="col-2">
					    	<div class="row">
								<button class="btn btn-primary">변경</button>
					    	</div>
					    </div>
						<!-- 변경 버튼 끝 -->
					</div>
				</div>
				<!--리워드 정보 끝-->
				<!--서포터 정보-->
				<div class="row border">
					<span class="fs-4 fw-bold">서포터 정보</span>
					<div class="col">
					  <table class="table">
					    <tr>
					      <th>연락처</th>
					      <td></td>
					    </tr>
					    <tr>
					      <th>이메일</th>
					      <td></td>
					    </tr>
					  </table>
					  * 위 연락처와 이메일로 후원 관련 소식이 전달됩니다. <br>
					  * 연락처 및 이메일 변경은 설정 > 계정 설정에서 가능합니다.
					</div>
				</div>
				<!--서포터 정보 끝--> 
				<!--배송지-->     
				<div class="row border">
				  <h1>배송지</h1>
				  <div class="col">
				    기존 회원 정보의 주소지
				  </div>
				  <div class="col">
				    <!--변경 버튼 클릭시 모달창 => 배송지 정보 -->
				    <button class="btn btn-primary">변경</button>
				  </div>
				</div>
				<!--배송지 끝--> 
				<!--쿠폰-->     
				<div class="row border">
				  <h1>쿠폰</h1>
				  
				  <div class="col">
				  <!-- 드롭다운으로 가지고있는 쿠폰 선택 -->
				  </div>
				</div>
				<!--쿠폰 끝-->          
			</div>
			<!--왼쪽 영역 끝-->
			<!-- 결제 확인 영역-->
			<div class="col border">
			  <!-- 최종 후원 금액 -->
			  <div class="row text-start">
			    <div class="col">
			      <h3>최종 후원 금액</h3>
			    </div>
			    <div class="col">
			      xxx원
			    </div>
			  </div>
			  <!-- 최종 후원 금액 끝-->
			  <!-- 결제전 체크 사항-->
			  <div class="row">
			    <!--개인정보 동의, 유의사항 체크박스-->
			    <div class="col p-5 text-start">
			      <div class="form-check">
			        <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
			        <label class="form-check-label text-start" for="flexCheckDefault">
			          개인정보 제3자 제공 동의
			        </label>
			      </div>
			    </div>
			    <!-- a태그 내용보기 -->
			    <!--모달창으로 개인정보 동의 내용 보여주기-->
			    <div class="col p-5">
			      <a href="#">내용보기</a>
			    </div>
			  </div>
			  <!-- 결제전 체크 사항 끝-->
			  <div class="row">
			    <button class="btn btn-primary">이 프로젝트 후원하기</button>
			  </div>
			</div>
			<!-- 결제 확인 영역 끝-->
		</div>
	</div>
	<!-- 리워드, 서포터, 배송지, 쿠폰, 결제확인 영역 끝 -->

  <!-- 부트스트랩 -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>