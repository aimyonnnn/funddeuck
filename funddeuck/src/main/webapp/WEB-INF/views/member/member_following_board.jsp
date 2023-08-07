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
			
			makerChatList();
			
			$(window).on("scroll", function() { // 스크롤 동작 시 이벤트 처리
				
				let scrollTop = $(window).scrollTop(); // 스크롤바 현재 위치
				let windowHeight = $(window).height(); // 브라우저 창의 높이
				let documentHeight = $(document).height(); // 문서의 높이(창의 높이보다 크거나 같음)
				let x = 1;
				if(scrollTop + windowHeight + x >= documentHeight) {
					if(pageNum < maxPage) {
						pageNum++;
						makerChatList();
					} else {
					}
				}
				
			});
		});
	
	
    </script>
</head>
<body>
    <!-- 팔로잉 페이지 시작 -->
    <!-- 팔로잉 페이지 시작 -->
<div class="row">
    <div class="col"></div>
    <div class="col-12 col-md-5">
        <div class="row" style="margin-top: 100px">
            <h2><b>팔로잉 프로젝트</b></h2>
        </div>
        <!-- 메뉴 선택 -->
        <div class="row mt-4 text-center">
            <div class="col col-lg-3">
                <a href="" class="text-black"> 팔로잉 </a>
            </div>
            <div class="col col-lg-4 pb-2" style="border-bottom: 1px solid #ff9300;">
                <a href="" class="text-black"> 팔로잉 프로젝트 </a>
            </div>
        </div>
        <!-- 메뉴 선택 -->
        <c:forEach items="${projectList }" var="project">
        <div class="row my-5 align-items-center">
            <div class="col-1 me-5 h5 text-primary">
                <img class="center" style="width: 50px; height: 50px; border-radius: 50%;">
            </div>
            <div class="col">
                <div class="row">
                   <h5><b>${project.project_subject }</b></h5>
                </div>
                <div class="row">
                    ${project.project_introduce }
                </div>
            </div>
            <div class="col">
               	${project.project_start_date } ~ ${project.project_end_date }
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