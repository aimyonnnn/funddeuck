<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
	<script>

	</script>
</head>
<body>
	<!-- include -->
 	<jsp:include page="../common/project_top.jsp"/>

	<main id="main">
		<div class="containerCSS">
      
	      	<!-- 왼쪽 네비게이션 시작 -->
			<aside id="aisdeLeft">
			    <div id="projectManagement">
					<img src="${pageContext.request.contextPath}/resources/images/managementImage.jpg" width="200px" height="150px">
			    	${sessionScope.sId}님의 프로젝트
			    </div>
			    <ul id="navMenu">
			        <li>
			            <a href="#" class="toggleTab">
			                &nbsp;&nbsp;&nbsp;프로젝트 관리
			                <i class="fas fa-caret-down"></i>
			            </a>
			            <ul class="subMenu">
			                <li><a href="projectMaker">메이커 정보</a></li>
			                <li><a href="projectManagement" id="active-tab">프로젝트 등록</a></li>
			                <li><a href="projectReward">리워드 설계</a></li>
			            </ul>
			        </li>
			        <li><a href="projectStatus">프로젝트 현황</a></li>
			        <li><a href="projectShipping">발송·환불 관리</a></li>
			        <li><a href="projectSettlement" id="active-tab">수수료·정산 관리</a></li>
			    </ul>
			</aside>
	
			<!-- 중앙 섹션 시작 -->
			<section id="section">
		      	<article id="article">
					<div class="projectArea">
						<p class="projectTitle">메이커 챌린지</p>
						<p class="projectContent">미션을 수행하고 메이커 등급을 올려보세요!</p>
						
					<div class="row mt-5">
						<div class="col">
		            		<div class="row">
		            		
				                <div class="col-12 col-md-6">
			                        <table class="table text-center projectContent">
	                            		<tr>
			                                <td colspan="2">
                                	            <img src="${pageContext.request.contextPath}/resources/images/challenge.png" width="450px" height="450px">
			                                </td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 30%">메이커명</th>
			                                <td style="width: 70%">XXX 메이커</td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 30%">현재 점수</th>
			                                <td style="width: 70%">1</td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 30%">현재 레벨</th>
			                                <td style="width: 70%">1</td>
	                            		</tr>
	                        		</table>
		               			</div>
		               			
				                <div class="col-12 col-md-6">
			                        <table class="table projectContent">
	                           			<tr class="text-center">
			                                <th colspan="2">미션 리스트</th>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 20%">Mission 1.</th>
			                                <td style="width: 80%">
			                                	프로젝트를 생성하셨나요?<br>
			                                	이제, 첫 리워드를 등록해주세요!
			                                </td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 20%">Mission 2.</th>
			                                <td style="width: 80%">
			                                	리워드 등록까지 완료하셨나요?<br>
			                                	프로젝트 승인요청을 하여 검수를 진행해주세요!<br>
			                                	리워드 페이지 하단에 승인요청 버튼이 있습니다!
			                                </td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 20%">Mission 3.</th>
			                                <td style="width: 80%">
			                                	프로젝트 검수가 끝나셨나요?<br>
			                                	요금제 결제를 하고하면 펀딩+ 페이지에서 프로젝트를 확인할 수 있어요!
			                                </td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 20%">Mission 4.</th>
			                                <td style="width: 80%">
			                                	판매량을 이끌기 위한 첫단계!<br>
			                                	메이커 페이지를 꾸미러 가볼까요?
			                                </td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 20%">Mission 5.</th>
			                                <td style="width: 80%">
			                                	서포터분들에게 전달하고 싶은 말이 있을땐?<br>
			                                	공지사항 게시판에 첫 게시글을 작성해보러 갈까요?<br>
			                                </td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 20%">Mission 6.</th>
			                                <td style="width: 80%">
			                                	프로젝트 전체적인 진행상황이 궁금하신가요?<br>
			                                	전체 현황을 한 눈에 확인할 수 있는 프로젝트 현황 페이지로 이동해볼까요?
			                                </td>
	                            		</tr>
	                           			<tr>
			                                <th style="width: 20%">Mission 7.</th>
			                                <td style="width: 80%">
			                                	프로젝트 진행에 어려움이 있을땐?<br>
			                                	고객센터의 1대1 문의하기를 이용해주세요<br>
			                                	담당자가 확인후 최대한 빠르게 답변을 해드립니다!
			                                </td>
	                            		</tr>
	                        		</table>
		               			</div>
		               			
		            		</div>
		        		</div>
		    		</div>
				
					</div>
				</article>
			</section>
		</div>
	</main>
	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>