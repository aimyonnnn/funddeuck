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
        
        .nav-tabs-no-border {
	      	border-bottom: none !important;
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
        <div class="bg-primary" style="height: 400px; width: 100%; position: absolute; top: 0; left: 0;"></div>
        <!-- 백그라운드 -->
        <!-- 마이페이지 시작 -->
        <div class="container"
            style="position: absolute; top: 0; left:50% ; transform: translateX(-50%); margin-top: 100px;">
            <!-- 서포터와 메이커 구분 탭 -->
			<div class="container">
				<div class="bg-primary rounded" style="padding: 0.5rem; padding-bottom: 0;">
			 		<ul class="nav nav-tabs nav-tabs-no-border justify-content-end">
			    		<li class="nav-item">
			     			<a class="nav-link active text-primary" id="member-tab" href="memberMypage">회원</a>
			    		</li>
					    <li class="nav-item">
					    	<a class="nav-link text-white" id="maker-tab" href="makerMypage">메이커</a>
					    </li>
			  		</ul>
		  		</div>
						
            <div class="row bg-white">
                <!-- 프로필 영역 -->
                <div class="col-md-2 col-12 text-center mt-3" style="border-right: solid 1px lightgray;">
				<div>
				    <c:choose>
				        <c:when test="${not empty profile.profile_img}">
				            <img class="mt-5 center" src="${pageContext.request.contextPath}/resources/upload/${profile.profile_img}"
				                 style="width: 80px; height: 80px;">
				        </c:when>
				        <c:otherwise>
				            <img class="mt-5 center" src="https://cdn.pixabay.com/photo/2017/04/20/01/46/focus-2244304_1280.png"
				                 style="width: 80px; height: 80px;">
				        </c:otherwise>
				    </c:choose>
				</div>


                    <br>
                    <div>
                        <a href="" class="text-black">${sessionScope.sId}님</a>
                    </div>
                    <hr>
                    <button class="btn" style="border-radius: 50px;">로그아웃</button><br>
					<button class="btn" style="border-radius: 50px;" onclick="location.href='profile'">프로필수정</button>
                </div>
                <!-- 프로필 영역 -->
                <!-- 쿠폰, 펀딩, 스토어 영역 -->
                <div class="col">
                    <div class="row mt-5 h6">
                        <div class="col-sm-12 col-md-6">
                            <a href="coupon" class="text-black w-100">
                                <div class="row ms-md-1 me-md-1" style="border: 1px solid lightgray; border-radius: 7px;">
                                    <div class="col text-start m-3">
                                        쿠폰
                                    </div>
                                    <div class="col text-end m-3">
                                    사용 가능한 쿠폰 확인하기
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md">
                             <div class="col">
                                 <a href="MemberFunDing" class="text-black">
                                     <div class="row me-3" style="border: 1px solid lightgray; border-radius: 7px;">
                                         <div class="col text-start m-3">
                                             펀딩
                                         </div>
                                         <div class="col text-end m-3">
                                             ${fundingCount } 개
                                         </div>
                                     </div>
                                 </a>
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
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/following.png" style="width: 30px; height: 30px;"> 팔로잉
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
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/mine.png" style="width: 30px; height: 30px;"> 찜하기
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
                                       <img src="${pageContext.request.contextPath }/resources/images/icon/review.png" style="width: 30px; height: 30px;"> 리뷰
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
                            <a href="memberChattingRoomList" class="text-black w-100">
                                <div class="row me-md-2">
                                    <div class="col text-start my-3">
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/chat.png" style="width: 30px; height: 30px;"> 1대1 채팅 문의
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
                                <div class="row me-md-2">
                                    <div class="col text-start my-3">
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/question.png" style="width: 30px; height: 30px;"> 1대1 상담
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="" class="text-black w-100">
                                <div class="row ms-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/help.png" style="width: 30px; height: 30px;"> 도움말 센터
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
                            <a href="helpNotice" class="text-black w-100">
                                <div class="row  me-md-2">
                                    <div class="col text-start my-3">
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/notice.png" style="width: 30px; height: 30px;"> 공지사항
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="modifyMember" class="text-black w-100">
                                <div class="row  ms-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/setting.png" style="width: 30px; height: 30px;"> 정보수정
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
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>