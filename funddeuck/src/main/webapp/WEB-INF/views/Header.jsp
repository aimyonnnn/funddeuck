<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Header</title>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    
    <!-- Bootstrap JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    
	<style>
       .navbar-nav {
            display: flex;
            align-items: center;
        }

        /* Centering the search input and button */
        .navbar-nav .form-control {
            width: 300px; /* Set the width of the search input */
            height: 40px; /* Adjust the height to align with the button */
        }

        .navbar-nav .btn {
            height: 40px; /* Match the height with the search input */
        }
    </style>
</head>
<body>
    <!-- Fixed-top navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container">
            <!-- Navbar Items -->
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
            </div>
            
            <!-- Center-aligned Navbar Items -->
            <ul class="navbar-nav mx-auto"> 
                <li class="navbar-item">
                    <form class="d-flex">
                        <input class="form-control me-2" type="search" placeholder="원하는 프로젝트는?" aria-label="Search">
                        <button class="btn btn-outline-primary" type="submit">검색</button>
                    </form>
                </li>
            </ul>

            <ul class="navbar-nav">
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
    </nav>
</body>
</html>