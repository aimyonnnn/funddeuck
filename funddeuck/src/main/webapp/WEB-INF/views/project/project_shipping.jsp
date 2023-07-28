<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="stylesheet" type="text/css">
	<script>
	// 서포터 관리
	$(document).ready(function() {
		$("#project-btn").siblings(".dropdown-menu").find("a").click(function(event) {
			// 드롭다운 버튼 클릭 시 텍스트 활성화 
		    var selectedText = $(this).text();
		    $('#project-btn').text(selectedText);
			
			// 클릭한 dropdown의 id 값을 가져옴
			var project_idx = $(this).data("id");
			
			// 배송 및 환불 카운트 - Ajax 요청
			$.ajax({
				url: "shippingStatus",
				method: "POST",
				data: {project_idx: project_idx},
				dataType: "json",
				success: function(data) {
					var deliveryStatus = data.deliveryStatus; // 배송 상황
					var refundStatus = data.refundStatus; // 환불 승인 여부
					
					
					for (var i = 0; i < deliveryStatus.length; i++) {
					      var status = deliveryStatus[i].delivery_status;
					      var count = deliveryStatus[i].count;

					      if (status == 1) {
					        $(".table .text-primary:eq(0)").next().text(count);
					      } else if (status == 2) {
					        $(".table .tableTag:eq(1)").next().text(count);
					      } else if (status == 3) {
					        $(".table .tableTag:eq(2)").next().text(count);
					      }
					    }

					    // 컨트롤러에서 조회된 결제승인여부 데이터 처리
					    for (var i = 0; i < refundStatus.length; i++) {
					      var status = refundStatus[i].payment_confirm;
					      var count = refundStatus[i].count;

					      if (status == 2) {
					        $(".table .text-primary:eq(1)").next().text(count);
					      } else if (status == 3) {
					        $(".table .tableTag:eq(4)").next().text(count);
					      } else if (status == 4) {
					        $(".table .tableTag:eq(5)").next().text(count);
					      }
					    }
			    },
				error: function() {
					// Ajax 요청에 실패한 경우 처리
					alert("요청에 오류가 발생했습니다.");
				}
			});
			// 링크 클릭 시 발생하는 페이지 이동 차단
	        event.preventDefault();
		});
		
		// 목록 - Ajax 요청
		$('.shipping-filter-item').on('click', function(event) {
			event.preventDefault(); // 이벤트 방지 
			
			// 드롭다운 버튼 클릭 시 텍스트 활성화 
		    var selectedDrop = $(this).text();
		    $('#list-btn').text(selectedDrop);
		    
		    var project_idx = $("#project-btn").siblings(".dropdown-menu").find("a").data('id'); // 프로젝트 번호
		    var filter = $(this).data('filter'); // 배송 상태
		    var type = $(this).data('type'); // 환불 상태
		    console.log(project_idx);
		    console.log(filter);
		    console.log(type);
		    
		    $.ajax({
		    	url: "shippingList",
		    	method: "POST",
		    	data: {
		    		project_idx: project_idx,
		    		filter: filter,
		    		type: type
		    	},
		    	dataType: "json",
		    	success: function(data) {
		    		
		    	},
		    	error: function() {
		    		
		    	}
		    	
		    });
		});
	});
	
	</script>
</head>
<body>
	<!-- include -->
 	<jsp:include page="../common/project_top.jsp"/>

	<main id="main">
		<div class="containerCSS">
      
	      	<!-- 왼쪽 네비게이션 시작 -->
			<aside id="aisdeLeft">
			    <div id="projectManagement">
					<img src="${pageContext.request.contextPath}/resources/images/managementImage.jpg" width="200px" height="150px">
			    	${sessionScope.sId}님의 프로젝트
			    </div>
			    <ul id="navMenu">
			        <li>
			            <a href="#" class="toggleTab">
			                &nbsp;&nbsp;&nbsp;프로젝트 관리
			                <i class="fas fa-caret-down"></i>
			            </a>
			            <ul class="subMenu">
			                <li><a href="projectMaker">메이커 정보</a></li>
			                <li><a href="projectManagement" id="active-tab">프로젝트 등록</a></li>
			                <li><a href="projectReward">리워드 설계</a></li>
			            </ul>
			        </li>
			        <li><a href="projectStatus">프로젝트 현황</a></li>
			        <li><a href="projectShipping" id="active-tab">발송·환불 관리</a></li>
			        <li><a href="projectSettlement">수수료·정산 관리</a></li>
			    </ul>
			</aside>
	
			<!-- 중앙 섹션 시작 -->
			<section id="section">
		      	<article id="article">
		      	
			      	<!-- 발송·환불 관리 시작 -->
					<div class="projectArea">
						<div class="shippingManagementTitle">
							<div>발송·환불 관리</div>
						    <!-- 프로젝트 선택 -->
						    <div class="dropdown ms-4">
						        <button type="button" class="btn dropdown-toggle btn-sm" id="project-btn" data-bs-toggle="dropdown" aria-expanded="false">
						            프로젝트 선택
						        </button>
						        <ul class="dropdown-menu" aria-labelledby="project-btn">
							        <c:forEach var="projectList" items="${projectList }">
							            <li>
							            	<a class="dropdown-item" href="#" data-id="${projectList.project_idx}">${projectList.project_subject }</a>
							            </li>
							        </c:forEach>
						        </ul>
						    </div>
						</div>
						<div class="projectContent">펀딩 리워드의 발송 및 펀딩금 반환까지 한눈에 볼 수 있어요.</div>
						<!-- 서포터 관리 -->
						<div>
							<p class="subheading">서포터 관리</p>
							<div class="table-responsive">
							    <table class="table table-bordered">
									<tr>
										<th>발송·배송 상태</th>
										<td>
											<span class="tableTag text-primary">미발송</span>
											<span class="customSpan"></span>건
										</td>
										<td>
											<span class="tableTag">배송중</span>
											<span class="customSpan"></span>건
										</td>
										<td>
											<span class="tableTag">배송완료</span>
											<span class="customSpan"></span>건
										</td>
									</tr>
									<tr>
										<th>펀딩금 반환 상태</th>
										<td>
											<span class="tableTag text-primary">신청</span>
											<span class="customSpan"></span>건
										</td>
										<td>
											<span class="tableTag">완료</span>
											<span class="customSpan"></span>건
										</td>
										<td colspan="2">
											<span class="tableTag">거절</span>
											<span class="customSpan"></span>건
										</td>
									</tr>
							    </table>
							</div>
							<p class="tableDescription">
								· 리워드 발송이 완료되면 발송정보 입력을 통해 발송처리를 진행하세요.<br>
								· 상태별 건수는 발송번호 기준으로 계산됩니다.
							</p>
						</div>
						<!-- 서포터 관리 끝 -->

						<!-- 목록 -->
						<div>
							<div class="shippingSubheading">목록 <span class="sideDescription text-primary">| 총 829명</span>
								<div class="dropdown">
									<button type="button" class="btn dropdown-toggle btn-sm" id="list-btn" data-bs-toggle="dropdown" aria-expanded="false">
										발송·배송 전체 관리
									</button>
									<ul class="dropdown-menu" aria-labelledby="list-btn">
										<li><a class="dropdown-item shipping-filter-item" href="#" data-filter="1">미발송</a></li>
										<li><a class="dropdown-item shipping-filter-item" href="#" data-filter="2" href="#">배송중</a></li>
										<li><a class="dropdown-item shipping-filter-item" href="#" data-filter="3">배송 완료</a></li>
										<li><hr class="dropdown-divider"></li>
										<li><a class="dropdown-item shipping-filter-item" href="#" data-type="2">펀딩금 반환 신청</a></li>
										<li><a class="dropdown-item shipping-filter-item" href="#" data-type="3">펀딩금 반환 신청 완료</a></li>
										<li><a class="dropdown-item shipping-filter-item" href="#" data-type="4">펀딩금 반환 신청 거절</a></li>
									</ul>
								</div>
							</div>
							<div class="table-responsive">
							    <table class="table">
									<thead class="table-light text-center">
										<tr>
											<th scope="col">펀딩번호</th>
											<th scope="col">서포터 정보</th>
											<th scope="col">결제</th>
											<th scope="col">금액</th>
											<th scope="col">리워드</th>
											<th scope="col">발송정보</th>
											<th scope="col">발송예정일</th>
											<th scope="col">발송·배송</th>
											<th scope="col">발송번호</th>
											<th scope="col">펀딩금 반환</th>
										</tr>
									</thead>
									<tbody class="text-center">
										<tr>
											<td>1111</td>
											<td>
												진국이<br>
												test@test.com<br>
												010-1234-5678
											</td>
											<td>완료 01-01</td>
											<td>25,000원</td>
											<td>
												[패키지A] 5월초 제철 귤 '귤로향' 1 SET (배송비포함) x 1개
											</td>
											<td>
												<button class="btn btn-outline-primary" id="tableButton" data-bs-toggle="modal" data-bs-target="#trackingModal">입력</button>
											</td>
											<td>2023-08 초</td>
											<td>미발송</td>
											<td>1111-111</td>
											<td>
												<button class="btn btn-outline-primary" id="tableButton" data-bs-toggle="modal" data-bs-target="#refundModal">신청</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- 목록 끝-->
				</article>
			</section>
			<!-- 중앙 섹션 끝 -->
		</div>
	</main>
	
	<!-- 발송번호 입력 모달창 -->
	<div class="modal fade" id="trackingModal" tabindex="-1" aria-labelledby="trackingModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
	    		<div class="modal-header">
	    			<h1 class="modal-title fs-5" id="trackingModalLabel">발송정보</h1>
	    			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div>
						<p class="fw-bold fs-5">[100개 한정] 오픈런(1달 플랜+보틀 증정)</p>
					  	<p>·주문수량: 1개</p>
					  	<p>·금액: 50,000원</p>
					</div>
					<form action="#" method="post">
						<div>
							<p class="modalTitle">발송방법</p>
							<select class="form-control" name="delivery_method">
								<option value="">선택</option>
								<option value="courier">택배</option>
								<option value="digitalDelivery">디지털 전송</option>
								<option value="post">우편</option>
								<option value="donation">후원</option>
							</select>
						</div>
						<div>
							<p class="modalTitle">택배사</p>
							<select class="form-control" name="courier">
								<option value="">선택</option>
								<option value="cjLogistics">CJ대한통운</option>
								<option value="koreaPost">우체국택배</option>
						        <option value="hanjin">한진택배</option>
						        <option value="lotte">롯데택배</option>
						        <option value="logen">로젠택배</option>
						        <option value="ilyang">일양로지스</option>
							</select>
						</div>
						<div>
							<label class="modalTitle" for="waybillNum">송장번호</label>
							<input class="form-control" type="text" name="waybill_num" id="waybillNum" placeholder="송장번호를 입력해 주세요">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary">완료</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 발송번호 입력 모달창 끝 -->
	
	<!-- 펀딩금 반환 모달창 -->
	<div class="modal fade" id="refundModal" tabindex="-1" aria-labelledby="refundModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="refundModalLabel">펀딩금 반환 처리</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>서포터가 펀딩금 반환을 요청한 내역을 확인하고 승인 또는 거절 처리하세요.</p>
					<div>
						<p>
							<span class="fw-bold">펀딩번호: </span>1111
						</p>
						<p>
							<span class="fw-bold">서포터명: </span>진국이
						</p>
					</div>
					<div>
						<p class="modalTitle">[100개 한정] 오픈런(1달 플랜+보틀 증정)</p>
					  	<p>·주문수량: 3개</p>
					  	<p>·금액: 150,000원</p>
					</div>
					<div>
						<p class="modalTitle">펀딩금 반환 신청 사유</p>
					  	<p>
					  		<span class="fw-bold">사유</span><br>
					  		기능·성능 상 치명적인 초기 결함
					  	</p>
					  	<p>
					  		<span class="fw-bold">증빙 서류</span><br>
					  		<a href="#">미작동 이미지.jpg</a>
					  	</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">반환 신청</button>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 펀딩금 반환 모달창 끝 -->
	
	<script>
	$(document).ready(function () {
        // 탭 1을 기본으로 활성화
        $("#tab1").addClass("active");
        $(".tab-button[data-tab='tab1']").addClass("active"); // 기본 탭 버튼에도 active 클래스 추가

        $(".tab-button").click(function (e) {
            e.preventDefault(); // form 태그와의 충돌 방지
            var tabId = $(this).data("tab");
            $(".content-area").removeClass("active");
            $("#" + tabId).addClass("active");

            // 탭 버튼에도 active 클래스 추가 (활성화된 탭 표시)
            $(".tab-button").removeClass("active");
            $(this).addClass("active");
        });
    });
	</script>

	
	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>