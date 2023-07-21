<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!--bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
	<style>
	  /* 버튼과 글자 사이의 높이 간격을 줄임 */
	  .alert button {
	    margin-top: -0.25rem; /* 음수 값을 주어서 간격을 줄입니다. */
	    margin-bottom: -0.25rem; /* 음수 값을 주어서 간격을 줄입니다. */
	    padding: 0.1rem 0.25rem;
	  }
	  /* 경고창 내부 요소들의 두께와 여백 조정 */
	  .alert .fas,
	  .alert span {
	    margin: 0; /* 모든 여백을 제거 */
	    padding: 0; /* 패딩을 제거 */
	    line-height: 1; /* 줄 간격을 조정하여 텍스트가 더 밀집되도록 설정*/
	  }
	</style>
</head>
<body>
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
			                <li><a href="projectManagement">프로젝트 등록</a></li>
			                <li><a href="projectReward" id="active-tab">리워드 설계</a></li>
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
	      			<img src="${pageContext.request.contextPath}/resources/images/projectRewardImage.png" class="img-fluid me-auto">
	      		</div>
		
		        <div class="projectArea">
		       		<p class="projectTitle">리워드 설계</p>
		          	<p class="projectContent">서포터들에게 제공할 리워드를 입력해 주세요.</p>
		            
		            <!-- 폼 태그 시작 -->
		            <form action="" class="projectContent" method="post" id="rewardForm">
		            	<!-- 히든 처리하는 부분 -->
<!-- 		            	<label class="form-content subheading" for="project_idx">project_idx</label> -->
		            	<input type="text" name="project_idx" id="project_idx" value="1" class="form-control" style="width:500px;">
		            	
			            <!-- 금액 -->
			            <div>
			            	<label class="form-content subheading" for="reward_price">금액</label>
			           		<input class="form-control" type="text" name="reward_price" id="reward_price" value="${reward.reward_price }" placeholder="금액을 입력하세요" style="width:500px;">
			            </div>
		
		                <!-- 리워드 카테고리 -->
		                <label class="form-content subheading" for="reward_category">카테고리</label>
		                <div class="d-flex flew-row">
		                	<select class="form-control" name="reward_category" id="reward_category" style="width:150px;">
			                	<option value="">-- 선택 --</option>
			                    <option value="tech" <c:if test="${reward.reward_category eq 'tech'}">selected</c:if>>테크/가전</option>
			                    <option value="fassion" <c:if test="${reward.reward_category eq 'fassion'}">selected</c:if>>패션/잡화</option>
			                    <option value="living" <c:if test="${reward.reward_category eq 'living'}">selected</c:if>>홈/리빙</option>
			                    <option value="beauty" <c:if test="${reward.reward_category eq 'beauty'}">selected</c:if>>뷰티</option>
			                    <option value="book" <c:if test="${reward.reward_category eq 'book'}">selected</c:if>>출판</option>
		               		</select>
		              </div>
		              <!--리워드명 -->
		              <div>
			              <label class="form-content subheading" for="reward_name">리워드명</label>
			              <input class="form-control" type="text" name="reward_name" id="reward_name" value="${reward.reward_name }" placeholder="예시 - 베이지 이불/베개 1개 세트" style="width:500px;">
		              </div>
		              
		              <!--리워드 수량 -->
		              <div>
			              <label class="form-content subheading" for="reward_quantity">수량</label>
			              <input class="form-control" type="text" name="reward_quantity" id="reward_quantity" value="${reward.reward_quantity }" style="width:500px;">
		              </div>
		              
		              <!--리워드 옵션 -->
		              <div>
			              <label class="form-content subheading" for="reward_option">옵션</label>
			              <input class="form-control" type="text" name="reward_option" id="reward_option" value="${reward.reward_option }" style="width:500px;">
		              </div>
		
		              <!-- 리워드 설명 -->
		              <label class="form-content subheading" for="reward_detail">리워드 설명</label>
		              <textarea class="form-control reward-info" name="reward_detail" id="reward_detail" placeholder="리워드 구성과 혜택을 간결하게 설명해 주세요" style="height: 300px; resize: none;">${reward.reward_detail}</textarea>
		              
		              <!-- 배송여부 -->
		              <div class="form-content">
              	  		<span class="subheading">배송여부</span>
			            <div class="form-check">
			          		<input class="form-check-input" type="radio" name="delivery_status" id="delivery_status1" value="배송"
			          			<c:if test="${reward.delivery_status eq '배송'}">checked</c:if>>
			                <label class="form-check-label" for="delivery_status1">
		                		<span>배송</span>
			                </label>
			            </div>
			            <div class="form-check">
		              		<input class="form-check-input" type="radio" name="delivery_status" id="delivery_status2" value="배송없음"
		              			<c:if test="${reward.delivery_status eq '배송없음'}">checked</c:if>>
			                <label class="form-check-label" for="delivery_status2">
		                    	<span>배송없음</span>
			                </label>
	            	  	</div>
		              </div>
		
		              <!-- 배송비 -->
		              <div>
		                <label class="form-content subheading" for="delivery_price">배송비</label>
		                <input class="form-control" type="text" name="delivery_price" id="delivery_price" value="${reward.delivery_price}" placeholder="배송비를 입력하세요" style="width:500px;">
		              </div>
		
		              <!-- 발송 시작일 -->
		              <label class="form-content subheading" for="yearMonth">발송 시작일</label>
		              <!-- 히든 처리 예정 -->
<%-- 		              <input type="text" name="delivery_date" id="delivery_date" value="${reward.delivery_date}" > --%>
		              <div class="d-flex flew-row">
		                <select class="form-control" name="yearMonth" id="yearMonth" style="width:130px;">
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
		                <select class="form-control mx-3" name="day" id="day" style="width:170px;">
		                  <option value="">-- 선택 --</option>
		                  <option value="/1~10">1일 ~ 10일(초)</option>
		                  <option value="/11~20">11일 ~ 20일(중순)</option>
		                  <option value="/21~30">21일 ~ 30일(말)</option>
		                </select>
		                <input type="text" name="delivery_date" id="delivery_date" value="${reward.delivery_date}" class="form-control" style="width:170px;" readonly="readonly">
		              </div>
		
              <!-- 리워드 정보 제공 고시 -->
              <!-- 들여쓰기 안한게 아니라 스페이스바 누르면 뷰에 스페이스바까지 나와서 이렇게 작성한거임 -->
              <label class="form-content subheading" for="reward_info">리워드 정보 제공 고시</label>
              <c:choose>
			  	<c:when test="${empty reward.reward_info}">
				    <!-- 첫 페이지 - 기본 양식 -->
				    <textarea class="form-control reward-info" placeholder="제품 소재, 색상, 주의사항, 품질보증기준을 작성해주세요" name="reward_info" id="reward_info" style="height: 300px; resize: none;">
제품소재 :

색상 :

크기 :

주의사항 :

품질보증기준 :</textarea>
				</c:when>
				<c:otherwise>
				    <textarea class="form-control reward-info" placeholder="제품 소재, 색상, 주의사항, 품질보증기준을 작성해주세요" name="reward_info" id="reward_info" style="height: 300px; resize: none;">${reward.reward_info}</textarea>
				 </c:otherwise>
				</c:choose>
						
						<!-- 저장하기 & 수정하기 버튼 -->
						<c:choose>
							<c:when test="${empty reward.reward_idx}">
							  	<div class="d-flex justify-content-center my-3">
							  		<button type="button" class="btn btn-outline-primary" onclick="saveReward()">등록하기</button>
						      	</div>
							</c:when>
							<c:otherwise>
							  	<div class="d-flex justify-content-center my-3">
							  		<button type="button" class="btn btn-outline-primary me-3" onclick="modifyReward(${reward.reward_idx})">수정하기</button>
							  		<button type="button" class="btn btn-outline-primary" onclick="removeReward(${reward.reward_idx})">삭제하기</button>
						      	</div>
							</c:otherwise>
						</c:choose>
				      	
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
			            	<div class="alert alert-primary" role="alert">
								<i class="fas fa-exclamation-circle"></i><span>&nbsp;알림이 없습니다.</span>
							</div>
				        </div>
				        <!--  -->
				        <div class="admin-title mt-5">리워드 리스트</div>
				        <div class="alert alert-success" role="alert" id="numRewardsAdded">
							<span><i class="fas fa-exclamation-circle"></i>&nbsp;현재 등록된 리워드 수 : <span id="rewardCount">0</span></span>
						</div>
						<!-- 이 부분은 리워드 리스트가 출력될 컨테이너입니다. -->
						<div id="rewardContainer"></div>
						<button onclick="saveTemporaryData()" class="btn btn-outline-secondary btn-sm me-3">임시저장</button>
						<button onclick="deleteTemporaryData()" class="btn btn-outline-secondary btn-sm">삭제하기</button>
			     	 </div>
			     </aside>
			     <!-- 오른쪽 네비게이션 끝 -->
   		</div>
    </main>
	
	<script type="text/javascript">
	// 페이지 로드될 때 리워드 갯수, 리스트 조회하기
	$(document).ready(function() {
		// 리워드 갯수 조회하기
	    $.ajax({
	        type: "GET",
	        url: "<c:url value='rewardCount'/>",
	        data: {
	            project_idx: $('#project_idx').val()
	        },
	        dataType: "text",
	        success: function (response) {
	            $('#rewardCount').text(response + "개");
	        },
	        error: function (error) {
	            console.error(error);
	            alert("리워드 갯수 조회에 실패했습니다.");
	        }
	    }); // ajax
	    
		// 리워드 리스트 조회하기
	    $.ajax({
	        type: "GET",
	        url: "<c:url value='rewardList'/>",
	        data: {
	            project_idx: $('#project_idx').val()
	        },
	        dataType: "json",
	        success: function (response) {
	            // json 데이터를 변수에 저장
	            let rList = response;
	            // 리워드 리스트를 생성하여 컨테이너에 추가
	            let container = $("#rewardContainer");
	            for (let i = 0; i < rList.length; i++) {
	                let reward = rList[i];
	                let rewardInfo = reward.reward_idx + " - " + reward.reward_name;
	                // 리워드 정보를 담은 html을 생성하여 컨테이너에 추가
	                let rewardDiv = $('<div>', {
	                    class: "alert alert-success d-flex flex-column align-items-center",
	                    role: "alert"
	                }).append(
	                    $('<span>', {
	                        class: "mb-3",
	                    }).append(
	                        $('<i>', { class: "fas fa-exclamation-circle" }),
	                        "&nbsp;" + rewardInfo
	                    ),
	                    $('<div>', { class: "d-flex justify-content-center" }).append(
	                        $('<button>', {
	                            type: "button",
	                            class: "btn btn-outline-secondary btn-sm me-3",
	                            text: "수정하기",
	                            click: function() {
	                                // 수정하기 버튼을 클릭하면 해당 리워드 페이지로 이동
	                                window.location.href = 'projectReward?reward_idx=' + reward.reward_idx;
	                            }
	                        }),
	                        $('<button>', {
	                            type: "button",
	                            class: "btn btn-outline-secondary btn-sm",
	                            text: "삭제하기",
	                            click: function() {
	                                // 삭제 버튼을 클릭 시 removeReward() 함수 호출
	                                removeReward(reward.reward_idx);
	                            }
	                        })
	                    )
	                );

	                container.append(rewardDiv);

	            }
	        },
	        error: function (error) {
	            console.error(error);
	            alert("리워드 리스트 조회에 실패했습니다.");
	        }
	    }); // ajax
	}); // ready
	
	// 리워드 등록하기
	function saveReward() {
		
		let confirmation = confirm('리워드를 등록 하시겠습니까?')
		
		if(confirmation) {
			$.ajax({
			    type: "POST",
			    url: "<c:url value='saveReward'/>",
			    data: $("#rewardForm").serialize(),
			    dataType: "text",
			    success: function (response) {
			    	
			    	if(response.trim() == 'true') {
				        alert("성공적으로 저장되었습니다!");
				        location.href='projectReward';
			    	} else {
			    		alert("모든 항목을 입력해주세요.");
			    	}
			    },
			    error: function (error) {
			        console.error(error);
			        alert("리워드 데이터 저장에 실패했습니다.");
			    }
			}); // ajax
		}
    }
	
	// 리워드 수정하기
	function modifyReward(reward_idx) {
		
		let confirmation = confirm('리워드를 수정 하시겠습니까?')
		
		if(confirmation) {
			$.ajax({
			    type: "POST",
			    url: "<c:url value='modifyReward'/>",
		        data: $("#rewardForm").serialize() + "&reward_idx=" + reward_idx,
			    dataType: "text",
			    success: function (response) {
			    	
			    	if(response.trim() == 'true') {
				        alert("성공적으로 수정되었습니다!");
				        location.href = '<c:url value="projectReward?reward_idx="/>' + reward_idx;
			    	} else {
			    		alert("수정에 실패했습니다.");
			    	}
			    },
			    error: function (error) {
			        console.error(error);
			        alert("수정에 실패했습니다.");
			    }
			}); // ajax
		}
    }
	
	// 리워드 삭제하기
	function removeReward(reward_idx) {
		
		let confirmation = confirm('리워드를 삭제 하시겠습니까?')
		
		if(confirmation) {
			$.ajax({
			    type: "POST",
			    url: "<c:url value='removeReward'/>",
		        data: {
		        	reward_idx: reward_idx	
		        },
			    dataType: "text",
			    success: function (response) {
			    	
			    	if(response.trim() == 'true') {
				        alert("성공적으로 삭제되었습니다!");
				        // 리워드 등록 페이지로 이동
				        location.href='projectReward';
			    	} else {
			    		alert("삭제에 실패했습니다.");
			    	}
			    },
			    error: function (error) {
			        console.error(error);
			        alert("삭제에 실패했습니다.");
			    }
			}); // ajax
		}
    }
	
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
		        var alertDiv = $('<div class="alert alert-primary" role="alert"></div>');
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
// 		setInterval(getNotifications, 5000);
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
						// 관리자 피드백 메시지 업데이트
						getNotifications();
						alert('읽음 처리 하였습니다!')
					} 
				},
				error: function(error) {
					console.log("읽음 처리 실패!")
				}
			})
		}
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
	</script>
	
	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>
	