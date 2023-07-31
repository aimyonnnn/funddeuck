<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
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
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/project_status.css" rel="styleSheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
// 메이커 통합 차트
$(() => {
    $('.datepicker').datepicker();

    let myChart2 = null; // Chart 객체를 저장하기 위한 변수

    $('#updateButton').click(() => {
    	
    	// 시작 날짜, 끝 날짜 검사
        var makerStartDate = new Date(document.getElementById("startDate").value);
        var makerEndDate = new Date(document.getElementById("endDate").value);

        if (!makerStartDate || !makerEndDate) {
            alert("시작 날짜와 끝 날짜를 모두 입력해주세요.");

            if (!makerStartDate) {
                document.getElementById("startDate").focus();
            } else {
                document.getElementById("endDate").focus();
            }
            return;
        }

        if (makerStartDate > makerEndDate) {
            alert("시작 날짜는 끝 날짜보다 빠를 수 없습니다.");
            document.getElementById("startDate").focus();
            return;
        }

        // 차트 유형 검사
        var makerChartType = document.getElementById("chartType").value;
        if (makerChartType === "") {
            alert("차트 유형을 선택해주세요.");
            document.getElementById("chartType").focus();
            return;
        }
    	
        let startDate = $('#startDate').val(); 		// 시작일 입력값 가져오기
        let endDate = $('#endDate').val(); 			// 종료일 입력값 가져오기
        let chartType = $('#chartType').val(); 		// 선택된 차트 유형 가져오기
        let maker_idx = ${maker_idx}; 				// 모델에 저장된 maker_idx 가져오기

        $.ajax({
            type: 'post',
            url: '<c:url value="chartData"/>', 		// 차트 데이터를 가져올 URL 설정
            data: {
                startDate,      // 시작일
                endDate,        // 종료일
                chartType,      // 차트
                maker_idx       // 메이커 번호
            },
            success: (response) => {
                console.log(response);
                updateChart(response, chartType); 	// 차트 업데이트 함수 호출
            }
        });
    });
}); // ready

let updateChart = (data, chartType) => {
    // 응답 데이터에서 라벨, 일별 결제 금액, 누적 결제 금액, 일별 서포터 수, 누적 서포터 수를 추출
    let { labels, dailyPaymentAmounts, acmlPaymentAmounts, dailySupporterCounts, acmlSupporterCounts } = data;
    // 차트 컨테이너 요소
    let chartContainer = document.getElementById('chartContainer');
    // 기존의 차트 캔버스를 제거
    chartContainer.innerHTML = '<canvas id="myChart2"></canvas>';
    // 새로운 차트를 위한 캔버스 요소
    let ctx2 = document.getElementById('myChart2').getContext('2d');
    // 기존의 차트 객체가 존재하는 경우 제거함
    if (myChart2 && myChart2 instanceof Chart) {
        myChart2.destroy();
    }
    // 새로운 차트 객체를 생성
    myChart2 = new Chart(ctx2, {
        type: chartType, // 바 차트로 초기 설정
        data: {
            labels, // 라벨
            datasets: [
                {
                    label: '일별 결제 금액',
                    data: dailyPaymentAmounts, 					// 일별 결제 금액 설정
                    type: 'line', 								// 라인 차트로 설정
                    backgroundColor: 'rgb(135, 206, 235)',
                    borderColor: 'rgb(135, 206, 235)',
                    borderWidth: 4,
                    fill: false,
                    yAxisID: 'y-axis-1', 						// 왼쪽 축에 연결될 Y축 ID
                },
                {
                    label: '누적 결제 금액',
                    data: acmlPaymentAmounts, 					// 누적 결제 금액 설정
                    type: 'line', 								// 라인 차트로 설정
                    backgroundColor: 'rgba(255, 99, 132, 1)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 4,
                    fill: false,
                    yAxisID: 'y-axis-1', 						// 왼쪽 축에 연결될 Y축 ID
                },
                {
                    label: '누적 회원 수',
                    data: acmlSupporterCounts, 					// 누적 회원 수 설정
                    type: chartType,
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    borderColor: 'rgba(153, 102, 255, 0.2)',
                    borderWidth: 4,
                    yAxisID: 'y-axis-2', 						// 오른쪽 축에 연결될 Y축 ID
                }
            ]
        },
        options: {
            title: {
                display: true,
                text: '결제 금액과 누적 회원 수 데이터' 		// 차트 제목
            },
            scales: {
                yAxes: [
                    {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        id: 'y-axis-1', 						// 왼쪽 Y축 ID
                    },
                    {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        id: 'y-axis-2', 						// 오른쪽 Y축 ID
                    },
                ],
            },
        },
    });
    
 	// 텍스트 업데이트 작업 시작
 	// 누적 결제 금액 업데이트
    let acmlPaymentAmountElementMaker = document.getElementById('acmlPaymentAmountMaker');
    let acmlPaymentAmountMaker = acmlPaymentAmounts[acmlPaymentAmounts.length - 1];

    if (acmlPaymentAmountMaker !== undefined) {
        acmlPaymentAmountElementMaker.textContent = acmlPaymentAmountMaker;
    } else {
        acmlPaymentAmountElementMaker.textContent = '0';
    }

	// 일별 평균 결제 금액 업데이트
    let todayPaymentAmountElementMaker = document.getElementById('todayPaymentAmountMaker');
    let totalDays = dailyPaymentAmounts.length;
    let totalPaymentAmount = dailyPaymentAmounts.reduce((acc, amount) => acc + amount, 0);
    let todayPaymentAmountMaker = totalDays > 0 ? Math.round(totalPaymentAmount / totalDays) : 0;
    todayPaymentAmountElementMaker.textContent = todayPaymentAmountMaker;

    // 누적 서포터 수 업데이트
    let acmlSupporterCountElementMaker = document.getElementById('acmlSupporterCountMaker');
    let acmlSupporterCountMaker = acmlSupporterCounts[acmlSupporterCounts.length - 1];

    if (acmlSupporterCountMaker !== undefined) {
        acmlSupporterCountElementMaker.textContent = acmlSupporterCountMaker;
    } else {
        acmlSupporterCountElementMaker.textContent = '0';
    }
    
};
// 페이지 로드시에 차트 출력하기
window.addEventListener('load', function() {
	const today = new Date();                        // 현재 날짜를 생성
	const sevenDaysAgo = new Date(today);            // 새로운 날짜 객체 생성    
	sevenDaysAgo.setDate(today.getDate() - 7);       // 7일 전의 날짜로 설정
	
	// 시작 날짜 입력란에 7일 전 날짜 설정
	document.getElementById("startDate").valueAsDate = sevenDaysAgo;
	
	// 끝 날짜 입력란에 오늘 날짜 설정
	document.getElementById("endDate").valueAsDate = today;
	
	// Bar 차트로 설정
	document.getElementById("chartType").value = "bar";
	
	// 페이지 로드 후 자동으로 조회 버튼 클릭 (1초 후에 실행하도록 설정)
	setTimeout(function () {
	    document.getElementById("updateButton").click();
	}, 1000); 
});
</script>
	
<script type="text/javascript">
// 프로젝트별 차트
$(() => {
    $('.datepicker').datepicker();

    let myChart3 = null; // Chart 객체를 저장하기 위한 변수

    $('#updateProjectButton').click(() => {
    	
    	// 차트 선택 시 유효성 검사
        // 프로젝트 선택 검사
        var projectSelect = document.getElementById("projectSelect").value;
        if (projectSelect === "") {
            alert("프로젝트를 선택해주세요.");
            return;
        }

        // 시작 날짜, 끝 날짜 검사
        var startDate = new Date(document.getElementById("startDateProject").value);
        var endDate = new Date(document.getElementById("endDateProject").value);

        if (!startDate || !endDate) {
            alert("시작 날짜와 끝 날짜를 모두 입력해주세요.");

            if (!startDate) {
                document.getElementById("startDateProject").focus();
            } else {
                document.getElementById("endDateProject").focus();
            }
            return;
        }

        if (startDate > endDate) {
            alert("시작 날짜는 끝 날짜보다 빠를 수 없습니다.");
            document.getElementById("startDateProject").focus();
            return;
        }

        // 차트 유형 검사
        var chartType = document.getElementById("chartTypeProject").value;
        if (chartType === "") {
            alert("차트 유형을 선택해주세요.");
            document.getElementById("chartTypeProject").focus();
            return;
        }
        
        var selectedProjectIdx = document.getElementById("projectSelect").value; 	// 셀렉트 박스에서 선택된 값을 가져오기
        var selectedText = $('#projectSelect option:selected').text();				// 셀렉트 박스에서 선택된 옵션의 표시 텍스트를 가져오기
        $("#selectedProjectIdx").text(selectedProjectIdx + "번 " + selectedText);	// selectedProjectIdx 요소의 내용을 업데이트 하기
    	
        let startDateProject = $('#startDateProject').val(); 						// 시작일 입력값 가져오기
        let endDateProject = $('#endDateProject').val(); 							// 종료일 입력값 가져오기
        let chartTypeProject = $('#chartTypeProject').val(); 						// 선택된 차트 유형 가져오기
        let maker_idx = ${maker_idx}; 												// 파라미터로 받은 maker_idx를 변수에 저장
        let project_idx = $('#projectSelect').val(); 								// 선택된 프로젝트 번호 가져오기

        $.ajax({
            type: 'POST',
            url: '<c:url value="chartDataProject"/>',  // 프로젝트별 차트 데이터를 가져올 URL
            data: {
                startDateProject,   // 시작일
                endDateProject,     // 종료일
                chartTypeProject,   // 차트
                maker_idx,          // 메이커 번호
                project_idx         // 프로젝트 번호
            },
            success: (response) => {
            	
                console.log(response);
                
                const accumulatedAmount = response.acmlPaymentAmounts;
                $("#accumulatedAmount").html(`${accumulatedAmount}<span class="sideDescription">원</span>`);
                
                updateProjectChart(response, chartTypeProject); 	// 프로젝트별 차트 업데이트 함수 호출
                
            }
        });
    });
}); // ready

let updateProjectChart = (data, chartTypeProject) => {
    // 응답 데이터에서 라벨, 일별 결제 금액, 누적 결제 금액, 일별 서포터 수, 누적 서포터 수를 추출
    let { labels, dailyPaymentAmounts, acmlPaymentAmounts, dailySupporterCounts, acmlSupporterCounts } = data;
    // 차트 컨테이너 요소
    let chartContainer = document.getElementById('chartContainer3');
    // 기존의 차트 캔버스를 제거
    chartContainer.innerHTML = '<canvas id="myChart3"></canvas>';
    // 새로운 차트를 위한 캔버스 요소
    let ctx3 = document.getElementById('myChart3').getContext('2d');
    // 기존의 차트 객체가 존재하는 경우 제거함
    if (myChart3 && myChart3 instanceof Chart) {
        myChart3.destroy();
    }
    // 새로운 차트 객체를 생성
    myChart3 = new Chart(ctx3, {
        type: chartTypeProject, // 선택된 차트 유형으로 초기 설정
        data: {
            labels, // 라벨
            datasets: [
                {
                    label: '일별 결제 금액',
                    data: dailyPaymentAmounts, 						// 일별 결제 금액 설정
                    type: 'line', 									// 라인 차트로 설정
                    backgroundColor: 'rgb(135, 206, 235)',
                    borderColor: 'rgb(135, 206, 235)',
                    borderWidth: 4,
                    fill: false,
                    yAxisID: 'y-axis-1', 							// 왼쪽 축에 연결될 Y축 ID
                },
                {
                    label: '누적 결제 금액',
                    data: acmlPaymentAmounts, 						// 누적 결제 금액 설정
                    type: 'line', 									// 라인 차트로 설정
                    backgroundColor: 'rgba(255, 99, 132, 1)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 4,
                    fill: false,
                    yAxisID: 'y-axis-1', 							// 왼쪽 축에 연결될 Y축 ID
                },
                {
                    label: '누적 서포터 수',
                    data: acmlSupporterCounts, 						// 누적 서포터 수 설정
                    type: chartTypeProject,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 4,
                    yAxisID: 'y-axis-2', 							// 오른쪽 축에 연결될 Y축 ID
                }
            ]
        },
        options: {
            title: {
                display: true,
                text: '프로젝트별 결제 금액과 누적 서포터 수 데이터' // 차트 제목
            },
            scales: {
                yAxes: [
                    {
                        type: 'linear',
                        display: true,
                        position: 'left',
                        id: 'y-axis-1', 							// 왼쪽 Y축 ID
                    },
                    {
                        type: 'linear',
                        display: true,
                        position: 'right',
                        id: 'y-axis-2', 							// 오른쪽 Y축 ID
                    },
                ],
            },
        },
    });
    
    // 텍스트 업데이트 작업 시작
    // 프로젝트 페이지의 기간별 누적 결제 금액 업데이트
	let acmlPaymentAmountElementProject = document.getElementById('acmlPaymentAmount');
	let acmlPaymentAmountProject = acmlPaymentAmounts[acmlPaymentAmounts.length - 1];
	
	if (acmlPaymentAmountProject !== undefined) {
	    acmlPaymentAmountElementProject.textContent = acmlPaymentAmountProject;
	} else {
	    acmlPaymentAmountElementProject.textContent = '0';
	}

	// 프로젝트 페이지의 일별 평균 결제 금액 업데이트
	let todayPaymentAmountElementProject = document.getElementById('todayPaymentAmount');
	let totalDaysProject = dailyPaymentAmounts.length;
	let totalPaymentAmountProject = dailyPaymentAmounts.reduce((acc, amount) => acc + amount, 0);
	let todayPaymentAmountProject = totalDaysProject > 0 ? Math.round(totalPaymentAmountProject / totalDaysProject) : 0;
	todayPaymentAmountElementProject.textContent = todayPaymentAmountProject;

	// 프로젝트 페이지의 기간별 누적 서포터 수 업데이트
	let acmlSupporterCountElementProject = document.getElementById('acmlSupporterCount');
	let acmlSupporterCountProject = acmlSupporterCounts[acmlSupporterCounts.length - 1];

	if (acmlSupporterCountProject !== undefined) {
	    acmlSupporterCountElementProject.textContent = acmlSupporterCountProject;
	} else {
	    acmlSupporterCountElementProject.textContent = '0';
	}
    
};
// 페이지 로드시에 차트 출력하기
window.addEventListener('load', function() {
	const today = new Date();						// 현재 날짜를 생성
	const sevenDaysAgo = new Date(today);			// 새로운 날짜 객체 생성 	
	sevenDaysAgo.setDate(today.getDate() - 7);		// 7일 전의 날짜로 설정
	
	// 시작 날짜 입력란에 7일 전 날짜 설정
	document.getElementById("startDateProject").valueAsDate = sevenDaysAgo;
	
	// 끝 날짜 입력란에 오늘 날짜 설정
	document.getElementById("endDateProject").valueAsDate = today;
	
	// Bar 차트로 설정
	document.getElementById("chartTypeProject").value = "bar";
	
	// 페이지 로드 후 자동으로 조회 버튼 클릭 (1초 후에 실행하도록 설정)
	setTimeout(function () {
	    document.getElementById("updateProjectButton").click();
	}, 1000); 
});
</script>
<style>
/* 아이콘의 크기를 2배로 설정 */
.las.la-chart-line {
	font-size: 3em;
}
/* 아이콘의 크기를 3배로 설정하고 색상을 변경 */
.las.la-chart-line {
	font-size: 3em;
	color: orange; /* 예시로 빨간색으로 변경 */
}
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
</head>
<body>
<jsp:include page="../common/project_top.jsp" />
<main id="main">
	<div class="containerCSS">

		<!-- 왼쪽 네비게이션 시작 -->
		<aside id="aisdeLeft">
			<div id="projectManagement">
				<img
					src="${pageContext.request.contextPath}/resources/images/managementImage.jpg"
					width="200px" height="150px"> ${sessionScope.sId}님의 프로젝트
			</div>
			<ul id="navMenu">
				<li><a href="#" class="toggleTab"> &nbsp;&nbsp;&nbsp;프로젝트
						관리 <i class="fas fa-caret-down"></i>
				</a>
					<ul class="subMenu">
						<li><a href="projectMaker">메이커 정보</a></li>
						<li><a href="projectManagement">프로젝트 등록</a></li>
						<li><a href="projectReward">리워드 설계</a></li>
					</ul>
				</li>
				<li><a href="projectStatus" id="active-tab">프로젝트 현황</a></li>
				<li><a href="projectShipping">발송·환불 관리</a></li>
				<li><a href="projectSettlement">수수료·정산 관리</a></li>
			</ul>
		</aside>

		<!-- 중앙 섹션 시작 -->
		<section id="section">
			<article id="article">

				<!--  -->
				<div class="projectArea">
					<p class="projectTitle">프로젝트 현황</p>
					<p class="projectContent mb-4">프로젝트 진행 상황을 실시간으로 한 번에 볼 수
						있습니다.</p>
					
					<!-- 프로젝트 차트 -->
					<div class="container mt-5 mb-3">
						<div class="row justify-content-center">
							<p class="subheading">프로젝트별 매출 분석</p>
							<p class="projectContent"><strong id="selectedProjectIdx"></strong> 프로젝트의 매출 분석 그래프 입니다.</p>
							
							<div class="col-md-12 col-lg-4 d-md-block my-1">
								<div class="card">
									<div class="card-body d-flex flex-row justify-content-evenly">
										<div>
											<span class="sideDescription">누적 결제 금액</span>
											<h1 class="card-title">
												<span id="acmlPaymentAmount"></span><span class="sideDescription">원</span>
											</h1>
										</div>
										<div class="">
											<i class="las la-chart-line" style="color: rgba(255, 99, 132, 1);"></i>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-12 col-lg-4 d-md-block my-1">
								<div class="card">
									<div class="card-body d-flex flex-row justify-content-evenly">
										<div>
											<span class="sideDescription">평균 결제 금액</span>
											<h1 class="card-title">
												<span id="todayPaymentAmount"></span><span class="sideDescription">원</span>
											</h1>
										</div>
										<div class="">
											<i class="las la-chart-line" style="color: rgb(135, 206, 235);"></i>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-12 col-lg-4 d-md-block my-1">
								<div class="card">
									<div class="card-body d-flex flex-row justify-content-evenly">
										<div>
											<span class="sideDescription">누적 서포터 수</span>
											<h1 class="card-title">
												<span id="acmlSupporterCount"></span><span class="sideDescription">명</span>
											</h1>
										</div>
										<div class="">
											<i class="las la-chart-line" style="color: rgba(75, 192, 192, 0.2);"></i>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
					
					<!-- 데이트피커 -->
					<div class="d-flex flex-row justify-content-end">
						<select id="projectSelect" class="datepicker-button mx-2" onchange="">
							<option value="">선택</option>
						</select>
						<input type="date" class="datepicker" id="startDateProject" placeholder="시작 날짜">
						<input type="date" class="datepicker mx-2" id="endDateProject" placeholder="끝 날짜">
						<select class="datepicker" id="chartTypeProject">
							<option value="">선택</option>
							<option value="bar">bar</option>
							<option value="line">line</option>
							<option value="radar">Radar</option>
							<option value="polarArea">Polar Area</option>
							<option value="doughnut">Doughnut</option>
						</select>
						<button class="datepicker-button mx-2" id="updateProjectButton">조회</button>
					</div>
					
					<!-- myChart3 -->
					<div id="chartContainer3">
						<canvas id="myChart3"></canvas>
					</div>
					
					<hr>
					
					<!-- 메이커 차트(프로젝트 통합) -->					
					<div class="container mt-5 mb-3">
						<div class="row justify-content-center">
							<p class="subheading">메이커의 전체 프로젝트 매출 분석</p>
							<p class="projectContent">메이커님이 소유한 전체 프로젝트의 매출을 확인할 수 있습니다.</p>

							<div class="col-md-12 col-lg-4 d-md-block my-1">
								<div class="card">
									<div class="card-body d-flex flex-row justify-content-evenly">
										<div>
											<span class="sideDescription">누적 결제 금액</span>
											<h1 class="card-title">
												<span id="acmlPaymentAmountMaker"></span><span class="sideDescription">원</span>
											</h1>
										</div>
										<div class="">
											<i class="las la-chart-line" style="color: rgba(255, 99, 132, 1);"></i>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-12 col-lg-4 d-md-block my-1">
								<div class="card">
									<div class="card-body d-flex flex-row justify-content-evenly">
										<div>
											<span class="sideDescription">평균 결제 금액</span>
											<h1 class="card-title">
												<span id="todayPaymentAmountMaker"></span><span class="sideDescription">원</span>
											</h1>
										</div>
										<div class="">
											<i class="las la-chart-line" style="color: rgb(135, 206, 235);"></i>
										</div>
									</div>
								</div>
							</div>

							<div class="col-md-12 col-lg-4 d-md-block my-1">
								<div class="card">
									<div class="card-body d-flex flex-row justify-content-evenly">
										<div>
											<span class="sideDescription">누적 서포터 수</span>
											<h1 class="card-title">
												<span id="acmlSupporterCountMaker"></span><span class="sideDescription">명</span>
											</h1>
										</div>
										<div class="">
											<i class="las la-chart-line" style="color: rgba(153, 102, 255, 0.2);"></i>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>

					<!-- 데이트피커 -->
					<div class="d-flex flex-row justify-content-end">
						<input type="date" class="datepicker" id="startDate" placeholder="시작 날짜" style="width: 115px;">
						<input type="date" class="datepicker mx-2" id="endDate" placeholder="끝 날짜" style="width: 115px;">
						<select class="datepicker" id="chartType">
							<option value="">선택</option>
							<option value="bar">bar</option>
							<option value="line">line</option>
							<option value="radar">Radar</option>
							<option value="polarArea">Polar Area</option>
							<option value="doughnut">Doughnut</option>
						</select>
						<button class="datepicker-button mx-2" id="updateButton">조회</button>
					</div>

					<!-- myChart2 -->
					<div id="chartContainer">
						<canvas id="myChart2"></canvas>
					</div>
					
					<!-- 전체 결제 내역 조회 -->
					<div class="container mt-5 mb-3">
						<div class="row justify-content-center">
							<p class="subheading">전체 결제 내역 조회</p>
							<p class="projectContent">결제 내역을 실시간으로 조회 할 수 있습니다.</p>
						
							<!-- 셀렉트 박스 -->
							<div class="d-flex flex-row justify-content-end">
								<select id="projectSelect2" class="datepicker-button" onchange="onProjectSelectChange()">
									<option value="">선택</option>
								</select>		
							</div>
							
							<div class="row">
								<div class="d-flex justify-content-center">
								
								<!-- 결제 테이블 -->
								<table class="table" style="font-size: 15px">
								<thead>
									<tr>
										<th class="text-center" style="width: 3%;">번호</th>
										<th class="text-center" style="width: 13%;">프로젝트명</th>
										<th class="text-center" style="width: 13%;">리워드명</th>
										<th class="text-center" style="width: 3%;">수량</th>
										<th class="text-center" style="width: 6%;">결제금액</th>
										<th class="text-center" style="width: 7%;">주문날짜</th>
										<th class="text-center" style="width: 5%;">상태</th>
										<th class="text-center" style="width: 7%;">상세보기</th>
									</tr>
								</thead>
								<tbody id="paymentTableBody">
								
								</tbody>
								</table>
								<!--  -->
								
								</div>
							</div>
							<!--  -->
							
						</div>
					</div>	
					<!--  -->
					
				</div>
			</article>
		</section>
		<!-- 중앙 섹션 끝 -->

	</div>
</main>

<script>
// 페이지 로드 후에 호출해야 하는 함수 모음
$(() => {
	// datepicker
   	$.datepicker.setDefaults({ dateFormat: 'yy-mm-dd' });
   	$('.datepicker').datepicker();
	   
	// 셀렉트 박스에 프로젝트 리스트를 출력
	getProjectList();
	getProjectList2();
});

// 서버에서 프로젝트 리스트를 받아와서 셀렉트 박스에 추가
function getProjectList() {
	
	let selectElement = document.getElementById("projectSelect");
	
	$.ajax({
		method: 'post',
		data: {
			maker_idx: ${maker_idx}
		},
		url: '<c:url value="getProjectListByMakerIdx"/>',
	  	success: function (data) {
	  		
	  		console.log(data);
	  		
	  		data.forEach((project) => {
		        let option = document.createElement("option");
		        option.value = project.project_idx;
		        option.textContent = project.project_subject;
		        selectElement.appendChild(option);
		    });
		    
		    let selectedProjectIdx = ${firstProjectIdx};
		    selectElement.value = selectedProjectIdx;
		    
	  	},
	  	error: function (error) {
	    console.error(error);
	  }
	});
}

//서버에서 프로젝트 리스트를 받아와서 셀렉트 박스에 추가
function getProjectList2() {
	
    let selectElement = document.getElementById("projectSelect2");
    
    $.ajax({
        method: 'post',
        data: {
            maker_idx: ${maker_idx}
        },
        url: '<c:url value="getProjectListByMakerIdx"/>',
        success: function (data) {

            console.log(data);

            data.forEach((project) => {
                let option = document.createElement("option");
                option.value = project.project_idx;
                option.textContent = project.project_subject;
                selectElement.appendChild(option);
            });

            let selectedProjectIdx = ${firstProjectIdx};
            selectElement.value = selectedProjectIdx;

        },
        error: function (error) {
            console.error(error);
        }
    });
}

// 메이커 전체 결제 내역 조회
$(document).ready(function() {
	$.ajax({
	    url: '<c:url value="getAllMakerPayment"/>',
	    method: 'post',
	    data: {
	    	maker_idx: ${maker_idx}
	    },
	    dataType: 'json',
	    success: function(data) {
	        updatePaymentTable(data);
	    },
	    error: function(error) {
	        console.error(error);
	    }
	});
});

// 프로젝트별 전체 결제 내역 조회
// 셀렉트 박스의 값이 변경되었을 때 호출되는 함수
function onProjectSelectChange() {
	let selectedProjectIdx = $("#projectSelect2").val();
	$.ajax({
	    url: '<c:url value="getPaymentByProjectIdx"/>',
	    method: 'POST',
	    data: {
	    	maker_idx: ${maker_idx},
	        project_idx: selectedProjectIdx
	    },
	    dataType: 'json',
	    success: function (data) {
	    	
	        updatePaymentTable(data);
	    },
	    error: function (error) {
	        console.error(error);
	    }
 });
}

// 결제내역 데이터를 테이블에 추가하는 함수
function updatePaymentTable(data) {
   
    let tbody = $('#paymentTableBody');
    tbody.empty();
    
    // 날짜 변환
    function formatDate(timestamp) {
		  let date = new Date(timestamp);
		  let year = date.getFullYear();
		  let month = ('0' + (date.getMonth() + 1)).slice(-2);
		  let day = ('0' + date.getDate()).slice(-2);
		  return year + '-' + month + '-' + day;
	}
    
    data.forEach(function(payment, index) {
    	
    	// 결제상태 판별하기
    	let status;
        if (payment.payment_confirm === 1) {
            status = "결제완료";
        } else if (payment.payment_confirm === 2) {
            status = "취소요청";
        } else if (payment.payment_confirm === 3) {
            status = "취소완료";
        } else {
            status = "없음";
        }
    	
    	let formattedDate = formatDate(payment.payment_date); // 주문 날짜 변환
	   	let newRow = 
		   	    "<tr>" +
			   	    "<td class='text-center'>" + payment.payment_idx + "</td>" +
			   	    "<td class='text-center'>" + payment.project_subject + "</td>" +
			   	    "<td class='text-center'>" + payment.reward_name + "</td>" +
			   	    "<td class='text-center'>" + payment.payment_quantity + "</td>" +
			   	    "<td class='text-center'>" + payment.total_amount + "</td>" +
			   	    "<td class='text-center'>" + formattedDate + "</td>" +
			   	    "<td class='text-center'>" + status + "</td>" +
			   	    "<td class='text-center'><button class='btn btn-outline-primary btn-sm'>상세보기</button></td>" +
		   	    "</tr>";
        tbody.append(newRow);
    });
}
</script>
<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<!-- datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</body>
</html>