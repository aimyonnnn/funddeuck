<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Admin</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
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
        text-align: center;
    }
    
    td {
        padding: 10px;
        text-align: center;
    }
    
    th {
        background-color: #f2f2f2;
        font-weight: bold; 
        text-align: center;
        padding: 10px;
    }
    
    p input {
        margin-bottom: 10px;
    }
    
        /* CSS for the popup */
        .popup {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
        }

        .popup-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
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
                <li class="nav-item">
                    <a class="nav-link" href="#couponBanner">쿠폰 광고</a>
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
						        <c:if test="${coupon.member_idx == 1}"> <!-- 10이 amdin member_idx이기 때문 -->
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
				    <br>
    				<button type="button" class="btn btn-primary" onclick="processExpiredCoupons()">쿠폰 만료 처리</button>
				    <br><br>
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
						        <p style="text-align: center;";>발행된 쿠폰이 없습니다.</p>
						    </c:if>
				    <br>
				  </div>
				<div id="couponBanner">
				    <input type="hidden" name="member_idx" value="${sessionScope.sId}" />
				    <h5><b>쿠폰 광고 팝업 설정</b></h5>
				    <br>
				
				<form id="couponAdForm" enctype="multipart/form-data" method="POST">
				        <div class="mb-3">
				            <label for="coupon_idx" class="form-label">쿠폰 번호 선택:</label>
				            <select class="form-select" id="coupon_idx" name="coupon_idx">
				                <option value="" selected disabled>쿠폰 번호를 선택하세요</option>
				                <!-- 데이터베이스에서 가져온 쿠폰 번호 옵션을 추가 -->
				                <c:forEach var="coupon" items="${couponList}">
				                    <option value="${coupon.coupon_idx}">${coupon.coupon_idx}</option>
				                </c:forEach>
				            </select>
				        </div>
				        <div class="mb-3">
				            <label for="newCoupon_name" class="form-label">쿠폰 광고 제목:</label>
				            <input type="text" class="form-control" id="newCoupon_name" name="newCoupon_name">
				        </div>
				        <div class="mb-3">
				            <label for="newCoupon_start" class="form-label">시작 날짜:</label>
				            <input type="text" class="form-control" id="newCoupon_start" name="newCoupon_start">
				        </div>
				        <div class="mb-3">
				            <label for="newCoupon_end" class="form-label">끝나는 날짜:</label>
				            <input type="text" class="form-control" id="newCoupon_end" name="newCoupon_end">
				        </div>
				        <div class="mb-3">
				            <label for="couponImage" class="form-label">광고 이미지 업로드:</label>
				            <input type="file" class="form-control" id="couponImage" name="file">
				        </div>
							<button type="submit" class="btn btn-primary" id="submitCouponBanner">광고 등록</button>
				    </form>
				    <br>
					<h5><b>등록된 쿠폰 광고 목록</b></h5>
                        <br>
						<table id="couponBannerListTable">
						    <tr>
						        <th>쿠폰 이름</th>
						        <th>광고 시작</th>
						        <th>광고 만료</th>
						        <th>쿠폰 이미지</th>
						    </tr>
						    <c:forEach items="${newCouponList}" var="newcoupon">
						        <tr>
						            <td>${newcoupon.newCoupon_name}</td>
						            <td>${newcoupon.newCoupon_start}</td>
						            <td>${newcoupon.newCoupon_end}</td>
						            <td><img class="mt-5 center" src="${pageContext.request.contextPath}/resources/upload/${newcoupon.newCouponImage}"
									style="width: 80px; height: 80px;" alt="Coupon Image"></td>
						        </tr>
						    </c:forEach>
						</table>

                    </div>
            </div>
	</div>
</div>
    <script>
        // 탭 스크립트
        $(document).ready(function () {
            $("#couponForm").show();
            $("#couponControll").hide();
            $("#couponBanner").hide();


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
                url: '${pageContext.request.contextPath}/saveCoupon',
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
	$(document).ready(function() {
	    $("#coupon_start").datepicker({
	        minDate: 0,
	        dateFormat: "yy-mm-dd"
	    });

	    $("#coupon_end").datepicker({
	        minDate: 0,
	        dateFormat: "yy-mm-dd"
	    });
	});
	</script>
	
	<script>
	    $(document).ready(function () {
	        $("#newCoupon_start").datepicker({
	            minDate: 0,
	            dateFormat: "yy-mm-dd",
	            onSelect: function (selectedDate) {
	                var startDate = new Date(selectedDate);
	                startDate.setDate(startDate.getDate() + 3); // 시작 날짜 + 3일
	                $("#newCoupon_end").datepicker("option", "minDate", startDate);
	                $("#newCoupon_end").datepicker("setDate", startDate);
	            }
	        });
	
	        $("#newCoupon_end").datepicker({
	            minDate: 0,
	            dateFormat: "yy-mm-dd"
	        });
	    });
	</script>

	<script>
    $(document).ready(function () {
        $("#submitCouponBanner").click(function (event) {
        	console.log("체크1");	
            event.preventDefault(); // 기본 동작(페이지 새로고침)을 막습니다.
            
            // 광고 등록 폼 데이터를 FormData 객체에 담습니다.
            var formData = new FormData($("#couponAdForm")[0]);
            console.log("체크2");	
            
            // 서버로 데이터 전송
            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "${pageContext.request.contextPath}/saveCouponBanner",
                data: formData,
                processData: false,
                contentType: false,
                cache: false,
                timeout: 600000,
                success: function (data) {
                    if (data === "success") {
                        // 성공적으로 데이터가 저장되었을 때의 처리
                        alert("광고가 성공적으로 등록되었습니다.");
                        console.log("체크3");	
                        location.reload(); // 페이지 새로고침
                    } else {
                        // 데이터 저장 실패시의 처리
                        console.log("체크4");	
                        alert("광고 등록에 실패했습니다.");
                    }
                },
                error: function (e) {
                	console.log("체크5");	
                    alert("오류가 발생했습니다.");
                    console.log("ERROR : ", e);
                }
            });
        });
    });
</script>


<script type="text/javascript">
    $(document).ready(function() {
        $.ajax({
            url: "${pageContext.request.contextPath}/couponList", // 컨트롤러의 매핑 주소
            type: "GET",
            dataType: "json",
            success: function(data) {
                populateTable(data);
            },
            error: function(xhr, status, error) {
                console.error("Error fetching coupon data: " + error);
            }
        });
    });

    function populateTable(data) {
        var table = $("#couponBannerListTable");

        $.each(data, function(index, newcoupon) {
            var row = $("<tr>");
            row.append($("<td>").text(newcoupon.newCoupon_name));
            row.append($("<td>").text(newcoupon.newCoupon_start));
            row.append($("<td>").text(newcoupon.newCoupon_end));
            
            // 이미지 경로를 수정하여 추가합니다.
            var imagePath = "${pageContext.request.contextPath}/resources/upload/" + newcoupon.newCouponImage;
            var imageElement = $("<img>").attr("src", imagePath).attr("alt", "Coupon Image");
            imageElement.css("width", "80px"); // 가로 크기 설정
            imageElement.css("height", "80px"); // 세로 크기 설정
            row.append($("<td>").append(imageElement));
            
            table.append(row);
        });
    }

</script>

	
	<script>
	var addedCouponNumbers = new Set();
		
	function processExpiredCoupons() {
	    $.ajax({
	        type: 'POST',
	        url: '${pageContext.request.contextPath}/processExpiredCoupons',
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

<!-- datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

</body>
</html>
