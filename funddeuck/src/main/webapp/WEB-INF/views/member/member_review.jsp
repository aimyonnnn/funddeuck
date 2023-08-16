<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>리뷰 목록</title>
    <%@ include file="../Header.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    .box {
      width: 200px;
      
      /* 특정 단위로 텍스트를 자르기 위한 구문 */
      white-space: normal;
      display: -webkit-box;
      -webkit-line-clamp: 2; /* 텍스트를 자를 때 원하는 단위 ex) 3줄 */
      -webkit-box-orient: vertical;
      overflow: hidden;  
    }
    .box1 {
      width: 200px;
      
      /* 특정 단위로 텍스트를 자르기 위한 구문 */
      white-space: normal;
      display: -webkit-box;
      -webkit-line-clamp: 1; /* 텍스트를 자를 때 원하는 단위 ex) 3줄 */
      -webkit-box-orient: vertical;
      overflow: hidden;  
    }
  </style>
  </head>
  <body>
    <div class="row justify-content-center" style="margin-top: 100px; margin-bottom: 300px;">
      <div class="col-12 col-md-8 mt-5">
        <h3><strong>내가 작성한 리뷰</strong></h3>
        <div class="row" id="reviewListArea">
        </div>
      </div>
    </div>
    

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	function deleteReview(num) {
		
		Swal.fire({
			  title: '정말 삭제하시겠습니까?',
			  text: "리뷰를 삭제하면 다시 작성할 수 없습니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '네 삭제할게요!',
			  cancelButtonText: '삭제 안할래요..'
			}).then((result) => {
			  if (result.isConfirmed) {
				  
					$.ajax({
						type:"post",
						url:"reviewMemberDelete",
						data:{num:num},
						dataType:"text",
						success: function(data) {
							
							if(data == "true"){
								  Swal.fire({
									  title: '삭제가 완료되었습니다!',
									  icon: 'success',
									  confirmButtonColor: '#3085d6',
									  confirmButtonText: '확인'
									}).then((result) => {
									  if (result.isConfirmed) {
										location.href="reviewListPage";					
									  }
									})
							} else {
							alert("실패");
							}
							
						},
						error: function() {
							alert("실패");
						}
					});
				  

			  }
			})
		

	}

	let pageNum = 1;
	let maxPage = 1;

	$(function() {
		
		loadReviewList();
		$(window).on("scroll", function() {
			console.log("scroll");
			let scrollTop = $(window).scrollTop();
			let windowHeight = $(window).height();
			let documentHeight = $(document).height();
			let x = 30;
			if(scrollTop + windowHeight + x >= documentHeight){
				if(pageNum < maxPage){
					pageNum ++;
					loadReviewList();
				}
			}
		});
		
		function loadReviewList() {
			
			$.ajax({
				type:"POST",
				url:"MemberReveiwList",
				data:{pageNum:pageNum},
				dataType:"json",
				success: function(data) {
					maxPage = data.maxPage
					console.log(data);
					
					if(maxPage == 0){
						$("#reviewListArea").append(
							    '<div class="col-12 mt-5 text-center" style="padding-bottom: 300px;"> <h4> 아직 리뷰가 없습니다! </h4></div>'
						);
						return false;
					}
					
					for(let review of data.ReveiwList){
						$("#reviewListArea").append(
						'<div class="col-12 col-xxl-3 col-sm-6 col-lg-4">'
				        +    '<div class="card" style="width: 18rem;">'
				        +      '<img src="${pageContext.request.contextPath}/resources/upload/'+review.saveFileName +'" class="card-img-top">'
				        +      '<div class="card-body">'
				        +        '<h5 class="card-title box"><a href="fundingDetail?project_idx='+review.project_idx+'">'+ review.project_subject +'</a></h5>'
				        +        '<p class="card-text h6 box1">'+review.reward_name+'</p>'
				        +        '<hr>'
				        +        '<p class="card-text">'+ review.review_content +'</p>'
				        +        '<button onclick="deleteReview('+review.review_idx+')" class="btn btn-primary">삭제하기</button>'
				        +      '</div>'
				        +    '</div>'
				        +  '</div>'
						);
					}
					
					
				},
				error: function() {
					alert("실패");
				}
			});
			
			
		}
	});
</script>
        <%@ include file="../Footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
  </body>
</html>