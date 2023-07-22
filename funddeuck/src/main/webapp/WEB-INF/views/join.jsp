<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css"/>
    <script type="text/javascript">
        $(document).ready(function () {
            
            $("#passwd2").focusout(function() {
    			let passwd = $("#passwd").val();
    			let passwd2 = $("#passwd2").val();
    			
    			if(passwd != passwd2){
    				$("#area").remove();
    				
    				$("#passwd2").after(
    					 "<div style='color: red;' id='area'>"
    					+ "비밀번호가 일치하지 않습니다."
    					+ "</div>"
    				);
    			} else {
    				$("#area").remove();
    				$("#passwd2").after(
    						"<div style='color: green;' id='area'>"
    						+ "비밀번호가 일치합니다."
    						+ "</div>"
    				);
    			}
    			
    			
    		});
        });

        
    </script>
</head>

<body>


    <header id="header"></header>
    <!-- 탑 영역 -->

    <div class="row my-5">
        <div class="col"></div>
        <div class="col-6 col-md-3 text-center">
            <h2 class="float-start mt-5" style="font-weight: bold;">간편가입</h2>
            <input class="btn btn-warning w-100 mt-2 p-2 mb-4" type="button" value="카카오로 시작하기"/>
            <hr>
              <div class="text-start">
                <h5 class="my-3 text-start">이메일 간편가입</h5>
	                <form action="JoinPro" method="post">
		                <h6 class="mt-4">이름</h6>
		                <input class="form-control" type="text" name="member_name" placeholder="이름">
		                <h6 class="mt-4">아이디</h6>
		                <input class="form-control" type="text" name="member_id" placeholder="아이디">
		                <h6 class="mt-4">비밀번호</h6>
		                <input class="form-control" type="password" id="passwd" name="member_passwd" placeholder="비밀번호 입력">
		                <input class="form-control mt-1" type="password" id="passwd2" placeholder="비밀번호 확인">
		                <h6 class="mt-4">전화번호</h6>
		                <input class="form-control" type="text" id="passwd" name="member_phone" placeholder="전화번호 입력">
		                <h6 class="mt-3">이메일</h6>
		                <input class="form-control center mt-2" type="text" name="member_email" placeholder="이메일 계정">
		                <input type="checkbox"> 전체동의
		                <br>
		                <input type="submit" class="btn btn-primary w-100 mt-3" value="완료">
	                </form>
              </div>
            </div>
        <div class="col"></div>
    </div>


    
    <footer id="footer"></footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>

</html>