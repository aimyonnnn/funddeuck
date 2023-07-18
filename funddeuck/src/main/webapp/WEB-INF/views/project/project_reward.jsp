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
	  if (window.pageYOffset = adminFeedbackOffsetTop) {
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
	            	<label class="form-content subheading" for="reward_price">금액</label>
	           		<input class="form-control" type="text" name="reward_price" id="reward_price" placeholder="금액을 입력하세요" style="width:500px;">
	            </div>

                <!-- 리워드 카테고리 -->
                <label class="form-content subheading" for="reward_category">카테고리</label>
                <div class="d-flex flew-row">
                	<select class="form-control" name="reward_category" id="reward_category" style="width:150px;">
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
	              <label class="form-content subheading" for="reward_name">리워드명</label>
	              <input class="form-control" type="text" name="reward_name" id="reward_name" placeholder="예시 - 베이지 이불/베개 1개 세트" style="width:500px;">
              </div>
              
              <!--리워드 수량 -->
              <div>
	              <label class="form-content subheading" for="reward_quantity">수량</label>
	              <input class="form-control" type="text" name="reward_quantity" id="reward_quantity" style="width:500px;">
              </div>
              
              <!--리워드 옵션 -->
              <div>
	              <label class="form-content subheading" for="reward_option">옵션</label>
	              <input class="form-control" type="text" name="reward_option" id="reward_option" style="width:500px;">
              </div>

              <!-- 리워드 설명 -->
              <label class="form-content subheading" for="reward_detail">리워드 설명</label>
              <textarea class="form-control reward-info" name="reward_detail" id="reward_detail" placeholder="리워드 구성과 혜택을 간결하게 설명해 주세요" style="height: 300px; resize: none;"></textarea>
              
              <!-- 배송여부 -->
              <div class="form-content">
	              		<span class="subheading">배송여부</span>
	              <div class="form-check">
	          		<input class="form-check-input" type="radio" name="delivery_status" id="delivery_status1" value="배송">
	                <label class="form-check-label" for="delivery_status1">
	                	<span>배송</span>
	                </label>
	              </div>
	              <div class="form-check">
	              	<input class="form-check-input" type="radio" name="delivery_status" id="delivery_status2" value="배송없음">
	                <label class="form-check-label" for="delivery_status2">
	                    <span>배송없음</span>
	                </label>
	              </div>
              </div>

              <!-- 배송비 -->
              <div>
                <label class="form-content subheading" for="delivery_price">배송비</label>
                <input class="form-control" type="text" name="delivery_price" id="delivery_price" placeholder="배송비를 입력하세요" style="width:500px;">
              </div>

              <!-- 발송 시작일 -->
              <label class="form-content subheading" for="yearMonth">발송 시작일</label>
              <!-- hidden으로 처리할 예정 -->
              <input type="text" name="delivery_date" id="delivery_date">
              <div class="d-flex flew-row">
                <select class="form-control" name="yearMonth" id="yearMonth" style="width:150px;">
                  <option value="">-- 선택 --</option>
                  <option value="2023/08">2023년 8월</option>
                  <option value="2023/09">2023년 9월</option>
                  <option value="2023/10">2023년 10월</option>
                  <option value="2023/11">2023년 11월</option>
                  <option value="2023/12">2023년 12월</option>
                  <option value="2024/01">2024년 1월</option>
                  <option value="2024/02">2024년 2월</option>
                  <option value="2024/03">2024년 3월</option>
                  <option value="2024/04">2024년 4월</option>
                  <option value="2024/05">2024년 5월</option>
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
              <label class="form-content subheading" for="reward_info">리워드 정보 제공 고시</label>
              <textarea class="form-control reward-info" placeholder="제품 소재, 색상, 주의사항, 품질보증기준을 작성해주세요" name="reward_info" id="reward_info" style="height: 300px; resize: none;">
제품소재 :

색상 :

크기 :

주의사항 :

품질보증기준 :</textarea>
              	<!-- 저장하기 버튼 -->
			  	<div class="d-flex justify-content-center my-3">
				    <button type="button" class="btn btn-outline-secondary mx-3" onclick="addRewardToList()">추가하기</button>
			  		<button type="button" class="btn btn-outline-secondary" onclick="saveReward()">저장하기</button>
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
        	<div class="admin-title">리워드 피드백</div>
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
	        
	        <!-- 추가한 리워드 수 표시 -->
	        <div class="alert alert-success" role="alert" id="numRewardsAdded">
				<a><i class="fas fa-exclamation-circle"></i>&nbsp;추가된 리워드 수 : 0</a>
			</div>
			<!-- 임시저장, 삭제하기 버튼 -->
			<div class="alert alert-warning" role="alert">
			  <button onclick="saveTemporaryData()" class="btn btn-outline-secondary btn-sm mx-3">임시저장</button>
			  <button onclick="deleteTemporaryData()" class="btn btn-outline-secondary btn-sm">삭제하기</button>
			</div>
	        
	        
      </div>
      <!-- 관리자 피드백 끝 -->

      </aside>
      <!-- 오른쪽 네비게이션 끝 -->

    	</div>
    </main>
    <!-- main -->
	
	<script type="text/javascript">
    	
    	// 리워드 추가하기
        var rewardList = []; // 리워드 데이터를 저장할 배열
        var project_idx = 1; // 나중에 모델로 받아와야 함!

	    function addRewardToList() {
	        // rewardList 배열에 수집한 리워드 데이터를 추가
	        var reward_price = $("#reward_price").val();
	        var reward_category = $("#reward_category").val();
	        var reward_name = $("#reward_name").val();
	        var reward_quantity = $("#reward_quantity").val();
	        var reward_option = $("#reward_option").val();
	        var reward_detail = $("#reward_detail").val();
	        var delivery_status = $("input[name='delivery_status']:checked").val();
	        var delivery_price = $("#delivery_price").val();
	        var delivery_date = $("#delivery_date").val();
	        var reward_info = $("#reward_info").val();
	
	        rewardList.push({
	        	project_idx: project_idx,
	            reward_price: reward_price,
	            reward_category: reward_category,
	            reward_name: reward_name,
	            reward_quantity: reward_quantity,
	            reward_option: reward_option,
	            reward_detail: reward_detail,
	            delivery_status: delivery_status,
	            delivery_price: delivery_price,
	            delivery_date: delivery_date,
	            reward_info: reward_info
	        });

	        // 추가한 리워드 수를 표시 (옵션)
	        var numRewards = rewardList.length;
	        document.getElementById("numRewardsAdded").innerText = "추가된 리워드 수: " + numRewards;
	        
	        // 입력된 텍스트 지우기
	        $("#reward_price").val("");
	        $("#reward_category").val("");
	        $("#reward_name").val("");
	        $("#reward_quantity").val("");
	        $("#reward_option").val("");
	        $("#reward_detail").val("");
	        $("input[name='delivery_status']").prop("checked", false);
	        $("#delivery_price").val("");
	        $("#yearMonth").val("");
	        $("#day").val("");
	        $("#delivery_date").val("");
	        $("#reward_info").val(`제품소재 :

색상 :

크기 :

주의사항 :

품질보증기준 :`);
	        
	        alert("리워드가 추가되었습니다." +
	        "\n계속해서 추가하시려면 추가하기 버튼을 클릭해주세요");
	        
	    }

        function saveReward() {
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "<c:url value='saveReward'/>",
                data: JSON.stringify(rewardList),
                dataType: "text",
                success: function (response) {
                    alert("성공적으로 저장되었습니다!");
                },
                error: function (xhr, status, error) {
                    console.error(error);
                    alert("리워드 데이터 저장에 실패했습니다.");
                }
            });
        }
    	
		// 선택 상자의 값을 변경할 때마다 히든 필드 업데이트
	    document.getElementById("yearMonth").addEventListener("change", updateDeliveryDate);
	    document.getElementById("day").addEventListener("change", updateDeliveryDate);

	    function updateDeliveryDate() {
	        var yearMonth = document.getElementById("yearMonth").value;
	        var day = document.getElementById("day").value;
	        var delivery_date = yearMonth + day;
	        document.getElementById("delivery_date").value = delivery_date;
	    }
	    
	    // 임시 저장하기
	    function saveTemporaryData() {
		    // 현재 입력된 리워드 정보를 가져옵니다.
		    var reward_price = $("#reward_price").val();
		    var reward_category = $("#reward_category").val();
		    var reward_name = $("#reward_name").val();
		    var reward_quantity = $("#reward_quantity").val();
		    var reward_option = $("#reward_option").val();
		    var reward_detail = $("#reward_detail").val();
		    var delivery_status = $("input[name='delivery_status']:checked").val();
		    var delivery_price = $("#delivery_price").val();
		    var delivery_date = $("#delivery_date").val();
		    var reward_info = $("#reward_info").val();
		
		    // 리워드 정보를 객체로 만듭니다.
		    var newReward = {
		        reward_price: reward_price,
		        reward_category: reward_category,
		        reward_name: reward_name,
		        reward_quantity: reward_quantity,
		        reward_option: reward_option,
		        reward_detail: reward_detail,
		        delivery_status: delivery_status,
		        delivery_price: delivery_price,
		        delivery_date: delivery_date,
		        reward_info: reward_info
		    };
		
		    // 로컬 스토리지에 리워드 정보를 저장합니다.
		    localStorage.setItem('newReward', JSON.stringify(newReward));
		
		    alert("리워드 데이터가 임시저장되었습니다.");
		}
	    
	    // 페이지 로드 시
	    window.onload = function() {
	        var storedNewReward = localStorage.getItem('newReward');

	        if (storedNewReward) {
	            var lastReward = JSON.parse(storedNewReward);
	            restoreRewardInputs(lastReward);
	        }
	    };
	    
	    function restoreRewardInputs(lastReward) {
	        $("#reward_price").val(lastReward.reward_price);
	        $("#reward_category").val(lastReward.reward_category);
	        $("#reward_name").val(lastReward.reward_name);
	        $("#reward_quantity").val(lastReward.reward_quantity);
	        $("#reward_option").val(lastReward.reward_option);
	        $("#reward_detail").val(lastReward.reward_detail);
	        $("input[name='delivery_status'][value='" + lastReward.delivery_status + "']").prop("checked", true);
	        $("#delivery_price").val(lastReward.delivery_price);
	        $("#yearMonth").val(lastReward.delivery_date.split("/")[0]);
	        $("#day").val(lastReward.delivery_date.split("/")[1]);
	        $("#reward_info").val(lastReward.reward_info);
	    }
	    
	    // 임시저장 된 데이터 삭제하기
	    function deleteTemporaryData() {
			localStorage.removeItem('newReward');
			alert("임시저장 데이터가 삭제되었습니다.");
			location.reload();
		}
	</script>
		
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>
	