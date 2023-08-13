
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
		// 기존의 submit 이벤트를 막기
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
			        // form으로 전달할 데이터들
			        $('#delivery_idx').val(saveDelivery.delivery_idx);
			        $('#delivery_zipcode').val(saveDelivery.delivery_zipcode);
			        $('#delivery_add').val(saveDelivery.delivery_add);
			        	
			        
					
				} else {
					console.log("배송지 신규 등록 실패!");
				}
			},
			error: function (xhr, status, error) {
				console.error("오류 발생!" , error);
			}
		});
		
			
	});
// ===========================================================
// 배송지 추가 모달창
	// 배송지 추가를 위한 ajax 요청 (기본 배송지 O)
	$(document).on('submit', '#deliveryAddModal form', function(e) {
		// 기존의 submit 이벤트를 막기
		e.preventDefault();
		// 배송지 변경 모달창 닫기
        $("#deliveryChangeModalClose").click();
		
		// ajax 요청
		$.ajax({
			type: "POST",
			url: "deliveryAdd",
			data: $(this).serialize(),
			success: function(msg) {
				if($.trim(msg) == "success") {
					console.log("배송지 등록 완료!");
					// 배송지 추가 모달창의 입력된 데이터 지우기
					$("#deliveryAddModal input").val("");
					// 배송지 추가 모달창 닫힘(부트스트랩 5.3.0에서는 X)
// 					$('#deliveryAddModal').modal('hide');
			        // 배송지 추가 모달창 닫기 버튼 클릭 발생
			        $("#deliveryAddModalClose").click();
					
					// 배송지 변경 모달창 열림
					$("#deliveryChangeModal").modal("show");
				} else {
					console.log("배송지 등록 실패!");
				}
			},
			error: function (xhr, status, error) {
				console.error("오류 발생!" , error);
			}
		});
		
			
	});	
	
	$(document).ready(function() {
	    // 배송지 추가 모달 열릴때 배송지 변경 모달 닫힘
	    $("#deliveryAddModal").on("show.bs.modal", function() {
	    	$("#deliveryChangeModalClose").click();
	    });
	    
	});			
	
// ===========================================================
// 배송지 변경 모달창 
		
	$(document).ready(function() {
		// 배송지 목록을 가져오는 ajax 요청
	    $('#deliveryChangeModal').on('show.bs.modal', function(event) {
	        var modal = $(this);
	        $.ajax({
	            type: "GET",
	            url: "getDeliveryList",
	            dataType: "json",
	            success: function(data) {
					console.log(data);
					var deliveryListElem = $('#deliveryList');
					deliveryListElem.empty(); // 배송지 목록 삭제
					
		            // 배송지 갯수 출력 부분 추가
		            $("#deliveryCount").text(data.length + "개의 배송지가 있습니다");					
					
					if (data.length > 0) {
						// 반복문을 사용하여 각 데이터를 배송지 목록에 추가
						data.forEach(function(delivery) {
							var html = '';
							
							html += '<div class="row border">';
							html += '<div class="form-check col-1 d-flex justify-content-center align-self-center">';
							html += '<input class="form-check-input radio-input" type="radio" name="deliveryGroup" value="'+ delivery.delivery_idx + '">';
							html += '</div>';
							html += '<div class="col text-start">';
							html += '<span class="fs-6 fw-bold">' + delivery.delivery_reciever + '</span>';
							// 기본 배송지 있을 경우 기본 뱃지 표시 
						    if (delivery.delivery_default == 1) {
						        html += '&nbsp;<span class="badge bg-danger text-white">기본</span>';
						    }
							
							html += '<br>';
							html += '<span class="fs-6">' + delivery.delivery_phone + '</span>';
							html += '<br>';
							html += '<span class="fs-6t">[' + delivery.delivery_zipcode + ']' 
								+ delivery.delivery_add + '&nbsp;&nbsp;' + delivery.delivery_detailadd + '</span>' ;
							html += '</div>';
							html += '</div>';
							deliveryListElem.append(html);
						});
					}
	            	
	            },
	            error: function(xhr, status, error) {
	                console.log(error);
	            }
	        });
	    });		
		
		// 배송지 변경 모달창에서 선택된 배송지의 번호를 hidden에 전달
	    // 라디오 버튼이 선택되었을 때, 값을 #deliver_idx 인 hidden input에 전달하기 위한 이벤트 리스너
	    $(document).on('change', 'input[type="radio"].radio-input', function() {
	        var selectedValue = $(this).val();
	        $('#changeDelivery_idx').val(selectedValue);
	    });
	});
	
	// 배송지 변경 출력을 위한 ajax 요청
	$(document).on("click", "#deliveryChange", function() {
		
		// 폼 데이터 가져오기
		var formData = $("#deliveryChangeModal form").serialize();
		console.log(formData);
		// ajax 요청
		$.ajax({
			type: "POST",
			url: "deliveryChange",
			data: formData,
			success: function(delivery) {
				console.log(delivery);
				if(delivery != null) {
					console.log("배송지 변경 완료!");
					
					// 배송지 변경 모달창 닫힘(부트스트랩 5.3.0에서는 X)
// 					$('#deliveryAddModal').modal('hide');
			        // 배송지 변경 모달창 닫기 버튼 클릭 
			        $("#deliveryChangeModalClose").click();
			        // 기존 배송지란에 있던 내용 지우기
			        $('#deliveryContainer').html('');
			        
					let output = '<div class="col">'
						+ '<div class="row-12">'
						+ '<span class="fs-6 fw-bold">' + delivery.delivery_reciever + '</span>&nbsp;';
					// 기본 배송지일 경우 기본배송지 뱃지 표시
					if (delivery.delivery_default == 1) {
						output += '<span class=" badge bg-danger text-white">기본</span>';
					}
					output += '</div>'
						+ '<div class="row-12">'
						+ '<span class="fs-6">[' + delivery.delivery_zipcode + ']</span>&nbsp;'
						+ '<span class="fs-6">' + delivery.delivery_add + '</span>&nbsp;';
					// 상세주소 있을 경우 출력 
					if (delivery.delivery_detailadd) {
						output += '<span class="fs-6">' + delivery.delivery_detailadd + '</span>';
					}
					output += '</div>'
						+ '<div class="row-12">'
						+ '<span class="fs-6">' + delivery.delivery_phone + '</span>'
						+ '</div></div>'
						+ '<div class="col-lg-2 col-sm-12 d-flex justify-content-center align-self-center">'
						+ '<button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#deliveryChangeModal">변경</button>'
						+ '</div>';
						
			        // 배송지란에 변경된 배송지 출력
			        $('#deliveryContainer').html(output);	
			        // form으로 전달할 데이터들		     	
			        $('#delivery_idx').val(delivery.delivery_idx);			     	
			        $('#delivery_zipcode').val(delivery.delivery_zipcode);			     	
			        $('#delivery_add').val(delivery.delivery_add);			     	
					
				} else {
					console.log("배송지 등록 실패!");
				}
			},
			error: function (xhr, status, error) {
				console.error("오류 발생!" , error);
			}
		});
		
			
	});
// ===========================================================
// 리워드 변경 모달창
	// 리워드 변경 요청 ajax
	$(document).ready(function() {
		// 리워드 변경 모달창
		// 리워드 변경 버튼 클릭시 라디오박스에 해당하는 리워드 번호 전달하는 ajax
		$("#rewardChange").on("click", function()  {
			// 체크된 라디오 박스
			let checkedRadio = $('input[name="rewardCheck"]:checked');
			
			// 체크된 라디오 버튼 있는지 확인
			if(checkedRadio.length > 0) {
				// 선택한 라디오 버튼의 상위 row 요소 선택
				let rewardRow = checkedRadio.closest('.row');
				// 리워드 번호 가져오기
				let reward_idx = rewardRow.find('input[type="hidden"]').val();
				
				// ajax 요청 컨트롤러 전달
				$.ajax({
					type: "POST",
					url: "rewardChange",
					data: {reward_idx: reward_idx},
					success: function(reward) {
						// 전달받은 RewardVO 출력
						console.log(reward);
						// 리워드 변경 모달창 닫기
						$("#rewardListModalClose").click();
						// 기존 HTML 지우기
						$('#rewardContainer').html('');
						$('#rewardPrice').html('');
						$('#rewardDeliveryPrice').html('');
						$('#reward_idx').val();
						
						
						// HTML 출력할 내용
						// hidden 값으로 리워드번호 전달
						let output = `
							<input type="hidden" value="${reward.reward_idx}" name="reward_idx">
							<table class="table table-borderless" style="table-layout: fixed">
								<tr>
									<th>리워드 구성</th>
									<td>
										${reward.reward_name} <br>
										${reward.reward_option}
									</td>
								</tr>
								<tr>
									<th>리워드 금액</th>
									<td>
										<span id="reward">${reward.reward_price}</span>원
									</td>
								</tr>
						
								<tr>
									<th>리워드 수량</th>
									<td class="d-flex align-items-center">
										<a class="text-primary fs-4 w-20 d-block" role="button" id="rewardQuantityUp">
											<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-up-circle fs-6" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
											</svg>										
										</a> &nbsp;&nbsp;
										<input type="hidden" id="maxRewardQuantity" value="${reward.reward_quantity}">
										<input class="form-control form-inline w-10" id="rewardQuantity" type="number" value="1" min="1" max="${reward.reward_quantity}">&nbsp;&nbsp;
										<a class="text-primary fs-4 w-20 d-block" role="button" id="rewardQuantityDown">
											<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-arrow-down-circle" viewBox="0 0 16 16">
												<path fill-rule="evenodd" d="M1 8a7 7 0 1 0 14 0A7 7 0 0 0 1 8zm15 0A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
											</svg>									
										</a>
									</td>
								</tr>
						
								<tr>
									<th>배송비</th>
									<td>${reward.delivery_price}원</td>
								</tr>
								<tr>
									<th>발송 시작일</th>
									<td>${reward.delivery_date}</td>
								</tr>
							</table>`;						
						
						let output2 = reward.reward_price;
						let output3 = reward.delivery_price;
						let output4 = reward.reward_idx;
			            // 출력하기
			            $('#rewardContainer').html(output);
			            $('#rewardPrice').html(output2);
			            $('#rewardDeliveryPrice').html(output3);
			            $('#reward_idx').val(output4);
			            $('#reward_amount').val(output2);
						updateCouponSale();
						updateTotalPrice();
					},
					error: function(xhr, status, error) {
						 console.error("Error:", error);
					}
					
				});
				
			} else {
				alert("리워드를 선택하세요");
			}
		});
	});	
// ===========================================================
// 후원 유의사항 열기/닫기
	$(document).ready(function() {
		// 열기 버튼 클릭시 후원 유의사항 출력
		$("#notesOpen").on("click", function() {
			// 열기 버튼 숨김
			$('#notesOpen').hide();
			// notesContainer
			// 후원 유의사항
			let output = '<p>'
				+ '펀딩은 일반 쇼핑과 달리 메이커에게 투자하고, 투자의 보상으로 제품이나 서비스를 받는 구조입니다.<br>'
				+ '따라서 단숨 변심으로 인한 환불은 신청하실 수 없습니다.'
				+ '</p>';
			$('#notesContainer').html(output);
			
			// 닫기 버튼 보임
			$('#notesClose').show();
		});
		// 닫기 버튼 클릭시 후원 유의사항 지우기
		$("#notesClose").on("click", function() {
			// 열기 버튼 숨김
			$('#notesClose').hide();
			// notesContainer
			$('#notesContainer').html('');
			
			// 닫기 버튼 보임
			$('#notesOpen').show();
		});
		
	});

// ===========================================================
// 쿠폰 선택시 할인율 출력
// 최종 후원 금액에 쿠폰 사용 금액 출력

	function updateCouponSale() {
		let selectElement = document.getElementById('couponSelect');
		let selectedIndex = selectElement.selectedIndex;
		let selectedCoupon = selectElement.options[selectedIndex];
		let couponSaleElement = document.getElementById('couponSale');
		
		// 리워드 가격
		let rewardPrice = parseFloat(document.getElementById('rewardPrice').innerText);
		// 쿠폰 사용금액 출력 위한 변수
		let couponPriceElement = document.getElementById('couponPrice');	
		// 마이너스 기호 출력 위한 변수
		let minusElement = document.getElementById('minus');	
		if (!selectedCoupon || selectedCoupon.value === "") { // 쿠폰 미선택시
			couponSaleElement.innerText = '';
			// 쿠폰 사용 금액 0 으로 출력
			couponPriceElement.innerText = 0;
			$("#use_coupon_amount").val(0);
			updateTotalPrice();
		} else {
			// 쿠폰 사용금액 계산
			let discountPercentage = parseFloat(selectedCoupon.value);
			let discountedPrice = Math.round(rewardPrice * discountPercentage / 100);
			// 할인율 출력
			couponSaleElement.innerText = selectedCoupon.value.toString() + '% 할인';
			// 쿠폰 사용 금액 출력
			minusElement.innerText = '-';
			couponPriceElement.innerText = discountedPrice.toString();
			$("#use_coupon_amount").val(discountedPrice);
			updateTotalPrice();
		}
	}	

// ===========================================================
// 추가 후원금 입력
	$(document).ready(function() {
	    $("#addDonationAmountInput").on('input', function (e) {
	        // 입력된 값에서 숫자만 추출합니다.
	        var value = $(this).val().replace(/[^0-9]/g, '');
	
	        // 숫자가 없는 경우는 빈 문자열로 설정합니다.
	        if (value === '') {
	            $(this).val('');
	            return;
	        }

	        // 입력란에 포맷팅된 값을 설정합니다.
	        $(this).val(Number(value).toString());
	        
	    });
	    
		// 포커스가 벗어난 경우 최종 후원금란에 출력
		$("#addDonationAmountInput").on("blur", function() {
		    let inputAmount = $(this).val();
		    // 아무것도 입력안했을 경우 0 출력
		    if (inputAmount === '') {
				inputAmount = 0;
			}
		    $("#addDonationAmount").text(inputAmount);
		    $("#additional_amount").val(inputAmount);
		    updateTotalPrice();
		});
		
		
		
	});

// ===========================================================
// 최종 후원금액 출력
	function updateTotalPrice() {
		let rewardQuantity = parseFloat($("#rewardQuantity").val());
	    let rewardPrice = parseFloat(document.getElementById("rewardPrice").innerText);
	    let deliveryPrice = parseFloat(document.getElementById("rewardDeliveryPrice").innerText);
	    let couponPrice = parseFloat(document.getElementById("couponPrice").innerText);
	    let addDonationAmount = parseFloat(document.getElementById("addDonationAmount").innerText);
	
	    let totalPrice = rewardPrice + deliveryPrice + addDonationAmount - couponPrice;
	    document.getElementById("totalPrice").innerText = totalPrice;
	    $("#total_amount").val(totalPrice);
	}
// ===========================================================
// 계좌인증
	$(document).ready(function() {
		$("#btnAccountAuth").on("click", function() {
			// 새 창에서 사용자 인증 페이지 요청
			let requestUri = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
					+ "response_type=code"
					+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
					+ "&redirect_uri=http://localhost:8089/test/callbackMember" // 서버주소 변경필요!
					+ "&scope=login inquiry transfer oob"
					+ "&state=12345678901234567890123456789012"
					+ "&auth_type=0";
			window.open(requestUri, "authWindow", "width=600, height=800");
		});
	});	

// ===========================================================
// 후원하기 버튼 클릭(submit)시 배송지 정보가 없을경우 경고창
// 체크박스 체크되지 않으면 경고창
	function validateForm() {
		let deliveryIdx = document.getElementById("delivery_idx").value;
		let personalInfoAgree = document.getElementById("personalInfoAgree");
		let notesCheck = document.getElementById("notesCheck");
		
		if (deliveryIdx === "") {
		    alert("배송지를 등록해주세요!");
		    return false;
		}
		if(!personalInfoAgree.checked) {
			alert("개인정보 제3자 제공 동의를 체크해주세요!");
			return false;
		}
		if(!notesCheck.checked) {
			alert("후원 유의사항 확인을 체크해주세요!");
			return false;
		}
		return true;
	}

// ===========================================================
// 개인정보 제3자 제공동의 체크시 내용보기 모달창 버튼 클릭
	$(document).ready(function() {
		$("#personalInfoAgree").on("change", function() {
			if ($(this).is(":checked")) {
				$("#personalInfoAgreeModalOpen").click();
			}
		});
	});

// ===========================================================
// 후원 유의사항 체크시 열기 버튼 클릭
	$(document).ready(function() {
		$("#notesCheck").on("change", function() {
			if ($(this).is(":checked")) {
				$("#notesOpen").click();
			}
		});
	});
// ===========================================================
// 리워드 수량 증가/감소 버튼
    $(document).on('click', '#rewardQuantityUp', function() {
        let rewardQuantity = parseInt($("#rewardQuantity").val());
        let maxRewardQuantity = parseInt($("#maxRewardQuantity").val());
        // 리워드 총금액
        let rewardPrice = parseInt(document.getElementById("rewardPrice").innerText);
        let reward = parseInt(document.getElementById("reward").innerText);
        
        rewardQuantity += 1;
        rewardPrice = reward * rewardQuantity;
        if(rewardQuantity > maxRewardQuantity) {
            alert("주문수량을 초과했습니다");
            rewardQuantity = maxRewardQuantity;
            rewardPrice = reward * maxRewardQuantity;
        }
        $("#rewardQuantity").val(rewardQuantity);
        $("#payment_quantity").val(rewardQuantity);
        $("#rewardPrice").html(rewardPrice);
        updateCouponSale();
        updateTotalPrice();
    });

    $(document).on('click', '#rewardQuantityDown', function() {
        let rewardQuantity = parseInt($("#rewardQuantity").val());
        let maxRewardQuantity = parseInt($("#maxRewardQuantity").val());
        // 리워드 총금액
        let rewardPrice = parseInt(document.getElementById("rewardPrice").innerText);
        let reward = parseInt(document.getElementById("reward").innerText);
        
        rewardQuantity -= 1;
        rewardPrice = reward * rewardQuantity;
        if(rewardQuantity < 1) {
            alert("1개 이상 주문가능합니다");
            rewardQuantity = 1;
            rewardPrice = reward;
        }
        $("#rewardQuantity").val(rewardQuantity);
        $("#payment_quantity").val(rewardQuantity);
        $("#rewardPrice").html(rewardPrice);
        updateCouponSale();
        updateTotalPrice();
    });

// ===========================================================
// 카드결제/계좌결제 라디오박스 체크시

$(document).ready(function () {
	
	// 스크롤바 가장 아래로 내리기
    function scrollToBottom() {
        window.scrollTo(0, document.body.scrollHeight);
    }

    function togglePaymentArea(radioElement, paymentAreaElement, paymentMethodValue) {
        if (radioElement.checked) {
            paymentAreaElement.classList.remove("d-none");
            paymentAreaElement.classList.add("d-block");
            document.getElementById("payment_method").value = paymentMethodValue;
            scrollToBottom();
        } else {
            paymentAreaElement.classList.remove("d-block");
            paymentAreaElement.classList.add("d-none");
        }
    }
	
    // 라디오 버튼 클릭 이벤트 리스너 추가
    let cardPaymentRadio = document.getElementById("card_payment");
    let cardPaymentArea = document.getElementById("card_payment_area");
    cardPaymentRadio.addEventListener("click", function() {
        togglePaymentArea(cardPaymentRadio, cardPaymentArea, "1");
        togglePaymentArea(accountPaymentRadio, accountPaymentArea, "");
    });
	
    let accountPaymentRadio = document.getElementById("account_payment");
    let accountPaymentArea = document.getElementById("account_payment_area");
    accountPaymentRadio.addEventListener("click", function() {
        togglePaymentArea(accountPaymentRadio, accountPaymentArea, "2");
        togglePaymentArea(cardPaymentRadio, cardPaymentArea, "");
    });
	
    // 페이지 로드시 모든 결제 영역 숨기기
    togglePaymentArea(cardPaymentRadio, cardPaymentArea, "1");
    togglePaymentArea(accountPaymentRadio, accountPaymentArea, "1");
});



// ===========================================================