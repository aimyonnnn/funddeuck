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
	<script>
		$(document).ready(function() {
			// 임시 저장
			$(function () {
				// 저장 함수 정의
				function save(key, value) {
					localStorage.setItem(key, value);
				}
			
				// 불러오기 함수 정의
			    function load(key) {
					return localStorage.getItem(key);
			    }
				
			    const fields = [
			        "#maker_name",
			        "#maker_intro",
			        "#maker_email",
			        "#maker_tel",
			        "#maker_url"
			    ];
	
			 	// 저장하기 버튼 
				$("#saveButton").click(function () {
				    fields.forEach(f => save(f, $(f).val()));
				    alert("임시 저장 되었습니다!");
				});
			 	
				// 삭제하기 버튼
			    $("#deleteButton").click(function () {
					localStorage.clear();
					alert("임시저장된 내용을 삭제했습니다!");
			    });
				
				// 불러오기 버튼 
			    $("#loadButton").click(function () {
			        fields.forEach(f => {
			            var value = load(f);
			            if (value) {
			                $(f).val(value);
			            }
			        });
			        alert("임시저장을 불러왔습니다!");  
			    });
			});
		});
	</script>
</head>
<body>
	<div id="loadingIndicator" style="display: none;">
	    <img src="${pageContext.request.contextPath }/resources/images/loading.gif" alt="Loading..." />
	</div>
	
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
            
              <!-- 메이커 유형 -->
              <div>
                <p class="subheading">메이커 유형</p>
                <p class="sideDescription">메이커 유형을 선택해주세요.</p>
                
                <!-- 탭 버튼 -->
			    <div class="tab-buttons text-center">
			        <button class="btn btn-outline-primary tab-button w-100" data-tab="tab1">개인</button>
			        <button class="btn btn-outline-primary tab-button w-100" data-tab="tab2">개인사업자</button>
			        <button class="btn btn-outline-primary tab-button w-100" data-tab="tab3">법인사업자</button>
			    </div>
			    	
				<!-- 개인회원 -->			    
				<div class="content-area sideDescription" id="tab1">
				    <!-- 폼 태그 -->
				    <form action="projectMakerPro" class="projectContent" method="post" enctype="multipart/form-data" onsubmit="return validateForm()" name="projectForm">
				        <!-- 히든 처리 -->
				        <input type="hidden" name="member_idx" class="form-control" value="${member_idx}" >
						<input type="file" name="file2" class="mt-3" style="display: none">
						<input type="file" name="file3" class="mt-3" style="display: none">
				        
				        <span>대표자 확인을 위해 신분증 사본을 업로드해 주세요.<br>
				            주민등록번호 뒷자리는 노출되지 않도록 가려 주세요.<br>
				            JPG, JPEG, PNG, PDF / 10MB 이하 파일 업로드 가능<br>
				            <input type="file" name="file1" class="mt-3">
				        </span>
				
				        <!-- 메이커 명 -->
				        <div>
				            <label class="subheading" for="maker_name">메이커명</label>
				            <p class="sideDescription">법인 사업자는 법인등기부상 법인명 / 개인 사업자는 주민등록상 성명 또는 상호 / 개인은 주민등록상 성명을 입력해 주세요.</p>
				            <input class="form-control" type="text" id="maker_name" name="maker_name" placeholder="메이커명을 입력해 주세요">
				        </div>
				
				        <!-- 메이커 소개 -->
				        <div>
				            <label class="subheading" for="maker_intro">메이커 소개</label>
				            <button class="btn btn-outline-primary btn-sm mx-2" onclick="makeGpt(event)">AI로 입력</button>
				            <p class="sideDescription">
				                메이커를 표현할 수 있는 매력적인 문구를 작성해주세요.<br>
				                문구 작성이 막막하시면 AI가 문구를 추천해 드려요.<br>
				                간단하게 작성하고 버튼을 클릭하면 AI가 문구를 수정해드려요.<br>
				                예시-"무선충전기 판매업체 입니다" 입력 후 AI로 입력 버튼 클릭
				            </p>
				            <input class="form-control" type="text" name="maker_intro" placeholder="메이커를 소개를 적어주세요.">
				        </div>
				
				        <!-- 메이커 대표 이미지 -->
				        <div>
				            <p class="subheading">메이커 이미지&로고</p>
				            <p class="sideDescription">
				                · 3MB 이하의 JPG, JPEG, PNG 파일<br>
				            </p>
				            <!-- maker_img, maker_logo -->
				            <input type="file" name="file4" class="mb-2"><br>
				            <input type="file" name="file5"><br>
				        </div>
				
				        <!-- 메이커 이메일 -->
				        <div>
				            <label class="subheading" for="maker_email">메이커 이메일</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 이메일을 입력해 주세요.</p>
				            <input class="form-control" type="text" id="maker_email" name="maker_email" placeholder="메이커 이메일을 입력해 주세요">
				        </div>
				
				        <!-- 메이커 전화번호 -->
				        <div>
				            <label class="subheading" for="maker_tel">메이커 전화번호</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 전화번호를 입력해 주세요.</p>
				            <input class="form-control" type="text" id="maker_tel" name="maker_tel" placeholder="메이커 전화번호를 입력해 주세요">
				        </div>
				
				        <!-- 메이커 SNS/홈페이지/채널 주소 -->
				        <div>
				            <label class="subheading" for="maker_url">메이커 링크</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 홈페이지 URL을 입력해 주세요.</p>
				            <input class="form-control" type="text" id="maker_url" name="maker_url" placeholder="입력예시-www.example.com">
				        </div>
				
				        <div class="d-flex justify-content-center my-3">
				            <input type="submit" value="등록하기" class="btn btn-outline-primary">
				        </div>
				    </form>
				</div>
				
				
				<!-- 개인사업자 회원 -->
		        <div class="content-area" id="tab2">
		          	<!-- 폼 태그 -->
				    <form action="projectMakerPro" class="projectContent" method="post" enctype="multipart/form-data" onsubmit="return validateIndividualForm()" name="individualForm">
				        <!-- 히든 처리 -->
				        <input type="hidden" name="member_idx" value="${member_idx}" class="form-control">
				        <input type="file" name="file1" class="mt-3" style="display: none">
						<input type="file" name="file3" class="mt-3" style="display: none">
				        
			        	<div>
			                <label class="my-2" for="individual_biz_num">사업자 등록번호(10자리)</label>
			                <input class="form-control" type="text" name="individual_biz_num" id="individual_biz_num" placeholder="사업자 등록번호를 입력해 주세요">
			                
			                <div id="individual_biz_num_result"></div>
			                
			                <label class="my-2" for="individual_biz_name">상호 또는 법인명</label>
			                <input class="form-control" type="text" name="individual_biz_name" id="individual_biz_name" placeholder="사업자 등록번호를 입력해 주세요">
			                <label class="my-2" for="individual_biz_name">사업자 등록증</label><br>
		          			<span class="sideDescription my-2">
		          				  가장 최근에 발급한 사업자 등록증을 업로드해 주세요.<br>
								  JPG, JPEG, PNG, PDF / 10MB 이하 파일 1개만 업로드 가능해요.<br>
						    </span>
		             		 <input type="file" name="file2" class="mt-3">
		             	</div>
				        <!-- 메이커 명 -->
				        <div>
				            <label class="subheading" for="maker_name">메이커명</label>
				            <p class="sideDescription">법인 사업자는 법인등기부상 법인명 / 개인 사업자는 주민등록상 성명 또는 상호 / 개인은 주민등록상 성명을 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_name" placeholder="메이커명을 입력해 주세요">
				        </div>
				
				        <!-- 메이커 소개 -->
				        <div>
				            <label class="subheading" for="maker_intro">메이커 소개</label>
				            <button class="btn btn-outline-primary btn-sm mx-2" onclick="makeGpt(event)">AI로 입력</button>
				            <p class="sideDescription">
				                메이커를 표현할 수 있는 매력적인 문구를 작성해주세요.<br>
				                문구 작성이 막막하시면 AI가 문구를 추천해 드려요.<br>
				                간단하게 작성하고 버튼을 클릭하면 AI가 문구를 수정해드려요.<br>
				                예시-"무선충전기 판매업체 입니다" 입력 후 AI로 입력 버튼 클릭
				            </p>
				            <input class="form-control makerIntro" type="text" name="maker_intro" id="maker_intro" placeholder="메이커를 소개를 적어주세요.">
				        </div>
				
				        <!-- 메이커 대표 이미지 -->
				        <div>
				            <p class="subheading" for="maker_img">메이커 이미지&로고</p>
				            <p class="sideDescription">
				                · 3MB 이하의 JPG, JPEG, PNG 파일<br>
				            </p>
				            <!-- maker_img, maker_logo -->
				            <input type="file" name="file4" class="mb-2"><br>
				            <input type="file" name="file5"><br>
				        </div>
				
				        <!-- 메이커 이메일 -->
				        <div>
				            <label class="subheading" for="maker_email">메이커 이메일</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 이메일을 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_email" placeholder="메이커 이메일을 입력해 주세요">
				        </div>
				
				        <!-- 메이커 전화번호 -->
				        <div>
				            <label class="subheading" for="maker_tel">메이커 전화번호</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 전화번호를 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_tel" placeholder="메이커 전화번호를 입력해 주세요">
				        </div>
				
				        <!-- 메이커 SNS/홈페이지/채널 주소 -->
				        <div>
				            <label class="subheading" for="maker_url">메이커 링크</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 홈페이지 URL을 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_url" placeholder="입력예시-www.example.com">
				        </div>
				
				        <div class="d-flex justify-content-center my-3">
				            <input type="submit" value="등록하기" class="btn btn-outline-primary">
				        </div>
				    </form>
		        </div>
		        
		        
		        <!-- 법인사업자 회원 -->
		        <div class="content-area" id="tab3">
		        	<!-- 폼 태그 -->
				    <form action="projectMakerPro" class="projectContent" method="post" enctype="multipart/form-data" onsubmit="return validateCorporateForm()" name="corporateForm">
				        <!-- 히든 처리 -->
				        <input type="hidden" name="member_idx" value="${member_idx}" class="form-control">
				        <input type="file" name="file1" class="mt-3" style="display: none">
						<input type="file" name="file2" class="mt-3" style="display: none">
				        
			        	<div>
			                <label class="my-2" for="corporate_biz_num">법인사업자 등록번호(10자리)</label>
			                <input class="form-control" type="text" name="corporate_biz_num" placeholder="사업자 등록번호를 입력해 주세요">
			                
			                <div id="corporate_biz_num_result"></div>
			                
			                <label class="my-2" for="corporate_biz_name">상호 또는 법인명</label>
			                <input class="form-control" type="text" name="corporate_biz_name" placeholder="사업자 등록번호를 입력해 주세요">
			                <label class="my-2" for="corporate_biz_id">사업자 등록증</label><br>
		          			<span class="sideDescription my-2">
		          				  가장 최근에 발급한 사업자 등록증을 업로드해 주세요.<br>
								  JPG, JPEG, PNG, PDF / 10MB 이하 파일 1개만 업로드 가능해요.<br>
						    </span>
		             		 <input type="file" name="file3" class="mt-3" >
		             	</div>
		             	
				        <!-- 메이커 명 -->
				        <div>
				            <label class="subheading" for="maker_name">메이커명</label>
				            <p class="sideDescription">법인 사업자는 법인등기부상 법인명 / 개인 사업자는 주민등록상 성명 또는 상호 / 개인은 주민등록상 성명을 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_name"  placeholder="메이커명을 입력해 주세요">
				        </div>
				
				        <!-- 메이커 소개 -->
				        <div>
				            <label class="subheading" for="maker_intro">메이커 소개</label>
				            <button class="btn btn-outline-primary btn-sm mx-2" onclick="makeGpt(event)">AI로 입력</button>
				            <p class="sideDescription">
				                메이커를 표현할 수 있는 매력적인 문구를 작성해주세요.<br>
				                문구 작성이 막막하시면 AI가 문구를 추천해 드려요.<br>
				                간단하게 작성하고 버튼을 클릭하면 AI가 문구를 수정해드려요.<br>
				                예시-"무선충전기 판매업체 입니다" 입력 후 AI로 입력 버튼 클릭
				            </p>
				            <input class="form-control" type="text" name="maker_intro" placeholder="메이커를 소개를 적어주세요.">
				        </div>
				
				        <!-- 메이커 대표 이미지 -->
				        <div>
				            <p class="subheading" for="maker_img">메이커 이미지&로고</p>
				            <p class="sideDescription">
				                · 3MB 이하의 JPG, JPEG, PNG 파일<br>
				            </p>
				            <!-- maker_img, maker_logo -->
				            <input type="file" name="file4" class="mb-2"><br>
				            <input type="file" name="file5"><br>
				        </div>
				
				        <!-- 메이커 이메일 -->
				        <div>
				            <label class="subheading" for="maker_email">메이커 이메일</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 이메일을 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_email"  placeholder="메이커 이메일을 입력해 주세요">
				        </div>
				
				        <!-- 메이커 전화번호 -->
				        <div>
				            <label class="subheading" for="maker_tel">메이커 전화번호</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 전화번호를 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_tel"  placeholder="메이커 전화번호를 입력해 주세요">
				        </div>
				
				        <!-- 메이커 SNS/홈페이지/채널 주소 -->
				        <div>
				            <label class="subheading" for="maker_url">메이커 링크</label>
				            <p class="sideDescription">프로젝트 공개 후 문의할 수 있는 홈페이지 URL을 입력해 주세요.</p>
				            <input class="form-control" type="text" name="maker_url"  placeholder="입력예시-www.example.com">
				        </div>
				
				        <div class="d-flex justify-content-center my-3">
				            <input type="submit" value="등록하기" class="btn btn-outline-primary">
				        </div>
				    </form>
		        </div>
		        
		        
              </div>
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
					<i class="fas fa-exclamation-circle"></i><a>&nbsp;알림이 없습니다.</a>
				</div>
	      	</div>
			<button id="saveButton" class="btn btn-outline-secondary btn-sm me-3">임시저장</button>
			<button id="loadButton" class="btn btn-outline-secondary btn-sm me-3">불러오기</button>
			<button id="deleteButton" class="btn btn-outline-secondary btn-sm">삭제하기</button>
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
	})
	
	// AI로 입력하기
	function makeGpt(event) {
	    event.preventDefault(); // 기본 동작 중지

     	// 로딩 이미지 표시
         $('#loadingIndicator').show();
     	
         var makeStoryRequest = {
         	 makerIntroduce: $('#maker_intro').val()
         };
	
         console.log(makeStoryRequest);
         
         $.ajax({
             type: "POST",
             url: "<c:url value='MakeStory'/>",
             contentType: "application/json",
             data: JSON.stringify(makeStoryRequest),
             beforeSend: function() {
                 $('#loadingIndicator').show();
             },
             success: function (response) {
                 $('#loadingIndicator').hide();
             	
                 console.log(response);
                 var responseObject = response; 			  	// 이미 json 형식의 응답이므로 파싱하지 않음
                 var result = responseObject.choices[0].text; 	// 필요한 필드 추출
                 result = result.replace(/\./g, "");          	
                 $("#maker_intro").val(result).focus();
                 Swal.fire({
     	            icon: 'success',
     	            title: '메이커 소개글 추천 완료!',
     	            text: '메이커 소개글 입력이 완료되었습니다.'
     	       	 });
                 
             },
             error: function (xhr, status, error) {
             	
                 console.log(error);
             }
         });
     }
	</script>
	
	<script type="text/javascript">
	// 공통된 유효성 검사 함수
	function validateCommonFields(form) {
	    var makerName = form["maker_name"].value;
	    var makerIntro = form["maker_intro"].value;
	    var file4 = form["file4"].value;
	    var file5 = form["file5"].value;
	    var makerEmail = form["maker_email"].value;
	    var makerTel = form["maker_tel"].value;
	    var makerUrl = form["maker_url"].value;

	    if (makerName === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '메이커명을 입력해주세요.'
	        });
	        return false;
	    }
	    if (makerIntro === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '메이커 소개를 입력해주세요.'
	        });
	        return false;
	    }
	    if (file4 === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '메이커 이미지를 첨부해주세요.'
	        });
	        return false;
	    }
	    if (file5 === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '메이커 로고를 첨부해주세요.'
	        });
	        return false;
	    }
	    
	    if (makerEmail === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '메이커 이메일을 입력해주세요.'
	        });
	        return false;
	    }
	    // 이메일 형식 검사
        var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if (!makerEmail.match(emailRegex)) {
            Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '유효한 이메일 주소를 입력해주세요.'
	        });
            return false;
        }
        
        if (makerTel == "") {
            Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '메이커 전화번호를 입력해주세요.'
	        });
            return false;
        }
        // 전화번호 형식 검사
        var telRegex = /^\d{3}-\d{3,4}-\d{4}$/;
        if (!makerTel.match(telRegex)) {
            Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '유효한 전화번호를 입력해주세요. (000-0000-0000)'
	        });
            return false;
        }
        
        if (makerUrl == "") {
            Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '메이커 링크를 입력해주세요.'
	        });
            return false;
        }
        // URL 형식 검사
        var urlRegex = /^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-zA-Z0-9]+([-.]{1}[a-zA-Z0-9]+)*\.[a-zA-Z]{2,5}(:[0-9]{1,5})?(\/.*)?$/;
        if (!makerUrl.match(urlRegex)) {
            Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '유효한 URL을 입력해주세요.'
	        });
            return false;
        }
        
	    return true;
	}

	
	// 개인회원 - 유효성 검사
	function validateForm() {
	    var file1 = document.forms["projectForm"]["file1"].value;

	    if (file1 === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '신분증 사본을 첨부해주세요.'
	        });
	        return false;
	    }

	    // 개인일때의 공통 필드 유효성 검사
	    if (!validateCommonFields(document.forms["projectForm"])) {
	        return false;
	    }

	    return true; // 모든 검사 통과
	}
	
	
	// 개인사업자 - 유효성 검사
	function validateIndividualForm() {
	    var individualBizNum = document.forms["individualForm"]["individual_biz_num"].value;
	    var individualBizName = document.forms["individualForm"]["individual_biz_name"].value;
	    var file2 = document.forms["individualForm"]["file2"].value;

	    if (individualBizNum === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '사업자 등록번호를 입력해주세요.'
	        });
	        return false;
	    }
	    if (!/^(\d{3}-\d{2}-\d{5})$/.test(individualBizNum)) {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '유효한 사업자 등록번호(XXX-XX-XXXXX)를 입력해주세요.'
	        });
	        return false;
	    }
	    if (individualBizName === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '상호 또는 법인명을 입력해주세요.'
	        });
	        return false;
	    }
	    if (file2 === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '사업자 등록증을 첨부해주세요.'
	        });
	        return false;
	    }

	    // 개인사업자일때의 공통 필드 유효성 검사
	    if (!validateCommonFields(document.forms["individualForm"])) {
	        return false;
	    }

	    return true; // 모든 검사 통과
	}
	
	
	// 법인사업자 - 유효성 검사
	function validateCorporateForm() {
	    var corporateBizNum = document.forms["corporateForm"]["corporate_biz_num"].value;
	    var corporateBizName = document.forms["corporateForm"]["corporate_biz_name"].value;
	    var file3 = document.forms["corporateForm"]["file3"].value;

	    if (!/^(\d{3}-\d{2}-\d{5})$/.test(corporateBizNum)) {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '유효한 법인사업자 등록번호(XXX-XX-XXXXX)를 입력해주세요.'
	        });
	        return false;
	    }
	    if (corporateBizName === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '상호 또는 법인명을 입력해주세요.'
	        });
	        return false;
	    }
	    if (file3 === "") {
	        Swal.fire({
	            icon: 'error',
	            title: 'Oops...',
	            text: '사업자 등록증을 첨부해주세요.'
	        });
	        return false;
	    }

	    // 법인사업자일때의 공통 필드 유효성 검사
	    if (!validateCommonFields(document.forms["corporateForm"])) {
	        return false;
	    }

	    return true; // 모든 검사 통과
	}
	
	// ============================================================================
	
	// 모든 휴대폰 번호 입력 필드를 선택
	var phoneNumberInputs = document.querySelectorAll("input[name='maker_tel']");
	
	// 각각의 입력 필드에 대해 이벤트 리스너 등록
	phoneNumberInputs.forEach(function(phoneNumberInput) {
	    phoneNumberInput.addEventListener("input", function (event) {
	        // 입력 내용에서 "-"를 제외하고 숫자만 추출
	        var inputValue = event.target.value.replace(/-/g, '');
	
	        // "-" 제외한 번호 길이를 확인
	        var length = inputValue.length;
	
	        // 휴대폰 번호 형식에 맞게 "-"를 추가
	        var formattedValue = '';
	        if (length > 3) {
	            formattedValue += inputValue.substr(0, 3) + '-';
	            if (length > 6) {
	                formattedValue += inputValue.substr(3, 4) + '-';
	                formattedValue += inputValue.substr(7, 4);
	            } else {
	                formattedValue += inputValue.substr(3);
	            }
	        } else {
	            formattedValue = inputValue;
	        }
	
	        // 변환된 번호를 입력 필드에 설정
	        event.target.value = formattedValue;
	    });
	
	    phoneNumberInput.addEventListener("keydown", function (event) {
	        // Backspace 키를 눌렀을 때 "-"를 제거
	        if (event.key === "Backspace") {
	            var inputValue = event.target.value.replace(/-/g, '');
	            inputValue = inputValue.slice(0, -1); // 마지막 문자 제거
	            var formattedValue = '';
	            if (inputValue.length >= 3) {
	                formattedValue += inputValue.substr(0, 3) + '-';
	                if (inputValue.length >= 7) {
	                    formattedValue += inputValue.substr(3, 4) + '-';
	                    formattedValue += inputValue.substr(7);
	                } else {
	                    formattedValue += inputValue.substr(3);
	                }
	            } else {
	                formattedValue = inputValue;
	            }
	            event.target.value = formattedValue;
	        }
	    });
	});
	
	// 사업자 등록 번호 조회
	// 쿠팡 : 120-88-00767
	$('#individual_biz_num').blur(()=>{
		
		console.log('사업자등록번호조회함');
	    let check = {}; // check 변수 빈 객체로 초기화
		let individualBizNum = $('#individual_biz_num').val();
	    individualBizNum = individualBizNum.replace(/-/g, ''); // 하이픈 제거
		console.log(individualBizNum);

		new Promise( (succ, fail)=>{
		
			
			let data = { "b_no": [individualBizNum] }; 
			
			let apiKey = "r8adyuvJItJ6iJEp7oUvG8Qpvt63fsTfhpQegQYy%2BLjVYUA7nHRyPoESMMafkSvBUZPgQ%2BqCNOP2aogAnz8T4A%3D%3D";
	
			// 사업자 등록증 조회
			$.ajax({
				type: "POST",
		        url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=" + apiKey,
		        data: JSON.stringify(data),
		        dataType: "JSON",
		        contentType: "application/json",
		        accept: "application/json",
		        success: function(result) {
					
		        	console.log(result);
		        	
	        	  	check.code = result.data[0].b_stt_cd;
                    check.b_no = result.data[0].b_no;
	               	succ(result);
		
		        },
		        fail: function(result) {
		            fail(error);                                    
		        }
		    });
			
		 	}).then((arg) =>{   
	
	             $.ajax({
	                 type: 'post',
	                 url: '<c:url value="bizNumCheck"/>',
	                 data: { individual_biz_num: $('#individual_biz_num').val() },
	                 success: function(result) {
	                	 
	                	 console.log(result);
	
	                	 if (result.trim() == 'true') {
	                		
	                		console.log('DB에 없는 사업자번호임');
	                		 
                		    if (check.code == "01") {
                		    	
                		        $("#individual_biz_num_result").text("정상적인 사업자번호입니다.");
                		        $("#individual_biz_num_result").css("color", "green");
                		        
                		    } else if (check.code == "02" || check.code == "03") {
                		    	
                		        $("#individual_biz_num_result").text("휴/폐업한 사업자번호입니다.");
                		        $("#individual_biz_num_result").css("color", "red");
                		        $('#individual_biz_num').focus();
								                		        
                		    } else {
                		    	
                		        $("#individual_biz_num_result").text("등록되지 않은 사업자번호입니다.");
                		        $("#individual_biz_num_result").css("color", "red");
                		        $('#individual_biz_num').focus();
                		    }
                		    
                		} else {
                			
                			console.log('DB에 있는 사업자번호임');
                			
                		    $("#individual_biz_num_result").text("이미 가입한 사업자번호입니다.");
                		    $("#individual_biz_num_result").css("color", "red");
                		    $('#individual_biz_num').focus();
                		    
                		}
                 }                                              
             });

         }); //then end

	});
	</script>
	
	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
	<!-- 휴대폰 번호, 사업자 번호 유효성 검사 -->
	<script src="${pageContext.request.contextPath}/resources/js/formValidation.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

</body>
</html>