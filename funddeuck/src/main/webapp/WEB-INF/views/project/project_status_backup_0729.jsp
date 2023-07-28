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
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
	<!-- CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
	<link href="${pageContext.request.contextPath }/resources/css/project_status.css" rel="styleSheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
	<!-- chart.js -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
    // datepicker
    $(() => {
        $.datepicker.setDefaults({ dateFormat: 'yy-mm-dd' });
        $('.datepicker').datepicker();
    });

    // 시작일, 종료일 => 지정 가능
    // maker_idx(파라미터)를 받아서 차트를 불러옴
    $(() => {
        $('.datepicker').datepicker();

        let myChart2 = null; // Chart 객체를 저장하기 위한 변수

        $('#updateButton').click(() => {
            let startDate = $('#startDate').val(); // 시작일 입력값 가져오기
            let endDate = $('#endDate').val(); // 종료일 입력값 가져오기
            let chartType = $('#chartType').val(); // 선택된 차트 유형 가져오기
            let maker_idx = ${param.maker_idx}; // 파라미터로 받은 maker_idx를 변수에 저장

            $.ajax({
                type: 'GET',
                url: '<c:url value="chartData"/>', // 차트 데이터를 가져올 URL 설정
                data: {
                    startDate,      // 시작일
                    endDate,        // 종료일
                    chartType,      // 차트
                    maker_idx       // 메이커 번호
                },
                success: (response) => {
                    console.log(response);
                    updateChart(response, chartType); // 차트 업데이트 함수 호출
                }
            });
        });
    }); // ready

    let updateChart = (data, chartType) => {
        // 응답 데이터에서 라벨, 일별 결제 금액, 누적 결제 금액, 일별 서포터 수, 누적 서포터 수를 추출
        let { labels, dailyPaymentAmounts, cumulativePaymentAmounts, dailySupporterCounts, cumulativeSupporterCounts } = data;
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
//             type: 'bar', // 바 차트로 초기 설정
            type: chartType, // 바 차트로 초기 설정
            data: {
                labels, // 라벨
                datasets: [
                    {
                        label: '일별 결제 금액',
                        data: dailyPaymentAmounts, // 일별 결제 금액 설정
                        type: 'line', // 라인 차트로 설정
                        backgroundColor: 'rgba(255, 99, 132, 1)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 4,
                        fill: false,
                        yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                    },
                    {
                        label: '누적 결제 금액',
                        data: cumulativePaymentAmounts, // 누적 결제 금액 설정
                        type: 'line', // 라인 차트로 설정
                        backgroundColor: 'rgb(135, 206, 235)',
                        borderColor: 'rgb(135, 206, 235)',
                        borderWidth: 4,
                        fill: false,
                        yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                    },
                    {
                        label: '누적 회원 수',
                        data: cumulativeSupporterCounts, // 누적 회원 수 설정
                        type: chartType,
                        backgroundColor: 'orange',
                        borderColor: 'orange',
                        borderWidth: 4,
                        yAxisID: 'y-axis-2', // 오른쪽 축에 연결될 Y축 ID
                    }
                ]
            },
            options: {
                title: {
                    display: true,
                    text: '결제 금액과 누적 회원 수 데이터' // 차트 제목
                },
                scales: {
                    yAxes: [
                        {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            id: 'y-axis-1', // 왼쪽 Y축 ID
                        },
                        {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            id: 'y-axis-2', // 오른쪽 Y축 ID
                        },
                    ],
                },
            },
        });
    };
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
					<li><a href="projectStatus?maker_idx=${param.maker_idx}" id="active-tab">프로젝트 현황</a></li>
					<li><a href="projectShipping">발송·환불 관리</a></li>
					<li><a href="projectSettlement">수수료·정산 관리</a></li>
				</ul>
			</aside>

			<!-- 중앙 섹션 시작 -->
			<section id="section">
				<article id="article">

					<!--  -->
					<div class="projectArea">
						<p class="projectTitle">메이커 현황</p>
						<p class="projectContent mb-4">프로젝트 진행 상황을 실시간으로 한 번에 볼 수
							있습니다.</p>

						<div class="container mt-5 mb-3">
							<div class="row justify-content-center">
								<p class="subheading">메이커의 전체 프로젝트 매출 분석</p>
								<p class="projectContent">결제가 갱신될 때 마다 아래 현황이 업데이트 됩니다.</p>

								<div class="col-md-12 col-lg-4 d-md-block my-1">
									<div class="card">
										<div class="card-body d-flex flex-row justify-content-evenly">
											<div>
												<span class="sideDescription">누적 결제 금액</span>
												<h1 class="card-title">${totalAmount}<span
														class="sideDescription">원</span>
												</h1>
											</div>
											<div class="">
												<i class="las la-chart-line" style="color: red;"></i>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-12 col-lg-4 d-md-block my-1">
									<div class="card">
										<div class="card-body d-flex flex-row justify-content-evenly">
											<div>
												<span class="sideDescription">오늘 결제금액</span>
												<h1 class="card-title">${todayAmount}<span
														class="sideDescription">원</span>
												</h1>
											</div>
											<div class="">
												<i class="las la-chart-line"></i>
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
													${totalSupporterCount}<span class="sideDescription">명</span>
												</h1>
											</div>
											<div class="">
												<i class="las la-chart-line" style="color: green;"></i>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>

						<!-- 날짜 선택 -->
						<div class="d-flex flex-row justify-content-end">
							<input class="datepicker" id="startDate" placeholder="시작 날짜">
							<input class="datepicker mx-2" id="endDate" placeholder="끝 날짜">
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
						
						<hr class="my-5">
						
						<!-- 메이커의 프로젝트별 차트 출력 -->
						<!-- 메이커는 여러개의 프로젝트를 소유 할 수 있음 -->
						<div class="container mt-5 mb-3">
							<div class="row justify-content-center">
								<p class="subheading">프로젝트별 매출 분석</p>
								<p class="projectContent"><strong>${param.project_idx}번</strong> 프로젝트의 매출 분석 그래프 입니다.</p>

								<div class="col-md-12 col-lg-4 d-md-block my-1">
									<div class="card">
										<div class="card-body d-flex flex-row justify-content-evenly">
											<div>
												<span class="sideDescription">누적 결제 금액</span>
												<h1 class="card-title">
													${projectTotalAmount}<span class="sideDescription">원</span>
												</h1>
											</div>
											<div class="">
												<i class="las la-chart-line" style="color: red;"></i>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-12 col-lg-4 d-md-block my-1">
									<div class="card">
										<div class="card-body d-flex flex-row justify-content-evenly">
											<div>
												<span class="sideDescription">오늘 결제금액</span>
												<h1 class="card-title">
													${projectTodayAmount}<span class="sideDescription">원</span>
												</h1>
											</div>
											<div class="">
												<i class="las la-chart-line"></i>
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
													${projectTotalSupporterCount}<span class="sideDescription">명</span>
												</h1>
											</div>
											<div class="">
												<i class="las la-chart-line" style="color: green;"></i>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>

						<!-- 날짜 선택 -->
						<div class="d-flex flex-row justify-content-end">
							<input class="datepicker" id="startDate2" placeholder="시작 날짜">
							<input class="datepicker mx-2" id="endDate2" placeholder="끝 날짜">
							<select class="datepicker" id="chartType2">
								<option value="">선택</option>
								<option value="bar">bar</option>
								<option value="line">line</option>
								<option value="radar">Radar</option>
								<option value="polarArea">Polar Area</option>
								<option value="doughnut">Doughnut</option>
							</select>
							<button class="datepicker-button mx-2" id="updateButton2">조회</button>
						</div>

						<!-- myChart3 -->
						<div id="chartContainer3">
							<canvas id="myChart3"></canvas>
						</div>
						
					</div>
				</article>
			</section>
			<!-- 중앙 섹션 끝 -->

		</div>
	</main>

	<!-- 페이지 로드 시 출력되는 차트 -->
	<!-- 메이커의 전체 프로젝트(통합) 차트 -->
	<script type="text/javascript">
    var payJson = JSON.parse('${payListAmount}');
    var supporterJson = JSON.parse('${supporterListCount}');

    var labelList = [];
    var dailyAmountList = []; // 일별 결제 금액
    var cumulativeAmountList = []; // 누적 결제 금액
    var cumulativeAmount = 0; // 누적 결제 금액 초기값

    var cumulativeSupporterCounts = []; // 누적 서포터 수 리스트
    var cumulativeSupporterCount = 0; // 누적 서포터 수 초기값

    // 결제 금액 구하기
    for (var i = 0; i < payJson.length; i++) {
        var d = payJson[i];
        labelList.push(d.date); // 날짜 라벨
        dailyAmountList.push(d.amount); // 일별 결제 금액 추가
        cumulativeAmount += d.amount; // 누적 결제 금액
        cumulativeAmountList.push(cumulativeAmount); // 누적 결제 금액 추가
    }

 	// 누적 서포터 수 구하기
    for (var i = 0; i < supporterJson.length; i++) {
        var supporter = supporterJson[i];
        cumulativeSupporterCount += supporter.supporterCount; // 누적 서포터 수 갱신
        cumulativeSupporterCounts.push(cumulativeSupporterCount); // 누적 서포터 수 추가
    }
 	
 	// 누락된 데이터 채우기
    for (var i = 1; i < labelList.length; i++) {
        // 결제 금액의 누적 값 채우기
        if (dailyAmountList[i] === undefined) {
            dailyAmountList[i] = dailyAmountList[i - 1];
            cumulativeAmountList[i] = cumulativeAmountList[i - 1];
        }

        // 누적 서포터 수 채우기
        if (cumulativeSupporterCounts[i] === undefined) {
            cumulativeSupporterCounts[i] = cumulativeSupporterCounts[i - 1];
        }
    }

    // 결제 금액과 누적 서포터 수 데이터 설정
    var chartData = {
        labels: labelList,
        datasets: [
            {
                label: '일별 결제 금액',
                data: dailyAmountList,
                backgroundColor: 'rgba(255, 99, 132, 1)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 4,
                fill: false,
                yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                type: 'line', // line 차트로 설정
            },
            {
                label: '누적 결제 금액',
                data: cumulativeAmountList,
                backgroundColor: 'rgb(135, 206, 235)',
                borderColor: 'rgb(135, 206, 235)',
                borderWidth: 4,
                fill: false,
                yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                type: 'line', // line 차트로 설정
            },
            {
                label: '누적 서포터 수',
                data: cumulativeSupporterCounts,
                backgroundColor: 'orange',
                borderColor: 'orange',
                borderWidth: 4,
                yAxisID: 'y-axis-2', // 오른쪽 축에 연결될 Y축 ID
                type: 'bar', // bar 차트로 설정
            }
        ]
    };

    // 페이지 로드 시 차트 호출하기
    $(() => {
        let ctx2 = document.getElementById('myChart2').getContext('2d');
        let myChart2 = new Chart(ctx2, {
            type: 'bar', // 바 차트로 초기 설정
            data: chartData,
            options: {
                title: {
                    display: true,
                    text: '결제 금액과 누적 서포터 수 데이터' // 차트 제목
                },
                scales: {
                    yAxes: [
                        {
                            type: 'linear',
                            display: true,
                            position: 'left',
                            id: 'y-axis-1', // 왼쪽 Y축 ID
                        },
                        {
                            type: 'linear',
                            display: true,
                            position: 'right',
                            id: 'y-axis-2', // 오른쪽 Y축 ID
                        },
                    ],
                },
            },
        });
    });
	</script>
	
	<!-- 메이커의 프로젝트별 차트 -->
	<script type="text/javascript">
    var projectPayJson = JSON.parse('${projectPayListAmount}');
    var projectSupporterJson = JSON.parse('${projectSupporterListCount}');
    var projectTotalAmount = ${projectTotalAmount};
    var projectTodayAmount = ${projectTodayAmount};
    var projectTotalSupporterCount = ${projectTotalSupporterCount};

    var projectLabelList = [];
    var projectDailyAmountList = [];
    var projectCumulativeAmountList = [];
    var projectCumulativeAmount = 0;

    var projectCumulativeSupporterCounts = [];
    var projectCumulativeSupporterCount = 0;

    // 결제 금액 구하기
    for (var i = 0; i < projectPayJson.length; i++) {
        var d = projectPayJson[i];
        projectLabelList.push(d.date); // 날짜 라벨
        projectDailyAmountList.push(d.amount); // 일별 결제 금액 추가
        projectCumulativeAmount += d.amount; // 누적 결제 금액
        projectCumulativeAmountList.push(projectCumulativeAmount); // 누적 결제 금액 추가
    }

    // 누적 서포터 수 구하기
    for (var i = 0; i < projectSupporterJson.length; i++) {
        var supporter = projectSupporterJson[i];
        projectCumulativeSupporterCount += supporter.projectSupporterCount; // 누적 서포터 수 갱신
        projectCumulativeSupporterCounts.push(projectCumulativeSupporterCount); // 누적 서포터 수 추가
    }

    // 누락된 데이터 채우기
    for (var i = 1; i < projectLabelList.length; i++) {
        // 결제 금액의 누적 값 채우기
        if (projectDailyAmountList[i] === undefined) {
            projectDailyAmountList[i] = projectDailyAmountList[i - 1];
            projectCumulativeAmountList[i] = projectCumulativeAmountList[i - 1];
        }

        // 누적 서포터 수 채우기
        if (projectCumulativeSupporterCounts[i] === undefined) {
            projectCumulativeSupporterCounts[i] = projectCumulativeSupporterCounts[i - 1];
        }
    }
	
    // 결제 금액과 누적 서포터 수 데이터 설정
    var projectChartData = {
        labels: projectLabelList,
        datasets: [
            {
                label: '일별 결제 금액',
                data: projectDailyAmountList,
                backgroundColor: 'rgba(255, 99, 132, 1)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 4,
                fill: false,
                yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                type: 'line', // line 차트로 설정
            },
            {
                label: '누적 결제 금액',
                data: projectCumulativeAmountList,
                backgroundColor: 'rgb(135, 206, 235)',
                borderColor: 'rgb(135, 206, 235)',
                borderWidth: 4,
                fill: false,
                yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                type: 'line', // line 차트로 설정
            },
            {
                label: '누적 서포터 수',
                data: projectCumulativeSupporterCounts,
                backgroundColor: 'orange',
                borderColor: 'orange',
                borderWidth: 4,
                yAxisID: 'y-axis-2', // 오른쪽 축에 연결될 Y축 ID
                type: 'bar', // bar 차트로 설정
            }
        ]
    };

    // 차트 생성
    $(() => {
	    let ctx3 = document.getElementById('myChart3').getContext('2d');
	    let myChart3 = new Chart(ctx3, {
	        type: 'bar', // 바 차트로 초기 설정
	        data: projectChartData,
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
	                        id: 'y-axis-1', // 왼쪽 Y축 ID
	                    },
	                    {
	                        type: 'linear',
	                        display: true,
	                        position: 'right',
	                        id: 'y-axis-2', // 오른쪽 Y축 ID
	                    },
	                ],
	            },
	        },
	    });
	});    
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