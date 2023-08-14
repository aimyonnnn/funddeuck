<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Header</title>
    <!-- 제이쿼리 -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- 합쳐지고 최소화된 최신 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <style>
        /* 추가된 CSS */
        .navbar-nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
            .navbar-nav .form-control {
	        flex: 0 0 auto;
	        width: auto;
	    }
	    .navbar-nav .btn {
	        flex: 0 0 auto;
	        margin-left: 10px; 
	    }
	    
	    /* 위로 가기 버튼 */
	   #go-top {
		display: none;
	       position: fixed;
	       bottom: 120px;
	       right: 100px;
	       z-index: 99;
	       border: none;
	       background: none;
	       padding: 0;
	   }
    </style>
</head>
<body class="pt-5">
	<!-- 위로 가기 버튼 -->
<button id="go-top"><img src="${pageContext.request.contextPath }/resources/images/topbtn.png" style="width: 56px; height: 56px;"></button>
    <!-- nav 상단 고정-->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#">
                <img alt="Brand" src="" class="img-responsive" style="height: 30px; width: auto;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar" aria-controls="navbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbar">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">오픈예정</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">펀딩+</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">고객센터</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto"> 
                    <li class="navbar-item">
                        <form class="d-flex">
                            <input class="form-control me-2" type="search" placeholder="원하는 프로젝트는?" aria-label="Search">
                            <button class="btn btn-outline-primary" type="submit">검색</button>
                        </form>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link" href="#">로그인</a>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link" href="#">회원가입</a>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link" href="#">프로젝트 생성</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <script>
    //위로가기 버튼
    var backToTop = () => {
        // Scroll | button show/hide
        window.addEventListener('scroll', () => {
            if (document.querySelector('html').scrollTop > 100) {
                document.getElementById('go-top').style.display = "block";
            } else {
                document.getElementById('go-top').style.display = "none";
            }
        });

        // back to top
        document.getElementById('go-top').addEventListener('click', () => {
            window.scroll({
                top: 0,
                left: 0,
                behavior: 'smooth'
            });
        });
    };
    backToTop();
    // 위로 가기 버튼 끝
    </script>
</body>
</html>
