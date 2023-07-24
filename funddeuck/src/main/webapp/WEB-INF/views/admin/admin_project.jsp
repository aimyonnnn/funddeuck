<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Admin</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1">
    <!--bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jquery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- line-awesome -->
	<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
	<!-- css -->
    <link href="${pageContext.request.contextPath}/resources/css/adminDetail.css" rel="stylesheet" type="text/css"/>
   	<link href="${pageContext.request.contextPath }/resources/css/project_status.css" rel="styleSheet" type="text/css">
    <link rel="shortcut icon" href="#">
   
  </head>
  <body>

   <!-- 사이드바 -->
   <input type="checkbox" name="" id="sidebar-toggle">
   
    <div class="sidebar">
      <div class="sidebar-main"> 
        <div class="sidebar-user">
            <img src="${pageContext.request.contextPath}/resources/images/adminProfile.png">
          <div>
            <span>${sessionScope.sId}님</span>
          </div>
        </div>

        <div class="sidebar-menu">
          <div class="menu-head">
              <span></span>
            </div>
            <ul>
              <li>
                <a href="./">
                  <span class="las la-home"></span>
                  홈페이지
                </a>
              </li>
              <li>
                <a href="admin">
                  <span class="las la-user"></span>
                  관리자 메인
                </a>
              </li>
              <li>
                <a href="adminChart">
                  <span class="las la-chart-line"></span>
                  데이터 분석
                </a>
              </li>
            </ul>

          <div class="menu-head">
            <span>MENU</span>
          </div>
          <ul>
            <li>
                <a href="adminProject">
                 <span class="las la-store"></span>
                 프로젝트 관리
                 </a>
             </li>
            <li>
                <a href="adminMember">
                 <span class="las la-users"></span>
                 회원 관리
                 </a>
            </li>
            <li>
              <a href="adminPayment">
                  <span class="las la-exchange-alt"></span>
                 결제 관리
              </a>
            </li>
             <li>
                <a href="#">
                  <span class="las la-history"></span>
                  점검중
                </a>
             </li>
            <li>
              <a href="#">
                  <span class="las la-comment-dots"></span>
                 점검중
              </a>
            </li>
           </ul>
           <div class="menu-head">
             <span>2 TEAM</span>
           </div>
           <ul>
	           <li><a><span class="las la-crown"></span>박수민</a></li>
	           <li><a><span class="las la-laugh"></span>김민진</a></li>
	           <li><a><span class="las la-laugh"></span>김보희</a></li>
	           <li><a><span class="las la-laugh"></span>이재승</a></li>
	           <li><a><span class="las la-laugh"></span>김묘정</a></li>
	           <li><a><span class="las la-laugh"></span>이건무</a></li>
           </ul>
        </div>
      </div>
    </div>
<!-- ------------------------------------------------------------------ -->
	<div class="main-content">
		<jsp:include page="../common/admin_top.jsp"/>
		<main>
		
			<div class="container mt-3 mb-2">
				<div class="row justify-content-center">
					
					
					
					
				</div>
			</div>

		</main>
	</div>
    
    <label for="sidebar-toggle" class="body-label"></label>
    
    <!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <!-- datepicker -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
 	<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
 	
</body>
</html>