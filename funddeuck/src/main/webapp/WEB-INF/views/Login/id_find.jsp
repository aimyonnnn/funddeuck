<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Bootstrap demo</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
  integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css"/>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script type="text/javascript">
  	$(function() {
		$("#btn").click(function() {
        	let email = $("#email").val();
        	let pattern = /^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/;
        	let result = pattern.test(email);
        	
			if(email.length == 0) {
				$("#isEmail").remove();
				$("#email").after(
					"<div id='isEmail' style='color: red;'>"
					+ "이메일을 작성해주세요."
					+ "</div>"
				);
				return false;
			}
			
			if(!result){
				$("#isEmail").remove();
				$("#email").after(
					"<div id='isEmail' style='color: red;'>"
					+ "이메일 형식이 아닙니다."
					+ "</div>"
				);
				return false;
			}
			
			$.ajax({
				type:"post",
				url:"idFindPro",
				data:{email:email},
				dataType:"json",
				success: function(data) {
					if(data.result == "true"){
						
						const swalWithBootstrapButtons = Swal.mixin({
							  customClass: {
							    confirmButton: 'btn btn-success',
							    cancelButton: 'btn btn-danger'
							  },
							  buttonsStyling: false
							})

							swalWithBootstrapButtons.fire({
							  title: '아이디는 ('+data.member.member_id+') 입니다!',
							  text: "비밀번호를 찾으러 가시겠습니까?",
							  icon: 'success',
							  showCancelButton: true,
							  confirmButtonText: '응 갈래!',
							  cancelButtonText: '아니 로그인 할거야',
							  reverseButtons: true
							}).then((result) => {
							  if (result.isConfirmed) {
							    location.href="passwdFindForm";
							  } else if (
							    result.dismiss === Swal.DismissReason.cancel
							  ) {
								  location.href="LoginForm";
							  }
							})
						
					} else {
						Swal.fire(
								  '아이디 조회 결과가 없습니다!',
								  '',
								  'question'
								)
					}
					
					
				},
				error: function() {
					Swal.fire({
						  icon: 'error',
						  title: 'Oops...',
						  text: '오류!',
						});
				}
			});
			
		});
	})
  </script>
</head>
<body>
<%@ include file="../Header.jsp" %>
  <div class="row text-center" style="margin-top: 100px;">
    <div class="col"></div>
    <div class="col-12 col-md-8">
      <h3><strong>아이디∙비밀번호 찾기</strong></h3>
      <div class="row mt-5">
        <div class="col"></div>
        <div class="col p-1">
                  <a href="idFindForm" class="pb-1" style="font-size:18px; border-bottom: 3px solid #ff9300; color: #ff9300; text-decoration: none;">아이디 찾기</a>
        </div>
        <div class="col p-1">
          <a href="passwdFindForm" class="pb-1" href="" style="font-size:18px; text-decoration: none; color: #0000008a;">비밀번호 찾기</a>
        </div>
        <div class="col"></div>
      </div>
    </div>
    <div class="col"></div>
  </div>
  <div class="row" id="idResultArea" style="background-color: #eeeeee; padding-bottom:100px ;">
    <div class="col"></div>
    <div class="col-12 mt-5 col-md-4 col-sm-8">
      <div style="color: #0000008a;">
        가입하셨던 이메일 계정을 입력하시면,<br>
        가입하신 아이디를 보여드립니다.
      </div>
        <input type="text" id="email" class="form-control mt-5 py-3" placeholder="이메일 계정">
      <input type="button" id="btn" class="btn btn-primary w-100 mt-3" value="아이디 조회">
    </div>
    <div class="col"></div>
  </div>
  <div style="height:400px"></div>

  <%@ include file="../Footer.jsp" %>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
    crossorigin="anonymous"></script>
</body>

</html>