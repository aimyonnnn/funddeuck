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
        
/*         footer { */
/*  			width: 100%;  */
/* 			height: auto;  */
/*  			padding: 1rem; */
/*  			position: absolute; */
/*  			bottom: 0; */
/*  			left: 0; */
/* 		} */
    </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript">
        function zimAlam(isAlam,project_idx){
	
        	$.ajax({
        		type:"post",
        		url:"zimAlam",
        		data:{isAlam : isAlam,
        			project_idx : project_idx},
        		dataType : "text",
        		success: function(data) {
        			
        			if(data = "true"){
        				if(isAlam == 1){
	        				$("#zimBtnArea"+project_idx).empty();
	        				$("#zimBtnArea"+project_idx).append(
	        					'<button class="btn btn-outline-primary" onclick="zimAlam(0,'+ project_idx +')"><i class="bi bi-bell"></i></button>'	
	        					+'<button class="btn btn-outline-primary ms-1"><i class="bi bi-suit-heart-fill"></i></button>'
	        				);
        				} else {
	        				$("#zimBtnArea"+project_idx).empty();
	        				$("#zimBtnArea"+project_idx).append(
	        					'<button class="btn btn-outline-primary" onclick="zimAlam(1,'+ project_idx +')"><i class="bi bi-bell-slash"></i></button>'	
	        					+'<button class="btn btn-outline-primary ms-1"><i class="bi bi-suit-heart-fill"></i></button>'
	        				);
        				}
        			} else {
        				alert("실패");
        			}
        			
				},
				error: function() {
					alert("오류!");
				}
        	});
        	
        	
        }
        
        function zim(is_zim,project_idx) {
			
        	$.ajax({
        		type:"post",
        		url:"isZim",
        		data:{is_zim:is_zim,
        			project_idx:project_idx},
        		dataType: "text",
        		success: function(data) {
					
        			if(data = "true"){
        				if(is_zim == 1){
	        				$("#zimBtnArea"+project_idx).empty();
	        				$("#zimBtnArea"+project_idx).append(
	        					'<button class="btn btn-outline-primary" onclick="zimAlam(0,'+ project_idx +')"><i class="bi bi-bell"></i></button>'	
	        					+'<button class="btn btn-outline-primary ms-1" onclick="zim(0, '+ project_idx +')"><i class="bi bi-suit-heart-fill"></i></button>'
	        				);
        				} else {
	        				$("#zimBtnArea"+project_idx).empty();
	        				$("#zimBtnArea"+project_idx).append(
	        					'<button class="btn btn-primary" onclick="zim(1, '+ project_idx +')"><i class="bi bi-suit-heart"></i></button>'
	        				);
        				}
        			} else {
        				alert("실패");
        			}
        			
				},
				error: function() {
					alert("오류!");
				}
        	});
		}
        
        let pageNum = 1; // 기본 페이지 번호 미리 저장
    	let maxPage = 1; // 최대 페이지 번호 미리 저장
    	
    		$(function() {
    			
    			memberZimList();
    			
    			$(window).on("scroll", function() { // 스크롤 동작 시 이벤트 처리
    				
    				let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
    				let windowHeight = $(window).height(); // 브라우저 창의 높이
    				let documentHeight = $(document).height(); // 문서의 높이(창의 높이보다 크거나 같음)
    				let x = 1;
    				if(scrollTop + windowHeight + x >= documentHeight) {
    					if(pageNum < maxPage) {
    						pageNum++;
    						memberZimList();
    					} else {
    						
    					}
    				}
    				
    			});
    		});
    	
    	function memberZimList() {
			
    		$.ajax({
    			type:"post",
    			url:"memberZimList",
    			data:{pageNum:pageNum},
    			dataType:"json",
    			success: function(data) {
					
					console.log(JSON.stringify(data));
					maxPage = data.maxPage;
					
					
					if(maxPage == 0){
						$("#zimListArea").append(
							    '<div class="col-12 mt-5 text-center" style="padding-bottom: 300px;"> <h4> 아직 찜 한 프로잭트가 없습니다! </h4></div>'
						);
						return false;
					}
					
					var html = '';
					for (let zim of data.zimList) {
					    html += '<div class="row">' +
					        '<div class="col"></div>' +
					        '<div class="col-12 col-sm-8 col-lg-6 m-3" style="border: 1px solid #eeeeee;">' +
					            '<div class="row align-items-center">' +
					                '<div class="col">' +
					                    '<div class="row">' +
					                        '<div class="row my-3">' +
					                            '<div class="col-1 me-3 h5 text-primary">' +
					                                '<img class="center" style="width: 30px; height: 30px; border-radius: 50%;">' +
					                            '</div>' +
					                            '<div class="col" style="font-size: 0.7em;">' +
					                                '<div class="row">' +
					                                    '<a href="makerDetail?maker_idx=' + zim.maker_idx + '" style="color:black; text-decoration:none;">' + zim.maker_name + '</a>' +
					                                '</div>' +
					                                '<div class="row">' +
					                                    '팔로워 ' + zim.follow_count +
					                                '</div>' +
					                            '</div>' +
					                        '</div>' +
					                    '</div>' +
					                    '<div class="row">' +
					                        '<div class="col-12">' +
					                            '<a href="fundingDetail?project_idx=' + zim.project_idx + '" style="color:black; text-decoration:none;">' + zim.project_subject + '</a>' +
					                        '</div>' +
					                        '<div class="col-12 mt-1" style="font-size: 0.9em;">' +
					                            zim.project_introduce +
					                        '</div>' +
					                        '<div class="col-12 my-1">' +
					                            '<img src="${pageContext.request.contextPath}/resources/upload/'+ zim.project_thumnails1 +'" width="20">' +
					                        '</div>' +
					                    '</div>' +
					                '</div>' +
					                '<div class="col text-end" id="zimBtnArea' + zim.project_idx + '">' +
					                    (zim.zim_is_alam == 1
					                        ? '<button class="btn btn-outline-primary" onclick="zimAlam(0, ' + zim.project_idx + ')"><i class="bi bi-bell"></i></button>'
					                        : '<button class="btn btn-outline-primary" onclick="zimAlam(1, ' + zim.project_idx + ')"><i class="bi bi-bell-slash"></i></button>'
					                    ) +
					                    '<button class="btn btn-outline-primary" onclick="zim(0,' + zim.project_idx + ')"><i class="bi bi-suit-heart-fill"></i></button>' +
					                '</div>' +
					            '</div>' +
					        '</div>' +
					        '<div class="col"></div>' +
					    '</div>';
					}

					
					$('#zimListArea').append(html);
    				
				},
				error: function() {
					
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
            <h2><b>찜만 모았어요</b></h2>
        </div>
        <!-- 메뉴 선택 -->
        <div class="row mt-4 text-center">
            <div class="col col-sm-3 col-lg-2 py-3" style="border-bottom: solid 1px #ff9300;">
                <a href="" class="text-black"> 찜 목록 </a>
            </div>
            <div class="col col-sm-3 col-lg-2 py-3">
                <a href="zimFollowBoard" class="text-black"> 최근 소식 </a>
            </div>
        </div>
    </div>
    <div class="col"></div>
    </div>
    <div class="col"></div>
	<div id="zimListArea">
		
	</div>
	


	<%@ include file="../Footer.jsp" %>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"></script>
</body>

</html>