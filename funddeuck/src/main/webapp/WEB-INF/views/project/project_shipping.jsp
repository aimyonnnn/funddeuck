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
		let project_idx;
		
		$("#project-btn").siblings(".dropdown-menu").find("a").click(function(event) {
			// 드롭다운 버튼 클릭 시 텍스트 활성화 
		    var selectedText = $(this).text();
		    $('#project-btn').text(selectedText);
			
		    $('.customSpan').empty(); // 클릭 시 내용 비움
		 	// 목록 리셋 작업
		    $('#list-btn').text('발송·배송 관리 선택'); // 드롭다운 버튼 텍스트를 초기 텍스트로 변경
		    $('#shippingListBody').empty(); // 테이블 내의 데이터를 비움
		    
			// 클릭한 dropdown의 id 값을 가져옴
			project_idx = $(this).data("id");
			
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

					      if (status == 1) { // 미발송 시 
					        $(".table .text-primary:eq(0)").next().text(count);
					      } else if (status == 2) { // 배송중일 시
					        $(".table .tableTag:eq(1)").next().text(count);
					      } else if (status == 3) { // 배송완료일 시
					        $(".table .tableTag:eq(2)").next().text(count);
					      }
					    }

					    // 컨트롤러에서 조회된 결제승인여부 데이터 처리
					    for (var i = 0; i < refundStatus.length; i++) {
					      var status = refundStatus[i].payment_confirm;
					      var count = refundStatus[i].count;

					      if (status == 3) { // 펀딩금 반환 신청 시
					        $(".table .text-primary:eq(1)").next().text(count);
					      } else if (status == 4) { // 반환 완료 시
					        $(".table .tableTag:eq(4)").next().text(count);
					      } else if (status == 5) { // 거절 시
					        $(".table .tableTag:eq(5)").next().text(count);
					      }
					    }
					    
					    // 목록 인원수 출력
					    $('.list-count').text('| 총 ' + data.listCount + '명');
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

			if(project_idx) {
				
				// 드롭다운 버튼 클릭 시 텍스트 활성화 
			    var selectedDrop = $(this).text();
			    $('#list-btn').text(selectedDrop);
			    
			    var all = $(this).data('all'); // 전체 목록
			    var filter = $(this).data('filter'); // 배송 상태
			    var type = $(this).data('type'); // 환불 상태
			    $.ajax({
			    	url: "shippingList",
			    	method: "POST",
			    	data: {
			    		project_idx: project_idx,
			    		filter: filter,
			    		type: type,
			    		all: all
			    	},
			    	dataType: "json",
			    	success: function(data) {
			    		var tableBody = $('#shippingListBody');
			    		tableBody.empty(); // 선택 시 테이블 목록 비움
			    		
			    		function formatDate(timestamp) { // 밀리초 단위를 Date 날짜 변환하는 함수
		    			  var date = new Date(timestamp);
		    			  var year = date.getFullYear();
		    			  var month = ('0' + (date.getMonth() + 1)).slice(-2);
		    			  var day = ('0' + date.getDate()).slice(-2);

		    			  return year + '-' + month + '-' + day;
		    			}

			    	    $.each(data, function(index, row) {
			    			var formattedDate = formatDate(row.payment_date); // 주문 날짜 변환
			    			
			    	        var newRow = "<tr>" +
			    	                        "<td>" + row.payment_idx + "</td>" +
			    	                        "<td>" +
			    	                            row.member_name + "<br>" +
			    	                            row.member_email + "<br>" +
			    	                            row.member_phone +
			    	                        "</td>" +
			    	                        "<td>" + formattedDate + "</td>" +
			    	                        "<td>" + row.total_amount + "원</td>" +
			    	                        "<td>" + row.reward_name + "</td>" +
			    	                        "<td>" +
			    	                            "<button class='btn btn-outline-primary btn-sm' id='tableButton' data-id="+ row.payment_idx +" data-bs-toggle='modal' data-bs-target='#trackingModal'>입력</button>" +
			    	                        "</td>" +
			    	                        "<td>" + row.delivery_date + "</td>" +
			    	                        "<td class='shippingStatus' data-payment-idx=" + row.payment_idx + ">" + 
				    	                        (function() {
				    	                            if(row.delivery_status == 1) { // 배송 상태 
				    	                                return "미발송";
				    	                            } else if(row.delivery_status == 2) {
				    	                                return "배송중";
				    	                            } else if(row.delivery_status == 3) {
				    	                                return "배송완료";
				    	                            } else {
				    	                            	return "";
				    	                            }
				    	                        })()
			    	                        + "</td>" +
			    	                        "<td class='waybillNum' data-payment-idx=" + row.payment_idx + ">" +  // data-payment-idx 속성 추가
			    	                        	(function() {
			    	                        		if(row.waybill_num == null) { // 운송장번호 없을 시
			    	                        			return "";
			    	                        		} else {
			    	                        			return row.waybill_num;
			    	                        		}
			    	                        	})()
			    	                        + "</td>" +
			    	                        "<td class='refundStatus' data-id='" + row.payment_idx + "'>" +
			    	                        	(function() {
			    	                        		if(row.payment_confirm == 3) { // 펀딩금 반환 신청 시
					    	                            return "<button class='btn btn-outline-danger btn-sm' id='refundButton' data-id="+ row.payment_idx +" data-bs-toggle='modal' data-bs-target='#refundModal'>신청</button>";
			    	                        		} else if(row.payment_confirm == 4) { // 반환 완료 시
			    	                        			return "완료";
			    	                        		} else if(row.payment_confirm == 5) { // 반환 거절 시 
			    	                        			return "거절";
			    	                        		} else if(row.payment_confirm == 0) { // 프로젝트 취소 시
			    	                        			return "<span style='color:red;'>프로젝트 취소</span>";
			    	                        		} else { // 반환 신청 없을 시
			    	                        			return "";
			    	                        		}
			    	                        	})()
			    	                        + "</td>" +
			    	                     "</tr>";
			    	        tableBody.append(newRow);
			    	    });
			    	},
			    	error: function() {
			    		// Ajax 요청에 실패한 경우 처리
						alert("두번째 요청에 오류가 발생했습니다.");
			    	}
			    });
		    } else {
		    	alert("프로젝트를 먼저 선택해 주세요!");
		    }
		});
		
		// 버튼의 클릭 이벤트 리스너
		$('#excelDownloadBtn').on('click', function() {
		    if (project_idx) {
		        location.href = 'shippingExcelDownload?project_idx=' + project_idx;
		    } else {
		    	alert("프로젝트를 먼저 선택해 주세요!");
		    }
		});
		
		// 발송입력 - 모달창
		$(document).on("click", "#tableButton", function(event) {
			var payment_idx = $(this).data("id");
		    $('.shippingForm input[name="payment_idx"]').val(payment_idx); // 폼 hidden에 payment_idx 값 주기
			
			$.ajax({
				url: "shippingModalList",
				method: "POST",
				data: {payment_idx: payment_idx},
				dataType: "json",
				success: function(data) {
					var data = data;
					
					$("#trackingModal .reward-name").text(data.reward_name); // 리워드 이름 출력

					// 테이블 바디 생성
					var tableBodyHtml = 
					  '<tr>' +
					    '<th scope="row" class="col-3 bg-light">주문수량</th>' +
					    '<td class="col-9">' + data.payment_quantity + '개</td>' +
					  '</tr>' +
					  '<tr>' +
					    '<th scope="row" class="col-3 bg-light">금액</th>' +
					    '<td class="col-9">' + data.total_amount + '원</td>' +
					  '</tr>' +
					  '<tr>' +
					    '<th scope="row" class="col-3 bg-light">수취인</th>' +
					    '<td class="col-9">' + data.delivery_reciever + '</td>' +
					  '</tr>' +
					  '<tr>' +
					    '<th scope="row" class="col-3 bg-light">연락처</th>' +
					    '<td class="col-9">' + data.delivery_phone + '</td>' +
					  '</tr>' +
					  '<tr>' +
					    '<th scope="row" class="col-3 bg-light">우편번호</th>' +
					    '<td class="col-9">' + data.delivery_zipcode + '</td>' +
					  '</tr>' +
					  '<tr>' +
					    '<th scope="row" class="col-3 bg-light">주소</th>' +
					    '<td class="col-9">' + data.delivery_add + ', ' + data.delivery_detailadd + '</td>' +
					  '</tr>';

				      // 테이블 바디에 추가
				      $("#trackingModal .shippingModalTbody").html(tableBodyHtml);
				},
				error: function() {
					alert("모달 요청에 오류가 발생했습니다!");
				}
			});
			
		});
		
		// 반환입력 - 모달창
		$(document).on("click", "#refundButton", function(event) {
			var payment_idx = $(this).data("id");
			console.log(payment_idx);
			
			$.ajax({
				url: "shippingModalList",
				method: "POST",
				data: {payment_idx: payment_idx},
				dataType: "json",
				success: function(data) {
					var data = data;
		            
		            var tableBodyHtml = 
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">펀딩번호</th>' +
						    '<td class="col-9">' + data.payment_idx + '</td>' +
						  '</tr>' +
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">서포터명</th>' +
						    '<td class="col-9">' + data.member_name + '</td>' +
						  '</tr>' +
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">리워드명</th>' +
						    '<td class="col-9">' + data.reward_name + '</td>' +
						  '</tr>' +
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">주문수량</th>' +
						    '<td class="col-9">' + data.payment_quantity + '개</td>' +
						  '</tr>' +
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">결제금액</th>' +
						    '<td class="col-9">' + data.total_amount + '원</td>' +
						  '</tr>' +
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">결제수단</th>' +
						    '<td class="col-9">' + (data.payment_method === 1 ? '카드결제' : '계좌이체') + '</td>' +
						  '</tr>' +
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">환불은행</th>' +
						    '<td class="col-9">' + (data.refund_bank !== null ? data.refund_bank : '없음') + '</td>' +
						  '</tr>' +
						  '<tr>' +
						    '<th scope="row" class="col-3 bg-light">환불계좌</th>' +
						    '<td class="col-9">' + (data.refund_accountnum !== null ? data.refund_accountnum : '없음') + '</td>' +
						  '</tr>'
						  '<tr>';

						// 테이블 바디에 추가
						$("#refundModal .refundModalTbody").html(tableBodyHtml);
						
						$("#refund-reason").text(data.cancel_context);
						if (data.cancel_img) { // 이미지 파일이 있다면 
							var fileName = data.cancel_img.split("_")[1];
							var fileURL = "/resources/upload/" + data.cancel_img;
							
							$("#refund-document")
							    .attr("href", fileURL)
							    .attr("download", data.cancel_img)
							    .text(fileName);
						} else {
						    $("#refund-document").text("").removeAttr("href").removeAttr("download");
						}
						
						// hidden에 환불 입금 api 요청할 값 추가 
						$('#fintech_use_num').val(data.fintech_use_num);
						$('#project_idx').val(data.project_idx);
						$('#print_content').val('펀딩금반환');
						$('#final_settlement').val(data.total_amount);
						$('#member_id').val(data.member_id);
						$('#payment_idx').val(payment_idx);
				},
				error: function() {
					alert("모달 요청에 오류가 발생했습니다!");
				}
			});
		});
		
		$('.shippingForm').on("submit", submitForm); // 발송입력 모달창 폼 제출
		
		function submitForm(event) {
		    event.preventDefault(); // 기본 제출 동작을 중지
		    
		    const payment_idx = $('input[name="payment_idx"]').val();

		    $.ajax({
		        url: 'updateShippingInfo', 
		        type: 'POST', 
		        data: $(this).serialize(), 
		        success: function(data) {
		            var newRowContent = (data[0] && data[0].waybill_num) ? data[0].waybill_num : "";
		            var updatedTd = $('td.waybillNum[data-payment-idx="' + payment_idx + '"]');
				    updatedTd.html(newRowContent);
		            
					// 발송·배송 칸 찾기
				    var updatedStatus = $('td.shippingStatus[data-payment-idx="' + payment_idx + '"]');

				    // 새로운 상태로 업데이트
				    var statusMapping = {
				    	0: "",
				        1: "미발송",
				        2: "배송중",
				        3: "배송완료"
				    };

				    // 상태 업데이트
				    var newStatusValue = (data[0] && data[0].delivery_status) ? statusMapping[data[0].delivery_status] : "";
				    updatedStatus.html(newStatusValue);
				    
		            $("#trackingModal").modal("hide"); // 모달을 닫음
		            alert('성공적으로 발송 입력이 되었습니다.');
		        },
		        error: function(xhr) {
		            alert(xhr.responseText); // 실패 메시지 출력
		        }
		    });
		}
		
		// 환불 거절 상태 변경
		$(document).on("click", "#refuse", function(event) {
			var payment_idx = $(this).closest(".modal-content").find("#payment_idx").val();
			console.log(payment_idx);
			$.ajax({
				url: "updateShippingRefuse",
				method: "POST",
				data: { payment_idx: payment_idx },
				dataType: "json",
				success: function(data) {
					var updatedTd = $('td.refundStatus[data-id="' + payment_idx + '"]');
		            updatedTd.html("거절");
					         
					$("#refundModal").modal("hide"); // 모달을 닫음
					alert('성공적으로 반환이 거절되었습니다.');
				},
				error: function(xhr) {
				    alert(xhr.responseText); // 실패 메시지 출력
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
							            	<a class="dropdown-item" href="" data-id="${projectList.project_idx}">${projectList.project_subject }</a>
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
						    <div class="shippingSubheading d-flex justify-content-between">
						        <div>
						            목록 <span class="sideDescription text-primary list-count"></span>
						            <div class="dropdown d-inline">
						                <button type="button" class="btn dropdown-toggle btn-sm" id="list-btn" data-bs-toggle="dropdown" aria-expanded="false">
						                    발송·배송 관리 선택
						                </button>
						                <ul class="dropdown-menu" aria-labelledby="list-btn">
						                    <li><a class="dropdown-item shipping-filter-item" href="#" data-all="1">전체</a></li>
						                    <li><hr class="dropdown-divider"></li>
						                    <li><a class="dropdown-item shipping-filter-item" href="#" data-filter="1">미발송</a></li>
						                    <li><a class="dropdown-item shipping-filter-item" href="#" data-filter="2">배송중</a></li>
						                    <li><a class="dropdown-item shipping-filter-item" href="#" data-filter="3">배송 완료</a></li>
						                    <li><hr class="dropdown-divider"></li>
						                    <li><a class="dropdown-item shipping-filter-item" href="#" data-type="3">펀딩금 반환 신청</a></li>
						                    <li><a class="dropdown-item shipping-filter-item" href="#" data-type="4">펀딩금 반환 신청 완료</a></li>
						                    <li><a class="dropdown-item shipping-filter-item" href="#" data-type="5">펀딩금 반환 신청 거절</a></li>
						                </ul>
						            </div>
						        </div>
						        <div>
						            <button type="button" class="btn btn-outline-primary btn-sm" id="excelDownloadBtn">엑셀 다운로드</button>
						        </div>
						    </div>
						    <div class="table-responsive">
						        <table class="table">
						            <thead class="table-light text-center">
						                <tr>
						                    <th scope="col">펀딩번호</th>
						                    <th scope="col">서포터 정보</th>
						                    <th scope="col">주문날짜</th>
						                    <th scope="col">금액</th>
						                    <th scope="col">리워드</th>
						                    <th scope="col">발송정보</th>
						                    <th scope="col">발송예정일</th>
						                    <th scope="col">발송·배송</th>
						                    <th scope="col">발송번호</th>
						                    <th scope="col">펀딩금 반환</th>
						                </tr>
						            </thead>
						            <tbody class="text-center" id="shippingListBody">
						            </tbody>
						        </table>
						    </div>
						</div>
						<!-- 목록 끝-->
					</div>
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
						<p class="fw-bold fs-5 reward-name"></p>
						<table class="table table-bordered table-inverse">
							<tbody class="shippingModalTbody">
							</tbody>
						</table>
					</div>
					<form class="shippingForm" action="updateShippingInfo" method="post">
						<input type="hidden" name="payment_idx">
						<div>
							<p class="modalTitle">발송방법</p>
							<select class="form-control" name="delivery_method">
								<option value="">선택</option>
								<option value="택배">택배</option>
								<option value="디지털 전송">디지털 전송</option>
								<option value="우편">우편</option>
								<option value="후원">후원</option>
							</select>
						</div>
						<div>
							<p class="modalTitle">택배사</p>
							<select class="form-control" name="courier">
								<option value="">선택</option>
								<option value="CJ대한통운">CJ대한통운</option>
								<option value="우체국택배">우체국택배</option>
						        <option value="한진택배">한진택배</option>
						        <option value="롯데택배">롯데택배</option>
						        <option value="로젠택배">로젠택배</option>
						        <option value="일양로지스">일양로지스</option>
							</select>
						</div>
						<div>
							<label class="modalTitle" for="waybillNum">송장번호</label>
							<input class="form-control mb-4" type="text" name="waybill_num" id="waybillNum" placeholder="송장번호를 입력해 주세요">
						</div>
						<div class="modal-footer">
							<button type="submit" class="btn btn-primary">완료</button>
							<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						</div>
					</form>
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
						<table class="table table-bordered table-inverse">
							<tbody class="refundModalTbody">
							</tbody>
						</table>
						<div class="border-top my-3"></div>
						<p class="modalTitle">펀딩금 반환 신청 사유</p>
					  	<p>
					  		<span class="fw-bold">사유</span><br>
					  		<span id="refund-reason"></span>
					  	</p>
					  	<p>
					  		<span class="fw-bold">증빙 서류</span><br>
					  		<a href="#" id="refund-document"></a>
					  	</p>
					</div>
				</div>
				<div class="modal-footer">
					<form action="bankRefund" method="post" class="settlement-form">
						<input type="hidden" name="fintech_use_num" id="fintech_use_num">
						<input type="hidden" name="project_idx" id="project_idx">
						<input type="hidden" name="final_settlement" id="final_settlement">
						<input type="hidden" name="print_content" id="print_content">
						<input type="hidden" name="member_id" id="member_id">
						<input type="hidden" name="payment_idx" id="payment_idx">
						<button type="submit" class="btn btn-danger">반환 승인</button>
						<button type="button" class="btn btn-primary" id="refuse" data-bs-dismiss="modal">거절</button>
						<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					</form>
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