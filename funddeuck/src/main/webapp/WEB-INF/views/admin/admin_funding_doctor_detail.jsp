<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.google.gson.Gson" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
table {
    width: 100%; /* 테이블의 전체 너비를 100%로 설정 */
    table-layout: fixed; /* 테이블 레이아웃을 고정으로 설정 */
}
th, td {
    width: 10%; /* 각 셀의 너비를 20%로 설정 */
}
.hover-effect:hover {
 	text-decoration: underline; /* 제목 클릭 시 밑줄 효과 */
}
</style>
<script>
	$(document).ready(function() {
		var project_target = Number(${project.project_target}).toLocaleString();
		$("#target").text(project_target + '원');
		
		var cumulative_amount = Number(${project.project_cumulative_amount}).toLocaleString();
		$("#cumulativeAmount").text(cumulative_amount + '원');
	});
	
	$(() => {
	    
	    'use strict';

	    var projectListStr = '<%= new Gson().toJson(request.getAttribute("projectList")) %>';
	    var projectList = JSON.parse(projectListStr);
	    
	    let myChart2 = null; // Chart 객체를 저장하기 위한 변수

	    let updateChart = (data) => {
	        let labels = [];
	        let zim_counts = [];

	        data.forEach(project => {
	            labels.push(project.zim_date);
	            zim_counts.push(Math.floor(project.zim_count));
	        });

	        let ctx2 = document.getElementById('myChart2').getContext('2d');

	        myChart2 = new Chart(ctx2, {
	            type: 'line',
	            data: {
	                labels,
	                datasets: [
	                    {
	                        label: '일별 찜한 횟수',
	                        data: zim_counts,
	                        type: 'line',
	                        backgroundColor: 'rgba(75, 192, 192, 0.4)',
	                        borderColor: 'rgba(75, 192, 192, 1)',
	                        borderWidth: 4,
	                        yAxisID: 'y-axis-3',  // 새로 설정할 Y축 ID
	                    },
	                ]
	            },
	            options: {
	                title: {
	                    display: true,
	                    text: '일별 찜한 횟수 데이터'
	                },
	                scales: {
	                    yAxes: [
	                        {
	                        	id: 'y-axis-3',
	                            type: 'linear',
	                            display: true,
	                            position: 'right',
	                            ticks: {
	                                beginAtZero: true,
	                                min: 0,
	                                stepSize: 1,
	                                precision: 0
	                            }
	                        },
	                    ],
	                },
	            },
	        });
	    };
	    
	    updateChart(projectList);
	    
	});
</script>
</head>
<body>
<!-- sidebar -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<!-- top -->
<div class="main-content">
<jsp:include page="../common/admin_top.jsp"/>

<div class="container">
	<h2 class="fw-bold mt-5">펀딩 닥터 상세보기</h2>
	<p class="projectContent">프로젝트의 모든 정보를 확인하고 컨설팅 합니다.</p>
</div>

<div class="container mt-2" style="max-width: 800px;">

	<div id="chartContainer">
	    <canvas id="myChart2" style="height: 40vh; width: 50vw"></canvas>
	</div>

	<div class="row">
		<div class="col">
	
			<div class="tab-buttons text-center">
				<button class="btn btn-outline-primary tab-button w-100" data-tab="tab1">프로젝트 정보</button>
				<button class="btn btn-outline-primary tab-button w-100" data-tab="tab2">컨설팅</button>
			</div>
				
				<div class="content-area" id="tab1">
						<div class="table-responsive">
							<table class="table text-start mt-4">
								<tr>
									<th style="background-color: #f8f9fa;">메이커 번호</th>
									<td style="width: 30%;">${project.maker_idx}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 번호</th>
									<td>
										${project.project_idx}
										<a href="adminFundingDoctorChart?member_idx=${project.member_idx }&maker_idx=${project.maker_idx}">
											<img src="${pageContext.request.contextPath }/resources/images/icon/bar.png" style="width: 20px; height: 20px;" class="no-action">
										</a>
									</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 요금제</th>
									<c:choose>
										<c:when test="${project.project_plan eq 1}">
											<td>기본 요금제</td>
										</c:when>
										<c:when test="${project.project_plan eq 2}">
											<td>인플루언서 요금제</td>
										</c:when>
									</c:choose>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 카테고리</th>
									<td>${project.project_category}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 제목</th>
									<td><a href="fundingDetail?project_idx=${project.project_idx }">${project.project_subject}</a></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">목표 금액</th>
									<td id="target"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 누적 금액</th>
									<td id="cumulativeAmount"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 시작일</th>
									<td>${project.project_start_date}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 종료일</th>
									<td>${project.project_end_date}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 썸네일</th>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_thumnails1}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 상세이미지</th>
									<td><img
										src="${pageContext.request.contextPath}/resources/upload/${project.project_image}"
										alt="첨부파일 없음"></td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 상세소개</th>
									<td>${project.project_introduce}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">프로젝트 한줄소개</th>
									<td>${project.project_semi_introduce}</td>
								</tr>
								<tr>
									<th style="background-color: #f8f9fa;">검색용 태그</th>
									<td>${project.project_hashtag}</td>
								</tr>
								<c:forEach var="rList" items="${rList }">
									<tr>
										<th style="background-color: #f8f9fa;">리워드 번호</th>
										<td>${rList.reward_idx}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">리워드 가격</th>
										<td>${rList.reward_price}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">리워드 카테고리</th>
										<td>${rList.reward_category}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">리워드명</th>
										<td>${rList.reward_name}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">리워드 수량</th>
										<td>${rList.reward_quantity}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">리워드 옵션</th>
										<td>${rList.reward_option}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">리워드 설명</th>
										<td>${rList.reward_detail}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">배송여부</th>
										<td>${rList.delivery_status}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">배송비</th>
										<td>${rList.delivery_price}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">발송 시작일</th>
										<td>${rList.delivery_date}</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">리워드 정보제공</th>
										<td>${rList.reward_info}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
					
					<div class="content-area" id="tab2">
					<c:choose>
						<c:when test="${project.project_status eq 7 }">
							<form action="fundingDoctorConsulting" method="post" enctype="multipart/form-data">
								<div class="mb-3">
						        	<label for="doctor_subject" class="form-label">글 제목</label>
						        	<input type="text" class="form-control" id="doctor_subject" name="doctor_subject" placeholder="컨설팅 제목을 입력하세요" required>
								</div>
								<div class="mb-3">
						        	<label for="doctor_content" class="form-label">상세 내용</label>
						        	<textarea class="form-control" id="doctor_content" name="doctor_content" rows="20" placeholder="상세 컨설팅 내용을 입력하세요" required></textarea>
								</div>
								<div class="mb-3">
						        	<label for="doctor_file" class="form-label">첨부파일</label>
						        	<input class="form-control" type="file" id="doctor_file" name="file1">
								</div>
								<div class="d-flex justify-content-center">
									<input type="hidden" name="project_idx" value="${project.project_idx }">
									<button type="submit" class="btn btn-primary btn-sm">등록</button>
								</div>
							</form>
						</c:when>
						<c:when test="${project.project_status eq 8 }">
							<p class="fw-bold text-info">컨설팅을 완료했습니다.</p>
							<div class="table-responsive">
								<table class="table text-start mt-4">
									<tr>
										<th style="background-color: #f8f9fa;">제목</th>
										<td style="width: 30%;">${doctor.doctor_subject }</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">내용</th>
										<td>${doctor.doctor_content }</td>
									</tr>
									<tr>
										<th style="background-color: #f8f9fa;">첨부파일</th>
										<td><img
											src="${pageContext.request.contextPath}/resources/upload/${doctor.doctor_file}"
											alt="첨부파일 없음"></td>
									</tr>
								</table>
							</div>
						</c:when>
					</c:choose>
					</div>
					
					<!-- 하단 버튼 -->
					<div class="d-flex justify-content-center my-3">
						<input type="button" value="목록" class="btn btn-outline-primary btn-sm" onclick="history.back()">
					</div>
			</div>
		</div>
	</div>
</div>

<!-- 모달창 -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel">이미지 보기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img src="" alt="이미지" id="modalImage" style="max-width: 100%;">
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
	
    $(".tab-button").click(function() {
    	
        var tabId = $(this).data("tab");
        $(".content-area").removeClass("active");
        $("#" + tabId).addClass("active");

        // 탭 버튼 클릭시 active 효과 설정
        $(".tab-button").removeClass("active"); // 모든 탭 버튼의 active 클래스 제거
        $(this).addClass("active"); // 클릭한 탭 버튼에 active 클래스 추가
        
    });

    // URL 파라미터 확인하여 탭 활성화 설정
    let urlParams = new URLSearchParams(window.location.search);
    let activeTab = urlParams.get("tab");

    // 모든 탭 버튼의 active 클래스 제거
    $(".tab-button").removeClass("active");

    if (activeTab === "1" || activeTab === "2") {
    	
        // 클릭한 탭 버튼에 active 클래스 추가
        $(".tab-button[data-tab='tab" + activeTab + "']").addClass("active");
        // 해당 탭의 컨텐트 영역에 active 클래스 추가
        $(".content-area").removeClass("active");
        $("#tab" + activeTab).addClass("active");
        
    } else {
    	
        // 기본적으로 활성화될 탭 설정 (여기선 1번 탭으로 설정)
        $(".tab-button[data-tab='tab1']").addClass("active");
        $(".content-area").removeClass("active");
        $("#tab1").addClass("active");
        
    }
    
});

//이미지 클릭 시 모달 창에 이미지 보여주기
$(document).ready(function () {
	$("tr td img:not(.no-action)").click(function () {
        var src = $(this).attr("src");
        $("#modalImage").attr("src", src);
        $("#imageModal").modal("show");
    });
});
    
// 이미지 크기를 50px x 50px로 조절
$(document).ready(function () {
	$("tr td img:not(.no-action)").css({
        "width": "50px",
        "height": "50px"
    });
    $("tr td img").attr("title", "클릭 시 이미지를 크게 볼 수 있습니다");
});

// 비행기 아이콘 클릭 시 아이디를 자동으로 입력
$(document).ready(function() {
	// 아이디 입력 필드 찾기
	let receiver = $('#message_receiver');
	
	// memberId 값을 가져와서 입력 필드의 value로 설정하고 readonly로 만들기
	let memberId = '${memberId}';
	receiver.val(memberId);
	receiver.prop('readonly', true);
});
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>