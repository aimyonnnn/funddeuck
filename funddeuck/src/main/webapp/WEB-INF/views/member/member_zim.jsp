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
			
        	alert(is_zim+ ", " +project_idx);
        	
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
        
        </script>
</head>
<body>
    <!-- cupon 페이지 시작 -->
    <div class="row" style="margin-top: 100px;">
    <div class="col"></div>
    <div class="col-12 col-md-8 col-lg-6 bg-light mt-5">
        <div class="row">
            <h2><b>찜만 모았어요</b></h2>
        </div>
        <!-- 메뉴 선택 -->
        <div class="row mt-4 text-center">
            <div class="col col-sm-3 col-lg-2 py-3" style="border-bottom: solid 1px #ff9300;">
                <a href="" class="text-black"> 전체 </a>
            </div>
            <div class="col col-sm-3 col-lg-2 py-3">
                <a href="" class="text-black"> 메이커 </a>
            </div>
            <div class="col col-sm-3 col-lg-2 py-3">
                <a href="" class="text-black"> 알림신청 </a>
            </div>
        </div>
    </div>
    <div class="col"></div>
    </div>
    <div class="col"></div>
    <c:forEach items="${zimList }" var="zim">
	    <div class="row">
	        <div class="col"></div>
		    <div class="col-12 col-sm-8 col-lg-6 bg-light">
		    	<div class="row align-items-center">
			    	<div class="col">
				        <div class="row mt-5 align-items-start">
				            <div class="row my-3 align-items-start">
				                <div class="col-1 me-3 h5 text-primary">
				                    <img class="center" style="width: 30px; height: 30px; border-radius: 50%;">
				                </div>
				                <div class="col" style="font-size: 0.7em;">
				                    <div class="row">
				                        ${zim.maker_name }
				                    </div>
				                    <div class="row">
				                        팔로워 ${zim.follow_count }
				                    </div>
				                </div>
				            </div>
				        </div>
				        <div class="row">
				            <div class="col-12">
				                ${zim.project_subject }
				            </div>
				            <div class="col-12 mt-1" style="font-size: 0.9em;">
				                ${zim.project_introduce }
				            </div>
				            <div class="col-12 my-1">
				                이미지 영역
				            </div>
				        </div>
			        </div>
			        <div class="col text-end" id="zimBtnArea${zim.project_idx }">
			        	<c:choose>
			        		<c:when test="${zim.zim_is_alam eq 1 }">
				        		<button class="btn btn-outline-primary" onclick="zimAlam(0,${zim.project_idx })"><i class="bi bi-bell"></i></button>
			        		</c:when>
			        		<c:otherwise>
				        		<button class="btn btn-outline-primary" onclick="zimAlam(1,${zim.project_idx })"><i class="bi bi-bell-slash"></i></button>
				        	</c:otherwise>
			        	</c:choose>
			        	<button class="btn btn-outline-primary" onclick="zim(0, ${zim.project_idx})"><i class="bi bi-suit-heart-fill"></i></button>
			        </div>
		        </div>
		    </div>
	    <div class="col"></div>
	</div>
</c:forEach>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
            crossorigin="anonymous"></script>
</body>

</html>