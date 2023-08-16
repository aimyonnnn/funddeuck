<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <title>Document</title>
    <%@ include file="../Header.jsp" %>
    <style type="text/css">
        .text-black {
            text-decoration: none;
            width: 15%;
        }

        .f7 {
            font-size: 0.7em;
        }
    </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript">
        
		let pageNum = 1; // 기본 페이지 번호 미리 저장
		let maxPage = 1; // 최대 페이지 번호 미리 저장
		
	$(function() {
		
		ZimPostList();
		
		$(window).on("scroll", function() { // 스크롤 동작 시 이벤트 처리
			
			let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
			let windowHeight = $(window).height(); // 브라우저 창의 높이
			let documentHeight = $(document).height(); // 문서의 높이(창의 높이보다 크거나 같음)
			let x = 1;
			if(scrollTop + windowHeight + x >= documentHeight) {
				if(pageNum < maxPage) {
					pageNum++;
					ZimPostList();
				} else {
					
				}
			}
			
		});
	});
        
        
		function ZimPostList() {
        		$.ajax({
        			type:"post",
        			url:"ZimPostList",
        			data:{pageNum:pageNum},
        			dataType:"json",
        			success: function(data) {
        				
        				console.log(JSON.stringify(data));
        				maxPage = data.maxPage;
        				
    					if(maxPage == 0){
    						$("#rowArea").append(
    							    '<div class="col-12 mt-5 text-center" style="padding-bottom: 300px;"> <h4> 아직 찜한 프로젝트의 소식이 없습니다! </h4></div>'
    						);
    						return false;
    					}
        				
        				for(let zimPost of data.zimPostList){
        					$("#rowArea").after(
        						'<div class="row">'
							    +    '<div class="col"></div>'
								+    '<div class="col-12 col-sm-8 col-lg-6 m-3" style="border: 1px solid #eeeeee;">'
								+    	'<div class="row align-items-center">'
								+	    	'<div class="col">'
								+		        '<div class="row">'
								+		        	'<div class="col" style="font-size: 0.7em;">'
								+						zimPost.maker_board_regdate
								+					'</div>'
								+		        '</div>'
								+		        '<div class="row">'
								+		            '<div class="row my-3">'
								+		                '<div class="col-1 me-3 h5 text-primary">'
								+		                    '<img class="center" style="width: 30px; height: 30px; border-radius: 50%;">'
								+		                '</div>'
								+		                '<div class="col" style="font-size: 0.7em;">'
								+		                    '<div class="row">'
								+		                        '<a href="makerDetail?maker_idx='+ zimPost.maker_idx +'" style="color:black; text-decoration:none;">' + zimPost.maker_name + '</a>'
								+		                    '</div>'
								+		                    '<div class="row">'
								+		                        '팔로워 ' + zimPost.maker_follow_count 
								+		                    '</div>'
								+		                '</div>'
								+		            '</div>'
								+		        '</div>'
								+		        '<div class="row">'
								+		            '<div class="col-12">'
								+		                '<a href="fundingDetail?project_idx='+ zimPost.project_idx +'" style="color:black; text-decoration:none;">' + zimPost.project_subject + '</a>'
								+		            '</div>'
								+		            '<div class="col-12 my-1">'
								+		                '<hr>'
								+						'<div class="row h5">'
								+							zimPost.maker_board_subject
								+						'</div>'
								+						'<div class="row">'
								+							zimPost.maker_board_content
								+						'</div>'
								+						'<div class="row mt-4">'
								+		                    '<img src="${pageContext.request.contextPath}/resources/upload/'+ zimPost.maker_board_file1 +'">'
								+						'</div>'
								+		           ' </div>'
								+		        '</div>'
								+	        '</div>'
								+       '</div>'
								+ 	 '</div>'
							    +	'<div class="col"></div>'
								+	'</div>'		
        					);
        				}
						
					},
					error: function() {
						alert("오류");
					}
        			
        		});
		}		
        </script>
</head>
<body>
    <!-- cupon 페이지 시작 -->
    <div class="row" style="margin-top: 100px;">
    <div class="col"></div>
    <div class="col-12 col-md-8 col-lg-6 mt-5">
        <div class="row">
            <h2><b>찜하신 프로잭트의 최근 소식입니다!</b></h2>
        </div>
        <!-- 메뉴 선택 -->
        <div class="row mt-4 text-center">
            <div class="col col-sm-3 col-lg-2 py-3">
                <a href="ZimForm" class="text-black"> 찜 목록 </a>
            </div>
            <div class="col col-sm-3 col-lg-2 py-3" style="border-bottom: solid 1px #ff9300;">
                <a href="zimFollowBoard" class="text-black"> 최근 소식 </a>
            </div>
        </div>
    </div>
    <div class="col"></div>
    </div>
    <div class="col" id="rowArea"></div>


<%@ include file="../Footer.jsp" %>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"></script>
</body>

</html>