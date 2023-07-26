<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    $(function() {
        $("form").submit(function(event) {
			
        	let id = $("#id").val();
        	let passwd = $("#passwd").val();
        	
        	if(id.length == 0){
        		alert("아이디를 입력해주세요");
        		return false;
        	} else if(passwd.length == 0){
        		alert("비밀번호를 입력해주세요");
        		return false;
        	}
        	
		});
	});
    </script>
</head>

<body>
    <%@ include file="Header.jsp" %>

    <header id="header"></header>
    <!-- 탑 영역 -->

    <div class="row my-5" style="height: 500px">
        <div class="col"></div>
        <div class="col-6 col-md-3 text-center">
            <h2 class="float-start mt-5" style="font-weight: bold;">로그인</h2>
            <br>    
            <form method="post" action="LoginPro">
                <input class="form-control center mt-5" type="text" name="member_id" id="id" placeholder="아이디를 작성해주세요.">
                <input class="form-control mt-2" type="password" id="passwd" name="member_passwd" placeholder="비밀번호를 작성해주세요.">
            <a class="float-end mt-2" href="idFindForm" style="text-decoration: none; color: gray;">로그인 정보를 잊으셨나요?</a>
            <input class="btn btn-primary w-100 mt-5 p-2" id="LoginSubmit" type="submit" value="로그인"/>
            </form>
            <input class="btn btn-warning w-100 mt-2 p-2 mb-4" type="button" value="카카오로 시작하기"/>
            아직 계정이 없으신가요? <a class=" mt-2" href="JoinForm" style="color: blue">회원가입</a>
        </div>
        <div class="col"></div>
    </div>


    
    <%@ include file="Footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>

</html>