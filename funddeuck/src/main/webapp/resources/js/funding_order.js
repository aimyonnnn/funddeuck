
// funding_order 페이지의 js

// 배송지 신규 등록 모달창
	// 배송지 연락처 입력시 자동으로 하이픈 생성 
	// 배송지 추가 모달창에도 적용되도록 클래스로 지정
	$(document).ready(function () {
		 $(document).on("keyup", ".delivery_phone", function() { 
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
		});
	
	});
// ====================================================
// 배송지 신규 등록을 위한 ajax 요청 (기본 배송지로 등록)
	$(document).on('submit', '#deliveryNewAddModal form', function(e) {
	  // 기존의 submit 이벤트를 막습니다.
	  e.preventDefault();
	
	  // form 요소의 유효성을 검증
//	  if (!this.checkValidity()) {
//	    // 유효하지 않은 경우, 알림 메시지
//	    alert('입력값이 올바르지 않습니다.')
//	    return;
//	  }
		$.ajax({
			type: "POST",
			url: "deliveryNewAdd",
			data: $(this).serialize(),
			success: function(saveDelivery) {
				if(saveDelivery != null) {
					console.log("배송지 신규 등록 완료!");
					// 배송지 추가 모달창의 입력된 데이터 지우기
					$("#deliveryNewAddModal input").val("");
					// 배송지 추가 모달창 닫힘(부트스트랩 5.3.0에서는 X)
	//					$('#deliveryAddModal').modal('hide');
			        // 배송지 추가 모달창 닫기 버튼 클릭 발생
			        $("#deliveryNewAddModalClose").click();
			        
			        console.log(saveDelivery);
			        // 기존 배송지란에 있던 내용 지우기
			        $('#deliveryContainer').html('');
			        
			        let output = '<div class="col">'
							+ '<div class="row-12">'
							+ '<span class="fs-6 fw-bold">' + saveDelivery.delivery_reciever + '</span>&nbsp;'
							+ '<span class=" badge bg-danger text-white">기본</span>'	
							+ '</div>'
							+ '<div class="row-12">'
							+ '<span class="fs-6">[' + saveDelivery.delivery_zipcode + ']</span>&nbsp;'
							+ '<span class="fs-6">' + saveDelivery.delivery_add + '</span>&nbsp;'
							+ '<c:if test="${not empty'	+  saveDelivery.delivery_detailadds + '}">'
							+ '<span class="fs-6">' + saveDelivery.delivery_detailadd + '</span>'
							+ '</c:if>'
							+ '</div>'
							+ '<div class="row-12">'
							+ '<span class="fs-6">' + saveDelivery.delivery_phone + '</span>'
							+ '</div></div>'
							+ '<div class="col-lg-2 col-sm-12 d-flex justify-content-center align-self-center">'
							+ '<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryChangeModal">변경</button>'
							+ '</div>';
						
			        // 배송지란에 등록된 기본배송지 출력
			        $('#deliveryContainer').html(output);
			        	
			        
					
				} else {
					console.log("배송지 신규 등록 실패!");
				}
			},
			error: function (xhr, status, error) {
				console.error("오류 발생!" , error);
			}
		});
		
			
	});
	
//	
//	$(document).on("click", "#deliveryNewAdd", function() {
//		
//		// 폼 데이터 가져오기
//		var formData = $("#deliveryNewAddModal form").serialize();
//		console.log(formData);
//		// ajax 요청
//		$.ajax({
//			type: "POST",
//			url: "deliveryNewAdd",
//			data: formData,
//			success: function(saveDelivery) {
//				if(saveDelivery != null) {
//					console.log("배송지 신규 등록 완료!");
//					// 배송지 추가 모달창의 입력된 데이터 지우기
//					$("#deliveryNewAddModal input").val("");
//					// 배송지 추가 모달창 닫힘(부트스트랩 5.3.0에서는 X)
//	//					$('#deliveryAddModal').modal('hide');
//			        // 배송지 추가 모달창 닫기 버튼 클릭 발생
//			        $("#deliveryNewAddModalClose").click();
//			        
//			        console.log(saveDelivery);
//			        // 기존 배송지란에 있던 내용 지우기
//			        $('#deliveryContainer').html('');
//			        
//			        let output = '<div class="col">'
//							+ '<div class="row-12">'
//							+ '<span class="fs-6 fw-bold">' + saveDelivery.delivery_reciever + '</span>&nbsp;'
//							+ '<span class=" badge bg-danger text-white">기본</span>'	
//							+ '</div>'
//							+ '<div class="row-12">'
//							+ '<span class="fs-6">[' + saveDelivery.delivery_zipcode + ']</span>&nbsp;'
//							+ '<span class="fs-6">' + saveDelivery.delivery_add + '</span>&nbsp;'
//							+ '<c:if test="${not empty'	+  saveDelivery.delivery_detailadds + '}">'
//							+ '<span class="fs-6">' + saveDelivery.delivery_detailadd + '</span>'
//							+ '</c:if>'
//							+ '</div>'
//							+ '<div class="row-12">'
//							+ '<span class="fs-6">' + saveDelivery.delivery_phone + '</span>'
//							+ '</div></div>'
//							+ '<div class="col-lg-2 col-sm-12 d-flex justify-content-center align-self-center">'
//							+ '<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryChangeModal">변경</button>'
//							+ '</div>';
//						
//			        // 배송지란에 등록된 기본배송지 출력
//			        $('#deliveryContainer').html(output);
//			        	
//			        
//					
//				} else {
//					console.log("배송지 신규 등록 실패!");
//				}
//			},
//			error: function (xhr, status, error) {
//				console.error("오류 발생!" , error);
//			}
//		});
//		
//			
//	});
	
// 