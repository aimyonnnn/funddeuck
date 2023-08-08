<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin</title>
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
        display: table-row;
    }
    
    table {
        border-collapse: collapse;
        width: 100%;
    }
    
    th, td {
        padding: 10px;
        text-align: center;
    }
    
    th {
        background-color: #f2f2f2;
        font-weight: bold; 
    }
    
    p input {
        margin-bottom: 10px;
    }
</style>
<body>

	<!-- sidebar -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<!-- top -->
<div class="main-content">
<jsp:include page="../common/admin_top.jsp"/>
	<div class="container my-5">
            <h2><b>쿠폰 관리</b></h2>
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
                                쿠폰 번호 : <button type="button" class="btn btn-primary" onclick="generateCouponNumber()">번호 생성</button><span id="couponNumber"></span><br>
                                쿠폰 할인 : <input type="text" name="coupon_sale" placeholder="할인률을 입력하세요." style="width: 300px"> %<br>
                                쿠폰 시작 : <input type="text" name="coupon_start" id="coupon_start" placeholder="시작 날짜를 선택하세요." style="width: 300px"><br>
                                쿠폰 만료 : <input type="text" name="coupon_end" id="coupon_end" placeholder="만료 날짜를 선택하세요." style="width: 300px">
                            </p>
                    		<input type="hidden" name="member_idx" value="${sessionScope.sIdx}" />
							<button type="button" class="btn btn-primary" onclick="registerCoupon()">새로운 쿠폰 발행</button>
                        </form>
                        <br>
                        <h5><b>등록된 쿠폰 목록</b></h5>
                        <br>
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
						        <c:if test="${coupon.member_idx == 10}"> <!-- 10이 amdin member_idx이기 때문 -->
						            <tr>
						                <td>${coupon.coupon_name}</td>
						                <td>${coupon.coupon_text}</td>
						                <td>${coupon.coupon_num}</td>
						                <td style="background-color: yellow; font-weight: bold;">${coupon.coupon_sale}%</td>
						                <td>${coupon.coupon_start}</td>
						                <td>${coupon.coupon_end}</td>
						            </tr>
						         </c:if>   
						    </c:forEach>
						</table>

                    </div>
                    <br>
                </div>
                <div id="couponControll">
					<input type="hidden" name="member_idx" value="${sessionScope.sId}" />
				    <h5><b>사용 기간 만료된 쿠폰목록</b></h5>
    				<button type="button" class="btn btn-primary" onclick="processExpiredCoupons()">쿠폰 만료 처리</button>
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
						        <c:if test="${coupon.member_idx == 10}"> 
						        <tr class="coupon-row">
						            <td>${coupon.coupon_name}</td>
						            <td>${coupon.coupon_text}</td>
						            <td>${coupon.coupon_num}</td>
									<td>${coupon.coupon_sale}%</td>
						            <td>${coupon.coupon_start}</td>
						            <td style="background-color: yellow; font-weight: bold;">${coupon.coupon_end}</td>
						        </tr>
						        </c:if>
						    </c:forEach>
						</table>
						    <!-- 쿠폰 목록이 없을 때 메시지 출력 -->
						    <c:if test="${empty couponList}">
						        <p>발행된 쿠폰이 없습니다.</p>
						    </c:if>
				</div>
            </div>
</div>
</div>
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
            var couponIdx = $('input[name="member_idx"]').val();
            var couponName = $('input[name="coupon_name"]').val();
            var couponText = $('input[name="coupon_text"]').val();
            var couponNum = parseInt($("#couponNumber").text());
            var couponSale = parseInt($('input[name="coupon_sale"]').val());
            var couponStart = $('input[name="coupon_start"]').val();
            var couponEnd = $('input[name="coupon_end"]').val();

            var couponData = {
            	member_idx: couponIdx,
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
	var addedCouponNumbers = new Set();
	
	function processExpiredCoupons() {
	    $.ajax({
	        type: 'POST',
	        url: '${pageContext.request.contextPath}/admin/processExpiredCoupons',
	        success: function (data) {
	            if (data.length === 0) {
	                alert("더이상 만료 처리할 쿠폰이 없습니다.");
	            } else {
	                var tableBody = $("#expiredCouponListTable tbody");
	                var hasAddedRows = false; 
	                $(".coupon-row").hide();
	
	                $.each(data, function (index, coupon) {
	                    if (coupon.coupon_use === 1 && !addedCouponNumbers.has(coupon.coupon_num)) {
	                        var newRow = '<tr class="coupon-row">' +
	                            '<td>' + coupon.coupon_name + '</td>' +
	                            '<td>' + coupon.coupon_text + '</td>' +
	                            '<td>' + coupon.coupon_num + '</td>' +
	                            '<td>' + coupon.coupon_sale + '%</td>' +
	                            '<td>' + coupon.coupon_start + '</td>' +
	                            '<td style="background-color: yellow; font-weight: bold;">' + coupon.coupon_end + '</td>' +
	                            '</tr>';
	                        tableBody.append(newRow);
	
	                        addedCouponNumbers.add(coupon.coupon_num);
	                        hasAddedRows = true;
	                    }
	                });
	
	                if (!hasAddedRows) {
	                    tableBody.append('<tr><td colspan="6">처리할 쿠폰이 없습니다.</td></tr>');
	                }
	
	                alert("만료된 쿠폰을 처리했습니다.");
	            }
	        },
	        error: function (error) {
	            console.error(error);
	            alert('쿠폰 처리 실패: ' + error.message);
	        }
	    });
	}
	</script>



</body>
</html>
