<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Profile</title>
    <%@ include file="../Header.jsp" %>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../resources/css/mypage.css" />	
    <link rel="stylesheet" type="text/css" href="../resources/css/member_profile.css" />
</head>
<body>
<section style="background-color: #f4f5f7;">
    <div style="height: 50px;"></div>
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
                                <hr class="mt-0 mb-4">
							<form id="profileForm">
							    <input type="hidden" name="member_idx" value="${profile.member_idx}" />
                                    <h6>회사 / 직책</h6>
                                <div class="row pt-1">
                                    <div class="col-6 mb-3">
                                        <h6>회사</h6>
                                        <p><input type="text" name="profile_job1" value="${profile.profile_job1}" /></p>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <h6>직책</h6>
                                        <p><input type="text" name="profile_job2" value="${profile.profile_job2}" /></p>
                                    </div>
                                </div>
                                <h6>학교 / 학과</h6>
                                <hr class="mt-0 mb-4">
                                <div class="row pt-1">
                                    <div class="col-6 mb-3">
                                        <h6>학교</h6>
                                        <p><input type="text" name="profile_school1" value="${profile.profile_school1}" /></p>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <h6>학과</h6>
                                        <p><input type="text" name="profile_school2" value="${profile.profile_school2}" /></p>
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
                <button id="saveButton" class="btn btn-primary">저장</button>
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
        	
        $.ajax({
            type: "POST",
            url: '<c:url value="/member/profile"/>',
            data: $("#profileForm").serialize(),
            dataType: "text",
            success: function (data) {
                console.log("실행");
                alert("프로필이 저장되었습니다.");
            },
            error: function () {
                alert("저장에 실패했습니다. 다시 시도해주세요.");
            }
        });
    });

    $("#cancelButton").on("click", function () {
        var formInputs = $("#profileForm :input");
        formInputs.each(function() {
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
