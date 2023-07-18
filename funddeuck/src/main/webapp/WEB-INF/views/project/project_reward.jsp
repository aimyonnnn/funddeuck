<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!--bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
	
    <!-- 관리자 피드백 구역 스크롤 내릴 때 고정시키기-->
	<script>
	function scrollHandler() {
	  // 관리자 피드백 요소를 가져옴
	  var adminFeedbackElement = document.querySelector(".admin-feedback");
	  // 관리자 피드백 요소의 위치(offsetTop)를 가져옴
	  var adminFeedbackOffsetTop = adminFeedbackElement.offsetTop;
	
	  // 스크롤 위치가 관리자 피드백 요소의 위치 이상일 때
	  if (window.pageYOffset >= adminFeedbackOffsetTop) {
	    // sticky 클래스를 추가하여 고정
	    adminFeedbackElement.classList.add("sticky");
	  } else {
	    // sticky 클래스를 제거하여 고정 해제
	    adminFeedbackElement.classList.remove("sticky");
	  }
	}
	
	// 스크롤 이벤트 핸들러 등록
	window.addEventListener("scroll", function() {
	  // 스크롤 타임아웃이 없을 경우에만 실행
	  if (!window.scrollTimeout) {
	    // 스크롤 이벤트를 지연시킴
	    window.scrollTimeout = setTimeout(function() {
	      window.scrollTimeout = null;
	      scrollHandler();
	    }, 250); // 250ms 지연
	  }
	});
	
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
						// top.jsp의 알림 갯수 조회하는 함수 호출하여 알림 갯수 변경
						getNotificationCount();
						alert('읽음 처리 하였습니다!')
					} 
				},
				error: function(error) {
					console.log("읽음 처리 실패!")
				}
			}) // ajax
			
		} // confirmation
		
	}
	</script>

</head>
<body>
	<!-- include -->
 	<jsp:include page="../common/project_top.jsp"></jsp:include>
 	
	<!-- main -->
	<main id="main">
    <div class="containerCSS">
      
	<!-- 왼쪽 네비게이션 시작 -->
	<aside id="aisdeLeft">
		<div id="projectManagement">XXX님의 프로젝트</div>
	   	<ul id="navMenu">
		    <li><a href="#">프로젝트 관리</a></li>
		    <li><a href="projectReward" id="active-tab">리워드 관리</a></li>
		    <li><a href="projectStatus">프로젝트 현황</a></li>
		    <li><a href="#">발송/환불 관리</a></li>
		    <li><a href="#">수수료/정산 관리</a></li>
	 	</ul> 
	</aside>
	<!-- 왼쪽 네비게이션 끝 -->

    <!-- 중앙 섹션 시작 -->
    <section id="section">
   		<article id="article">

        <!-- 리워드 설계 시작 -->
        <div class="reward-area">
       		<p class="reward-title">리워드 설계</p>
          	<p class="reward-content">서포터들에게 제공할 리워드를 입력해 주세요.</p>
            
            <!-- 폼 태그 시작 -->
            <form action="" class="reward-content" method="post">
	            <!-- 금액 -->
	            <div>
	            	<label class="form-content" for="rewardPrice">금액</label>
	           		<input class="form-control" type="text" name="rewardPrice" id="rewardPrice" placeholder="금액을 입력하세요" style="width:500px;">
	            </div>

                <!-- 리워드 카테고리 -->
                <label class="form-content" for="rewardCategory">카테고리</label>
                <div class="d-flex flew-row">
                	<select class="form-control" name="rewardCategory" id="rewardCategory" style="width:150px;">
	                	<option value="">-- 선택 --</option>
	                    <option value="tech">테크/가전</option>
	                    <option value="fassion">패션/잡화</option>
	                    <option value="living">홈/리빙</option>
	                    <option value="beauty">뷰티</option>
	                    <option value="book">출판</option>
               		</select>
              </div>

              <!--리워드명 -->
              <div>
	              <label class="form-content" for="rewardName">리워드명</label>
	              <input class="form-control" type="text" name="rewardName" id="rewardName" placeholder="예시 - 베이지 이불/베개 1개 세트" style="width:500px;">
              </div>

              <!-- 리워드 설명 -->
              <label class="form-content" for="rewardDetail">리워드 설명</label>
              <textarea class="form-control reward-info" name="rewardDetail" id="rewardDetail" placeholder="리워드 구성과 혜택을 간결하게 설명해 주세요" style="height: 300px; resize: none;"></textarea>
              
              <!-- 배송여부 -->
              <div class="form-content">
	              		배송여부
	              <div class="form-check">
	          		<input class="form-check-input" type="radio" name="delivery" id="deliveryChecke1">
	                <label class="form-check-label" for="deliveryChecke1">
	                	배송
	                </label>
	              </div>
	              <div class="form-check">
	              	<input class="form-check-input" type="radio" name="delivery" id="deliveryChecke2">
	                <label class="form-check-label" for="deliveryChecke2">
	                    배송없음
	                </label>
	              </div>
              </div>

              <!-- 배송비 -->
              <div>
                <label class="form-content" for="rewardPrice">배송비</label>
                <input class="form-control" type="text" name="rewardPrice" id="rewardPrice" placeholder="배송비를 입력하세요" style="width:500px;">
              </div>

              <!-- 발송 시작일 -->
              <label class="form-content" for="yearMonth">발송 시작일</label>
              <div class="d-flex flew-row">
                <select class="form-control" name="yearMonth" id="yearMonth" style="width:150px;">
                  <option value="">-- 선택 --</option>
                  <option value="2023/08">2023년 8월</option>
                  <option value="2023/09">2023년 9월</option>
                  <option value="2023/10">2023년 10월</option>
                  <option value="2023/11">2023년 11월</option>
                  <option value="2023/12">2023년 12월</option>
                  <option value="2023/01">2024년 1월</option>
                </select>
                <select class="form-control ms-3" name="day" id="day" style="width:150px;">
                  <option value="">-- 선택 --</option>
                  <option value="/1~10">1일 ~ 10일(초)</option>
                  <option value="/11~20">11일 ~ 20일(중순)</option>
                  <option value="/21~30">21일 ~ 30일(말)</option>
                </select>
              </div>

              <!-- 리워드 정보 제공 고시 -->
              <!-- 들여쓰기 안한게 아니라 스페이스바 누르면 뷰에 스페이스바까지 나와서 이렇게 작성한거임 -->
              <label class="form-content" for="rewardInfo">리워드 정보 제공 고시</label>
              <textarea class="form-control reward-info" placeholder="제품 소재, 색상, 주의사항, 품질보증기준을 작성해주세요" name="rewardInfo" id="rewardInfo" style="height: 300px; resize: none;">
제품소재 :

색상 :

크기 :

주의사항 :

품질보증기준 :</textarea>
              <div class="d-flex justify-content-center my-3">
                <input type="submit" value="저장하기" class="btn btn-outline-secondary">
              </div>
            </form>
            <!-- 폼 태그 끝-->

          </div>
          <!-- 리워드 설계 끝-->

        </article>
		</section>
		<!-- 중앙 섹션 끝 -->
		
		<!-- 오른쪽 네비게이션 -->
		<!-- 관리자 피드백 알림 메시지 출력 -->
		<!-- 피드백 받은 메시지 내용을 보면서 수정하면 편할듯? -->
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
            	
	        </div>
	        <!-- 메시지 끝 -->

      </div>
      <!-- 관리자 피드백 끝 -->

      </aside>
      <!-- 오른쪽 네비게이션 끝 -->

    	</div>
    </main>
    <!-- main -->
	
	<!-- 관리자 피드백 알림 실시간 출력 -->
	<script type="text/javascript">
	function getNotifications() {
		$.ajax({
			url: '<c:url value="getNotificationByAjax"/>',
			method: 'get',
			success: function(response) {
				
			var notifications = response; // 알림 데이터 배열
				  
		    // 알림 데이터를 화면에 출력하는 코드
		    var notificationContainer = $('#notificationContainer');
		    notificationContainer.empty(); // 기존 알림 내용 비우기
			  
		    $.each(notifications.slice(0, 10), function(index, notification) {
		    	var notificationContent = notification.notification_content;
		        var alertDiv = $('<div class="alert alert-info" role="alert"></div>');
		        var icon = $('<i class="fas fa-exclamation-circle"></i>');
		        var content = $('<span>' + notificationContent + '</span>');
		      	
		        // 알림 읽음 처리를 하기 위한 함수 호출
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
	
	// ready
	$(()=>{
		// 페이지 로드 후 초기 알림 조회
		getNotifications();
		
		// 일정 시간마다 알림 갱신을 위해 타이머 설정
// 		setInterval(getNotifications, 5000); // 5초마다 알림 조회
		
	})
	</script>
	
		
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>
	