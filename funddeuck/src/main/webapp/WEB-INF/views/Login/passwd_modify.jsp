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
            var pw = $('#passwd').val();
            
			let test = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
			let result = test.test(pw);
            
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
	});
  </script>
</head>

<body>
  <div class="row text-center" style="margin-top: 100px;">
    <div class="col"></div>
    <div class="col-12 col-md-8">
      <h3><strong>비밀번호 변경</strong></h3>
    </div>
    <div class="col"></div>
  </div>
  <div class="row mt-1">
    <div class="col"></div>
    <div class="col-12 mt-3 col-md-4 col-sm-8" style="background-color: #fafafa; border: 2px solid #ff9300; padding: 50px">
      <div style="color: #000000aa;">
        원하시는 비밀번호를 입력하시고<br>
        비밀번호 변경 버튼을 눌러주세요.
      </div>
	      <form method="post" action="ModifyPasswdPro">
	        <input type="password" class="form-control mt-5 py-3" id="passwd" name="passwd" placeholder="새 비밀번호 입력">
	        <input type="password" class="form-control mt-2 py-3" id="passwd2" placeholder="비밀번호 확인">
	      	<input type="submit" class="btn btn-primary w-100 mt-3" value="비밀번호 변경">
	      	<input type="hidden" value="${param.email }" name="email">
	      </form>
    </div>
    <div class="col"></div>
  </div>



  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
    crossorigin="anonymous"></script>
</body>

</html>