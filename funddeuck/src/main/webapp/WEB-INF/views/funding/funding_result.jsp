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
<br>
<br>
	<div class="container">
		<hr class="border border-success border border-2">
		<div class="grid gap-3">
			<p class="fs-2 fw-bolder">결제가 완료되었습니다</p><br>
			<div class="grid gap-3">
				<div class="row">
					<img src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}" class="d-block w-25 float-start" alt="...">
					  <div class="col-md-6 row-gap-10">
					  	<table class="text-start">
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주문번호</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${payment.payment_idx }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주문자</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${member.member_id }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">수취인</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${delivery.delivery_reciever }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">수취인 연락처</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${delivery.delivery_phone }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">배송지 주소</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">${delivery.delivery_add }${delivery.delivery_detailadd }</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">결제금액</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5"><fmt:formatNumber value="${payment.total_amount }" pattern="#,###" />원</span></td>
					  		</tr>
					  	</table>
					  </div>
				</div>
			</div>
		</div>
		<br>
		<div class="col text-center">
			<button class="btn btn-primary me-8 bg-success" onclick="location.href='fundingDiscover?category=all&status=all&index=newest'"><span class="text-center text-white fw-bold">프로젝트 목록 페이지로 이동</span></button>
			<button class="btn btn-primary me-8 bg-success" onclick="#"><span class="text-center text-white fw-bold">메인 페이지로 이동</span></button>
		</div>
		<br>
		<hr class="border border-success border border-2">
	</div>
<br>
</body>
</html>