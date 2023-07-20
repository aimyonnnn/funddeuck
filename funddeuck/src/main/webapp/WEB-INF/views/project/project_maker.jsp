<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
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

	<!--  -->
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
		                <li><a href="projectMaker" id="active-tab">메이커 정보</a></li>
		                <li><a href="projectManagement">프로젝트 등록</a></li>
		                <li><a href="projectReward">리워드 설계</a></li>
		            </ul>
		        </li>
		        <li><a href="projectStatus">프로젝트 현황</a></li>
		        <li><a href="projectShipping">발송·환불 관리</a></li>
		        <li><a href="projectSettlement">수수료·정산 관리</a></li>
		    </ul>
		</aside>

      <!-- 중앙 섹션 시작 -->
      <section id="section">
        <article id="article">
			<div class="mt-5">
	   			<img src="${pageContext.request.contextPath}/resources/images/projectMakerImage.png" class="img-fluid me-auto">
	   		</div>
	   		
          <!-- 메이커 정보 등록 시작 -->
          <div class="projectArea">
            <p class="projectTitle">메이커 정보</p>
            <p class="projectContent">메이커로 출력될 정보를 입력해 주세요.</p>
            
            <!-- 폼 태그 -->
            <form action="projectMakerPro" class="projectContent" method="post" enctype="multipart/form-data">
              
              <!-- 히든으로 처리할 예정-->
              <input type="text" name="member_idx" value="1">
              
              <!-- 메이커 유형 -->
              <div>
                <p class="subheading">메이커 유형</p>
                <p class="sideDescription">사업자 등록증 상단의 사업자 종류를 확인해 주세요.</p>
                <!-- 탭 버튼 -->
			    <div class="tab-buttons text-center">
			        <button class="btn btn-outline-primary tab-button w-100" data-tab="tab1">개인</button>
			        <button class="btn btn-outline-primary tab-button w-100" data-tab="tab2">개인사업자</button>
			        <button class="btn btn-outline-primary tab-button w-100" data-tab="tab3">법인사업자</button>
			    </div>
		        <div class="content-area sideDescription" id="tab1">
		        	<span>대표자 확인을 위해 신분증 사본을 업로드해 주세요.<br>
					   주민등록번호 뒷자리는 노출되지 않도록 가려 주세요.<br>
					   JPG, JPEG, PNG, PDF / 10MB 이하 파일 업로드 가능<br>
					   <input type="file" name="file1" class="mt-3" id="personal_id">
				   </span>
		        </div>
		        <div class="content-area" id="tab2">
		        	<div>
		                <label class="my-2" for="individual_biz_num">사업자 등록번호(10자리)</label>
		                <input class="form-control" type="text" name="individual_biz_num" id="individual_biz_num" placeholder="사업자 등록번호를 입력해 주세요">
		                <label class="my-2" for="individual_biz_name">상호 또는 법인명</label>
		                <input class="form-control" type="text" name="individual_biz_name" id="individual_biz_name" placeholder="사업자 등록번호를 입력해 주세요">
		                <label class="my-2" for="individual_biz_name">사업자 등록증</label><br>
	          			<span class="sideDescription my-2">
	          				  가장 최근에 발급한 사업자 등록증을 업로드해 주세요.<br>
							  JPG, JPEG, PNG, PDF / 10MB 이하 파일 1개만 업로드 가능해요.<br>
					    </span>
	             		 <input type="file" name="file2" class="mt-3" id="individual_biz_id">
	             	</div>
		        </div>
		        <div class="content-area" id="tab3">
		        	<div>
		                <label class="my-2" for="corporate_biz_num">법인사업자 등록번호(10자리)</label>
		                <input class="form-control" type="text" name="individual_biz_num" id="individual_biz_num" placeholder="사업자 등록번호를 입력해 주세요">
		                <label class="my-2" for="corporate_biz_name">상호 또는 법인명</label>
		                <input class="form-control" type="text" name="corporate_biz_name" id="corporate_biz_name" placeholder="사업자 등록번호를 입력해 주세요">
		                <label class="my-2" for="corporate_biz_id">사업자 등록증</label><br>
	          			<span class="sideDescription my-2">
	          				  가장 최근에 발급한 사업자 등록증을 업로드해 주세요.<br>
							  JPG, JPEG, PNG, PDF / 10MB 이하 파일 1개만 업로드 가능해요.<br>
					    </span>
	             		 <input type="file" name="file3" class="mt-3" id="corporate_biz_id">
	             	</div>
		        </div>
              </div>

              <!-- 메이커 정보 -->
              <div>
                <label class="subheading" for="maker_name">메이커명</label>
                <p class="sideDescription">법인 사업자는 법인등기부상 법인명 / 개인 사업자는 주민등록상 성명 또는 상호 / 개인은 주민등록상 성명을 입력해 주세요.</p>
                <input class="form-control" type="text" name="maker_name" id="maker_name" placeholder="메이커명을 입력해 주세요">
              </div>

              <!-- 메이커 대표 이미지 -->
              <div>
                <p class="subheading" for="maker_img">메이커 이미지&로고</p>
                <p class="sideDescription">
                  · 3MB 이하의 JPG, JPEG, PNG 파일<br>
                  · 텍스트나 로고는 넣을 수 없어요.
                </p>
                <!-- maker_img, maker_logo -->
                <input type="file" name="file4" class="mb-2"><br>
                <input type="file" name="file5"><br>
              </div>

              <!-- 메이커 이메일 -->
              <div>
                <label class="subheading" for="maker_email">메이커 이메일</label>
                <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 이메일을 입력해 주세요.</p>
                <input class="form-control" type="text" name="maker_email" id="maker_email" placeholder="메이커 이메일을 입력해 주세요">
              </div>

              <!-- 메이커 전화번호 -->
              <div>
                <label class="subheading" for="maker_tel">메이커 전화번호</label>
                <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 전화번호를 입력해 주세요.</p>
                <input class="form-control" type="text" name="maker_tel" id="maker_tel" placeholder="메이커 전화번호를 입력해 주세요">
              </div>

              <!-- 메이커 SNS/홈페이지/채널 주소 -->
              <div>
                <label class="subheading" for="maker_url">메이커 링크</label>
                <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 URL을 입력해 주세요.</p>
                <input class="form-control" type="text" name="maker_url" id="maker_url" placeholder="메이커 URL을 입력해 주세요">
              </div>

              <div class="d-flex justify-content-center my-3">
                <input type="submit" value="등록하기" class="btn btn-primary">
              </div>
            </form>

          </div>
          <!-- 리워드 설계 끝-->

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