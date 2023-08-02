<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
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
    <div class="row justify-content-center" style="margin-top: 100px;">
      <div class="col-12 col-md-8">
        <h3><strong>내가 작성한 리뷰</strong></h3>
        <div class="row" id="reviewListArea">
          <div class="col-12 col-xxl-3 col-sm-6 col-lg-4">
            <div class="card" style="width: 18rem;">
              <img src="discord-avatar-512-T50N7.png" class="card-img-top">
              <div class="card-body">
                <h5 class="card-title box">아트감성을 담은 수제장식품 제작</h5>
                <p class="card-text h6 box1">아트감성 수제장식품 제작 리워드1</p>
                <hr>
                <p class="card-text">너무 좋아요 하하</p>
                <a href="#" class="btn btn-primary">Go somewhere</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	let pageNum = 1;
	let maxPage = 1;

	$(function() {
		let searchType = $("#searchType").val();
		let searchKeyword = $("#searchKeyword").val();
		
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
				data:pageNum,
				dataType:"json",
				success: function(data) {
					maxPage = data.maxPage
					console.log(maxPage);
					
					for(let review of data.ReveiwList){
						$("#reviewListArea").
					}
					
					
				},
				error: function() {
					alert("실패");
				}
			});
			
		}
	});
</script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
  </body>
</html>