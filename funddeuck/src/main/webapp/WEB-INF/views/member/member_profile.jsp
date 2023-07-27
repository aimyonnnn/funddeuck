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
						<form id="profileimgForm">
						    <input type="file" id="imageInput" style="display: none;" accept="image/*">
						    <img src="${profile.profile_img}"
						         name = "profile_img" alt="profile" class="img-fluid my-5" style="width: 80px;" />
						    <div class="Imgcontainer">
						        <a href="#!" id="changeImg">바꾸기</a>
						        <a href="#!" id="deleteImg">삭제</a>
						    </div>
						</form>
						</div>

                        <div class="col-md-8">
                            <div class="card-body p-4">
							<form id="profileForm">
                                <hr class="mt-0 mb-4">
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

            var formData = new FormData();
            formData.append('profile_img', $("input[name='profile_img']").val());
            formData.append('profile_job1', $("input[name='profile_job1']").val());
            formData.append('profile_job2', $("input[name='profile_job2']").val());
            formData.append('profile_school1', $("input[name='profile_school1']").val());
            formData.append('profile_school2', $("input[name='profile_school2']").val());
            formData.append('profile_text', $("textarea[name='profile_text']").val());
            formData.append('member_idx', $("input[name='member_idx']").val());

            const imageInput = document.getElementById("imageInput");
            if (imageInput.files.length > 0) {
                formData.append('profile_img', imageInput.files[0]);
            }

            $.ajax({
                type: "POST",
                url: '<c:url value="/member/profile"/>',
                data: formData,
                processData: false,
                contentType: false,
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
            formInputs.each(function () {
                var prevValue = $(this).data("prev-value");
                if (prevValue !== undefined) {
                    $(this).val(prevValue);
                }
            });
        });

        document.getElementById("changeImg").addEventListener("click", function (event) {
            event.preventDefault();
            const imageInput = document.getElementById("imageInput");
            imageInput.click();
        });

        document.getElementById("imageInput").addEventListener("change", function (event) {
            const selectedFile = event.target.files[0];
            const reader = new FileReader();

            reader.onload = function () {
                const newImageUrl = reader.result;
                const profileImg = document.querySelector(".img-fluid");
                profileImg.src = newImageUrl;

                alert("프로필 이미지가 변경되었습니다.");

                $("#saveButton").prop("disabled", false);
            };

            reader.readAsDataURL(selectedFile);
        });

        document.getElementById("deleteImg").addEventListener("click", function (event) {
            event.preventDefault();

            const confirmDelete = confirm("프로필 사진을 삭제하시겠습니까?");
            if (confirmDelete) {
                const profileImg = document.querySelector(".img-fluid");
                profileImg.src = ""; 

                alert("프로필 사진이 삭제되었습니다.");

                $("#saveButton").prop("disabled", false);
            }
        });
    });
</script>


</body>
</html>
