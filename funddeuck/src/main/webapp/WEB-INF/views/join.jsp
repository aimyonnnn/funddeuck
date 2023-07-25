<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap demo</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/mypage.css" />
<script type="text/javascript">
        	let isPasswd = 0;
        	let isId = 0;
        	let isEmail = 0;

        $(document).ready(function () {
        	
        	
            $("form").submit(function(event) {
              	var id = $('#member_id').val();
                var pw = $('#passwd').val();
                var name = $("#name").val();
                var email = $("#email").val();
                var phone = $("#callNumber").val();
                
                if(phone.length > 13 || phone.length < 11) {
                	alert("잘못된 전화번호 입니다.");
                	$('#callNumber').focus();
                	return false;
                }
                
				let test = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
				let result = test.test(pw);
                
                if (name == "") {
                	alert("이름을 입력해주세요");
                	$('#name').focus();
                	event.preventDefault();
                  return false;
                }
                
                if (id == "") {
                	alert("아이디를 입력해주세요.");
                	$('#member_id').focus();
                	event.preventDefault();
                  return false;
                }
                
               	if(isId == 0){
                	alert("아이디 인증은 필수 입니다.");
                	$('#member_id').focus();
               		return false;
               	}
               	
                if (pw == "") {
                	alert("비밀번호를 입력해주세요.");
                	$('#passwd').focus();
                	event.preventDefault();
                  return false;
                }   
                
                if(pw.length < 8){
                	alert("비밀번호는 8글자 이상이어야 합니다.");
                	$('#passwd').focus();
                	return false;
                } else if(pw.length > 20){
                	alert("비밀번호는 20글자 이하이어야 합니다.");
                	$('#passwd').focus();
                	return false;
                }
                
                if(isPasswd == 0){
                	alert("비밀번호가 일치하지 않습니다.\n다시 작성해 주세요.");
                	$('#passwd').focus();
                	return false;
                }
                if(!result){
                	alert("비밀번호에 문자,숫자,특수기호가 1개 이상 들어가야합니다.");
                	$('#passwd').focus();
                	return false;
                }
                
                if(phone.length == 0){
                	alert("전화번호를 작성해주세요.");
                	$('#callNumber').focus();
                	return false;
                } 
                
                

                	
                if(email.length == 0){
                	alert("이메일을 작성해주세요.");
                	$('#email').focus();
                	return false;
                }
                
                if(isEmail == 0){
                	alert("이메일 인증은 필수 입니다.");
                	$('#email').focus();
                	return false;
                }
                
                
                
                $("#member_id").attr("disabled",false);
                $("#email").attr("disabled",false);
                
                
              });
			
            $("#passwd").keyup(function() {
            	
            	let passwd = $("#passwd").val();
            	let passwd2 = $("#passwd2").val();
    			let test = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    			let result = test.test(passwd);
            	
            	if(passwd.length < 8){
    				$("#passwdarea").remove();
    				$("#passwd").after(
       					 "<div style='color: red;' id='passwdarea'>"
       					+ "비밀번호는 8글자 이상이어야 합니다."
       					+ "</div>"
       				);
    			}
            	
            	if(passwd.length > 7 && passwd.length < 21) {
            		if(result){
        				$("#passwdarea").remove();
        				$("#passwd").after(
        						"<div style='color: green;' id='passwdarea'>"
        						+ "사용가능한 비밀번호 입니다."
        						+ "</div>"
        				);
            		} else {
        				$("#passwdarea").remove();
        				$("#passwd").after(
           					 "<div style='color: red;' id='passwdarea'>"
           					+ "문자, 숫자, 특수문자는 반드시 추가되어야 합니다."
           					+ "</div>"
           				);
            		}
            	}
            	
    			if(passwd.length > 20){
        			$("#passwdarea").remove();
    				$("#passwd").after(
           					 "<div style='color: red;' id='passwdarea'>"
           					+ "비밀번호는 20글자 이하이어야 합니다."
           					+ "</div>"
           				);
            	}
    			
    			if(passwd == passwd2){
    				isPasswd = 1;
    				
    				$("#passwd2area").empty();
    				$("#passwd2area").css("color", "green");
    				$("#passwd2area").append(
    						"비밀번호가 일치합니다."
    				);
    			} else {
    				isPasswd = 0;
    				
    				$("#passwd2area").empty();
    				$("#passwd2area").css("color", "red");
    				$("#passwd2area").append(
    					"비밀번호가 일치하지 않습니다."
    				);
    			}
    			
			});
            
            $("#passwd2").keyup(function() {
    			let passwd = $("#passwd").val();
    			let passwd2 = $("#passwd2").val();
    			
				if(passwd.length == 0 || passwd2.length == 0){
    				isPasswd = 0;
    				$("#passwd2area").remove();
    			} else if(passwd != passwd2) {
    				isPasswd = 0;
    				$("#passwd2area").remove();
    				$("#passwd2").after(
    					 "<div style='color: red;' id='passwd2area'>"
    					+ "비밀번호가 일치하지 않습니다."
    					+ "</div>"
    				);
    			} else {
    				isPasswd = 1;
    				$("#passwd2area").remove();
    				$("#passwd2").after(
    						"<div style='color: green;' id='passwd2area'>"
    						+ "비밀번호가 일치합니다."
    						+ "</div>"
    				);
    			}
    			
    			
    		});
            
            $("#callNumber").on("input", function() {
                var callNumber = $(this).val();

                callNumber = callNumber.replace(/[^0-9]/g, '')
                		.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
               
                $(this).val(callNumber);
            });


            
            $("#emailbtn").click(function() {
            	let email = $("#email").val();
            	let pattern = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
            	let result = pattern.test(email);
            	
            	if(email == ""){
            		alert("이메일을 작성해 주세요");
            		return ;
            	} else if(!result){
					alert("이메일 형식이 아닙니다.");
					return ;
				}         
            	
            	$.ajax({
            		type:"post",
            		url:"emailDuplicate",
            		data: {email:email},
            		dataType:"text",
            		success: function(data) {
            			if(data.trim() == "true"){
            				
            				alert("이메일이 발송되었습니다.");
            				$("#authCodeArea").remove();
            				$("#emailbtn").after(
            					'<div class="row" id="authCodeArea">'
								+	'<div class="col-8">'
            					+		'<input type="text" id="authCode" class="form-control" placeholder="인증코드를 입력하세요">'
								+	'</div>'
								+	'<div class="col">'
            					+		'<input type="button" class="btn btn-primary my-1" id="AuthCodeBtn" value="인증번호 확인">'	
								+	'</div>'
								+'</div>'
            				);

            			} else {
            				alert("이메일 발송실패");
            			}
            			
    				},
    				error: function() {
    					alert("실패");
    				}
            	});
            	
            	
    		});
            
        });
        
        $(document).on("click", "#AuthCodeBtn", function () {
        	
			let authCode = $("#authCode").val();
			let email = $("#email").val();
			
			if(authCode == null || authCode == ""){
				alert("코드를 입력해 주세요");
				return ;
			}
			
			$.ajax({
				type:"post",
				url:"certificationAuthCode",
				data:{email:email,
					authCode:authCode},
				dataType:"text",
				success: function(data) {
						if(data.trim() == "true"){
        				
        				alert("이메일 인증이 성공되었습니다.");
        				
        				$("#email").attr("disabled",true);
        				$("#authCodeArea").remove();
        				$("#emailbtn").remove();
        				$("#email").after(
        					"<div style='color:green'>"
        					+ "이메일 인증 완료"
        					+ "</div>"
        				);
        				isEmail = 1;

        			} else {
        				alert("이메일 인증실패");
        			}
				},
				error: function() {
					alert("실패");
				}
			});
        	
		});
	
        function idDuplicate() {
			
        	var id = $("#member_id").val()
        	

        	if(id == ""){
        		alert("아이디를 입력해주세요.");
        		return false;
        	}
        	
        	if(id.length < 5){
        		alert("아이디는 5글자 이상이어야 합니다.");
        		return false;
        	}
        	
        	if(id.length > 20){
        		alert("아이디는 20글자 이하이어야 합니다.");
        		return false;
        	}
        	
        	$.ajax({
        		type:"post",
        		url:"idDuplicate",
        		data: {id:id},
        		dataType:"text",
        		success: function(data) {
        			
        			if(data.trim() == "true"){
        				isId=1;
        				
        				alert("사용가능한 아이디 입니다.");
        				$("#member_id").attr("disabled",true); 
        			} else {
        				
        				alert("사용불가한 아이디 입니다.");

        			}
        			
				},
				error: function() {
					alert("실패");
				}
        	});
        	
		}
        

        
    </script>
</head>

<body>

	
	<header id="header"></header>
	<!-- 탑 영역 -->

	<div class="row my-5">
		<div class="col"></div>
		<div class="col-6 col-md-3 text-center">
			<h2 class="float-start mt-5" style="font-weight: bold;">간편가입</h2>
			<input class="btn btn-warning w-100 mt-2 p-2 mb-4" type="button"
				value="카카오로 시작하기" />
			<hr>
			<div class="text-start">
				<h5 class="my-3 text-start">이메일 간편가입</h5>
				<form action="JoinPro" method="post">
					<h6 class="mt-4">이름</h6>
					<input class="form-control" type="text" name="member_name"
						id="name" placeholder="이름">
					<h6 class="mt-4">아이디</h6>
					<div class="row">
						<div class="col-8">
							<input class="form-control" type="text" name="member_id"
								id="member_id" placeholder="아이디 (5~20글자)">
						</div>
						<div class="col">
							<input type="button" value="아이디 확인" class="btn btn-primary"
								id="isbtn" onclick="idDuplicate()">
						</div>
					</div>
					<h6 class="mt-4">비밀번호</h6>
					<input class="form-control" type="password" id="passwd"
						name="member_passwd" placeholder="비밀번호 입력 (문자,숫자,특수문자포함 8~20자)">
					<input class="form-control mt-1" type="password" id="passwd2"
						placeholder="비밀번호 확인">
					<h6 class="mt-4">전화번호</h6>
					<input class="form-control" type="text"
						id="callNumber"
						name="member_phone" placeholder="전화번호 입력">
					<h6 class="mt-3">이메일</h6>
					<input class="form-control center mt-2" type="text"
						id="email"
						name="member_email" placeholder="이메일 계정">
						<input type="button" class="btn btn-primary my-1" id="emailbtn" value="이메일 인증">
						<br>
						<input type="checkbox"> 전체동의 
						<br> 
				<input type="submit" class="btn btn-primary w-100 mt-3" value="완료">
				</form>
			</div>
		</div>
		<div class="col"></div>
	</div>



	<footer id="footer"></footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
		crossorigin="anonymous"></script>
</body>

</html>