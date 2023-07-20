<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>profile</title>
    <%@ include file="../Header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="../resources/css/mypage.css" />	
	<link rel="stylesheet" type="text/css" href="../resources/css/member_profile.css" />	
</head>
<body>
<section style="background-color: #f4f5f7;">
  <div class="container py-5">
    <div class="row d-flex justify-content-center align-items-center">
      <div class="col col-lg-6 mb-4 mb-lg-0">
	        <div class="card mb-3" style="border-radius: .5rem;">
	          <div class="row g-0">
	  			<h3 class="profile-heading">프로필 정보 설정</h3>
	            <div class="col-md-4 gradient-custom text-center text-white"
	              style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
	              <img src="../resources/images/profile.png"
	                alt="profile" class="img-fluid my-5" style="width: 80px;" />
                        <div class="link-container">
                            <a href="#!">바꾸기</a>
                            <a href="#!">삭제</a>
                         </div>
                        </div>
	            <div class="col-md-8">
	              <div class="card-body p-4">
	                <h6>회사 / 직책</h6>
	                <hr class="mt-0 mb-4">
	                <div class="row pt-1">
	                  <div class="col-6 mb-3">
	                    <h6>회사</h6>
	                    <p><input type ="text" placeholder="정보를 수정하시오"></p>
	                  </div>
	                  <div class="col-6 mb-3">
	                    <h6>직책</h6>
	                    <p><input type ="text" placeholder="정보를 수정하시오"></p>
	                  </div>
	                </div>
	                <h6>학교 / 학과</h6>
	                <hr class="mt-0 mb-4">
	                <div class="row pt-1">
	                  <div class="col-6 mb-3">
	                    <h6>학교</h6>
	                    <p><input type ="text" placeholder="정보를 수정하시오"></p>
	                  </div>
	                  <div class="col-6 mb-3">
	                    <h6>학과</h6>
	                    <p><input type ="text" placeholder="정보를 수정하시오"></p>
	                  </div>
	                </div>
	                <h6>간단한 말 한마디로 나를 소개해주세요</h6>
	                <hr class="mt-0 mb-4">
	                <div class="row pt-1">
	                  <div class="col-6 mb-3">
                      <p><textarea placeholder="내용을 입력해주세요"></textarea></p>
	                </div>
	                <div class="d-flex justify-content-start">
	                  <a href="#!"><i class="fab fa-facebook-f fa-lg me-3"></i></a>
	                  <a href="#!"><i class="fab fa-twitter fa-lg me-3"></i></a>
	                  <a href="#!"><i class="fab fa-instagram fa-lg"></i></a>
	                </div>
	              </div>
	            </div>
	          </div>
	        </div>
	       </div>
			<div class="button-container">
			  <button class="btn btn-primary">취소</button>
			  <button class="btn btn-primary">저장</button>
			</div>
	      </div>
	    </div>
	  </div>
	</section>
    <%@ include file="../Footer.jsp" %>

</body>
</html>