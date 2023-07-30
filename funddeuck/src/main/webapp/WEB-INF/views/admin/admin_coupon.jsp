<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin_Coupon</title>
	<%@ include file="../Header.jsp" %>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" type="text/css" href="../resources/css/mypage.css" />
</head>
<style>
    .container h3 {
        margin-top: 40px;
    }
     /* 만료된 쿠폰 행만 표시하기 */
    .coupon-row {
        display: none;
    }

    /* 만료되지 않은 쿠폰 행만 표시하기 */
    .expired-coupon {
        display: table-row;
    }
</style>
<body>
    <section style="background-color: #f4f5f7;">
        <div class="container">
            <div style="height: 50px;"></div>
            <h3><b>쿠폰 관리</b></h3>
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link " aria-current="page" href="#couponForm">쿠폰 등록</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#couponControll">만료된 쿠폰</a>
                </li>
            </ul>

            <div class="card-body p-4" id="tabContentContainer">
                <div id="couponForm">
                    <h5><b>쿠폰 등록하기</b></h5>
                    <br>
                    <div class="container">
                        <form method="post">
                            <p>
                                쿠폰 이름 : <input type="text" name="coupon_name" placeholder="쿠폰 이름을 입력하세요." style="width: 300px"><br>
                                쿠폰 용도 : <input type="text" name="coupon_text" placeholder="쿠폰 용도를 입력하세요." style="width: 300px"><br>
                                쿠폰 번호 : <button type="button" onclick="generateCouponNumber()">번호 생성</button><span id="couponNumber"></span><br>
                                쿠폰 할인 : <input type="text" name="coupon_sale" placeholder="할인률을 입력하세요." style="width: 300px"> %<br>
                                쿠폰 시작 : <input type="text" name="coupon_start" id="coupon_start" placeholder="시작 날짜를 선택하세요." style="width: 300px"><br>
                                쿠폰 만료 : <input type="text" name="coupon_end" id="coupon_end" placeholder="만료 날짜를 선택하세요." style="width: 300px">
                            </p>
                            <button type="button" onclick="registerCoupon()">등록</button>
                        </form>
                        <br>
                        <h5><b>등록된 쿠폰 목록</b></h5>
						<table id="couponListTable">
						    <tr>
						        <th>쿠폰 이름</th>
						        <th>쿠폰 용도</th>
						        <th>쿠폰 번호</th>
						        <th>쿠폰 할인</th>
						        <th>쿠폰 시작</th>
						        <th>쿠폰 만료</th>
						    </tr>
						    <c:forEach items="${couponList}" var="coupon">
						        <tr>
						            <td>${coupon.coupon_name}</td>
						            <td>${coupon.coupon_text}</td>
						            <td>${coupon.coupon_num}</td>
									<td style="background-color: yellow; font-weight: bold;">${coupon.coupon_sale}%</td>
						            <td>${coupon.coupon_start}</td>
						            <td>${coupon.coupon_end}</td>
						        </tr>
						    </c:forEach>
						</table>
                    </div>
                    <br>
                </div>
                <div id="couponControll">
				    <h5><b>사용 기간 만료된 쿠폰목록</b></h5>
				    <br>
				    <table id="expiredCouponListTable">
				            <tr class="expired-coupon">
						        <th>쿠폰 이름</th>
						        <th>쿠폰 용도</th>
						        <th>쿠폰 번호</th>
						        <th>쿠폰 할인</th>
						        <th>쿠폰 시작</th>
						        <th>쿠폰 만료</th>
						    </tr>
						    <c:forEach items="${couponList}" var="coupon">
						        <tr class="coupon-row">
						            <td>${coupon.coupon_name}</td>
						            <td>${coupon.coupon_text}</td>
						            <td>${coupon.coupon_num}</td>
									<td>${coupon.coupon_sale}%</td>
						            <td>${coupon.coupon_start}</td>
						            <td>${coupon.coupon_end}</td>
						        </tr>
						    </c:forEach>
						</table>
				</div>
            </div>
        </div>
    </section>

    <script>
        // 탭 스크립트
        $(document).ready(function () {
            $("#couponForm").show();
            $("#couponControll").hide();

            $(".nav-link").click(function () {
                var tabId = $(this).attr("href");
                $(".card-body > div").hide();
                $(tabId).show();

                return false;
            });
        });

        var usedCouponNumbers = new Set();

        function generateCouponNumber() {
            var couponNumberElement = document.getElementById("couponNumber");
            var randomNumber;

            do {
                randomNumber = Math.floor(Math.random() * 900000000) + 100000000;
            } while (usedCouponNumbers.has(randomNumber));

            usedCouponNumbers.add(randomNumber);
            couponNumberElement.innerHTML = randomNumber;
        }

        function registerCoupon() {
            // 쿠폰 정보 수집
            var couponName = $('input[name="coupon_name"]').val();
            var couponText = $('input[name="coupon_text"]').val();
            var couponNum = parseInt($("#couponNumber").text());
            var couponSale = parseInt($('input[name="coupon_sale"]').val());
            var couponStart = $('input[name="coupon_start"]').val();
            var couponEnd = $('input[name="coupon_end"]').val();

            var couponData = {
                coupon_name: couponName,
                coupon_text: couponText,
                coupon_num: couponNum,
                coupon_sale: couponSale,
                coupon_start: couponStart,
                coupon_end: couponEnd
            };

            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/admin/saveCoupon',
                contentType: 'application/json',
                data: JSON.stringify(couponData),
                success: function (data) {
                    alert("등록 성공했습니다.");
                    // 쿠폰 등록 성공 시, 쿠폰 목록을 갱신하는 함수 호출
                    reloadCouponList();
                },
                error: function (error) {
                    console.error(error);
                    alert('등록 실패 : ' + error.message);
                }
            });
        }

    </script>

	<script>
    // DatePicker 설정
    $(document).ready(function () {
        $("#coupon_start").datepicker({
            minDate: 0, // 오늘 이후의 날짜만 선택 가능하도록 설정
            dateFormat: "yy-mm-dd" 
        });

        $("#coupon_end").datepicker({
            minDate: 0, // 오늘 이후의 날짜만 선택 가능하도록 설정
            dateFormat: "yy-mm-dd" 
        });
    });
	</script>
	<script>
	    $(document).ready(function() {
	        // 주어진 날짜가 지난 날짜인지 확인하는 함수
	        function isDateInPast(dateStr) {
	            var currentDate = new Date();
	            var couponDate = new Date(dateStr);
	            return couponDate < currentDate;
	        }
	
	        // 만료된 쿠폰을 필터링하고 표시하는 함수
	        function showExpiredCoupons() {
	            $(".coupon-row").each(function() {
	                var couponEndDate = $(this).find("td:last-child").text(); // 해당 행의 마지막 <td> 요소 값을 가져옴 ('coupon_end' 날짜)
	                if (isDateInPast(couponEndDate)) {
	                    $(this).addClass("expired-coupon");
	                } else {
	                    $(this).removeClass("expired-coupon");
	                }
	            });
	        }
	
	        // 페이지 로드 시 만료된 쿠폰을 표시합니다.
	        showExpiredCoupons();
	    });
	</script>


    <%@ include file="../Footer.jsp" %>
</body>
</html>
