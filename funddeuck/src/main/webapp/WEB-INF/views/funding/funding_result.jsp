<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
					<img src="https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355" class="d-block w-25 float-start" alt="...">
					  <div class="col-md-6 row-gap-10">
					  	<table class="text-start">
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주문번호</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">123456789</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">주문자</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">홍길동</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">수취인</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">홍길동</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">수취인 연락처</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">010-1234-5678</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">배송지 주소</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">부산광역시 부산진구 동천로 109 삼한골든게이트 7층</span></td>
					  		</tr>
					  		<tr>
					  			<th><span class="fs-5 fw-bold">결제금액</span></th>
					  			<td>&nbsp;&nbsp;</td>
					  			<td><span class="fs-5">30,000원</span></td>
					  		</tr>
					  	</table>
					  </div>
				</div>
			</div>
		</div>
		<br>
		<div class="col text-center">
			<button class="btn btn-primary me-8 bg-success" onclick="javascript:history.back()"><span class="text-center text-white fw-bold">뒤로가기</span></button>
			<button class="btn btn-primary me-8 bg-success" onclick="#"><span class="text-center text-white fw-bold">메인 페이지로 이동</span></button>
		</div>
		<br>
		<hr class="border border-success border border-2">
	</div>
<br>
<!-- footer include -->
<jsp:include page="../Footer.jsp"></jsp:include>
</body>
</html>