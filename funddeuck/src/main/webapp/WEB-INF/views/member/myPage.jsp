<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <%@ include file="../Header.jsp" %>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/mypage.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style type="text/css" rel="stylesheet">
        a {
            text-decoration: none;
        }
        .border-1{
            border-bottom: 1px solid lightgray;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
    </script>
</head>


<body>
    <hr>
    <!-- 탑 영역 -->
    
    <!-- 백그라운드 -->
    <section style="position: relative;">
        <div class="bg-primary" style="height: 200px; width: 100%; position: absolute; top: 0; left: 0;"></div>
        <!-- 백그라운드 -->
        <!-- 마이페이지 시작 -->
        <div class="container"
            style="position: absolute; top: 0; left:50% ; transform: translateX(-50%); margin-top: 100px;">
            <div class="row bg-white">
                <!-- 프로필 영역 -->
                <div class="col-md-2 col-12 text-center mt-3" style="border-right: solid 1px lightgray;">
                    <div>
                        <img class="mt-5 center" style="width: 80px; height: 80px;">
                    </div>
                    <br>
                    <div>
                        <a href="" class="text-black">닉네임님</a>
                    </div>
                    <hr>
                    <button class="btn" style="border-radius: 50px;">로그아웃</button><br>
					<button class="btn" style="border-radius: 50px;" onclick="location.href='profile'">프로필수정</button>
                </div>
                <!-- 프로필 영역 -->
                <!-- 쿠폰, 펀딩, 스토어 영역 -->
                <div class="col">
                    <div class="row mt-5 h6">
                        <div class="col-sm-12 col-md-4">
                            <a href="" class="text-black w-100">
                                <div class="row ms-md-1 me-md-1" style="border: 1px solid lightgray; border-radius: 7px;">
                                    <div class="col text-start m-3">
                                        쿠폰
                                    </div>
                                    <div class="col text-end m-3">
                                        x개
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md">
                            <div class="row me-md-3" style="border: 1px solid lightgray; border-radius: 7px;">
                                <div class="col" style="border-right: solid 1px lightgray;">
                                    <a href="MemberFunDing" class="text-black">
                                        <div class="row">
                                            <div class="col text-start m-3">
                                                펀딩
                                            </div>
                                            <div class="col text-end m-3">
                                                x개
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="col">
                                    <a href="" class="text-black">
                                        <div class="row">
                                            <div class="col text-start m-3">
                                                스토어
                                            </div>
                                            <div class="col text-end m-3">
                                                x개
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 쿠폰, 펀딩, 스토어 영역 -->
                    <hr>
                    <div class="row mt-5 mx-3 border-1">
                        <div class="col-12">
                            <h5>나의 활동</h5>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="FallowingForm" class="text-black w-100">
                                <div class="row me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-people"></i> 팔로잉
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="ZimForm" class="text-black w-100">
                                <div class="row  ms-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-arrow-through-heart"></i> 찜하기
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="reviewListPage" class="text-black w-100">
                                <div class="row me-md-2">
                                    <div class="col text-start my-3">
                                       <i class="bi bi-pencil-square"></i> 리뷰
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="row mt-5 mx-3 border-1">
                        <div class="col-12">
                            <h5>나의 문의 내역</h5>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="" class="text-black w-100">
                                <div class="row   me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-envelope-at"></i> 서포터 문의
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="" class="text-black w-100">
                                <div class="row  ms-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-envelope-at-fill"></i> 메이커 문의
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="row mt-5 mx-3 border-1">
                        <div class="col-12">
                            <h5>고객센터</h5>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="" class="text-black w-100">
                                <div class="row   me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-chat-left-dots"></i> 1대1 상담
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="" class="text-black w-100">
                                <div class="row  ms-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-journals"></i> 도움말 센터
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="row mt-5 mx-3 border-1">
                        <div class="col-sm-12 col-md-6">
                            <a href="" class="text-black w-100">
                                <div class="row   me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-megaphone"></i> 공지사항
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="" class="text-black w-100">
                                <div class="row  ms-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <i class="bi bi-gear"></i> 설정
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div class="row" style="height: 100px;"></div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>