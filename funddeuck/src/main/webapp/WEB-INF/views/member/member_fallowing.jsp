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
    
    	function isAlam(alam, name, num) {
    		$.ajax({
    			type:'post',
    			url:'fallowingAlam',
    			data:{is_alam:alam,
    				maker_name:name},
    			dataType:'text',
    			success: function(data) {
    				
    				if (data.trim() == 'true') {
    				    if (alam == 1) {
    	                    $("#fallowing" + num).empty();
    	                    $("#fallowing" + num).append(
    				            '<button class="btn btn-outline-primary" onclick="isAlam(0,\'' + name + '\', ' + num + ')"><i class="bi bi-bell"></i></button>'
    				            +'<button class="ms-1 btn btn-outline-primary" onclick="fallowingCheck(1, \'' + name + '\', ' + num + ')"><i class="bi bi-check"></i> 팔로잉</button>'
    				        );
    				    } else {
    	                    $("#fallowing" + num).empty();
    	                    $("#fallowing" + num).append(
    				            '<button class="btn btn-outline-primary" onclick="isAlam(1,\'' + name + '\', ' + num + ')"><i class="bi bi-bell-slash"></i></button>'
    	                        +'<button class="ms-1 btn btn-outline-primary" onclick="fallowingCheck(1, \'' + name + '\', ' + num + ')"><i class="bi bi-check"></i> 팔로잉</button>'
    				        );
    				    } 
    				}

    				
				},
				error: function() {
					alert("오류");
				}
    		});
		}
    	
    	function fallowingCheck(isFallow, name, num) {
    	    $.ajax({
    	        type: "post",
    	        url: "fallowCheck",
    	        data: { is_fallow: isFallow, maker_name: name },
    	        success: function(data) {
    	        	
//     	        	alert(data);
    	        	
    	            if (data.trim() == 'true') {
    	                if (isFallow == 1) {
    	                    $("#fallowing" + num).empty();
    	                    $("#fallowing" + num).append(
    	                        '<button class="btn btn-primary" onclick="fallowingCheck(0, \'' + name + '\', ' + num + ')"><i class="bi bi-plus"></i> 팔로우</button>'
    	                    );
    	                } else {
    	                    $("#fallowing" + num).empty();
    	                    $("#fallowing" + num).append(
    	                        '<button class="btn btn-outline-primary" onclick="isAlam(1, \'' + name + '\',' + num + ')"><i class="bi bi-bell"></i></button>'
    	                        +'<button class="ms-1 btn btn-outline-primary" onclick="fallowingCheck(1, \'' + name + '\', ' + num + ')"><i class="bi bi-check"></i> 팔로잉</button>'
    	                    );
    	                }
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
    <!-- 팔로잉 페이지 시작 -->
<div class="row">
    <div class="col"></div>
    <div class="col-12 col-md-5">
        <div class="row" style="margin-top: 100px">
            <h2><b>팔로잉 메이커</b></h2>
        </div>
        <!-- 메뉴 선택 -->
        <div class="row mt-4 text-center">
            <div class="col col-lg-3 pb-2" style="border-bottom: 1px solid #ff9300;">
                <a href="" class="text-black"> 팔로잉 메이커 </a>
            </div>
            <div class="col col-lg-3">
                <a href="" class="text-black"> 팔로잉 서포터 </a>
            </div>
        </div>
        <!-- 메뉴 선택 -->
        <c:forEach items="${fallowList }" var="fallow">
        <div class="row my-5 align-items-center">
            <div class="col-1 me-5 h5 text-primary">
                <img class="center" style="width: 50px; height: 50px; border-radius: 50%;">
            </div>
            <div class="col">
                <div class="row">
                    ${fallow.maker_name }
                </div>
                <div class="row">
                    팔로워 ${fallow.follower_count }
                </div>
            </div>
            <div class="col text-end" id="fallowing${fallow.maker_idx }">
            	<c:choose>
            		<c:when test="${fallow.is_alam eq 1 }">
	                	<button class="btn btn-outline-primary" id='' onclick="isAlam(0,'${fallow.maker_name }',${fallow.maker_idx })"><i class="bi bi-bell"></i></button>
	                </c:when>
	                <c:otherwise>
	                	<button class="btn btn-outline-primary" onclick="isAlam(1,'${fallow.maker_name }',${fallow.maker_idx })"><i class="bi bi-bell-slash"></i></button>
	                </c:otherwise>
                </c:choose>
	                <button class="btn btn-outline-primary" onclick="fallowingCheck(1,'${fallow.maker_name }',${fallow.maker_idx })"><i class="bi bi-check"></i> 팔로잉</button>
            </div>
        </div> 
        </c:forEach>
    </div>
    <div class="col"></div>
</div>

<%@ include file="../Footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>

</html>