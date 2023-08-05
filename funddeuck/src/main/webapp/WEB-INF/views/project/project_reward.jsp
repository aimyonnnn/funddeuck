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
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<!-- jquery -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<!-- font awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
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
                        <input type="text" name="project_idx" id="project_idx" value="${project_idx}" class="form-control" style="width:500px;">

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
                                <option value="fashion">패션/잡화</option>
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
                            <input type="text" name="delivery_date" id="delivery_date" class="form-control" style="width:170px;" readonly="readonly">
                        </div>

                        <!-- 리워드 정보 제공 고시 -->
                        <!-- 들여쓰기 안한게 아니라 스페이스바 누르면 뷰에 스페이스바까지 나와서 이렇게 작성한거임 -->
                        <label class="form-content subheading" for="reward_info">리워드 정보 제공 고시</label>
                        <!-- 첫 페이지 - 기본 양식 -->
                        <textarea class="form-control reward-info" placeholder="제품 소재, 색상, 주의사항, 품질보증기준을 작성해주세요" name="reward_info" id="reward_info" style="height: 300px; resize: none;">
제품소재 :

색상 :

크기 :

주의사항 :

품질보증기준 :</textarea>
						
						<div class="alert alert-danger mt-3 text-center" role="alert">
		                	<i class="fas fa-exclamation-circle"></i>&nbsp;리워드 등록까지 완료해야 프로젝트 승인요청을 할 수 있습니다.
						</div>
						
                        <!-- 저장하기 & 수정하기 버튼 -->
                        <div class="d-flex justify-content-center my-3">
                            <button type="button" class="btn btn-outline-primary" id="saveButton" onclick="saveReward()">리워드 등록하기</button>
                            <button type="button" class="btn btn-outline-danger mx-3" onclick="projectApprovalRequestBtn()">프로젝트 승인요청 하기</button>
                            <button type="button" class="btn btn-outline-primary me-3" id="editButton" style="display: none;" onclick="modifyReward(selectedRewardIdx)">수정하기</button>
                            <button type="button" class="btn btn-outline-primary" id="removeButton" style="display: none;" onclick="removeReward(selectedRewardIdx)">삭제하기</button>
                        </div>
                    </form>
                </div>
                
                <div style="width: 100%; height: 10px;"></div>
                
                <!-- 리워드 설계 끝-->
            </article>
        </section>
        <!-- 중앙 섹션 끝 -->
        
        <!-- 오른쪽 네비게이션 -->
        <aside id="aisdeRight">
        
            <!-- 관리자 피드백 -->
            <div class="admin-feedback">
                <div class="admin-title">
                    관리자 피드백
                </div>
                <div class="admin-content">
                    관리자로부터 수정, 요청사항 피드백을 받으면 이곳에 피드백 메시지가 출력됩니다.
                </div>
                <div id="notificationContainer">
                    <div class="alert alert-primary" role="alert">
                        <i class="fas fa-exclamation-circle"></i><span>&nbsp;알림이 없습니다.</span>
                    </div>
                </div>
                
                <!-- 리워드 리스트  -->
                <div class="admin-title mt-5">
                    리워드 리스트
                </div>
                <div class="alert alert-success" role="alert" id="numRewardsAdded">
                    <span><i class="fas fa-exclamation-circle"></i>&nbsp;현재 등록된 리워드 수 : <span id="rewardCount">0</span></span>
                </div>
                <div id="rewardContainer">
                    <!-- 이 부분은 리워드 리스트가 출력될 컨테이너입니다. -->
                </div>
                
            </div>
        </aside>
        <!-- 오른쪽 네비게이션 끝 -->
    </div>
</main>
	
<script type="text/javascript">
// 선택된 리워드의 reward_idx 값을 저장하는 변수
let selectedRewardIdx; 
	
// 페이지 로드될 때 리워드 갯수, 리스트 조회하기
$(document).ready(function() {
	// 리워드 갯수 조회하기
	$.ajax({
        type: "post",
        url: "<c:url value='rewardCount'/>",
        data: {
            project_idx: $('#project_idx').val()
        },
        dataType: "text",
        success: function (response) {
        	if(response.trim() != '0') {
	            $('#rewardCount').text(response + "개");
        	} else {
        		console.log(response.trim());
        	}
        },
        error: function (error) {
            console.log("리워드 갯수 조회에 실패했습니다.");
        }
    });
    
	// 리워드 리스트 조회하기
    $.ajax({
        type: "post",
        url: "<c:url value='rewardList'/>",
        data: {
            project_idx: $('#project_idx').val()
        },
        dataType: "json",
        success: function (response) {
        	console.log(response);
        	
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
                                openRewardModifyForm(reward.reward_idx);
                                
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
            console.log("리워드 리스트 조회에 실패했습니다.");
        }
    });
}); // ready
	
//리워드 등록하기
function saveReward() {
	
	Swal.fire({
		title: '리워드 등록하기',
		text: '리워드를 등록 하시겠습니까?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonText: '예',
		cancelButtonText: '아니오'
	})
	.then((result) => {
		
		if(result.isConfirmed) {
			
			$.ajax({
				type: "POST",
				url: "<c:url value='saveReward'/>",
				data: $("#rewardForm").serialize(),
				dataType: "text",
				success: function (response) {
					
					if(response.trim() == 'true') {
						
						Swal.fire({
							icon: 'success',
							title: '리워드 등록 완료.',
							text: '리워드 등록이 완료되었습니다!'
						}).then(function(){
							
							Swal.fire({
								icon: 'question',
								title: '리워드 연속 등록',
								text: '리워드 등록을 연속해서 하시겠습니까?'
							}).then(function(){
								
						    	location.reload();
						        
							});
							
						});
					}
					
				},
				error: function (error) {
					console.log("리워드 데이터 저장에 실패했습니다.");
				}
			}); // ajax
		} // if
	});
}

// 프로젝트 승인요청 하기 클릭 시
function projectApprovalRequestBtn(){
	
	Swal.fire({
		title: '프로젝트 승인요청',
		text: '프로젝트 승인요청을 하시겠습니까?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonText: '예',
		cancelButtonText: '아니오'
	})
	.then((result) => {
		
		if(result.isConfirmed) {
		
			$.ajax({
				type: "post",
				url: "<c:url value='approvalRequest'/>",
				data: {
					project_idx: ${project_idx}
				},
				dataType: 'text',
				success: data => {
					
					if (data.trim() == 'true') {
					    Swal.fire({
					        icon: 'success',
					        title: '프로젝트 승인요청 완료!',
					        text: '프로젝트 승인 요청이 완료되었습니다!',
					    }).then(function () {
					        location.reload();
					    });
					} else if (data.trim() == 'false') {
					    Swal.fire({
					        icon: 'error',
					        title: '프로젝트 승인요청 실패',
					        text: '리워드 등록까지 완료해야 프로젝트 승인요청을 할 수 있습니다.',
					    }).then(function () {
					        location.reload();
					    });
					} else if (data.trim() == '2') {
					    Swal.fire({
					        icon: 'error',
					        title: '프로젝트 승인요청 실패',
					        text: '이미 승인요청된 프로젝트 입니다. 승인완료까지 최대 3일이 소요됩니다.',
					    }).then(function () {
					        location.reload();
					    });
					} else if (data.trim() == '3') {
					    Swal.fire({
					        icon: 'error',
					        title: '프로젝트 승인요청 실패',
					        text: '이미 승인완료된 프로젝트 입니다. 프로젝트 요금 결제를 진행해주세요.',
					    }).then(function () {
					        location.reload();
					    });
					} else if (data.trim() == '5') {
					    Swal.fire({
					        icon: 'error',
					        title: '프로젝트 승인요청 실패',
					        text: '이미 결제완료된 프로젝트 입니다. 새로운 프로젝트를 생성해주세요.',
					    }).then(function () {
					        location.reload();
					    });
					}

				},
				error: () => {
					console.log('프로젝트 승인요청 ajax 실패');
				}
			});
		}	
	});
}
	
// 리워드 수정 페이지 이동
function openRewardModifyForm(reward_idx) {
	
	$.ajax({
		type: 'post',
		url: '<c:url value="openRewardModifyForm"/>',
		data: {
			reward_idx: reward_idx
		},
		success: function(data) {
			console.log(data);
			
			if (data.reward_idx) {
                // 수정할 리워드가 있을 때
                $("#saveButton").hide();
                $("#editButton").show();
                $("#removeButton").show();
            } else {
                // 새로운 리워드를 등록할 때
                $("#saveButton").show();
                $("#editButton").hide();
                $("#removeButton").hide();
            }
			
			// 서버로부터 받은 데이터를 사용하여 폼에 값을 채워넣는 로직
            $("#reward_name").val(data.reward_name);
            $("#reward_price").val(data.reward_price);
            $("#reward_category").val(data.reward_category);
            $("#reward_quantity").val(data.reward_quantity);
            $("#reward_option").val(data.reward_option);
            $("#reward_detail").val(data.reward_detail);
            
            // 배송여부 라디오 버튼 처리
            if (data.delivery_status === '배송') {
                $("#delivery_status1").prop("checked", true);
            } else if (data.delivery_status === '배송없음') {
                $("#delivery_status2").prop("checked", true);
            }
            
            $("#delivery_price").val(data.delivery_price);
            
            // 발송 시작일 선택 처리
            const [yearMonth, day] = data.delivery_date.split('/');
            $("#yearMonth").val(yearMonth);
            $("#day").val(day);
            $("#delivery_date").val(data.delivery_date);
            
            // 리워드 정보 제공 고시 처리
            $("#reward_info").val(data.reward_info);
            
            // 전역 변수에 선택된 리워드의 reward_idx 값을 저장
            selectedRewardIdx = data.reward_idx;
			
		},
		error: function(){
			console.log('ajax 요청 실패');				
		}
	});
	
}
			
// 리워드 수정하기
function modifyReward(reward_idx) {
	
	Swal.fire({
		title: '리워드 수정하기',
		text: '리워드를 수정하시겠습니까?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonText: '예',
		cancelButtonText: '아니오'
	})
	.then((result) => {
		
		if(result.isConfirmed) {
	
			$.ajax({
			    type: "POST",
			    url: "<c:url value='modifyReward'/>",
		        data: $("#rewardForm").serialize() + "&reward_idx=" + reward_idx,
			    dataType: "text",
			    success: function (data) {
			    	
			    	
			    	if (data.trim() == 'true') {
					    Swal.fire({
					        icon: 'success',
					        title: '리워드 수정완료!',
					        text: '리워드가 성공적으로 수정되었습니다!',
					    }).then(function () {
					        location.reload();
					    });
					} else {
					    Swal.fire({
					        icon: 'error',
					        title: '리워드 수정실패',
					        text: '리워드 수정에 실패하였습니다.',
					    });
					}
			    	
			    },
			    error: function (error) {
			        console.error(error);
			        console.log("수정에 실패했습니다.");
			    }
			}); // ajax
		}
	});	
}
	
// 리워드 삭제하기
function removeReward(reward_idx) {
	
	Swal.fire({
		title: '리워드 삭제하기',
		text: '리워드를 삭제하시겠습니까?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonText: '예',
		cancelButtonText: '아니오'
	})
	.then((result) => {
		
		if(result.isConfirmed) {
			
			$.ajax({
			    type: "POST",
			    url: "<c:url value='removeReward'/>",
		        data: {
		        	reward_idx: reward_idx	
		        },
			    dataType: "text",
			    success: function (data) {
			    	
			    	if (data.trim() == 'true') {
					    Swal.fire({
					        icon: 'success',
					        title: '리워드 삭제완료!',
					        text: '리워드가 성공적으로 삭제되었습니다!',
					    }).then(function () {
					    	location.href='projectReward?project_idx=${project_idx}';
					    });
					} else {
					    Swal.fire({
					        icon: 'error',
					        title: '리워드 삭제실패',
					        text: '리워드 삭제에 실패하였습니다.',
					    });
					}
			    	
			    },
			    error: function (error) {
			        console.error(error);
			        alert("삭제에 실패했습니다.");
			    }
			});
		}
	});	
}
	
// 관리자 피드백
// 페이지 로드 후에 getNotifications 함수 호출
$(()=>{
	getNotifications();
})

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

//                 // 읽음 처리 하기
//                 content.click(function() {
//                     markNotificationAsRead(notification.notification_idx);
//                 });

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
	
// // 메시지 읽음 처리 하기
// function markNotificationAsRead(notification_idx) {
	
// 	let confirmation = confirm("메시지를 읽음 처리 하시겠습니까?");
	
// 	if(confirmation) {
// 		// 기본 동작 방지하기
// 		event.preventDefault();
		
// 		console.log("알림번호 : " + notification_idx);
// 		$.ajax({
// 			method: 'get',
// 			url: '<c:url value="markNotificationAsRead"/>',
// 			data: {
// 				notification_idx: notification_idx
// 			},
// 			success: function(response){
// 				if(response.trim() == 'true') {
					
// 					// 알림 갯수 변경
// 					getNotificationCount();
					
// 					// 관리자 피드백 메시지 업데이트
// 					getNotifications();
// 					alert('읽음 처리 되었습니다!');
// 				} 
// 			},
// 			error: function(error) {
// 				console.log("읽음 처리 실패!");
// 			}
// 		})
// 	} else {
		
// 		// "아니요"를 선택했을 때 메시지에 포함된 링크로 이동할지 물어보기
//         let linkConfirmation = confirm("메시지에 포함된 링크로 이동하시겠습니까?");
        
//         if (linkConfirmation) {
//             // 메시지에 포함된 링크로 이동
            
//         } else {
//         	// 기본 동작 방지하기 
//             event.preventDefault();
        	
//             // 아무 동작도 하지 않음 (현재 페이지에 머무름)
//         	location.reload();
//         }
// 	}
// }
	
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
	