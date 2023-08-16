<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>

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
        	let isPasswd = 0;
        	let isId = 0;
        	let isEmail = 0;
        	let isPhone = 0;

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
              	var id = $('#member_id').val();
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
                
                if (!checkbox.prop("checked")) {
                    alert("개인정보 수집에 동의해야 합니다.");
                    return false;
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
	
        function idDuplicate() {
			
        	var id = $("#member_id").val()
        	
        	if(isId == 1){
        		alert("인증이 완료되었습니다.");
        		return false;
        	}
			
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
        				$("#isIdbtn").remove();
        				
        			} else {
        				
        				alert("사용불가한 아이디 입니다.");

        			}
        			
				},
				error: function() {
					alert("실패");
				}
        	});
        	
		}
        
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
    	
    	
    </script>
</head>

<body>
    <%@ include file="Header.jsp" %>
	
	<header id="header"></header>
	<!-- 탑 영역 -->

	<div class="row my-5">
		<div class="col"></div>
		<div class="col-6 col-md-3 text-center">
			<h2 class="mt-5" style="font-weight: bold;">회원가입</h2>
			<hr>
			<div class="text-start">
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
								id="isIdbtn" onclick="idDuplicate()">
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
						<input type="button" class="btn btn-primary my-1" id="phonebtn" onclick="phoneNumberDuplcate()" value="전화번호 인증">
					<h6 class="mt-3">이메일</h6>
					<input class="form-control center mt-2" type="text"
						id="email"
						name="member_email" placeholder="이메일 계정">
						<input type="button" class="btn btn-primary my-1" id="emailbtn" value="이메일 인증">
						<br>
						<input type="checkbox" id="privacy"> <a href="" data-bs-toggle="modal" data-bs-target="#privacyModel">개인정보 수집동의 [필수]</a>
						<br> 
				<input type="submit" class="btn btn-primary w-100 mt-3" value="완료">
				</form>
			</div>
		</div>
		<div class="col"></div>
	</div>

<!-- 개인정보처리 방침 내용 -->
<div class="modal fade" id="privacyModel" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">개인정보처리 방침</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <section>
          <h5 class = "mt-3">1. 개인정보처리 방침의 목적</h5 class = "mt-3">
          <textarea class="form-control" rows="3" readonly>펀뜩은 개인정보보호법 및 관련 법규를 준수하며, 개인정보 보호의 중요성을 인식하고 이를 지키기 위해 최선의 노력을 다하고 있습니다. 본 개인정보처리 방침은 회사가 개인정보를 처리하는 방법과 그에 따른 권리 및 의무를 설명하는 문서입니다.</textarea>
        </section>
        
        <section>
          <h5 class = "mt-3">2. 수집하는 개인정보의 항목 및 수집 방법</h5 class = "mt-3">
          <textarea class="form-control" rows="3" readonly>회사는 다음과 같은 개인정보를 수집 및 처리할 수 있습니다.
개인정보 수집 항목: 성명, 연락처(전화번호, 이메일 주소 등), 주소, 생년월일, 성별 등
수집 방법: 홈페이지, 모바일 애플리케이션, 이메일, 이벤트 응모, 고객센터 문의 등</textarea>
        </section>
        
<section>
  <h5 class = "mt-3">3. 개인정보의 수집 및 이용목적</h5 class = "mt-3">
  <textarea class="form-control" rows="3" readonly>회사는 수집한 개인정보를 다음 목적을 위해 활용합니다.
서비스 제공: 상품 및 서비스 제공, 주문처리, 배송 및 환불 처리 등
회원 관리: 회원 가입 및 관리, 서비스 이용에 따른 본인 확인, 불법 및 악의적 사용 방지 등
마케팅 및 광고: 이벤트 정보 제공, 신규 서비스 안내, 마케팅 활동 수행 등
고객지원: 문의 및 불만 처리, 고객 응대 및 문제 해결 등</textarea>
</section>

<section>
  <h5 class = "mt-3">4. 개인정보의 보유 및 이용기간</h5 class = "mt-3">
  <textarea class="form-control" rows="3" readonly>회사는 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다. 다만, 관련 법령에 따라 일정 기간 동안 개인정보를 보관할 수 있으며, 보관 기간은 아래와 같습니다.
계약 및 청약철회 등에 관한 기록: 5년
대금결제 및 재화 등의 공급에 관한 기록: 5년
소비자의 불만 또는 분쟁처리에 관한 기록: 3년
본 개인정보처리 방침에서 별도로 명시한 경우: 해당 기간</textarea>
</section>

<section>
  <h5 class = "mt-3">5. 개인정보의 파기절차 및 방법</h5 class = "mt-3">
  <textarea class="form-control" rows="3" readonly>개인정보의 파기는 수집 및 이용목적이 달성된 후에 신속하게 진행되며, 다음과 같은 방법으로 파기됩니다.
종이에 출력된 개인정보: 분쇄기를 통한 파기
전자적 파일 형태로 저장된 개인정보: 기록을 재생할 수 없는 기술적 방법으로 삭제</textarea>
</section>

<section>
  <h5 class = "mt-3">6. 개인정보의 제3자 제공</h5 class = "mt-3">
  <textarea class="form-control" rows="3" readonly>회사는 원칙적으로 회원의 동의 없이 개인정보를 외부에 제공하지 않습니다. 다만, 아래 경우에는 개인정보를 제3자에게 제공할 수 있습니다.
법령 및 규정에 의한 경우
서비스 제공에 따른 계약 이행을 위하여 필요한 경우
이용자의 동의가 있는 경우</textarea>
</section>

<section>
  <h5 class = "mt-3">7. 개인정보의 안정성 확보조치</h5 class = "mt-3">
  <textarea class="form-control" rows="3" readonly>회사는 개인정보의 안정성을 확보하기 위하여 다음과 같은 조치를 취하고 있습니다.
개인정보 암호화: 개인정보를 암호화하여 저장 및 관리
접근 제한: 개인정보에 대한 접근 권한을 최소한의 인원에게만 제한
보안 프로그램 설치: 침입 차단 시스템 등을 설치하여 외부로부터의 공격 및 유출을 방지</textarea>
</section>

<section>
  <h5 class = "mt-3">8. 개인정보 주체의 권리와 의무</h5 class = "mt-3">
  <textarea class="form-control" rows="3" readonly>이용자는 개인정보에 대한 아래의 권리를 가집니다.
개인정보 열람, 정정 및 삭제 요청
개인정보 처리정지 요청
개인정보 이용 제한 요청</textarea>
</section>

<section>
  <h5 class = "mt-3">9. 개인정보 처리 관련 문의</h5 class = "mt-3">
  개인정보보호 담당자: 홍길동 <br>
	이메일 주소: admin@admin.com <br>
  전화번호: 010-1234-5678
</section>

        
        <section>
          <h5 class = "mt-3">10. 개인정보처리 방침 변경</h5 class = "mt-3">
          <textarea class="form-control" rows="3" readonly>본 개인정보처리 방침은 법령 및 회사의 정책에 따라 변경될 수 있습니다. 변경 시 본 페이지를 통해 사전 공지를 할 것입니다.</textarea>
        </section>
        
        <section>
          <h5 class = "mt-3">펀뜩</h5 class = "mt-3">
          <address>
[주소]
[연락처]
          </address>
        </section>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>




	<%@ include file="Footer.jsp" %>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
		crossorigin="anonymous"></script>
</body>

</html>