<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀딩</title>
<!-- 부트스트랩 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<!-- line-awesome icons CDN -->
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- header include -->
<jsp:include page="../Header.jsp"></jsp:include>
<!-- 공용 css -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<body>
<!-- 헤더와 본문 위치 조정 -->
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<br>
<br>
	<div class="container text-center">
		<span class=""></span>
		<hr class="border border-primary border-2">
		<div class="grid gap-3">
			<p class="fs-2 fw-bolder">결제가 완료되었습니다</p><br>
			<div class="row p-2 m-3 d-flex justify-content-center align-content-center">
				<!-- 프로젝트 이미지 영역 -->
				<!-- 프로젝트 이미지 불러오기 -->
				<div class="col-lg-3 col-md-1">
				</div>
				<div class="col-lg-2 col-4">
					<a href="fundingDetail?project_idx=${project.project_idx}">
						<img src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}" class="d-block w-100" alt="project_thumnails1">
					</a>
				</div>
				<!-- 프로젝트 이미지 영역 끝 -->
				<!-- 프로젝트 정보 영역 -->
				<div class="col p-2 text-start">
					<span class="fs-6 text-primary fw-bold">${project.project_category }</span> <br>
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
			<div class="grid gap-3">
<!-- 					  <div class="col-md-6 row-gap-10"> -->
<!-- 						<img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" class="img-fluid" alt="..."> -->
<%-- 						<img src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}" class="d-block w-25 float-start" alt="..." > --%>
<!-- 					  </div> -->
				<div class="row d-flex justify-content-center align-self-center">
					  <div class="col-md-6 row-gap-10">
					  	<span class="fs-4">기본 정보</span>
					  	<table class="text-start">
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주문자명</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${member.member_name }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">이메일</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${member.member_email }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">연락처</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${member.member_phone }</span></td>
					  		</tr>
					  	</table>
					  	<hr>
					  	<span class="fs-4">후원 정보</span>
					  	<table class="text-start">
					  		<tr>
					  			<th><span class="fs-5 fw-bold">프로젝트명</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${project.project_subject }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">종료일</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${project.project_end_date }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">리워드명</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${reward.reward_name }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">옵션</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${reward.reward_option }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주문수량</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${payment.payment_quantity }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">발송 시작일</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${reward.delivery_date }</span></td>
					  		</tr>
					  	</table>
					  	<hr>
					  	<span class="fs-4">배송 정보</span>
					  	<table class="text-start">
					  		<tr>
					  			<th><span class="fs-5 fw-bold">받는 사람</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${delivery.delivery_reciever }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">연락처</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${delivery.delivery_phone }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주소</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${delivery.delivery_add }&nbsp;${delivery.delivery_detailadd }</span></td>
					  		</tr>
					  	</table>
					  	<hr>
					  	<span class="fs-4">결제 정보</span>
					  	<table class="text-start">
					  		<tr>
					  			<th><span class="fs-5 fw-bold">결제 수단</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td>
					  				<c:if test="${payment.payment_method eq 1}">
					  					<span class="fs-5">카드</span>
					  				</c:if>
					  				<c:if test="${payment.payment_method eq 2}">
					  					<span class="fs-5">계좌</span>
					  				</c:if>
					  			
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주문 날짜</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${payment.payment_date }</span></td>
<%-- 					  			<td><span class="fs-5"><fmt:formatNumber value="${payment.payment_date }" pattern="#,###" />원</span></td> --%>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">결제 금액</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5"><fmt:formatNumber value="${payment.total_amount }" pattern="#,###" />원</span></td>
					  		</tr>
						  		<tr>
						  			<th><span class="fs-5 fw-bold">결제 상태</span></th>
						  			<td>&nbsp;&nbsp;</td>
						  			<td>
						  			<c:if test="${payment.payment_method eq 1}">
						  				<span class="fs-5">결제 완료</span>
					  				</c:if>
						  			
						  			<c:if test="${payment.payment_method eq 2}">
						  				<span class="fs-5"><span class="fs-5 text-danger" >${project.project_end_date }</span>에 결제 예정</span>
					  				</c:if>
						  			</td>
						  		</tr>
					  	</table>
					  </div>
				</div>
			</div>
		</div>
		<br>
		<div class="col text-center">
			<button class="btn btn-primary me-8" onclick="location.href='fundingDetail?project_idx=${project.project_idx }'"><span class="text-center text-white fw-bold">프로젝트 상세 페이지 이동</span></button>
			<button class="btn btn-primary me-8" onclick="location.href='fundingDiscover?category=all&status=all&index=newest'"><span class="text-center text-white fw-bold">다른 프로젝트 둘러보기</span></button>
		</div>
		<br>
		<hr class="border border-primary border-2">
	</div>
<br>
</body>
</html>