<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Header</title>

    <style>
      .navbar-nav.left,
      .navbar-brand{
        display: flex;
        align-items: center; 
        margin-right: auto; 
        padding-left: 70px; 
      }

      .navbar-nav.right {
        display: flex;
        align-items: center; 
        margin-left: auto; 
        padding-right: 70px; 
      }

      @media (max-width: 767px) {
        .navbar-nav.left,
        .navbar-nav.right {
          display: none; 
        }

        .navbar-toggler {
          margin-right: 15px; 
        }

        .navbar-nav.mobile {
          display: flex;
          flex-direction: column;
          padding-left: 15px; 
        }

        .navbar-collapse.show .navbar-nav.mobile {
          display: flex;
        }

        .navbar-toggler {
          position: absolute;
          right: 15px;
          top: 5px;
        }
        
        .banner {
          display: none; 
        }

        .navbar {
          padding-top: 70px;
        }

        .container {
          padding-top: 80px; 
        }
      }
      
     .form-inline .form-control {
        width: 500px;
        min-width: 500px;
        max-width: 500px;
    }
    
   .navbar {
    justify-content: space-between;
    position: relative;
    left: 0; 
  	}
      
    </style>
    <link rel="stylesheet" type="text/css" href="./resources/css/mypage.css" />	
</head>
<body>
<div class="container">
  <!-- 배너 -->

  <nav class="navbar navbar-expand-lg navbar-light bg-light rounded fixed-top">
    <a class="navbar-brand" href="#">Funddeuck</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsExample09" aria-controls="navbarsExample09" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarsExample09">

      <!-- 데스크 -->
      <ul class="navbar-nav left">
        <li class="nav-item">
          <a class="nav-link" href="fundingExpected?category=all">오픈예정</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="fundingDiscover?category=all&status=all&index=newest">펀딩+</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">고객센터</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">커뮤니티</a>
        </li>
      </ul>

      <!-- 모바일 환경-->
      <ul class="navbar-nav mobile">
      	<c:choose>
	      	<c:when test="${empty sessionScope.sId}">
		        <li class="nav-item">
		          <a class="nav-link" href="LoginForm">로그인</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="JoinForm">회원가입</a>
		        </li>
		        <li class="nav-item">
		          <a class="nav-link" href="#">프로젝트 생성</a>
		        </li>
	        </c:when>
	        <c:otherwise>
		        <li class="nav-item">
		        <a class="nav-link" href="memberMypage"><b>${sessionScope.sId}님 환영합니다.</b></a>
		        </li>
	        	<li class="nav-item">
		          <a class="nav-link" href="LogOut">로그아웃</a>
		        </li>
	        	<li class="nav-item">
		          <a class="nav-link" href="#">프로젝트 생성</a>
		        </li>
	        </c:otherwise>
        </c:choose>
      </ul>

      <form class="form-inline my-2 my-md-0">
        <input class="form-control" type="text" placeholder="프로젝트를 검색하세요!" aria-label="Search">
      </form>
    </div>
  
  </nav>
</div>

</body>
</html>
