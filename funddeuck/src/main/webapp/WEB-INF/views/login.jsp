<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    
    <meta name ="google-signin-client_id" content="813582187815-jvb4rbrlqvfhiuahkhjl76qv9drdolom.apps.googleusercontent.com">
    
    	  
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css"/>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
            <input class="btn btn-primary mt-5 p-2 mb-2" id="LoginSubmit" type="submit" value="로그인" style="width: 300px;"/>
            </form>
            <a class="w-100 mt-2 p-2 mb-4" id="kakaoLogin" href="javascript:loginWithKakao()"><img src="${pageContext.request.contextPath }/resources/images/kakao_login_medium_wide.png"></a><br>
            <a class="w-100 mt-2 p-2 mb-4" id="naverIdLogin_loginButton" href="javascript:naverLogin()"><img style="width: 60px; margin-top: 10px; " src="${pageContext.request.contextPath }/resources/images/naver.png"></a> 
			    <a class="w-100 mt-2 p-2 mb-4" id="googleSignInButton" href="javascript:void(0)">
			      <img style="width: 60px; margin-top: 10px;" src="${pageContext.request.contextPath}/resources/images/google.png"/>
			    </a>

			<hr>아직 계정이 없으신가요? <a class=" mt-2" href="JoinForm" style="color: blue">회원가입</a>
        </div>
        <div class="col"></div>
    </div>


<!-- 카카오 로그인 -->

<script type="text/javascript">
	Kakao.init('a72647ac003380343c63c5e2d79586a3');
	console.log(Kakao.isInitialized());
	function loginWithKakao(){
		// 카카오 로그인 실행시 오류메시지를 표시하는 경고창을 화면에 보이지 않게 한다.
		// 카카오 로그인 서비스 실행하기 및 사용자 정보 가져오기.
		Kakao.Auth.login({
			success:function(response){
				Kakao.API.request({
					url: '/v2/user/me',
					success: function(response){
						// 사용자 정보를 가져와서 폼에 추가.
						var email = response.kakao_account.email;
						
                        $.ajax({
                        	type:"post",
                        	url:"isKakao",
                        	data:{email:email},
                        	dataType:"text",
                        	success: function(data) {
								if(data == "true"){
									location.href="./";	
								} else if (data == "fail_back"){
									alert("탈퇴된 계정입니다.");
								}else {
									const swalWithBootstrapButtons = Swal.mixin({
										  customClass: {
										    confirmButton: 'btn btn-success',
										    cancelButton: 'btn btn-danger'
										  },
										  buttonsStyling: false
										})

										swalWithBootstrapButtons.fire({
										  title: '가입되지 않은 계정입니다.',
										  text: "회원가입 페이지로 이동하시겠습니까?",
										  icon: 'warning',
										  showCancelButton: true,
										  confirmButtonText: '네',
										  cancelButtonText: '아니오',
										  reverseButtons: true
										}).then((result) => {
										  if (result.isConfirmed) {
											  location.href="JoinForm";	
										  } else if (result.dismiss === Swal.DismissReason.cancel) {
											  
										  }
										})
									
									
								}
							},
							error: function() {
								
							}
                        });
                        
					},
					fail: function(error){
						alert("실패");
					}
				}); // api request
			}, // success 결과.
			fail:function(error){
				// 경고창에 에러메시지 표시
				alert("실패");
			}
		}); // 로그인 인증.
	} // 클릭이벤트
</script>
<!-- 네이버 로그인 -->

<script>
    var naverLogin = new naver.LoginWithNaverId(
    		{
    			clientId: "gafBue35LX_gbVST1SFI", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
    			callbackUrl: "http://localhost:8080/test/LoginForm", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
    			isPopup: false,
    			callbackHandle: true
    		}
    	);	

    naverLogin.init();
    
    if (location.href.indexOf("access_token") !== -1) {
        processCallback();
    }

function processCallback() {

        	naverLogin.getLoginStatus(function (status) {
        		if (status) {
        			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
  			      console.log(email);
			      console.log(naverLogin);
                    if(email == undefined || email == null) {
        				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
        				naverLogin.reprompt();
        				return false;
        			}
        			
                    $.ajax({
                    	type:"post",
                    	url:"isKakao",
                    	data:{email:email},
                    	dataType:"text",
                    	success: function(data) {
							if(data == "true"){
								location.href="./";
							} else if (data == "fail_back"){
								alert("탈퇴된 계정입니다.");
							}else {
								const swalWithBootstrapButtons = Swal.mixin({
									  customClass: {
									    confirmButton: 'btn btn-success',
									    cancelButton: 'btn btn-danger'
									  },
									  buttonsStyling: false
									})

									swalWithBootstrapButtons.fire({
									  title: '가입되지 않은 계정입니다.',
									  text: "회원가입 페이지로 이동하시겠습니까?",
									  icon: 'warning',
									  showCancelButton: true,
									  confirmButtonText: '네',
									  cancelButtonText: '아니오',
									  reverseButtons: true
									}).then((result) => {
									  if (result.isConfirmed) {
										  location.href="JoinForm";	
									  } else if (result.dismiss === Swal.DismissReason.cancel) {
										  
									  }
									})
							}
						},
						error: function() {
							
						}
                    });
        			
        			
        		} else {
        			console.log("callback 처리에 실패하였습니다.");
        		}
        	});
}


        var testPopUp;
        function openPopUp() {
            testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
        }
        function closePopUp(){
            testPopUp.close();
        }

        function naverLogout() {
        	openPopUp();
        	setTimeout(function() {
        		closePopUp();
        		}, 1000);
        	
        	
        }

</script>







    <%@ include file="Footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>

</html>