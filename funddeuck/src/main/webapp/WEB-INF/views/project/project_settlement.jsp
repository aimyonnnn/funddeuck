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
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
	<script>
	$(document).ready(function(){
		// 팝오버 활성화
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
          return new bootstrap.Popover(popoverTriggerEl)
        });
		
		// 정산내역서 - 모달
		$(document).on("click", "button[data-bs-target='#settlementModal']", function(event){
			var project_idx = $(this).data("project-idx");
			
			$.ajax({
				url: "settlementList",
				method: "GET",
				data: {project_idx: project_idx},
				dataType: "json",
				success: function(data) {
					var data = data[0];
					
					// 카드 결제의 수수료(카드 리워드 금액 + 후원금 + 배송비) * 0.03)
					var card_tax = (data.card_total_reward_amount + data.card_total_additional_amount + data.card_total_delivery_amount) * 0.03;
					// 결제 완료 금액 (현재 총 결제 금액 - 환불금액(이미 포함x) + 후원금 + 카드 결제의 수수료)
					var total_amount = Math.floor(data.total_amount + data.total_additional_amount + card_tax);
					// 배송비 (총 리워드 배송비 - 총 카드로 결제한 리워드 배송비)
					var delivery_amount = Math.floor(data.total_delivery_amount - (data.card_total_delivery_amount) * 0.03);
					// 요금제 수수료 1-기본요금제(5%), 2-인플루언서요금제(3%)
					var project_plan = data.project_plan === 1 ? 0.05 : 0.03;
					// 세금계산서 발행금액 (총 금액(이미 카드 수수료 포함o) * 선택한 요금제 수수료)
					var tax_amount = Math.floor(data.total_amount * project_plan + card_tax);
					// 총 지급 금액(결제 완료 금액 - 1차 정산금액 - 세금계산서 발행금액)
					var final_amount = total_amount - data.first_amount - tax_amount;
					// 요금제 수수료 출력용
					var charge = data.project_plan === 1 ? 5 : 3;
					
					
					$('#project_subject').text(data.project_subject);						// 프로젝트 제목
					$('#representative_name').text(data.project_representative_name);		// 대표자명
					$('#representative_email').text(data.project_representative_email);		// 이메일
					$('#settlement_bank').text(data.project_settlement_bank);				// 정산 받을 은행
					$('#settlement_account').text(data.project_settlement_account);			// 정산 받을 계좌
					$('#settlement_name').text(data.project_settlement_name);				// 예금주명
					$('#final_amount').text(final_amount.toLocaleString() + '원');			// 총 지급 금액
					$('#total_amount').text(total_amount.toLocaleString() + '원');			// 결제 완료 금액 
					$('#delivery_amount').text(delivery_amount.toLocaleString() + '원');	// 배송비 
					$('#tax_amount').text(tax_amount.toLocaleString() + '원');				// 세금
					$('#charge').text('(' + charge + '%)')									// 수수료 
					
					
					var buttonText = ""; // 버튼 텍스트를 초기화합니다.
					
					if(data.project_status == 3) { 			// 프로젝트 진행완료 (1차 정산 가능일 때)
						if(data.maker_grade == 1) { 		// 메이커 등급이 1레벨일 시
							final_amount *= 0.5; 			// 50%만 1차 정산
							$('#final_amount').text(final_amount.toLocaleString() + '원');
						} else if(data.maker_grade == 2) {	// 메이커 등급이 2레벨일 시
							final_amount *= 0.7;			// 70%만 1차 정산
							$('#final_amount').text(final_amount.toLocaleString() + '원');
						}
						buttonText = "1차 정산";
					} else if(data.project_status == 4) {	// 프로젝트 1차 정산완료 (최종 정산 불가능일 때)
						buttonText = "정산 대기중";		
					} else if(data.project_status == 5) {	// 프로젝트 최종 정산 가능일 때
						buttonText = "최종 정산";
					}
					$('.btn-danger').text(buttonText);
					
					$('.btn-danger').off('click').on('click', function(event) {
				        if (data.project_status == 4) { // 프로젝트 상태가 4일 때
				        	event.preventDefault(); // 제출 불가
				            alert("아직 환불 기간이므로 정산을 할 수 없습니다!");
				    	}
					});
					
					$('#fintech_use_num').val(data.project_fintech_use_num);				// 핀테크이용번호
					$('#final_settlement').val(final_amount);								// 총 지급 금액 전달
					$('#project_idx').val(project_idx);										// 프로젝트 고유번호
					
				},
				error: function() {
					alert("정산 내역 요청에 오류가 발생했습니다!");
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
			        <li><a href="projectShipping">발송·환불 관리</a></li>
			        <li><a href="projectSettlement" id="active-tab">수수료·정산 관리</a></li>
			    </ul>
			</aside>
	
			<!-- 중앙 섹션 시작 -->
			<section id="section">
		      	<article id="article">
			      	<!-- 수수료·정산 관리 시작 -->
					<div class="projectArea">
						<p class="projectTitle">수수료·정산 관리</p>
						<p class="projectContent">수수료 및 정산 관리 내역을 보고 신청할 수 있어요.</p>
						
						<!-- 현재 진행중인 프로젝트 -->
						<div>
							<p class="subheading">진행중인 프로젝트
								<!-- 팝오버 -->
								<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="#FF9300" class="bi bi-question-circle" viewBox="0 0 16 16" data-bs-toggle="popover" data-bs-content="현재 진행중인 프로젝트를 출력해요. 현재 진행중인 프로젝트는 정산을 완료할 수 없어요." data-bs-trigger="hover focus">
									<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
									<path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286zm1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
								</svg>
							</p>
							<div class="table-responsive">
								<table class="table table-bordered text-center table-center">
									<c:forEach var="projectList" items="${projectList }">
										<c:if test="${projectList.project_status eq 1 or projectList.project_status eq 2}">
											<thead class="table-light">
												<tr>
													<th colspan="2">프로젝트명</th>
													<th>진행률</th>
													<th>상태</th>
													<th>상세보기</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<img class="project-img" src="${pageContext.request.contextPath }/resources/upload/${projectList.project_thumnails1 }">
													</td>
													<td>${projectList.project_subject }</td>
													<td><fmt:formatNumber value="${projectList.project_cumulative_amount/projectList.project_target * 100}" pattern="#"/>%</td>
													<td>
														<c:choose>
															<c:when test="${projectList.project_status eq 1 }">
																미진행
															</c:when>
															<c:when test="${projectList.project_status eq 2 }">
																진행중
															</c:when>
														</c:choose>
													</td>
													<td>
														<button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#settlementModal">확인</button>
													</td>
												</tr>
											</c:if>
										</tbody>
									</c:forEach>
								</table>
							</div>
						</div>
						
						<!-- 진행완료된 프로젝트 -->
						<div>
							<p class="subheading">진행 완료된 프로젝트
								<!-- 팝오버 -->
								<svg xmlns="http://www.w3.org/2000/svg" width="21" height="21" fill="#FF9300" class="bi bi-question-circle" viewBox="0 0 16 16" data-bs-toggle="popover" data-bs-content="진행 완료된 프로젝트를 출력해요. 모든 리워드가 배송완료되고 14일 이후부터 정산이 가능해요." data-bs-trigger="hover focus">
									<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
									<path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286zm1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
								</svg>
							</p>
							<div class="table-responsive">
								<table class="table table-bordered text-center table-center">
									<c:forEach var="projectList" items="${projectList }">
										<c:if test="${projectList.project_status ge 3}">
											<thead class="table-light">
												<tr>
													<th colspan="2">프로젝트명</th>
													<th>진행률</th>
													<th>상태</th>
													<th>상세보기</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>
														<img class="project-img" src="${pageContext.request.contextPath }/resources/upload/${projectList.project_thumnails1 }">
													</td>
													<td>${projectList.project_subject }</td>
													<td><fmt:formatNumber value="${projectList.project_cumulative_amount/projectList.project_target * 100}" pattern="#"/>%</td>
													<td>
														<c:choose>
															<c:when test="${projectList.project_status eq 3 }">
																	진행완료
																</c:when>
																<c:when test="${projectList.project_status eq 4 }">
																	정산신청
																</c:when>
																<c:when test="${projectList.project_status eq 5 }">
																	정산완료
																</c:when>
														</c:choose>
													</td>
													<td>
														<button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#settlementModal" data-project-idx="${projectList.project_idx}">확인</button>
													</td>
												</tr>
											</tbody>
										</c:if>
									</c:forEach>
								</table>
							</div>
						</div>
					</div>
				</article>
			</section>
		</div>
	</main>
	
	<!-- 정산 내역 신청 버튼 -->
	<div class="modal fade" id="settlementModal" tabindex="-1" aria-labelledby="settlementModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="settlementModalLabel">정산내역서</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div>
						<span class="d-block">프로젝트명</span>
						<span class="d-block fw-bold text-primary" id="project_subject"></span>
					</div>
					<div class="border-top my-3"></div>
					<div>
						<span class="d-block">정산 정보</span>
						<table class="table table-bordered table-inverse mt-2">
							<tbody class="shippingModalTbody">
								<tr>
									<th scope="row" class="col-3 bg-light">대표자명</th>
									<td class="col-9" id="representative_name"></td>
								</tr>
								<tr>
									<th scope="row" class="col-3 bg-light">이메일</th>
									<td class="col-9" id="representative_email"></td>
								</tr>
								<tr>
									<th scope="row" class="col-3 bg-light">은행명</th>
									<td class="col-9" id="settlement_bank"></td>
								</tr>
								<tr>
									<th scope="row" class="col-3 bg-light">계좌번호</th>
									<td class="col-9" id="settlement_account"></td>
								</tr>
								<tr>
									<th scope="row" class="col-3 bg-light">예금주명</th>
									<td class="col-9" id="settlement_name"></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="border-top my-3"></div>
					<div>
						<span class="d-block">최종 정산 지급금액</span>
						<span class="fw-bold text-danger d-block fs-5" id="final_amount"></span>
						<span class="d-block mt-1" id="modalDescription">배송비: <span class="fw-bold" id="delivery_amount"></span> 포함</span>
					</div>
					<div class="border-top my-3"></div>
					<div>
						<span class="d-block">결제완료 금액</span>
						<span class="fw-bold d-block fs-5" id="total_amount"></span>
					</div>
					<div class="border-top my-3"></div>
					<div>
						<span class="d-block">세금계산서 발행금액</span>
						<span class="fw-bold d-block fs-5" id="tax_amount"></span>
						<span class="d-block mt-1" id="modalDescription">중개 수수료<span id="charge"></span> + 카드 결제(PG 등) 대행 수수료</span>
					</div>
					<div class="border-top my-3"></div>
					<div class="container">
						<div class="row">
						    <div class="col p-3 bg-light border" id="modalDescription">
						    	※리워드의 모든 배송이 완료된 후, 정산 신청이 가능합니다.<br>
						    	※배송 완료 후 14일이 경과해야 정산 신청을 할 수 있습니다<br>
						    	※정산 신청 시 확인이나 추가 정보 요청이 있을 수 있으니 주의하시기 바랍니다.<br>
						    	※정산 정보를 확인 후 정산 신청을 진행해 주시기 바랍니다.<br>
						    	※세금계산서는 이메일을 통해 발송이 됩니다.<br>
						    	※정산 정보 변경 등 문의 사항이 있으시면 고객 센터로 연락주시기 바랍니다.
						    </div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<form action="bankSettlement" method="post" class="settlement-form">
						<button type="submit" class="btn btn-danger"></button>
						<input type="hidden" name="fintech_use_num" id="fintech_use_num">
						<input type="hidden" name="final_settlement" id="final_settlement">
						<input type="hidden" name="project_idx" id="project_idx">
					</form>
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>