<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bootstrap demo</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    tr {
      vertical-align: middle;
    }
        /* 각 별들의 기본 설정 */
        .starR{
        display: inline-block;
        width: 30px;
        height: 30px;
        color: transparent;
        text-shadow: 0 0 0 #f0f0f0;
        font-size: 1.8em;
        box-sizing: border-box;
        cursor: pointer;
        }

        /* 별 이모지에 마우스 오버 시 */
        .starR:hover {
        text-shadow: 0 0 0 #ccc;
        }

        /* 별 이모지를 클릭 후 class="on"이 되었을 경우 */
        .starR.on{
        text-shadow: 0 0 0 #ffbc00;
        }
        
    	footer {
    		position: fixed;
			bottom: 0;
			left: 0;
			width: 100%;
			padding: 10px;
    	}
    </style>
  <script type="text/javascript">
  	
  //모달 창 처리
  function modal(num) {
	
	  $.ajax({
		 type:"post",
		 url:"FunDingModal",
		 data:{payment_idx:num},
		 dataType:"json",
  		success: function(items) {
  			
			$("#modal_content").empty();
			$("#modal_content").append(
			'<div class="modal-header">'
	        +  '<h5 class="modal-title">' + items.project_subject + '</h5>'
	        +  '<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'
	        +'</div>'
	        +'<div class="modal-body">'
	        +  '<div class="text-center">'
	        +  '<img src="discord-avatar-512-T50N7.png" style="width: 50%;">'
	        +  '</div>'
	        +  '<table class="table mt-5">'
	        +   '<tbody>'
	        +      '<tr>'
	        +        '<th scope="row" style="width: 20%;">주문번호</th>'
	        +        '<td style="width: 80%;">${items.payment_idx }</td>'
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row">리워드명</th>'
	        +        '<td>' + items.reward_name + '</td>'
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row">리워드 설명</th>'
	        +        '<td>' + items.reward_detail + '</td>'
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row">리워드 옵션</th>'
	        +        '<td>'
	        +          items.reward_option
	        +        '</td>'
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row">주문날짜</th>'
	        +        '<td>'+ convertDate(items.payment_date) + '</td>'
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row">배송지</th>'
	        +        '<td>' + items.delivery_add + ' '+ items.delivery_detailadd + '</td>'
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row">운송장번호</th>'
	        +        '<td>' + items.waybill_num + '</td>'
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row delevery">배송상황</th>'
	        +        (items.delivery_status == 1 ? '<td>미발송</td>' : (items.delivery_status == 2 ? '<td class="delevery">배송중</td>' : '<td>배송완료</td>'))
	        +      '</tr>'
	        +      '<tr>'
	        +        '<th scope="row">총가격</th>'
	        +       ' <td>' + items.total_amount + ' 원</td>'
	        +      '</tr>'
	        +    '</tbody>'
	        +  '</table>'
	        +'</div>'
	        +'<div class="modal-footer">'
	        +  (items.delivery_status == 2 ? '<button type="button" id="deliveryBtn" onclick="isDelivery('+ items.payment_idx +')"; class="btn btn-outline-primary">배송완료</button>' : '')
	        +  (items.delivery_status == 3 && items.review_idx == null ? '<button type="button" class="btn btn-outline-primary" onclick="IdxNum('+items.payment_idx+')" data-bs-toggle="modal" data-bs-target="#reviewmodify">리뷰작성</button>' : '')
	        +  (items.delivery_status == 2 ? '<button type="button" class="btn btn-outline-primary">배송확인하기</button>' : '')
	        +  (items.payment_confirm == 2 && items.delivery_status == 3 ? '<button type="button" class="btn btn-primary" onclick="IdxNum('+items.payment_idx+')" data-bs-toggle="modal" data-bs-target="#cancelModal">반환신청</button>' : '')
	        +  '<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>'
	        + '</div>'		
			);
		},
		error: function() {
			alert("오류");
		}
	  });
	  
	  
	  
	}
  // 날짜 변환기
  function convertDate(milliSecond) {
	  const data = new Date(milliSecond);  //Date객체 생성

	  const year = data.getFullYear();    //0000년 가져오기
	  const month = data.getMonth() + 1;  //월은 0부터 시작하니 +1하기
	  const date = data.getDate();        //일자 가져오기

	  return year + '-' + month + '-' + date;
	}
  
  $(function() {
	  pageing(1,0);

	  
	});
  
	// 페이징 처리
  	function pageing(pageNum, payment_confirm) {
	
	  
// 		alert(pageNum+ ", " +payment_confirm);
		
	  	$.ajax({
	  		type:"post",
	  		url:"MemberFundingPageing",
	  		data:{pageNum:pageNum, payment_confirm:payment_confirm},
	  		dataType:"json",
	  		success: function(data) {
				$("#tbody").empty();
				
				let page = data.pageInfo;
				if(page.maxPage != 0){
					for (let map of data.map) {
						  $("#tbody").append(
						    '<tr>'
						    + '<th scope="row">' + map.payment_idx + '</th>'
						    + '<td><a href="fundingDetail?project_idx='+map.project_idx+'"style="text-decoration: none; color: black;">' + map.project_subject + '<a></td>'
						    + '<td> ' + map.payment_quantity + '</td>'
						    + '<td> ' + map.total_amount + '</td>'
						    + (map.payment_confirm == 1 ? '<td id="payConfirm'+ map.payment_idx +'">예약완료</td>' : (map.payment_confirm == 2 ? '<td id="payConfirm'+ map.payment_idx +'">결제완료</td>' : (map.payment_confirm == 3 ? '<td>반환신청</td>' : (map.payment_confirm == 4 ? '<td>반환완료</td>' : '<td>반환거절</td>'))))
						    + (map.delivery_status == 1 ? '<td>미발송</td>' : (map.delivery_status == 2 ? '<td class="delevery">배송중</td>' : '<td>배송완료</td>'))
						    + '<td><button class="btn btn-primary" onclick="modal(' + map.payment_idx + ')" data-bs-toggle="modal" data-bs-target=".exampleModal">상세보기</button></td>'
						    + '</tr>'
						  );
						}
					
					$("#toolbar").empty();
					
// 						if(pageNum != 1){
// 							$("#toolbar").append(
// 								    '<button type="button" class="btn btn-outline-primary" onclick="pageing(1 ,' + payment_confirm + ')">&lt;&lt;</button>');
// 						}
						if(pageNum != 1){
							$("#toolbar").append(
								    '<button type="button" class="btn btn-outline-primary" onclick="pageing(' + (pageNum - 1) + ',' + payment_confirm + ')">&lt;</button>');
						}
						for (let i = page.startPage; i <= page.endPage; i++) {
						    $("#toolbar").append(
						        '<button type="button" class="' + (pageNum == i ? 'btn btn-primary' : 'btn btn-outline-primary') + '" onclick="pageing(' + i + ',' + payment_confirm + ')">' + i + '</button>'
						    );
						}
						
						if(pageNum != page.maxPage){
							$("#toolbar").append(
							    '<button type="button" class="btn btn-outline-primary" onclick="pageing(' + (pageNum + 1) + ',' + payment_confirm + ')">&gt;</button>'
							);
						}
// 						if(pageNum != page.maxPage){
// 							$("#toolbar").append(
// 							    '<button type="button" class="btn btn-outline-primary" onclick="pageing(' + page.maxPage + ',' + payment_confirm + ')">&gt;&gt;</button>'
// 							);
// 						}
					} else if(payment_confirm == 0 || page.maxPage == 0){
						$("#tbody").empty();
						$("#thead").empty();
						$("#tbody").append(
							'<th scope="row" colspan="7" class="mt-5"> <h4> 아직 참여하신 펀딩이 없습니다! </h4><br>'
							+ '<a href="fundingDiscover"style="text-decoration: none; color: black;"><h5>펀딩하러 가기</h5></a> </th>'
						);
					}

			},
			error: function() {
				alert("에러");
			}
	  	});  	
	}
  
	function IdxNum(num) {
		
		$("#cancel_idx").val(num);
		
	}
	

  
  </script>
</head>
<body>
    <%@ include file="../Header.jsp" %>
  <div class="row justify-content-center" style="margin-bottom: 100px; margin-top: 100px;" id="mainRow">
    <div class="col-12 col-lg-8">
      <h3><strong>참여내역</strong></h3>
      <select class="form-select my-4 w-25" onchange="pageing(1,this.value)">
        <option value="0">전체</option>
        <option value="1">예약완료</option>
        <option value="2">결제완료</option>
        <option value="3">반환신청</option>
        <option value="4">반환완료</option>
        <option value="5">반환거절</option>
      </select>

      <table class="table text-center" id="fundingTable">
        <thead id="thead" >
          <tr>
            <th scope="col">주문번호</th>
            <th scope="col">프로젝트</th>
            <th scope="col">주문수량</th>
            <th scope="col">총가격</th>
            <th scope="col">결제승인</th>
            <th scope="col">배송여부</th>
            <th scope="col">상세보기</th>
          </tr>
        </thead>
        <tbody id="tbody">
       
        </tbody>
      </table>
	      <div class="btn-toolbar justify-content-center" role="toolbar" aria-label="Toolbar with button groups">
			  <div class="btn-group me-2" id="toolbar" role="group" aria-label="First group">			
			  </div>
    	</div>
  	</div>
  </div>
  
<!-- 상세보기 모달창 -->
  <div class="modal fade exampleModal"  aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content" id="modal_content">

      </div>
    </div>
  </div>
  	
 

<!-- 취소 사유 모달창 -->
<div class="modal fade" id="cancelModal" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">반환 신청</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
			<textarea class="form-control" rows="5" cols="60" id="cancelContext" ></textarea>		
			<input type="file" id="cancelFile" class="form-control mt-2" accept="image/*">
			<input type="hidden" id="cancel_idx">
      </div>
      <div class="modal-footer">
        <button type="button" id="cancelBtn" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">반환신청</button>
      </div>	
    </div>
  </div>
</div>
  
  	<!-- 리뷰작성 메서드 -->
      <div class="modal" id="reviewmodify" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5">리뷰 수정</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                    <table>
                        <tr>
                            <th>별점</th>
                            <td>
                                <div class="starRev">
                                    <!-- 편의 상 가장 첫번째의 별은 기본으로 class="on"이 되게 설정해주었습니다. -->
                                    <span class="starR on">⭐</span>
                                    <span class="starR">⭐</span>
                                    <span class="starR">⭐</span>
                                    <span class="starR">⭐</span>
                                    <span class="starR">⭐</span>
                                </div>
                                <!-- 나중에 폼 전송시에는 type을 hidden으로 바꾸면 됨, 지금은 확인해야하니 text로 함-->
                                <input type="hidden" value="1" id="starRating" name="starRating">
	                            <script>
	                                <!-- 별점 jQuery -->
	                                $('.starRev span').click(function(){
	                                $(this).parent().children('span').removeClass('on');
	                                $(this).addClass('on').prevAll('span').addClass('on');
	                                return false;
	                                });
	                                let starCount = 0; // 별점을 저장할 변수 선언
	                                $(".starRev span").click(function(e) { // 콜백함수에 파라미터 추가
	                                    e.preventDefault(); // a태그 기본 동작 방지
	                                    // 실제 클릭된 이벤트 요소(e.currentTarget)의 인덱스를 가져옴
	                                    // index는 0부터 시작이니 +1을 해주면 됨
	                                    let index = $(e.currentTarget).index() + 1; 
	//                                     console.log($(e.currentTarget).index()); // 콘솔 확인용
	                                    starCount = index;
	                                    $("#starRating").val(starCount); // 전송할 폼의 input에 값을 넣음
	                                });
	                                <!-- 별점 jQuery -->
	
	                            </script>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td><textarea cols="50" rows="5" name="content" id="reviewContent"></textarea></td>
                        </tr>
                         <tr>
                            <td colspan="2"><input type="file" id="reviewFile" class="form-control mt-2" accept="image/*"></td>
                        </tr>
                    </table>
            </div>
            <div class="modal-footer">
              <button type="button" id="reivewRegistration" class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">리뷰작성</button>
              <button type="button" class="btn btn-primary" data-bs-dismiss="modal">취소</button>
            </div>
          </div>
        </div>
    </div>
  
 	<script type="text/javascript">
	  
	  	function isDelivery(num) {
			
	  		Swal.fire({
	  		  title: '정말 배송 완료되었나요?',
	  		  icon: 'warning',
	  		  showCancelButton: true,
	  		  confirmButtonColor: '#3085d6',
	  		  cancelButtonColor: '#d33',
	  		  confirmButtonText: '네! 배송이 완료 되었어요!',
	  		  cancelButtonText: '아니오! 아직이요!'
	  		}).then((result) => {
	  		  if (result.isConfirmed) {
	  			
	  			  $.ajax({
	  				 type:"post",
	  				 url:"deleveryComplete",
	  				 data:{payment_idx:num},
	  				 dataType:"text",
	  				 success: function(data) {
						
	  					 if(data == "true"){
	  						$('.delevery').empty();
	  						$('.delevery').append(
	  							"배송완료"		
	  						);
	  						$('#deliveryBtn').remove();
	  					 } else {
							alert("실패");
	  					 }
	  					 
					 },
					 error: function() {
						alert("오류");
					 }
	  				 
	  			  });
					  		    
	  		  }
	  		})
		}
		
		$("#cancelfile").change(function() {
			  // 선택된 파일 가져오기
			  var file = this.files[0];

			  if (file) {
			    // 파일 확장자 가져오기
			    var fileExtension = file.name.split(".").pop().toLowerCase();

			    // 이미지 파일 확장자 확인 (여기에 원하는 이미지 확장자를 추가할 수 있습니다.)
			    var allowedExtensions = ["jpg", "jpeg", "png", "gif"];

			    if (allowedExtensions.indexOf(fileExtension) === -1) {
			      // 이미지가 아닌 경우 경고 메시지 표시
			      Swal.fire({
					  icon: 'error',
					  title: '이미지 파일이 아닙니다!',
					  text: '이미지 파일을 올려주세요!',
					})
			      // 파일 선택 input 초기화
			      $("#cancelfile").val("");
			    }
			  }
			});
		
		$("#cancelBtn").click(function() {
			
			var formData = new FormData();
			var fileInput = $("#cancelFile").get(0);
			var file = fileInput.files[0];
			var context = $("#cancelContext").val();
			var cancel_idx= $("#cancel_idx").val();
			
			formData.append("file", file);
			formData.append("context", context);
			formData.append("cancel_idx", cancel_idx);
			
			if(file == null || context == "" || context == null){
				Swal.fire({
          			  icon:'error',
          			  text:'취소사유와 증빙이미지는 필수입니다!'
				})
          			
          			return false;
			}
			
			
			 $.ajax({
			        url: "cancellationRequest",
			        type: "POST",
			        data: formData,
			        contentType: false,
			        processData: false,
			        success: function(data) {
			            if(data == "true"){
			            	Swal.fire({
			            			icon:'success',
			            			text:'취소 신청이 되었습니다!'
			            	})
			            	
			            	$("#cancelContext").val("");
			            	$("#cancelFile").val("");
			            	
			            	$("#payConfirm" + cancel_idx).empty();
			            	$("#payConfirm" + cancel_idx).append("반환신청");	            	
			            } else {
				            	Swal.fire({
			            			icon:'error',
			            			text:'취소 신청이 실패되었습니다.'
			            	})
			            }
			        },
			        error: function() {
				        	Swal.fire({
		            			icon:'error',
		            			text:'취소 신청이 실패되었습니다.'
		            	})
			        }
		});
		})
		
		$("#reviewFile").change(function() {
			  // 선택된 파일 가져오기
			  var file = this.files[0];

			  if (file) {
			    // 파일 확장자 가져오기
			    var fileExtension = file.name.split(".").pop().toLowerCase();

			    // 이미지 파일 확장자 확인 (여기에 원하는 이미지 확장자를 추가할 수 있습니다.)
			    var allowedExtensions = ["jpg", "jpeg", "png", "gif"];

			    if (allowedExtensions.indexOf(fileExtension) === -1) {
			      // 이미지가 아닌 경우 경고 메시지 표시
			      Swal.fire({
					  icon: 'error',
					  title: '이미지 파일이 아닙니다!',
					  text: '이미지 파일을 올려주세요!',
					})
			      // 파일 선택 input 초기화
			      $("#reviewFile").val("");
			    }
			  }
			});
		
	$("#reivewRegistration").click(function() {
		var formData = new FormData();
		var payment_idx= $("#cancel_idx").val();
		var starRating = $("#starRating").val();
		var reviewFile = $("#reviewFile").get(0);
		var reviewContent = $("#reviewContent").val();
		var file = reviewFile.files[0];
		
		if(file == null || reviewContent == "" || reviewContent == null){
			Swal.fire({
      			  icon:'error',
      			  text:'리뷰작성시 내용과 사진은 필수입니다!'
			})
			return false;
		}
		
		formData.append("file", file);
		formData.append("context", reviewContent);
		formData.append("payment_idx", payment_idx);
		formData.append("starRating", starRating);
		
		 $.ajax({
		        url: "reivewRegistration",
		        type: "POST",
		        data: formData,
		        contentType: false,
		        processData: false,
		        success: function(data) {
		            if(data == "true"){
		            	Swal.fire({
		            			icon:'success',
		            			text:'리뷰작성이 완료었습니다!'
		            	})
		            	
                        $("#starRating").val("");
                        $("#reviewFile").val("");
                        $("#reviewContent").val("");
		            	
		            } else {
			            	Swal.fire({
		            			icon:'error',
		            			text:'리뷰작성이 실패되었습니다.'
		            	})
		            	
                        $("#starRating").val("");
	                        $("#reviewFile").val("");
	                        $("#reviewContent").val("");
		            }
		        },
		        error: function() {
			        	Swal.fire({
	            			icon:'error',
	            			text:'리뷰작성이 실패되었습니다.'
	            	})
	            	
                    $("#starRating").val("");
                    $("#reviewFile").val("");
                    $("#reviewContent").val("");
		        }
	});
		
	});
 	</script>
 	
 	
 	
<footer>
	<%@ include file="../Footer.jsp" %>
</footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
    crossorigin="anonymous"></script>
</body>

</html>