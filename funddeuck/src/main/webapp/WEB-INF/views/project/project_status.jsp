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
            alert("끝 날짜가 시작 날짜보다 빠릅니다. 올바른 날짜를 선택해주세요.");
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
                    label: '누적 서포터 수',
                    data: acmlSupporterCounts, 					// 누적 서포터 수 설정
                    type: chartType,
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    borderColor: 'rgba(153, 102, 255, 1)',
                    borderWidth: 1,
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
	// 누적 결제 금액 업데이트
	let makerAcmlPaymentElem = document.getElementById('acmlPaymentAmountMaker');
	let makerAcmlPayment = acmlPaymentAmounts[acmlPaymentAmounts.length - 1];
	
	if (makerAcmlPayment !== undefined) {
	    makerAcmlPaymentElem.textContent = numberWithCommas(makerAcmlPayment);
	} else {
	    makerAcmlPaymentElem.textContent = '0';
	}
	
	// 일별 평균 결제 금액 업데이트
	let makerTodayPaymentElem = document.getElementById('todayPaymentAmountMaker');
	let makerTotalDays = dailyPaymentAmounts.length;
	let makerTotalPayment = dailyPaymentAmounts.reduce((acc, amount) => acc + amount, 0);
	let makerTodayPayment = makerTotalDays > 0 ? Math.round(makerTotalPayment / makerTotalDays) : 0;
	makerTodayPaymentElem.textContent = numberWithCommas(makerTodayPayment);
	
	// 쉼표를 추가해주는 함수 (원단위로 쉼표 추가)
	function numberWithCommas(number) {
	    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	// 누적 서포터 수 업데이트
	let makerAcmlSupporterElem = document.getElementById('acmlSupporterCountMaker');
	let makerAcmlSupporter = acmlSupporterCounts[acmlSupporterCounts.length - 1];
	
	if (makerAcmlSupporter !== undefined) {
	    makerAcmlSupporterElem.textContent = makerAcmlSupporter;
	} else {
	    makerAcmlSupporterElem.textContent = '0';
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
            alert("끝 날짜가 시작 날짜보다 빠릅니다. 올바른 날짜를 선택해주세요.");
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
        $("#selectedProjectIdx").text(selectedText);								// selectedProjectIdx 요소의 내용을 업데이트 하기
    	
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
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1,
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
	// 기간별 누적 결제 금액 업데이트
	let projectAcmlPaymentElem = document.getElementById('acmlPaymentAmount');
	let projectAcmlPayment = acmlPaymentAmounts[acmlPaymentAmounts.length - 1];
	
	if (projectAcmlPayment !== undefined) {
	    projectAcmlPaymentElem.textContent = numberWithCommas(projectAcmlPayment);
	} else {
	    projectAcmlPaymentElem.textContent = '0';
	}
	
	// 일별 평균 결제 금액 업데이트
	let projectTodayPaymentElem = document.getElementById('todayPaymentAmount');
	let projectTotalDays = dailyPaymentAmounts.length;
	let projectTotalPayment = dailyPaymentAmounts.reduce((acc, amount) => acc + amount, 0);
	let projectTodayPayment = projectTotalDays > 0 ? Math.round(projectTotalPayment / projectTotalDays) : 0;
	projectTodayPaymentElem.textContent = numberWithCommas(projectTodayPayment);
	
	// 쉼표를 추가해주는 함수 (원단위로 쉼표 추가)
	function numberWithCommas(number) {
	    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// 기간별 누적 서포터 수 업데이트
	let projectAcmlSupporterElem = document.getElementById('acmlSupporterCount');
	let projectAcmlSupporter = acmlSupporterCounts[acmlSupporterCounts.length - 1];
	
	if (projectAcmlSupporter !== undefined) {
	    projectAcmlSupporterElem.textContent = projectAcmlSupporter;
	} else {
	    projectAcmlSupporterElem.textContent = '0';
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
					<p class="projectContent mb-4">프로젝트 진행 상황을 한 눈에 파악할 수 있습니다.</p>
					
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
<!-- 										<div class=""> -->
<!-- 											<i class="las la-chart-line" style="color: rgba(255, 99, 132, 1);"></i> -->
<!-- 										</div> -->
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
<!-- 										<div class=""> -->
<!-- 											<i class="las la-chart-line" style="color: rgb(135, 206, 235);"></i> -->
<!-- 										</div> -->
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
<!-- 										<div class=""> -->
<!-- 											<i class="las la-chart-line" style="color: rgba(75, 192, 192, 0.2);"></i> -->
<!-- 										</div> -->
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
<!-- 										<div class=""> -->
<!-- 											<i class="las la-chart-line" style="color: rgba(255, 99, 132, 1);"></i> -->
<!-- 										</div> -->
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
<!-- 										<div class=""> -->
<!-- 											<i class="las la-chart-line" style="color: rgb(135, 206, 235);"></i> -->
<!-- 										</div> -->
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
<!-- 										<div class=""> -->
<!-- 											<i class="las la-chart-line" style="color: rgba(153, 102, 255, 0.2);"></i> -->
<!-- 										</div> -->
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
							<p class="subheading">프로젝트별 결제 내역 조회</p>
							<p class="projectContent">기간별로 결제 내역을 조회 할 수 있습니다.</p>
						
							<!-- 셀렉트 박스 -->
							<div class="d-flex flex-row justify-content-end">
								<input type="date" class="datepicker" id="startDatePayment" placeholder="시작 날짜">
								<input type="date" class="datepicker mx-2" id="endDatePayment" placeholder="끝 날짜">
								<select id="projectSelect2" class="datepicker-button">
									<option value="">선택</option>
								</select>
								<button class="datepicker-button mx-2" id="paymentUpdateButton">조회</button>		
								<button class="datepicker-button" id="paymentExcelDownload">엑셀 다운로드</button>		
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
										<!-- 여기다가 출력함 -->
									</tbody>
									</table>
								</div>
							</div>
							<!-- 페이징 버튼 -->
							<div class="d-flex justify-content-center">
								<div id="pagingButtons">
								</div>
							</div>
							<!-- 페이징 버튼 -->
						</div>
					</div>	
					
					<!-- 전체 결제 내역 조회 -->
					<div class="container mt-5 mb-3">
						<div class="row justify-content-center">
							<p class="subheading">리워드 정보 조회</p>
							<p class="projectContent">프로젝트별 리워드 재고를 파악할 수 있습니다.</p>

							<!-- 셀렉트 박스 -->
							<div class="d-flex flex-row justify-content-end">
								<select id="projectSelect3" class="datepicker-button">
									<option value="">선택</option>
								</select>
								<button class="datepicker-button mx-2" id="rewardUpdateButton">조회</button>		
							</div>
							
							<div class="row">
								<div class="d-flex justify-content-center">
								
									<!-- 결제 테이블 -->
									<table class="table" style="font-size: 15px">
									<thead>
										<tr>
											<th class="text-center" style="width: 15%;">프로젝트명</th>
											<th class="text-center" style="width: 20;">리워드명</th>
											<th class="text-center" style="width: 10;">리워드 옵션</th>
											<th class="text-center" style="width: 10;">전체 리워드수</th>
											<th class="text-center" style="width: 10%;">재고</th>
											<th class="text-center" style="width: 10%;">판매</th>
											<th class="text-center" style="width: 7%;">상세보기</th>
										</tr>
									</thead>
									<tbody id="rewardTableBody">
										
									</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					
					<div>
					    <p class="subheading"><b>판매량이 높은 리워드 조회</b></p>
					    <p class="projectContent">리워드의 판매 비율을 전체 수량에 대해 계산한 차트입니다.</p>
					    
					    <!-- 선택한 프로젝트별 리워드의 판매 비율 차트 -->
					    <div id="rewardChartContainer">
					        <canvas id="rewardChart"></canvas>
					    </div>
					    
					    <!-- 차트에서 리워드 클릭 시 해당 리워드에 대한 옵션을 테이블로 출력 -->
					    
					    
					</div>

					
				
				<!-- 하단 여백 주기 -->
				<div style="height: 300px; width: 100%"></div>
													
				</div>
			</article>
		</section>
		<!-- 중앙 섹션 끝 -->
				
		
		
		
	</div>
</main>

<script>
// 페이지 로드 후에 호출해야 하는 함수
$(() => {
	// datepicker
   	$.datepicker.setDefaults({ dateFormat: 'yy-mm-dd' });
   	$('.datepicker').datepicker();
	   
	// 셀렉트 박스에 프로젝트 리스트를 출력
	getProjectList();
	getProjectList2();
	getProjectList3();
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

// 서버에서 프로젝트 리스트를 받아와서 셀렉트 박스에 추가
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

//서버에서 프로젝트 리스트를 받아와서 셀렉트 박스에 추가
function getProjectList3() {
	
    let selectElement = document.getElementById("projectSelect3");
    
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
// ===============================================================================================================
	
// 페이징 처리
let currentPage = 1;
let totalCount = 0;
const listLimit = 10; // 페이지당 데이터 수

// 총 페이지 수를 계산하는 함수
function calculateTotalPages(totalCount, listLimit) {
  	return Math.ceil(totalCount / listLimit);
}

// 날짜 형식 변환 함수
function formatDate(timestamp) {
  	let date = new Date(timestamp);
  	let year = date.getFullYear();
	let month = ('0' + (date.getMonth() + 1)).slice(-2);	// 날짜 객체에서 월을 가져오고 1을 더한 후 문자열로 변환 후 뒤에서 2개의 문자를 추출
  	let day = ('0' + date.getDate()).slice(-2);
  	return year + '-' + month + '-' + day;
}

// 테이블 데이터 채우기 함수
function fillTable(data) {
	
	let tbody = $('#paymentTableBody');
	tbody.empty();

	data.forEach(function (payment, index) {
		
		let status;
		
	  	if (payment.payment_confirm === 1) {
	    	status = "예약완료";
	  	} else if (payment.payment_confirm === 2) {
	    	status = "결제완료";
	  	} else if (payment.payment_confirm === 3) {
	    	status = "반환신청";
	  	} else if (payment.payment_confirm === 4) {
	    	status = "반환완료";
	  	} else if (payment.payment_confirm === 5) {
	    	status = "반환거절";
	  	} else {
	    	status = "없음";
 		}

		let formattedDate = formatDate(payment.payment_date);
		let newRow =
	    "<tr>" +
		    "<td class='text-center'>" + payment.payment_idx + "</td>" +
		    "<td class='text-center'>" + payment.project_subject + "</td>" +
		    "<td class='text-center'>" + payment.reward_name + "</td>" +
		    "<td class='text-center'>" + payment.payment_quantity + "</td>" +
		    "<td class='text-center'>" + payment.total_amount + "</td>" +
		    "<td class='text-center'>" + formattedDate + "</td>" +
		    "<td class='text-center'>" + status + "</td>" +
		    "<td class='text-center'><button class='btn btn-outline-primary btn-sm' data-bs-toggle='modal' data-bs-target='#paymentDetailBackdrop' onClick='showPaymentDetails(" + payment.payment_idx + ")'>상세보기</button></td>" +
	    "</tr>";
		tbody.append(newRow);
	});
}

// ajax로 데이터 가져오는 함수
function fetchPaginatedData(page) {
	
	let startDatePayment = $("#startDatePayment").val();
	let endDatePayment = $("#endDatePayment").val();
	let selectedProjectIdx2 = $("#projectSelect2").val();

  	$.ajax({
	    url: '<c:url value="getPaymentByProjectIdx"/>',
	    method: 'POST',
	    data: {
	    	
			maker_idx: ${maker_idx},
			project_idx: selectedProjectIdx2,
			startDate: startDatePayment,
			endDate: endDatePayment,
			startRow: (page - 1) * listLimit,
			listLimit: listLimit
	      
	    },
	    dataType: 'json',
	    success: function (data) {
	    	
	    	
	      	totalCount = data.totalCount;
	      	let totalPages = calculateTotalPages(totalCount, listLimit);
	      	currentPage = page;

	      	// 결제내역 데이터를 테이블에 추가
	      	fillTable(data.data);
	
	     	// 페이징 버튼 생성 및 이벤트 처리
	      	let pagingButtons = $("#pagingButtons");
	      	pagingButtons.empty();
	
	      	let navUl = $("<ul></ul>").addClass("pagination");
	
	      	// 맨 앞으로 가는 버튼
	      	let firstButton = $("<li></li>").addClass("page-item");
	      	let firstLink = $("<button></button>").addClass("page-link").html("&laquo;").css("color", "black");
	      	firstButton.addClass(currentPage === 1 ? "disabled" : ""); // 현재 페이지가 첫 페이지면 비활성화
	      	firstButton.append(firstLink);
	      	firstLink.click(function (event) {
	      		
		      	event.preventDefault(); // 링크 동작 방지
		      	fetchPaginatedData(1);
		      	
	      	});
	      	navUl.append(firstButton);

	      	// 페이지 버튼들
	      	for (let i = 1; i <= totalPages; i++) {
	      		
		      	let button = $("<li></li>").addClass("page-item");
		        let link = $("<button></button>").addClass("page-link text-dark").text(i);
		        
		        if (i === currentPage) {
// 		        	button.addClass("active");

		        }
		        
	       		button.append(link);
	        	link.click(function (event) {
	        		
		          	event.preventDefault(); // 링크 동작 방지
		          	fetchPaginatedData(i);
	          
	        	});
		        navUl.append(button);
	      	}

	      	// 맨 뒤로 가는 버튼
	      	let lastButton = $("<li></li>").addClass("page-item");
	      	let lastLink = $("<button></button>").addClass("page-link").html("&raquo;").css("color", "black");
	      	lastButton.addClass(currentPage === totalPages ? "disabled" : ""); // 현재 페이지가 마지막 페이지면 비활성화
     	 	lastButton.append(lastLink);
	      	lastLink.click(function (event) {
	    	  
			event.preventDefault(); // 링크 동작 방지
	      	fetchPaginatedData(totalPages);
	        
	      	});
	      	navUl.append(lastButton);
	      	pagingButtons.append(navUl);
	
	      	// 이전 페이지로 이동하는 버튼 활성화/비활성화 처리
	      	$("#prevPageButton").prop("disabled", currentPage === 1);
	
	      	// 다음 페이지로 이동하는 버튼 활성화/비활성화 처리
	      	$("#nextPageButton").prop("disabled", currentPage === totalPages);
	      
	      
	    },
	    error: function (error) {
	      console.error(error);
	    }
  	});
}

// // 조회 버튼 클릭 시 자료 조회와 페이징 처리 호출
// $('#paymentUpdateButton').click(function () {
// 	fetchPaginatedData(1); // 첫 페이지 데이터 조회
// });



// 프로젝트별 결제 내역 조회 유효성 검사 함수
function validateInputsAndReturnValidity() {
	
    let startDatePayment = $('#startDatePayment').val();
    let endDatePayment = $('#endDatePayment').val();
    let selectedProjectIdx2 = $('#projectSelect2').val();

    // 날짜 유효성 검사
    if (!startDatePayment || !endDatePayment) {
        alert("시작 날짜와 종료 날짜를 모두 입력해주세요.");
        if (!startDatePayment) {
            $('#startDatePayment').focus();
        } else {
            $('#endDatePayment').focus();
        }
        return false;
    }

    // 날짜 비교 유효성 검사
    let paymentStartDate = new Date(startDatePayment);
    let paymentEndDate = new Date(endDatePayment);
    if (paymentStartDate > paymentEndDate) {
        alert("끝 날짜가 시작 날짜보다 빠릅니다. 올바른 날짜를 선택해주세요.");
        $('#startDatePayment').focus();
        return false;
    }

    // 프로젝트 선택 유효성 검사
    if (selectedProjectIdx2 === "") {
        alert("프로젝트를 선택해주세요.");
        $('#projectSelect2').focus();
        return false;
    }

    return true;
}

// 조회 버튼 클릭 시 자료 조회와 페이징 처리 호출
$('#paymentUpdateButton').click(function () {
	
	// 유효성 검사 통과하지 않으면 중단
 	if (!validateInputsAndReturnValidity()) {
        return; 
    }
    // 유효성 검사 통과 시 조회와 페이징 처리 호출
    fetchPaginatedData(1); // 첫 페이지 데이터 조회
    
});

// 다음 페이지로 이동하는 버튼 클릭 이벤트 핸들러
$("#nextPageButton").click(function () {
	let totalPages = calculateTotalPages(totalCount, listLimit);
	if (currentPage < totalPages) {
		fetchPaginatedData(currentPage + 1);
	}
});

// 초기 데이터 가져오기
$(document).ready(function () {
	fetchPaginatedData(1); // 첫 페이지 데이터 조회
});

// ===============================================================================================================
	
// 페이지가 완전히 로드되었을 때 해당 함수를 실행
window.addEventListener('load', function() {
	
    const todayPayment = new Date();                        	   		// 현재 날짜를 생성
    const sevenDaysAgoPayment = new Date(todayPayment);            		// 새로운 날짜 객체 생성    
    sevenDaysAgoPayment.setDate(todayPayment.getDate() - 7);       		// 7일 전의 날짜로 설정
    
    // 시작 날짜 입력란에 7일 전 날짜 설정
    document.getElementById("startDatePayment").valueAsDate = sevenDaysAgoPayment;
    
    // 끝 날짜 입력란에 오늘 날짜 설정
    document.getElementById("endDatePayment").valueAsDate = todayPayment;
    
    // 프로젝트 선택 박스 초기화 (선택 사항이기 때문에 원하는 대로 설정)
    // document.getElementById("projectSelect2").value = "";
    
    // 페이지 로드 후 자동으로 조회 버튼 클릭 (1초 후에 실행하도록 설정)
    setTimeout(function () {
        document.getElementById("paymentUpdateButton").click();
    }, 1000); 
});

//===============================================================================================================
	
// 전역 변수로 차트 객체 선언
let rewardChart;

// 리워드 정보를 조회하고 차트를 그리는 함수
function drawRewardChart(rewardData) {
    // 차트 컨테이너 요소
    let rewardChartContainer = document.getElementById('rewardChartContainer');

    // 기존의 차트 캔버스를 제거
    rewardChartContainer.innerHTML = '<canvas id="rewardChart"></canvas>';

    // 새로운 차트를 위한 캔버스 요소
    const ctx4 = document.getElementById('rewardChart').getContext('2d');

    // 기존의 차트 객체 존재하는 경우 제거함
    if (rewardChart && rewardChart instanceof Chart) {
        rewardChart.destroy();
    }

    // 차트를 그릴 데이터 가공
    const labels = rewardData.map((reward) => reward.reward_name);
    const data = rewardData.map((reward) => reward.sales_quantity);
    const colors = [
    	'rgba(255, 206, 86, 0.2)', 
    	'rgba(75, 192, 192, 0.2)', 
    	'rgba(153, 102, 255, 0.2)', 
    	'rgba(255, 159, 64, 0.2)', 
    	'rgba(255, 99, 132, 0.2)', 
    	'rgba(54, 162, 235, 0.2)'
    	];
    const borderColors = [
    	'rgba(255, 206, 86, 1)', 
    	'rgba(75, 192, 192, 1)', 
    	'rgba(153, 102, 255, 1)', 
    	'rgba(255, 159, 64, 1)', 
    	'rgba(255, 99, 132, 1)', 
    	'rgba(54, 162, 235, 1)'
    ];

    // 차트 생성
    rewardChart = new Chart(ctx4, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
            	label: "판매량",
                data: data,
                backgroundColor: colors,
                borderColor: borderColors,
                borderWidth: 1
            }],
        },
        options: {
            title: {
                display: true,
                text: 'Reward Sales Chart',
            },
//             cutoutPercentage: 30, 											// 도넛 차트의 반지 모양의 두께 조절 (0 ~ 100)
        },
    });
}
	
// 프로젝트별 리워드 정보 조회
$(()=> {
		
	$('#rewardUpdateButton').click(()=>{
		
		let selectedProjectIdx3 = $("#projectSelect3").val();
		
		$.ajax({
			method: 'post',
			url: '<c:url value="getRewardInfo"/>',
			data: {
				project_idx: selectedProjectIdx3,
				maker_idx: ${maker_idx}
			},
			success: function(data) {
				
				console.log(data);
				
				let tbody = $('#rewardTableBody');
				tbody.empty();
				
				data.forEach(function(payment, index) {
					
					let projectName = $('#projectSelect3 option:selected').text();
					
					let newRow = 
						  "<tr>" + 
						    "<td class='text-center'>" + projectName + "</td>" +
						    "<td class='text-center'>" + payment.reward_name + "</td>" + 
						    "<td class='text-center'>" + payment.reward_option + "</td>" + 
						    "<td class='text-center'>" + payment.reward_quantity + "</td>" + 
						    "<td class='text-center'>" + payment.remaining_quantity + "</td>" + 
						    "<td class='text-center'>" + payment.sales_quantity + "</td>" + 
						    "<td class='text-center'><button class='btn btn-outline-primary btn-sm' data-bs-toggle='modal' data-bs-target='#rewardDetailBackdrop' onClick='showRewardDetails(" + payment.reward_idx + ")'>상세보기</button></td>" + 
						  "</tr>";
						
					tbody.append(newRow);
					
				});
				
				// 차트 그리기
                drawRewardChart(data);
				
			},
			error: function() {
				console.log('ajax 요청이 실패하였습니다.');
			}
		});
	});
	
	// 페이지 로드 후 1초 후에 실행
	setTimeout(() => {
		$('#rewardUpdateButton').click();
	}, 1000);
	
});

// 결제내역 상세보기 클릭 시 결제내역을 조회
function showPaymentDetails(payment_idx) {

	$.ajax({
		
	    method: 'post',
	    url: '<c:url value="getPaymentDetail"/>',
	    data: {
	      payment_idx: payment_idx
	    },
	    dataType: 'json',
	    success: data => {
	    	
      	console.log(data);

	    let modalBody = $('#paymentDetail');
	    modalBody.empty();

      	let tableHtml = `
      	
    	<table class='table text-center'>
	        <tr>
	          <td>주문번호</td>
	          <td>${'${data.payment_idx}'}</td>
	        </tr>
	        <tr>
	          <td>회원번호</td>
	          <td>${'${data.member_idx}'}</td>
	        </tr>
	        <tr>
	          <td>프로젝트번호</td>
	          <td>${'${data.project_idx}'}</td>
	        </tr>
	        <tr>
	          <td>이메일</td>
	          <td>${'${data.member_email}'}</td>
	        </tr>
	        <tr>
	          <td>연락처</td>
	          <td>${'${data.member_phone}'}</td>
	        </tr>
	        <tr>
	          <td>리워드금액</td>
	          <td>${'${data.reward_amount}'}</td>
	        </tr>
	        <tr>
	          <td>추가후원금</td>
	          <td>${'${data.additional_amount}'}</td>
	        </tr>
	        <tr>
	          <td>쿠폰금액</td>
	          <td>${'${data.use_coupon_amount}'}</td>
	        </tr>
	        <tr>
	          <td>최종결제금액</td>
	          <td>${'${data.total_amount}'}</td>
	        </tr>
	        <tr>
	          <td>주문날짜</td>
	          <td>${'${data.payment_date}'}</td>
	        </tr>
	        <tr>
	          <td>주문수량</td>
	          <td>${'${data.payment_quantity}'}</td>
	        </tr>
        </table>`;
        
      	modalBody.html(tableHtml);
   		}
  	});
}

// 리워드 정보 조회
function showRewardDetails(reward_idx) {
	
	$.ajax({
			
		    method: 'post',
		    url: '<c:url value="getRewardDetail"/>',
		    data: {
		    	reward_idx: reward_idx
		    },
		    dataType: 'json',
		    success: data => {
		    	
	      	console.log(data);
	
		    let modalBody2 = $('#rewardDetail');
		    modalBody2.empty();
	
	      	let tableHtml2 = `
	      	
	    	<table class='table text-center'>
		        <tr>
		          <td>프로젝트 번호</td>
		          <td>${'${data.project_idx}'}</td>
		        </tr>
		        <tr>
		          <td>리워드 번호</td>
		          <td>${'${data.reward_idx}'}</td>
		        </tr>
		        <tr>
		          <td>리워드 가격</td>
		          <td>${'${data.reward_price}'}</td>
		        </tr>
		        <tr>
		          <td>리워드 카테고리</td>
		          <td>${'${data.reward_category}'}</td>
		        </tr>
		        <tr>
		          <td>리워드명</td>
		          <td>${'${data.reward_name}'}</td>
		        </tr>
		        <tr>
		          <td>리워드 수량</td>
		          <td>${'${data.reward_quantity}'}</td>
		        </tr>
		        <tr>
		          <td>리워드 옵션</td>
		          <td>${'${data.reward_option}'}</td>
		        </tr>
		        <tr>
		          <td>리워드 설명</td>
		          <td>${'${data.reward_detail}'}</td>
		        </tr>
		        <tr>
		          <td>배송여부</td>
		          <td>${'${data.delivery_status}'}</td>
		        </tr>
		        <tr>
		          <td>배송비</td>
		          <td>${'${data.delivery_price}'}</td>
		        </tr>
		        <tr>
		          <td>발송시작일</td>
		          <td>${'${data.delivery_date}'}</td>
		        </tr>
		        <tr>
		          <td>리워드 정보 제공 고시</td>
   	  			  <td>${'${data.reward_info}'}</td>
		        </tr>
	        </table>`;
	        
	      	modalBody2.html(tableHtml2);
	   		}
	  	});	
}

// 프로젝트별 결제 내역 엑셀 다운로드
$('#paymentExcelDownload').click(() => {
	
	// 유효성 검사 통과하지 않으면 중단
 	if (!validateInputsAndReturnValidity()) {
        return; 
    }
	
    Swal.fire({
        icon: 'question',
        title: '결제 내역 엑셀 저장',
        text: '결제 내역을 엑셀로 저장하시겠습니까?',
        showCancelButton: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소'
        
    }).then((result) => {
    	
        if (result.isConfirmed) {
        	
            let startDatePayment = $("#startDatePayment").val();
            let endDatePayment = $("#endDatePayment").val();
            let selectedProjectIdx2 = $("#projectSelect2").val();

            $.ajax({
                url: '<c:url value="projectExcelDownload"/>',
                method: 'POST',
                data: {
                    maker_idx: ${maker_idx},
                    project_idx: selectedProjectIdx2,
                    startDate: startDatePayment,
                    endDate: endDatePayment
                },
                xhrFields: {
                    responseType: 'blob' // 이 부분이 엑셀 파일 데이터를 받기 위한 설정
                },
                success: function (data, status, xhr) {
                	
                    // 기간 메시지 생성
                    let periodMessage = `${'${startDatePayment}'}~${'${endDatePayment}'}`;

                    // SweetAlert로 성공 메시지 띄우기
                    Swal.fire({
                        icon: 'success',
                        title: '결제 내역 엑셀 저장 완료',
                        text: `${'${periodMessage}'} 선택한 날짜의 결제 내역을 엑셀로 저장하였습니다.`,
                        confirmButtonText: '확인'
                    });

                    const filename = xhr.getResponseHeader('Content-Disposition')
                        .split('filename=')[1];

                    // Blob 데이터를 Blob URL로 생성하여 다운로드 링크를 생성
                    const blobUrl = URL.createObjectURL(data);
                    const a = document.createElement('a');
                    a.href = blobUrl;
                    a.download = filename;
                    document.body.appendChild(a);
                    a.click();
                    document.body.removeChild(a);
                    URL.revokeObjectURL(blobUrl);
                    
                },
                error: function () {
                    // 에러 핸들링 코드 추가
                }
            });
        }
    });
});
</script>

<!-- 리워드 정보 조회 모달 -->
<div class="modal fade" id="rewardDetailBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="rewardStaticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rewardStaticBackdropLabel">리워드 상세조회</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="rewardDetail">
      <!-- 데이터 출력 -->
      </div>
      <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
    </div>
  </div>
</div>

<!-- 결제내역 조회 모달 -->
<div class="modal fade" id="paymentDetailBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="paymentStaticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="paymentStaticBackdropLabel">결제내역 상세조회</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="paymentDetail">
      <!-- 데이터 출력 -->
      </div>
      <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
    </div>
  </div>
</div>

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