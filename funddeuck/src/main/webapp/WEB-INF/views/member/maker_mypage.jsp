<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	    
		.card-img-top {
			height: 100px;
			object-fit: cover;
		}
		
		.card {
			height: 90%;
		}
		
		.button-group {
        	justify-content: space-between; /* 버튼 사이의 공간을 균등하게 배치 */
    	}
    	
    	.card-title {
    		font-size: 14px;
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
			     			<a class="nav-link text-white" id="member-tab" href="memberMypage">회원</a>
			    		</li>
					    <li class="nav-item">
					    	<a class="nav-link text-primary active" id="maker-tab" href="makerMypage">메이커</a>
					    </li>
			  		</ul>
		  		</div>
			</div>
						
            <div class="row bg-white">
                <!-- 프로필 영역 -->
                <div class="col-md-2 col-12 text-center mt-3" style="border-right: solid 1px lightgray;">
				<div>
				    <c:choose>
				        <c:when test="${not empty maker.maker_file4}">
				            <img class="mt-5 center" src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file4}"
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
                    <a href="" class="text-black">${maker.maker_name}님</a>
                </div>
                <hr>
                <button class="btn" style="border-radius: 50px;">로그아웃</button><br>
				<button class="btn btn-primary" style="border-radius: 50px;" onclick="location.href='makerDetail?maker_idx=${maker.maker_idx}'">메이커페이지 바로가기</button>
                </div>
                <!-- 프로필 영역 -->
                <!-- 프로젝트 목록 영역 -->
                <div class="col">
                    <div class="row mt-5 mx-3 border-1">
                        <div class="col-12 me-4">
                            <h5 class="fw-bold">현재 작성중인 프로젝트</h5>
                        </div>
                        <!-- 프로젝트 카드 영역 시작 -->
                        <c:choose>
						    <c:when test="${empty unapprovedList}">
						        <span>현재 작성중인 프로젝트가 없습니다.</span>
						    </c:when>
						    <c:otherwise>
			                	<c:forEach var="unapproved" items="${unapprovedList }">
						        <div class="col-12 col-sm-6 col-md-4 col-lg-3 mt-2">
						            <div class="card mb-3">
						                <img src="${pageContext.request.contextPath}/resources/upload/${unapproved.project_thumnails1}" class="card-img-top" alt="프로젝트 사진 없음">
						                <div class="card-body">
						                    <h5 class="card-title">${unapproved.project_subject }</h5>
						                    <div class="d-flex button-group">
											    <a href="projectReward?project_idx=${unapproved.project_idx}" class="btn btn-sm me-5">
											    	<img src="${pageContext.request.contextPath }/resources/images/icon/move.png" style="width: 30px; height: 30px;">
											    </a>
											    <form action="projectDelete" method="post" class="d-inline ml-auto">
											        <input type="hidden" name="project_idx" value="${unapproved.project_idx}" />
											        <button type="submit" class="btn btn-sm ms-5">
					                                    <img src="${pageContext.request.contextPath }/resources/images/icon/delete.png" style="width: 30px; height: 30px;">
					                                </button>
											    </form>
											</div>
						                </div>
						            </div>
						        </div>
			                	</c:forEach>
			                </c:otherwise>
						</c:choose>
				        <!-- 프로젝트 카드 영역 끝 -->
					</div>
                    <div class="row mt-5 mx-3 border-1">
                        <div class="col-12">
                            <h5 class="fw-bold">현재 진행중인 프로젝트</h5>
                        </div>
                        <!-- 프로젝트 카드 영역 시작 -->
                        <c:choose>
						    <c:when test="${empty proceedingList}">
						        <span>현재 진행중인 프로젝트가 없습니다.</span>
						    </c:when>
						    <c:otherwise>
			                	<c:forEach var="proceeding" items="${proceedingList }">
						        <div class="col-12 col-sm-6 col-md-4 col-lg-3 mt-2">
						            <div class="card mb-3">
						                <img src="${pageContext.request.contextPath}/resources/upload/${proceeding.project_thumnails1}" class="card-img-top" alt="프로젝트 사진 없음">
						                <div class="card-body">
						                    <h5 class="card-title">${proceeding.project_subject }</h5>
						                    <a href="fundingDetail?project_idx=${proceeding.project_idx }" class="btn btn-sm">
						                    	<img src="${pageContext.request.contextPath }/resources/images/icon/move.png" style="width: 30px; height: 30px;">
						                    </a>
						                </div>
						            </div>
						        </div>
			                	</c:forEach>
			                </c:otherwise>
			            </c:choose>
				        <!-- 프로젝트 카드 영역 끝 -->
					</div> 
					<div class="row mt-5 mx-3 border-1">
                        <div class="col-12">
                            <h5 class="fw-bold">현재 완료된 프로젝트</h5>
                        </div>
                        <!-- 프로젝트 카드 영역 시작 -->
                        <c:choose>
						    <c:when test="${empty completeList}">
						        <span>현재 진행중인 프로젝트가 없습니다.</span>
						    </c:when>
						    <c:otherwise>
			                	<c:forEach var="complete" items="${completeList }">
						        <div class="col-12 col-sm-6 col-md-4 col-lg-3 mt-2">
						            <div class="card mb-3">
						                <img src="${pageContext.request.contextPath}/resources/upload/${complete.project_thumnails1}" class="card-img-top" alt="프로젝트 사진 없음">
						                <div class="card-body">
						                    <h5 class="card-title">${complete.project_subject }</h5>
						                    <a href="fundingDetail?project_idx=${complete.project_idx }" class="btn btn-sm">
						                    	<img src="${pageContext.request.contextPath }/resources/images/icon/move.png" style="width: 30px; height: 30px;">
						                    </a>
						                </div>
						            </div>
						        </div>
			                	</c:forEach>
			                </c:otherwise>
			            </c:choose>
				        <!-- 프로젝트 카드 영역 끝 -->
					</div>
					
					<div class="row mt-5 mx-3 border-1">
                        <div class="col-12">
                            <h5 class="fw-bold">프로젝트 관리</h5>
                        </div>
                        
                        <div class="col-sm-12 col-md-6">
                            <a href="projectStatus" class="text-black w-100">
                                <div class="row me-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/project.png" style="width: 30px; height: 30px;"> 프로젝트 관리
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="fundingDoctorAnswer" class="text-black w-100">
                                <div class="row ms-md-2 me-md-2">
                                    <div class="col text-start my-3">
                                        <img src="${pageContext.request.contextPath }/resources/images/icon/doctor.png" style="width: 30px; height: 30px;"> 펀딩 닥터
                                    </div>
                                    <div class="col text-end my-3">
                                        <i class="bi bi-arrow-return-right"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col-sm-12 col-md-6">
                            <a href="makerChattingRoomList" class="text-black w-100">
                                <div class="row  me-md-2 me-md-2">
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
				</div>
			</div>
            <div class="row" style="height: 100px;"></div>
		</div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
        crossorigin="anonymous"></script>
</body>
</html>