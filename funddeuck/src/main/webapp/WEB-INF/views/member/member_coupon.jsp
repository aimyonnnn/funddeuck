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
	.container h3 {
		margin-top: 40px;
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
			<input type="hidden" name="member_idx" value="${sessionScope.sIdx}" />
			<h5><b>사용가능 쿠폰 등록하기</b></h5>
			<br>
			<p><button type="button" class="btn btn-primary" onclick="showCouponInput()">⊕ 쿠폰 등록하기</button></p>
			<!-- 모달 창 -->
			<div id="couponModal" class="modal fade" tabindex="-1">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title">쿠폰 등록</h5>
			                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			            </div>
			            <div class="modal-body">
			                <input type="text" id="couponNumberInput" class="form-control" placeholder="9자리 쿠폰 번호를 입력하세요" />
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-primary" onclick="registerCoupon()">확인</button>
			                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
			            </div>
			        </div>
			    </div>
			</div>
				<div id="couponInfoDiv"></div>
				<h5><b>${sessionScope.sId}님이 등록한 쿠폰</b></h5>
				<br>
				<table>
				    <tr>
				        <th>쿠폰 이름</th>
				        <th>쿠폰 용도</th>
				        <th>쿠폰 번호</th>
				        <th>쿠폰 할인</th>
				        <th>쿠폰 시작</th>
				        <th>쿠폰 만료</th>
				    </tr>
				    <c:forEach var="coupon" items="${couponList}">
				        <c:if test="${coupon.coupon_use == 0 and coupon.member_idx == sessionScope.sIdx}">
				            <tr>
				                <td>${coupon.coupon_name}</td>
				                <td>${coupon.coupon_text}</td>
				                <td>${coupon.coupon_num}</td>
				                <td>${coupon.coupon_sale}%</td>
				                <td>${coupon.coupon_start}</td>
				                <td>${coupon.coupon_end}</td>
				            </tr>
				        </c:if>
				    </c:forEach>
				</table>

			<br>
			<h5><b>펀딩 쿠폰 이용안내</b></h5>
			<ol>
				<li>쿠폰은 펀딩 서비스 이용 시 사용할 수 있습니다.</li>
				<li>쿠폰은 다른 쿠폰과 중복하여 사용할 수 없습니다.</li>
				<li>쿠폰의 구체적인 사용 조건은 발행되는 쿠폰 별로 다를 수 있습니다.</li>
				<li>프로젝트가 실패하거나 결제 예약 취소를 한 경우, 쿠폰은 반환 됩니다.</li>
			</ol>
		</div>
		<div id="couponHistory" style="display: none;">
			<input type="hidden" name="member_idx" value="${sessionScope.sIdx}" />
				<h5><b>${sessionScope.sId}님이 사용한 쿠폰</b></h5>
				<br>
				<table>
				    <tr>
				        <th>쿠폰 이름</th>
				        <th>쿠폰 용도</th>
				        <th>쿠폰 번호</th>
				        <th>쿠폰 할인</th>
				        <th>쿠폰 시작</th>
				        <th>쿠폰 만료</th>
				    </tr>
				    <c:forEach var="couponUse" items="${usedCoupons}">
				        <c:if test="${couponUse.coupon_use == 1 and couponUse.member_idx == sessionScope.sIdx}">
				            <tr>
				                <td>${couponUse.coupon_name}</td>
				                <td>${couponUse.coupon_text}</td>
				                <td>${couponUse.coupon_num}</td>
				                <td>${couponUse.coupon_sale}%</td>
				                <td>${couponUse.coupon_start}</td>
				                <td>${couponUse.coupon_end}</td>
				            </tr>
				        </c:if>
				    </c:forEach>
				</table>
	        </div>			
				<br>
				<div id="couponHistoryMessage" style="display: none;">
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
	            if (tabId === "#coupon") {
	                $("#couponInfoDiv").show();
	                $("#couponHistoryMessage").hide();
	            } else if (tabId === "#couponHistory") {
	                $("#couponInfoDiv").hide();
	                $("#couponHistoryMessage").show();
	            }
				return false;
			});
		});
	</script>

	<script>
	    function showCouponInput() {
	        $('#couponModal').modal('show');
	    }
	
	    function registerCoupon() {
	        var couponNumber = $('#couponNumberInput').val();
	        $.ajax({
	            type: 'POST',
	            url: '${pageContext.request.contextPath}/member/coupon-info', 
	            data: { couponNumber: couponNumber },
	            success: function (data) {
	                if (data.coupon_use === 1) {
	                    alert('이미 사용된 쿠폰입니다. 등록할 수 없습니다.');
	                    return;
	                }
	                
	                // 기존에 출력된 쿠폰 정보를 지우지 않고 새로운 쿠폰 정보를 추가
	                var couponInfoHtml = '<div class="coupon-info">' +
	                    '<b>쿠폰 이름:</b> ' + data.coupon_name + '<br>' +
	                    '<b>쿠폰 설명:</b> ' + data.coupon_text + '<br>' +
	                    '<b>쿠폰 시작일:</b> ' + data.coupon_start + '<br>' +
	                    '<b>쿠폰 종료일:</b> ' + data.coupon_end + '<br>' +
	                    '<hr>' +
	                    '</div>';
	                $('#couponInfoDiv').append(couponInfoHtml);
	                $('#couponModal').modal('hide');
	            },
	            error: function () {
	                alert('쿠폰 등록에 실패했습니다.');
	                $('#couponModal').modal('hide');
	            }
	        });
	    }
	</script>




<%@ include file="../Footer.jsp" %>

</body>
</html>