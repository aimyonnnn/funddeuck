<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    <!DOCTYPE html>
<html>
<head>
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
			<a class="nav-link " aria-current="page" href="#coupon">나의 쿠폰</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="#couponHistory" id="usedCoupon">지난 쿠폰 내역</a>
		</li>
	</ul>

	<div class="card-body p-4" id="tabContentContainer">
		<div id="coupon">
			<input type="text" name="member_idx" value="${sessionScope.sIdx}" />
			<h5><b>현재 사용가능 쿠폰</b></h5>
			<br>
			<p><a href="#" onclick="showCouponInput()">⊕ 쿠폰 등록하기</a></p>
			<div id="couponInfoDiv"></div>

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
			<input type="hidden" name="member_idx" value="${sessionScope.sIdx}" />
	        <h5><b>사용 쿠폰 이용내역</b></h5>
	        <br>
	        <div id="couponUseDiv">
	            <c:forEach var="couponData" items="${usedCoupons}">
	                <c:if test="${couponData.coupon_use == true}">
	                    <p><b>사용 쿠폰 이름:</b> ${couponData.coupon_name}</p>
	                    <p><b>사용 쿠폰 설명:</b> ${couponData.coupon_text}</p>
	                    <p><b>사용 쿠폰 시작일:</b> ${couponData.coupon_start}</p>
	                    <p><b>사용 쿠폰 종료일:</b> ${couponData.coupon_end}</p>
	                    <hr>
	                </c:if>
	            </c:forEach>
	        </div>			
				<br>
				<h5><b>지난 쿠폰 내역 안내</b></h5>
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
	var coupons = {};
	
	// 기존 쿠폰 정보를 세션 스토리지에 저장
	function saveCouponsToSessionStorage() {
	    sessionStorage.setItem("coupons", JSON.stringify(coupons));
	}
	
	// 쿠폰 정보를 보여주는 함수
	function displayCouponInfo(coupons) {
	    var couponInfoDiv = document.getElementById("couponInfoDiv");
	    var couponHtml = "<h5><b>쿠폰 정보</b></h5>";
	
	    for (var couponNumber in coupons) {
	        if (coupons.hasOwnProperty(couponNumber)) {
	            var couponData = coupons[couponNumber];
	            couponHtml += "<p><b>쿠폰 이름:</b> " + (couponData.coupon_name || '') + "</p>";
	            couponHtml += "<p><b>쿠폰 설명:</b> " + (couponData.coupon_text || '') + "</p>";
	            couponHtml += "<p><b>쿠폰 시작일:</b> " + (couponData.coupon_start || '') + "</p>";
	            couponHtml += "<p><b>쿠폰 종료일:</b> " + (couponData.coupon_end || '') + "</p>";
	            couponHtml += "<hr> ";
	        }
	    }
	
	    couponInfoDiv.innerHTML = couponHtml;
	}
	
	document.addEventListener("DOMContentLoaded", function () {
	    var storedCoupons = sessionStorage.getItem("coupons");
	    if (storedCoupons) {
	        coupons = JSON.parse(storedCoupons);
	        displayCouponInfo(coupons);
	    }
	});

    function showCouponInput() {
        var couponInput = prompt("쿠폰 번호를 입력하세요:");
        if (couponInput) {
            console.log("Coupon Number:", couponInput);

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/member/coupon-info",
                data: {coupon_num: couponInput},
                success: function (couponData) {
                    console.log("Coupon Data:", couponData);
                    if (couponData.length > 0) {
                        // 기존의 쿠폰 정보를 유지한 채로 새로운 쿠폰 정보를 추가합니다.
                        for (var i = 0; i < couponData.length; i++) {
                            coupons[couponInput + i] = couponData[i];
                        }

                        saveCouponsToSessionStorage();
                        displayCouponInfo(coupons);
                    } else {
                        alert("존재하지 않거나 사용할 수 없는 쿠폰입니다!");
                    }
                },
                error: function (xhr, status, error) {
                    console.error(xhr.responseText);
                    alert("쿠폰 정보를 가져오는 동안 오류가 발생했습니다.");
                }
            });
        }
    }
</script>

<%@ include file="../Footer.jsp" %>

</body>
</html>