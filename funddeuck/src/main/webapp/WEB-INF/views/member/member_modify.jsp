<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>정보수정</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/mypage.css" />
<script type="text/javascript">
        	let isPasswd = 1;
        	let isEmail = 1;
        	let isPhone = 1;
		

        	
        $(document).ready(function () {
        	
        	let email = "${sessionScope.email}";
        	var checkbox = $("#privacy");
        	
        	if(email.length != 0){
        		isEmail = 1;
                $("#email").val(email);
                $("#email").attr("disabled",true);
				$("#authCodeArea").remove();
				$("#emailbtn").remove();
				$("#email").after(
					"<div style='color:green'>"
					+ "이메일 인증 완료"
					+ "</div>"
				);
        		
        	} 
        	
            $("form").submit(function(event) {
            	
                var pw = $('#passwd').val();
                var name = $("#name").val();
                var email = $("#email").val();
                var phone = $("#callNumber").val();
                
                
				let test = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
				let result = test.test(pw);
                
                if (name == "") {
                	alert("이름을 입력해주세요");
                	$('#name').focus();
                	event.preventDefault();
                  return false;
                }
                
               	
                if (pw != "") {
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
                }   
                
                
                if(phone != "${member.member_phone}"){
	                if(phone.length == 0){
	                	alert("전화번호를 작성해주세요.");
	                	$('#callNumber').focus();
	                	return false;
	                } 
	                
	                if(phone.length > 13 || phone.length < 11) {
	                	alert("잘못된 전화번호 입니다.");
	                	$('#callNumber').focus();
	                	return false;
	                }
	
	                if(isPhone == 0){
	                	alert("전화번호 인증은 필수입니다.");
	                	$('#callNumber').focus();
	                	return false;
	                }
                }
                
                if(email != "${member.member_email}"){
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
                }
                
                
                $("#member_id").attr("disabled",false);
                $("#email").attr("disabled",false);
                $("#callNumber").attr("disabled",false);
                
                
              });
			
            $("#passwd").keyup(function() {
            	
            	let passwd = $("#passwd").val();
            	let passwd2 = $("#passwd2").val();
    			let test = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    			let result = test.test(passwd);
            	
    			isPasswd = 0;
    			
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
            				
            				isEmail = 0;
            				
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

            			} else if(data.trim() == "duplication"){
            				
            				Swal.fire({
            					  icon: 'error',
            					  title: 'Oops...',
            					  text: '이미 존재하는 이메일 입니다.',
            					})
            				
            			}else{
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
	
        
    	// 핸드폰 번호 인증
    	function phoneNumberDuplcate() {
    	let phoneNumber = $("#callNumber").val();
    		if(phoneNumber == null || phoneNumber == ""){
    			alert("전화번호를 입력해주시길 바랍니다.");
            	$('#callNumber').focus();
    			return false;
    		}
    		
            if(phoneNumber.length > 13 || phoneNumber.length < 11) {
            	alert("잘못된 전화번호 입니다.");
            	$('#callNumber').focus();
            	return false;
            }
            
            $.ajax({
            	type:"post",
            	url: "phoneNumberDuplcate",
            	data: {phoneNumber: phoneNumber},
            	dataType: "text",
            	success: function(data) {
            		
            		if(data == "true"){
						     
        				alert("인증번호가 발송되었습니다.");
        				
        				let isPhone = 0;
        				
        				$("#phoneAuthCodeArea").remove();
        				$("#phonebtn").after(
        					'<div class="row" id="phoneAuthCodeArea">'
							+	'<div class="col-8">'
        					+		'<input type="text" id="PhoneAuthCode" class="form-control" placeholder="인증코드를 입력하세요">'
							+	'</div>'
							+	'<div class="col">'
        					+		'<input type="button" class="btn btn-primary my-1" id="PhoneAuthCodeBtn" value="인증번호 확인">'	
							+	'</div>'
							+'</div>'
        				);
            			
            		} else if (data.trim() == "phone"){
        				
        				Swal.fire({
        					  icon: 'error',
        					  title: 'Oops...',
        					  text: '이미 존재하는 전화번호 입니다.',
        					})
        				
        			}else{
        				alert("인증코드 전송실패");
        			}
            		
    			},
    			error: function() {
    				
    			}
            }); 
    		
    	};
    	$(document).on("click", "#PhoneAuthCodeBtn", function() {
			
			let authCode = $("#PhoneAuthCode").val();
			let phoneNumber = $("#callNumber").val();
			
			if(authCode == null || authCode == ""){
				alert("코드를 입력해 주세요");
				return false;
			} else if (authCode.length != 6){
				alert("6자리의 코드를 입력해주세요");
				return false;
			}
			
			$.ajax({
				type:"post",
				url:"isPhoneNumberCode",
				data:{phoneNumber:phoneNumber
					, authCode:authCode},
				dataType:"text",
				success: function(data) {
				
					
						if(data.trim() == "true"){
        				
        				alert("전화번호 인증이 성공되었습니다.");
        				
        				$("#callNumber").attr("disabled",true);
        				$("#phoneAuthCodeArea").remove();
        				$("#phonebtn").remove();
        				$("#callNumber").after(
        					"<div style='color:green'>"
        					+ "전화번호 인증 완료"
        					+ "</div>"
        				);
        				isPhone = 1;

        			} else {
        				alert("전화번호 인증실패");
        			}
				},
				error: function() {
					alert("실패");
				}
			});
    		
		});
    	
    	$(document).on("click", "#deleteMemberBtn", function() {
    		
    		Swal.fire({
    			  title: '정말 탈퇴하시겠습니까?',
    			  text: "탈퇴시 다시 가입할 수 없습니다.",
    			  icon: 'warning',
    			  showCancelButton: true,
    			  confirmButtonColor: '#3085d6',
    			  cancelButtonColor: '#d33',
    			  confirmButtonText: '네',
    			  cancelButtonText:'아니오'
    			}).then((result) => {
    			  if (result.isConfirmed) {
    				  
    				  $.ajax({
    					  type:"Post",
    					  url:"deleteIsMaker",
    					  dataType:"text",
    					  success: function(data) {
							
    						  if(data = "true"){
    							  Swal.fire({
    								  title: '탈퇴가 완료되었습니다!',
    								  icon: 'success',
    								  confirmButtonColor: '#3085d6',
    								  confirmButtonText: '홈으로'
    								}).then((result) => {
    							  		location.href="./"
    								})
    						  } else if(data = "false"){
    							  Swal.fire({
    								  icon: 'error',
    								  title: 'Oops...',
    								  text: '탈퇴에 실패하였습니다.'
    								})
    						  } else {
    							  Swal.fire({
    								  icon: 'error',
    								  title: 'Oops...',
    								  text: '아직 진행중인 프로잭트 또는 정산중인 프로젝트가 있습니다.'
    								})
    						  }
    						  
						},
						error: function() {
							alert("탈퇴실패");
						}
    				  });
    				  
    			  }
    			});
    	})
    	
    </script>
</head>
<body>
    <%@ include file="../Header.jsp" %>
	
	<header id="header"></header>
	<!-- 탑 영역 -->

	<div class="row my-5">
		<div class="col"></div>
		<div class="col-6 col-md-3 text-center mt-5">
			<h2 class="mt-5" style="font-weight: bold;">회원정보수정</h2>
			<hr>
			<div class="text-start">
				<form action="ModifyPro" method="post">
					<h6 class="mt-4">이름</h6>
					<input class="form-control" type="text" name="member_name"
						id="name" placeholder="이름" value="${member.member_name }">
					<h6 class="mt-4">아이디</h6>
					<div class="row">
						<div class="col-12">
							<input class="form-control" type="text" name="member_id"
								id="member_id" placeholder="아이디 (5~20글자)" value="${member.member_id }" disabled="disabled">
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
						name="member_phone" placeholder="전화번호 입력" value="${member.member_phone }">
						<input type="button" class="btn btn-primary my-1" id="phonebtn" onclick="phoneNumberDuplcate()" value="전화번호 인증">
					<h6 class="mt-3">이메일</h6>
					<input class="form-control center mt-2" type="text"
						id="email"
						name="member_email" placeholder="이메일 계정" value="${member.member_email }">
						<input type="button" class="btn btn-primary my-1" id="emailbtn" value="이메일 인증">
						<br> 
				<input type="submit" class="btn btn-primary w-100 mt-3" value="정보변경">
				</form>
				<input type="button" class="btn btn-outline-primary w-100 mt-3" value="탈퇴하기" id="deleteMemberBtn">
			</div>
		</div>
		<div class="col"></div>
	</div>





	<%@ include file="../Footer.jsp" %>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
		crossorigin="anonymous"></script>
</body>

</html>