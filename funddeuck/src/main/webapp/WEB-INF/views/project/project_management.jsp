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
	<!-- datepicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<!-- CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">

	<script>
	// datepicker
	$(function() {
	$("#projectDatepicker").datepicker({
	    dateFormat: 'yy-mm-dd'
	    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	    ,changeYear: true //콤보박스에서 년 선택 가능
	    ,changeMonth: true //콤보박스에서 월 선택 가능                
	    ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	    ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	    ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	    ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	    ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	    ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	    ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
	});                    

	//초기값을 오늘 날짜로 설정
	$('#projectDatepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)            
	});

	// 약관 전체동의 체크박스
	$(document).ready(function() {
	  $("#agreeAll").click(function() {
	    if($("#agreeAll").is(":checked")) $("input[name=agreeCheck]").prop("checked", true);
	    else $("input[name=agreeCheck]").prop("checked", false);
	  });

	  $("input[name=agreeCheck]").click(function() {
	    var total = $("input[name=agreeCheck]").length;
	    var checked = $("input[name=agreeCheck]:checked").length;

	    if(total != checked) $("#agreeAll").prop("checked", false);
	    else $("#agreeAll").prop("checked", true); 
	  });
	});
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
		        <li><a href="projectSettlement">수수료·정산 관리</a></li>
		    </ul>
		</aside>

		<!-- 중앙 섹션 시작 -->
		<section id="section">
	      	<article id="article">
	      		<div class="mt-5">
	      			<img src="${pageContext.request.contextPath}/resources/images/projectManagementImage.png" class="img-fluid me-auto">
	      		</div>
	      		
		      	<!-- 프로젝트 관리 시작 -->
				<div class="projectArea">
	            <p class="projectTitle">프로젝트 등록</p>
	            <p class="projectContent">프로젝트에 필요한 내용을 작성해 주세요.</p>
            
				<!-- 폼 태그 시작 -->
				<form action="" class="projectContent" method="post">
					<!-- 기본 요금제 -->
					<div class="mt-4">
						<p class="subheading">기본 요금제</p>
						<p class="sideDescription">프로젝트 등록 시 수수료에 대한 요금제가 부과됩니다.</p>
						<div class="flex-container">
					    	<div class="card">
								<div class="card-header bg-primary text-white">
									FUNDDEUCK 회원제(5%) (VAT 별도)
								</div>
								<div class="card-body">
									<blockquote class="blockquote mb-0">
										<p class="card-detail">
										    · 프로젝트 공개<br>
										    · 오픈예정 서비스<br>
										    · 새소식 알림<br>
										</p>
									</blockquote>
								</div>
							</div>
						</div>
					</div>

					<!-- 프로젝트 정보 -->
					<div class="mt-4">
						<label class="subheading" for="projectCategory">프로젝트 정보</label>
						<p class="sideDescription">카테고리를 선택해주세요.</p>
						<div class="d-flex flex-row">
							<select class="form-control" name="projectCategory" id="projectCategory">
								<option value="">선택</option>
								<option value="tech">테크/가전</option>
								<option value="fassion">패션/잡화</option>
								<option value="living">홈/리빙</option>
								<option value="beauty">뷰티</option>
								<option value="book">출판</option>
							</select>
						</div>
					</div>

					<!-- 프로젝트 제목 -->
					<div class="mt-4">
						<label class="subheading" for="projectSubject">프로젝트 제목</label>
						<p class="sideDescription">리워드의 장점과 특징이 잘 드러나는 키워드를 한 가지 이상 포함해 주세요.</p>
						<input class="form-control" type="text" name="projectSubject" id="projectSubject" placeholder="제목을 입력해 주세요">
					</div>

					<!-- 프로젝트 썸네일 -->
					<div class="mt-5">
						<p class="subheading">썸네일 이미지</p>
						<p class="sideDescription">
							· 3MB 이하의 JPG, JPEG, PNG 파일<br>
							· 텍스트나 로고는 넣을 수 없어요.<br>
							· 최소 1개에서 최대 3개까지 업로드가 가능해요.
						</p>
						<input type="file" name="thumnailsImages"><br>
						<input type="file" class="mt-2" name="thumnailsImages2"><br>
						<input type="file" class="mt-2" name="thumnailsImages3"><br>
					</div>
              
					<!-- 검색용 해시태그 -->
					<div class="mt-4">
						<label class="subheading" for="searchTag">검색용 태그(#)</label>
						<p class="sideDescription">프로젝트가 더 잘 검색될 수 있도록 연관성이 높은 태그를 입력해 주세요.</p>
						<input class="form-control" type="text" name="searchTag" id="searchTag" placeholder="최대 3개의 태그를 입력해 주세요">
					</div>

					<!-- 프로젝트 소개 -->
					<div class="mt-4">
						<label class="subheading" for="managementDetail">프로젝트 소개</label>
						<button class="btn btn-outline-primary btn-sm">AI로 입력</button>
						<p class="sideDescription">
							준비하고 계신 리워드의 특별한 점을 작성해 주세요.<br>
							기존 제품 ・ 서비스 ・ 콘텐츠를 개선했다면 어떤 점이 달라졌는지 작성해 주세요.<br>
							위에 입력된 정보를 바탕으로 AI로 자동 입력도 가능해요. 
						</p>
						<textarea class="form-control management-info" name="managementDetail" id="managementDetail" placeholder="예시 : 우리집 아이가 ○○ 인형을 좋아하는 모습을 보고 만들게 되었습니다." style="height: 300px; resize: none;"></textarea>
					</div>

					<!-- 프로젝트 상세정보 이미지 -->
					<div class="mt-4">
						<p class="subheading">상세정보 이미지</p>
						<p class="sideDescription">
							· 3MB 이하의 JPG, JPEG, PNG 파일<br>
							· 프로젝트를 설명할 상세정보를 업로드해요. 
						</p>
						<input type="file" name="projectImage"><br>
					</div>

					<!-- 목표 금액 -->
					<div class="mt-4">
						<label class="subheading" for="targetAmount">목표 금액</label>
						<p class="sideDescription">최소 50만 원~최대 1억 원 사이에서 설정해 주세요.</p>
						<input class="form-control" type="text" name="targetAmount" id="targetAmount" placeholder="금액을 입력해 주세요">
					</div>

					<!-- 프로젝트 일정 -->
					<div class="mt-4">
						<p class="subheading">프로젝트 일정</p>
						<p class="sideDescription">
							프로젝트 심사부터 리워드 제작 기간 등 전체 일정을 고려해 설정해 주세요.<br>
							리워드 발송은 프로젝트 종료 후 결제까지 완료되어야 가능해요.
						</p>
						<label class="sideDescription fw-bold" for="projectStartDate">시작일</label>
						<input type="text" name="projectStartDate" id="projectStartDate"><br>
						<label class="sideDescription mt-3 fw-bold" for="projectEndDate">종료일</label>
						<input type="text" name="projectEndDate" id="projectEndDate"><br>
					</div>

					<!-- 대표자 및 정산 정보 입력 -->
					<div class="mt-5">
						<p class="subheading">대표자 정보</p>
						<label class="sideDescription" for="representativeName">대표자명</label>
						<input class="form-control" type="text" name="representativeName" id="representativeName" placeholder="법인 사업자는 법인등기부상 법인명 / 개인은 성명을 입력해 주세요">
						<label class="sideDescription" for="representativeEmail">대표 이메일</label>
						<input class="form-control" type="text" name="representativeEmail" id="representativeEmail" placeholder="대표자의 이메일을 입력해 주세요"><br>
					</div>
              
					<!-- 정산 정보 -->
					<div>
					  <p class="subheading">정산 정보</p>
					</div>

					<!-- 세금계산서 발행 정보 -->
					<div class="mt-5">
					<p class="subheading">세금계산서 발행 정보</p>
					<label class="sideDescription" for="representativeBirth1">대표자 주민등록번호</label>
					<div class="row">
						<div class="col-sm-6">
							<input class="form-control" type="text" name="representativeBirth1" id="representativeBirth1" placeholder="앞 6자리 입력">
						</div>
						<div class="col-sm-6">
							<input class="form-control" type="text" name="representativeBirth2" id="representativeBirth2" placeholder="뒤 7자리 입력">
						</div>
					</div>
					<label class="sideDescription" for="taxEmail">세금계산서 발행 이메일</label>
					<input class="form-control" type="text" name="taxEmail" id="taxEmail" placeholder="세금계산서를 발행할 이메일을 입력해 주세요"><br>
					<label class="sideDescription" for="taxEmail">계좌정보</label>
					<p class="sideDescription">
						· 개인사업자의 경우 본인/사업자 명의 계좌 등록이 가능하며, 법인사업자의 경우 법인계좌만 등록 가능해요.<br>
						· 입금이 가능한 계좌인지 확인 후 입력해 주세요.<br>
						· 저축성 예금 계좌, 외화 예금 계좌, CMA 계좌, 평생 계좌번호(휴대전화 번호) 등은 입금이 불가합니다.
					</p>
					<div class="d-flex flex-row">
						<select class="form-control" name="bankCategory">
							<option value="">은행 선택</option>
							<option value="tech">신한은행</option>
							<option value="fassion">국민은행</option>
							<option value="living">농협은행</option>
							<option value="beauty">우리은행</option>
							<option value="book">기업은행</option>
							<option value="book">KEB하나은행</option>
							<option value="book">부산은행</option>
							<option value="book">카카오뱅크</option>
						</select>
					</div>
					<input class="form-control mt-1" type="text" name="bankAccount" placeholder="계좌번호 '-' 없이 숫자만 입력">
					<input class="form-control mt-1" type="text" name="bankName" placeholder="예금주명"><br>
					<button class="btn btn-primary">본인 인증</button>
					</div>

					<!-- 통장 사본 -->
					<div class="mt-5">
						<p class="subheading">통장사본</p>
						<p class="sideDescription">
							· 10MB 이하의 JPG, JPEG, PNG 파일<br>
							· 위 계좌 정보와 동일한 명의의 통장 사본을 제출해 주세요.
						</p>
						<input type="file" name="bankImage"><br>
					</div>

					<!-- 약관 시작 -->
					<div class="mt-5">
					<span class="subheading">서비스 이용 동의</span>
					<p class="sideDescription">아래 내용을 반드시 확인해 주세요.</p>
					<div class="agree_box">
						<ul class="agree_article">
							<li>
							    <div class="InpBox">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="agreeAll">
										<label class="form-check-label" for="agreeAll">
										  <strong class="all_agree">위 사실을 모두 확인하였고 동의합니다.</strong>
										</label>
									</div>
									<input type="hidden" name="hidden_check_all" value="0" id="hidden_check_all">
							    </div>
							</li>
						</ul>
					    <ul class="agree_article depth2">
							<li>
								<div class="agree_desc">
									<div class="InpBox">
										<div class="form-check">
										<input class="form-check-input" type="checkbox" name="agreeCheck" id="agree_rule1" required>
										    <label class="form-check-label" for="agree_rule1">
										    	<span><strong>제출한 프로젝트와 공지의 내용이 모두 사실임을 보증하며 사실이 아닐 경우 모든 책임을 부담하겠습니다.(제10조)</strong></span>
										    </label>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="agree_desc">
									<div class="InpBox">
										<div class="form-check">
										<input class="form-check-input" type="checkbox" name="agreeCheck" id="agree_rule2" required>
										    <label class="form-check-label" for="agree_rule2">
										    	<span><strong>동의한 약관 및 정책에 반하는 행위를 할 경우 프로젝트가 취소될 수 있고(제35조), 이용 계약이 해지될 수 있습니다.(제31조, 제40조)</strong></span>
										    </label>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="agree_desc">
									<div class="InpBox">
										<div class="form-check">
										<input class="form-check-input" type="checkbox" name="agreeCheck" id="agree_rule3" required>
										    <label class="form-check-label" for="agree_rule3">
										    	<span><strong>프로젝트를 공개한 후 취소하거나 취소되면 손해 배상과는 별도로 위약벌이 발생할 수 있음(제32조, 제41조)을 확인했습니다.</strong></span>
										    </label>
										</div>
									</div>
								</div>
								<a id="popupClausePrivacyPerson" class="view_indetail popup_clause_open" target="_blank">
									<span class="blind">서비스 이용 동의 상세보기</span>
								</a>
							</li>
					   </ul>
					  </div>
					</div>
					<!-- 약관 끝 -->

					<!-- 환불 정책 -->
					<div class="mt-5">
						<p class="subheading">환불 정책</p>
						<p class="sideDescription">이 프로젝트는 환불 정책이 적용돼요.</p>
						<a href="#">환불 정책 상세보기</a>
					</div>
					
					<div class="d-flex justify-content-center my-3">
						<input type="submit" value="신청하기" class="btn btn-primary">
					</div>
				</form>
				<!-- 폼 태그 끝-->
			</div>
			<!-- 프로젝트 등록 끝-->

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