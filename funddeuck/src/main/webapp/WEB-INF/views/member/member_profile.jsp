<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>Profile</title>
    <%@ include file="../Header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="./resources/css/mypage.css" />	
    <link rel="stylesheet" type="text/css" href="./resources/css/member_profile.css" />
</head>
<body>
			<section style="background-color: #f4f5f7;">
			   <div style="height:80px;"></div>
			    <div style="height: 50px;"></div>
			    <div class="container py-5">
			        <div class="row d-flex justify-content-center align-items-center">
			            <div class="col col-lg-6 mb-4 mb-lg-0">
			                <div class="card mb-3" style="border-radius: .5rem;">
			                    <div class="row g-0">
			                        <h3 class="profile-heading">프로필 정보 설정</h3>
									<div class="col-md-4 gradient-custom text-center text-white" style="border-top-left-radius: .5rem; border-bottom-left-radius: .5rem;">
									  <div class="circle-image">
									    <img src="<c:choose>
						                 <c:when test="${not empty profile.profile_img}">
						                     ${pageContext.request.contextPath}/resources/upload/${profile.profile_img}
						                 </c:when>
						                 <c:otherwise>
						                     https://cdn.pixabay.com/photo/2017/04/20/01/46/focus-2244304_1280.png
						                 </c:otherwise>
						             </c:choose>"
						         alt="프로필 사진을 업로드 해주세요" style="max-height: 100px;">
						  </div>
						  <br>
						  <form action="updateProfileImage" method="post" enctype="multipart/form-data">
							    <input type="hidden" name="member_idx" value="${sessionScope.sIdx}" />
						      <div class="custom-file">
						          <input type="file" class="custom-file-input" name="file"  value="바꾸기" id="customFile">
						          <label class="custom-file-label" for="customFile"></label>
						      </div>
						      <button type="submit" class="btn btn-primary mt-3">사진 저장</button>
						  </form>
						</div>



                        <div class="col-md-8">
                            <div class="card-body p-4">
							<form id="profileForm">
                                <hr class="mt-0 mb-4">
							    <input type="hidden" name="member_idx" value="${sessionScope.sIdx}" />
							    
                                    <h6>회사 / 직책</h6>
                                <div class="row pt-1">
                                    <div class="col-6 mb-3">
                                        <h6>회사</h6>
                                        <p><input type="text" name="profile_job1" value="${profile.profile_job1}" style="width: 150px" /></p>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <h6>직책</h6>
                                        <p><input type="text" name="profile_job2" value="${profile.profile_job2}" style="width: 150px" /></p>
                                    </div>
                                </div>
                                <h6>학교 / 학과</h6>
                                <hr class="mt-0 mb-4">
                                <div class="row pt-1">
                                    <div class="col-6 mb-3">
                                        <h6>학교</h6>
                                        <p><input type="text" name="profile_school1" value="${profile.profile_school1}" style="width: 150px" /></p>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <h6>학과</h6>
                                        <p><input type="text" name="profile_school2" value="${profile.profile_school2}" style="width: 150px" /></p>
                                    </div>
                                </div>
                                <h6>간단한 말 한마디로 나를 소개해주세요</h6>
                                <hr class="mt-0 mb-4">
                                <div class="row pt-1">
                                    <div class="col-6 mb-3">
                                        <p><textarea name="profile_text" placeholder="내용을 입력해주세요">${profile.profile_text}</textarea></p>
                                    </div>
                                    <div class="d-flex justify-content-start">
                                        <a href="#!"><i class="fab fa-facebook-f fa-lg me-3"></i></a>
                                        <a href="#!"><i class="fab fa-twitter fa-lg me-3"></i></a>
                                        <a href="#!"><i class="fab fa-instagram fa-lg"></i></a>
                                    </div>
                                </div>
                        </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    <div class="button-container">
        <c:choose>
            <c:when test="${isProfileSaved}">
                <button id="saveButton" class="btn btn-primary">수정</button>
            </c:when>
            <c:otherwise>
                <button id="joinButton" class="btn btn-primary">등록</button>
            </c:otherwise>
        </c:choose>
        <button id="cancelButton" class="btn btn-primary">취소</button>
    </div>
        </div>
    </div>
</section>

<%@ include file="../Footer.jsp" %>

<script>
    $(document).ready(function () {
        $("#saveButton").on("click", function () {
            console.log("수정");
            
            console.log($("input[name='profile_job1']").val());
            console.log($("input[name='profile_job2']").val());
            console.log($("input[name='profile_school1']").val());
            console.log($("input[name='profile_school2']").val());
            console.log($("input[name='profile_text']").val());
            console.log($("input[name='member_idx']").val());

            var formData = new FormData();
            formData.append('profile_job1', $("input[name='profile_job1']").val());
            formData.append('profile_job2', $("input[name='profile_job2']").val());
            formData.append('profile_school1', $("input[name='profile_school1']").val());
            formData.append('profile_school2', $("input[name='profile_school2']").val());
            formData.append('profile_text', $("textarea[name='profile_text']").val());
            formData.append('member_idx', $("input[name='member_idx']").val());

            
            $.ajax({
                type: "POST",
                url: '<c:url value="/profile"/>',
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    console.log("실행");
                    alert("프로필이 저장되었습니다.");
                   	location.reload();
                },
                error: function () {
                    alert("저장에 실패했습니다. 다시 시도해주세요.");
                }
            });
        });

        $("#joinButton").on("click", function () {
            
        	var sIdx = '${sessionScope.sIdx}';
        	
        	console.log("등록");
            console.log($("input[name='profile_job1']").val());
            console.log($("input[name='profile_job2']").val());
            console.log($("input[name='profile_school1']").val());
            console.log($("input[name='profile_school2']").val());
            console.log($("input[name='profile_text']").val());
            console.log(sIdx);


            var formData = new FormData();
            formData.append('profile_job1', $("input[name='profile_job1']").val());
            formData.append('profile_job2', $("input[name='profile_job2']").val());
            formData.append('profile_school1', $("input[name='profile_school1']").val());
            formData.append('profile_school2', $("input[name='profile_school2']").val());
            formData.append('profile_text', $("textarea[name='profile_text']").val());
            formData.append('member_idx', sIdx);

            $.ajax({
                type: "POST",
                url: '<c:url value="/insert"/>', 
                data: formData,
                processData: false,
                contentType: false,
                success: function (data) {
                    console.log("실행");
                    alert("프로필이 저장되었습니다.");
                    location.reload();
                },
                error: function () {
                    alert("저장에 실패했습니다. 다시 시도해주세요.");
                }
            });
        });
        
        $("#cancelButton").on("click", function () {
            var formInputs = $("#profileForm :input");
            formInputs.each(function () {
                var prevValue = $(this).data("prev-value");
                if (prevValue !== undefined) {
                    $(this).val(prevValue);
                }
            });
        });
        
        
   });
        

</script>


</body>
</html>
