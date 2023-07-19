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
			        <li><a href="projectShipping" id="active-tab">발송·환불 관리</a></li>
			        <li><a href="projectSettlement">수수료·정산 관리</a></li>
			    </ul>
			</aside>
	
			<!-- 중앙 섹션 시작 -->
			<section id="section">
		      	<article id="article">
		      	
			      	<!-- 발송·환불 관리 시작 -->
					<div class="projectArea">
						<p class="projectTitle">발송·환불 관리</p>
						<p class="projectContent">펀딩 리워드의 발송 및 펀딩금 반환까지 한눈에 볼 수 있어요.</p>
						
						<!-- 서포터 관리 -->
						<div>
							<p class="subheading">서포터 관리</p>
							<div class="table-responsive">
							    <table class="table table-bordered">
									<tr>
										<th>발송·배송 상태</th>
										<td>
											<span class="tableTag">미발송</span>
											<span class="customSpan">1</span>건
										</td>
										<td>
											<span class="tableTag">발송 확인중</span>
											<span class="customSpan">1</span>건
										</td>
										<td>
											<span class="tableTag">배송중</span>
											<span class="customSpan">1</span>건
										</td>
										<td>
											<span class="tableTag">수령 확인중</span>
											<span class="customSpan">1</span>건
										</td>
										<td>
											<span class="tableTag">배송완료</span>
											<span class="customSpan">1</span>건
										</td>
									</tr>
									<tr>
										<th>펀딩금 반환 상태</th>
										<td>
											<span class="tableTag">신청</span>
											<span class="customSpan">1</span>건
										</td>
										<td>
											<span class="tableTag">신청취소</span>
											<span class="customSpan">1</span>건
										</td>
										<td>
											<span class="tableTag">완료</span>
											<span class="customSpan">1</span>건
										</td>
										<td colspan="2">
											<span class="tableTag">거절</span>
											<span class="customSpan">1</span>건
										</td>
									</tr>
							    </table>
							</div>
							<p class="tableDescription">
								· 리워드 발송이 완료되면 발송정보 입력을 통해 발송처리를 진행하세요.</br>
								· 상태별 건수는 발송번호 기준으로 계산됩니다.
							</p>
						</div>
						<!-- 서포터 관리 끝 -->

						<!-- 목록 -->
						<div>
							<p class="subheading">목록 <span class="sideDescription">| 총 829명</span></p>
							<div class="dropdown">
								<div class="btn-group">
								<button type="button" class="btn btn-outline-primary btn-sm dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
									발송·배송 전체 관리
								</button>
								<ul class="dropdown-menu">
									<li><a class="dropdown-item" href="#">미발송</a></li>
									<li><a class="dropdown-item" href="#">발송 확인중</a></li>
									<li><a class="dropdown-item" href="#">배송중</a></li>
									<li><a class="dropdown-item" href="#">수령 확인중</a></li>
									<li><a class="dropdown-item" href="#">배송 완료</a></li>
									<li><hr class="dropdown-divider"></li>
									<li><a class="dropdown-item" href="#">펀딩금 반환 신청</a></li>
									<li><a class="dropdown-item" href="#">펀딩금 반환 신청 취소</a></li>
									<li><a class="dropdown-item" href="#">펀딩금 반환 신청 완료</a></li>
									<li><a class="dropdown-item" href="#">펀딩금 반환 신청 거절</a></li>
								</ul>
								</div>
							</div>
							<div class="table-responsive">
							    <table class="table">
									<thead class="table-light text-center">
										<tr>
											<th scope="col">펀딩번호</th>
											<th scope="col">서포터 정보</th>
											<th scope="col">결제</th>
											<th scope="col">금액</th>
											<th scope="col">리워드</th>
											<th scope="col">발송정보</th>
											<th scope="col">발송예정일</th>
											<th scope="col">발송·배송</th>
											<th scope="col">발송번호</th>
											<th scope="col">펀딩금 반환</th>
										</tr>
									</thead>
									<tbody class="text-center">
										<tr>
											<td>1111</td>
											<td>
												진국이
												<a class="memberLink" href="#">회원정보</a>
											</td>
											<td>완료 01-01</td>
											<td>25,000원</td>
											<td>
												[패키지A] 5월초 제철 귤 '귤로향' 1 SET (배송비포함) x 1개
											</td>
											<td>
												<button class="btn btn-outline-primary" id="tableButton">입력</button>
											</td>
											<td>2023-08 초</td>
											<td>미발송</td>
											<td>1111-111</td>
											<td>
												<button class="btn btn-outline-primary" id="tableButton">신청</button>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<!-- 목록 끝-->
				</article>
			</section>
			<!-- 중앙 섹션 끝 -->

			<!-- 오른쪽 네비게이션 -->
			<aside id="aisdeRight"> 
				<!-- 관리자 피드백 -->
				<div class="admin-feedback">
				<div class="admin-title">관리자 피드백</div>
				<div class="admin-content">관리자로부터 수정, 요청사항 피드백을 받으면 이곳에 피드백 메시지가 출력됩니다.</div>
			   
					<!-- 메시지 시작 -->
					<!-- DB저장된 알림 메시지를 반복문으로 출력 -->
					<!-- 관리자 페이지에서 프로젝트를 승인, 반려 할 때
					반려되는 경우에는 해당 프로젝트를 작성한 id에게 알림 메시지로 수정해야할 내용을 전송함-->
					<!-- 해당 id가 로그인을 하게되면 상단 종모양 알림 아이콘에 읽지 않은 메시지 갯수가 표시가 됨 -->
					<!-- DB에 알림 메시지를 저장하기때문에 꼭 실시간으로 로그인을 안해도 알림내역 들어가서 확인할 수 있음 -->
					<!-- 로그인이 되어 있는 경우에는 하단에 toast팝업으로 알림도착 팝업 띄워주고 종모양 아이콘에 갯수도 변화시킴 -->
					<!-- 알림 status가 X번 일 때는 프로젝트 수정하는 url도 같이 넣어줘서 바로 프로젝트 수정 페이지로 이동시킴 -->
					<!-- 관리자가 보낸 메시지를 참고해서 내용을 수정하면 됨 -->
					<div id="notificationContainer">
					  	<div class="alert alert-info" role="alert">
							<i class="fas fa-exclamation-circle"></i><a>&nbsp;알림이 없습니다.</a>
						</div>
					</div>
				</div>
			</aside>
			<!-- 오른쪽 네비게이션 끝 -->
		</div>
	</main>
	
	<script>
	$(document).ready(function () {
        // 탭 1을 기본으로 활성화
        $("#tab1").addClass("active");
        $(".tab-button[data-tab='tab1']").addClass("active"); // 기본 탭 버튼에도 active 클래스 추가

        $(".tab-button").click(function (e) {
            e.preventDefault(); // form 태그와의 충돌 방지
            var tabId = $(this).data("tab");
            $(".content-area").removeClass("active");
            $("#" + tabId).addClass("active");

            // 탭 버튼에도 active 클래스 추가 (활성화된 탭 표시)
            $(".tab-button").removeClass("active");
            $(this).addClass("active");
        });
    });
	
	// 관리자 피드백
	function getNotifications() {
		$.ajax({
			url: '<c:url value="getNotificationByAjax"/>',
			method: 'get',
			success: function(response) {
				
			var notifications = response;
		    var notificationContainer = $('#notificationContainer');
		    notificationContainer.empty();
		    
		    $.each(notifications.slice(0, 5), function(index, notification) {
		    	var notificationContent = notification.notification_content;
		        var alertDiv = $('<div class="alert alert-info" role="alert"></div>');
		        var icon = $('<i class="fas fa-exclamation-circle"></i>');
		        var content = $('<span>&nbsp;' + notificationContent + '</span>');
		      	
		        // 읽음 처리 하기
		        content.click(function() {
        	  		markNotificationAsRead(notification.notification_idx);
	        	});
		        
		   		alertDiv.append(icon);
			    alertDiv.append(content);
    		    notificationContainer.append(alertDiv);
		   });
		},
		error: function(xhr, status, error) {
		  console.log('Error:', error);
		    }
	  });
	}
	
	$(()=>{
		getNotifications();
		setInterval(getNotifications, 5000);
	})
	
	// 메시지 읽음 처리 하기
	function markNotificationAsRead(notification_idx) {
		let confirmation = confirm("메시지를 읽음 처리 하시겠습니까?");
		if(confirmation) {
			console.log("알림번호 : " + notification_idx);
			$.ajax({
				method: 'get',
				url: '<c:url value="markNotificationAsRead"/>',
				data: {
					notification_idx: notification_idx
				},
				success: function(response){
					if(response.trim() == 'true') {
						// 알림 갯수 변경
						getNotificationCount();
						alert('읽음 처리 하였습니다!')
					} 
				},
				error: function(error) {
					console.log("읽음 처리 실패!")
				}
			})
		}
	}
	</script>

	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>