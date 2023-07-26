<%@ page session="false" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Coupon</title>
    <%@ include file="../Header.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../resources/css/mypage.css" />	
</head>
<style>
	.container h3{
	  margin-top: 40px;
</style>
<body>
<section style="background-color: #f4f5f7;">
	<div class="container">
	    <div style="height: 50px;"></div>
		  <h3><b>쿠폰</b></h3>
			<ul class="nav nav-tabs">
		<li class="nav-item">
			<a class="nav-link active" aria-current="page" href="#coupon">나의 쿠폰</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="#couponHistory">지난 쿠폰 내역</a>
		</li>
	</ul>

	<div class="card-body p-4" id="tabContentContainer">
		<div id="coupon">
			<h5><b>현재 사용가능 쿠폰</b></h5>
			<br>
<p><a href="#" onclick="showCouponInput()">⊕ 쿠폰 등록하기</a></p>

			<br>
			<h5><b>펀딩 쿠폰 이용안내</b></h5>
			<ol>
				<li>쿠폰은 펀딩 서비스 이용 시 사용할 수 있습니다.</li>
				<li>쿠폰은 다른 쿠폰과 중복하여 사용할 수 없습니다.</li>
				<li>쿠폰의 구체적인 사용 조건은 발행되는 쿠폰 별로 다를 수 있습니다.</li>
				<li>프로젝트가 실패하거나 결제 예약 취소를 한 경우, 쿠폰은 반환 됩니다.</li>
			</ol>
		</div>
		<div id="couponHistory">
			<h5><b>쿠폰 사용 내역</b></h5>
			<br>
			<h5><b>지난 쿠폰 내역 아내</b></h5>
			<ol>
				<li>3개월 이내에 사용했거나 만료된 쿠폰에 한하여 노출됩니다.</li>
				<li>프로젝트가 실패하거나 결제취소를 한 경우, 쿠폰은 반환됩니다.</li>
				<li>결제 실패일 경우, 쿠폰이 반환되지 않고 소멸됩니다.</li>
			</ol>
		</div>
	</div>

	</div>
</section>

	<script>
		// 탭 스크립트
		$(document).ready(function(){
			$("#coupon").show();
			$("#couponHistory").hide();

			$(".nav-link").click(function(){
				var tabId = $(this).attr("href");
				$(".card-body > div").hide();
				$(tabId).show();

				return false;
			});
		});
	</script>
<script>	
function showCouponInput() {
    var couponInput = prompt("쿠폰 번호를 입력하세요:");
    if (couponInput) {
      console.log("Coupon Number:", couponInput);
      var xhr = new XMLHttpRequest();
      xhr.open("GET", "/member/coupon?coupon_num=" + encodeURIComponent(couponInput), true);
      xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
          var couponData = JSON.parse(xhr.responseText);
          console.log("Coupon Data:", couponData);
          if (couponData) {
          } else {
            alert("Coupon not found!");
          }
        }
      };
    }
  }
</script>

	
<%@ include file="../Footer.jsp" %>

</body>
</html>