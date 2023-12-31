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
    <title>팔로우 목록</title>
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
    
    	function isAlam(alam, name, num, count) {
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
    				            '<button class="btn btn-outline-primary" onclick="isAlam(0,\'' + name + '\', ' + num + ', '+ count +')"><i class="bi bi-bell"></i></button>'
    				            +'<button class="ms-1 btn btn-outline-primary" onclick="fallowingCheck(1, \'' + name + '\', ' + num + ', '+ count +')"><i class="bi bi-check"></i> 팔로잉</button>'
    				        );
    				    } else {
    	                    $("#fallowing" + num).empty();
    	                    $("#fallowing" + num).append(
    				            '<button class="btn btn-outline-primary" onclick="isAlam(1,\'' + name + '\', ' + num + ', '+ count +')"><i class="bi bi-bell-slash"></i></button>'
    	                        +'<button class="ms-1 btn btn-outline-primary" onclick="fallowingCheck(1, \'' + name + '\', ' + num + ', '+ count +')"><i class="bi bi-check"></i> 팔로잉</button>'
    				        );
    				    } 
    				}

    				
				},
				error: function() {
					alert("오류");
				}
    		});
		}
    	
    	function fallowingCheck(isFallow, name, num, count) {
    		
    		let fallowCount = count;
			
    	    $.ajax({
    	        type: "post",
    	        url: "fallowCheck",
    	        data: { is_fallow: isFallow, maker_name: name },
    	        success: function(data) {
    	        	
    	            if (data.trim() == 'true') {
    	                if (isFallow == 1) {
    	                	
    	                	fallowCount = fallowCount - 1;
    	                	
    	                    $("#fallowing" + num).empty();
    	                    $("#fallowing" + num).append(
    	                        '<button class="btn btn-primary" onclick="fallowingCheck(0, \'' + name + '\', ' + num + ', '+ fallowCount +')"><i class="bi bi-plus"></i> 팔로우</button>'
    	                    );
    	                    
    	                    $("#count"+num).empty();
    	                    $("#count"+num).append(
    	                    	'팔로워 ' + fallowCount
    	                    );
    	                } else {
    	                	
    	                	fallowCount = fallowCount + 1;
    	                	
    	                    $("#fallowing" + num).empty();
    	                    $("#fallowing" + num).append(
    	                        '<button class="btn btn-outline-primary" onclick="isAlam(1, \'' + name + '\',' + num + ', '+ fallowCount +')"><i class="bi bi-bell"></i></button>'
    	                        +'<button class="ms-1 btn btn-outline-primary" onclick="fallowingCheck(1, \'' + name + '\', ' + num + ', '+ fallowCount +')"><i class="bi bi-check"></i> 팔로잉</button>'
    	                    );
    	                    
    	                    $("#count"+num).empty();
    	                    $("#count"+num).append(
    	                    	'팔로워 ' + fallowCount
    	                    );
    	                }
    	            }
    	        },
    	        error: function() {
    	            alert("오류");
    	        }
    	    });
    	}
    	
    	//------------------------- 팔로잉 스크롤 페이징 처리 ------------------------------------
    let pageNum = 1; // 기본 페이지 번호 미리 저장
	let maxPage = 1; // 최대 페이지 번호 미리 저장
	
		$(function() {
			
			memberFollowingList();
			
			$(window).on("scroll", function() { // 스크롤 동작 시 이벤트 처리
				
				let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
				let windowHeight = $(window).height(); // 브라우저 창의 높이
				let documentHeight = $(document).height(); // 문서의 높이(창의 높이보다 크거나 같음)
				let x = 1;
				if(scrollTop + windowHeight + x >= documentHeight) {
					if(pageNum < maxPage) {
						pageNum++;
						memberFollowingList();
					} else {
						
					}
				}
				
			});
		});
	
		function memberFollowingList(followName) {
			
			
			$.ajax({
				type:"Post",
				url:"MemberFollowList",
				data:{pageNum:pageNum
					,maker_name:followName},
				dataType:"json",
				success: function(data) {
					console.log(JSON.stringify(data));
					maxPage = data.maxPage;
					
					if(maxPage == 0){
						$("#followingArea").append(
							    '<div class="col-12 mt-5 text-center" style="padding-bottom: 300px;"> <h4> 아직 팔로잉 한 메이커가 없습니다! </h4></div>'
						);
						return false;
					}
					
					var html = '';
					for (let memberFollowing of data.memberFollowingList) {
						
					    let profileImageSrc;
					    
					        profileImageSrc = '${pageContext.request.contextPath}/resources/upload/'+memberFollowing.maker_file4;
						    if (profileImageSrc.trim() =='${pageContext.request.contextPath}/resources/upload/' ||
						    		profileImageSrc.trim() == '${pageContext.request.contextPath}/resources/upload/undefined') {
						        profileImageSrc = '${pageContext.request.contextPath}/resources/images/managementImage.jpg';
						    }
						
						html += '<div class="row my-5 align-items-center">' +
					    '<div class="col-1 me-5 h5 text-primary">' +
				               '<img class="center" src="' +
				         profileImageSrc +
				        '" style="width: 50px; height: 50px; border-radius: 50%;">' +
					    '</div>' +
					    '<div class="col">' +
					        '<div class="row">' +
					            '<a href="makerDetail?maker_idx=' + memberFollowing.maker_idx + '" style="color: black; text-decoration: none;">' +
					                memberFollowing.maker_name +
					            '</a>' +
					        '</div>' +
					        '<div class="row" id="count' + memberFollowing.maker_idx + '">' +
					            '팔로워 ' + memberFollowing.follower_count +
					        '</div>' +
					    '</div>' +
					    '<div class="col text-end" id="fallowing' + memberFollowing.maker_idx + '">' +
				        	(memberFollowing.is_alam == 1
				                ? '<button class="btn btn-outline-primary" onclick="isAlam(0, \'' + memberFollowing.maker_name + '\', ' + memberFollowing.maker_idx + ', ' + memberFollowing.follower_count + ')">' +
				                    '<i class="bi bi-bell"></i>' +
				                  '</button>'
				                : '<button class="btn btn-outline-primary" onclick="isAlam(1, \'' + memberFollowing.maker_name + '\', ' + memberFollowing.maker_idx + ', ' + memberFollowing.follower_count + ')">' +
				                    '<i class="bi bi-bell-slash"></i>' +
				                  '</button>') +
					        '<button class="btn btn-outline-primary ms-1" onclick="fallowingCheck(1, \'' + memberFollowing.maker_name + '\', ' + memberFollowing.maker_idx + ', ' + memberFollowing.follower_count + ')">' +
					            '<i class="bi bi-check"></i> 팔로잉' +
					        '</button>' +
					    '</div>' +
					'</div>';
					}
					
					$('#followingArea').append(html);
				            
				},
				error: function() {
					
				}
			});
			
		}
		
		function memberSearchFollowingList() {
			
			let followName = $("#followName").val();
			
			alert(followName);
			
			$('#followingArea').empty();
			
			memberFollowingList(followName);
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
                <a href="FallowingForm" class="text-black"> 팔로잉 메이커 </a>
            </div>
            <div class="col col-lg-3">
                <a href="FollowBoardForm" class="text-black"> 팔로잉 프로젝트 </a>
            </div>
        </div>
        <div class="row mt-3 d-flex justify-content-end">
	    	<div class="col-3">
				<input class="form-control" type="text" name="followName"
					id="followName" placeholder="메이커 검색">
			</div>
			<div class="col-2">
				<input type="button" value="검색" class="btn btn-primary"
					id="isIdbtn" onclick="memberSearchFollowingList()">
			</div>
        </div>
        <!-- 메뉴 선택 -->
		<div id="followingArea">
		</div>
    </div>
    <div class="col"></div>
</div>

<%@ include file="../Footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>

</html>