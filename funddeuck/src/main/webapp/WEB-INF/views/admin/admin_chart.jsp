<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Admin</title>
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1">
<!--bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<!-- jquery -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
<!-- line-awesome -->
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/adminDetail.css" rel="stylesheet" type="text/css"/>
<link href="${pageContext.request.contextPath }/resources/css/project_status.css" rel="styleSheet" type="text/css">
<link rel="shortcut icon" href="#">
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

            $.ajax({
                type: 'GET',
                url: '<c:url value="chartData2"/>', // 차트 데이터를 가져올 URL 설정
                data: {
                    startDate,      // 시작일
                    endDate,        // 종료일
                    chartType     // 차트
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
        let { labels, dailyPaymentAmounts, acmlPaymentAmounts, dailySupporterCounts, acmlSupporterCounts } = data;
        // 차트 컨테이너 요소
        let chartContainer = document.getElementById('chartContainer');
        // 기존의 차트 캔버스를 제거
        chartContainer.innerHTML = '<canvas id="myChart2"></canvas>';
        // 차트 크기를 동적으로 변경하는 부분 추가 - 생략 가능한 부분임!
        let chartCanvas = document.getElementById('myChart2');
        chartCanvas.style.height = '40vh';
        chartCanvas.style.width = '50vw';
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
                        data: acmlPaymentAmounts, // 누적 결제 금액 설정
                        type: 'line', // 라인 차트로 설정
                        backgroundColor: 'rgb(135, 206, 235)',
                        borderColor: 'rgb(135, 206, 235)',
                        borderWidth: 4,
                        fill: false,
                        yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                    },
                    {
                        label: '누적 회원 수',
                        data: acmlSupporterCounts, // 누적 회원 수 설정
                        type: chartType,
                        backgroundColor: 'rgba(153, 102, 255, 0.2)',
                        borderColor: 'rgba(153, 102, 255, 0.2)',
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
</head>
<body>
<input type="checkbox" name="" id="sidebar-toggle">
<!-- side include -->
<jsp:include page="../common/admin_side.jsp"/>


	<div class="main-content">
		<!-- top include -->
		<jsp:include page="../common/admin_top.jsp" />

		<main>
			<div class="container mt-3 mb-2">
				<div class="row justify-content-center">

					<div class="col-md-12 col-lg-4">
						<div class="card-single my-1">
							<div class="card-flex">
								<div class="card-into">
									<div class="card-head">
										<span>WEEK PAYMENT</span> <small>누적 결제금액</small>
									</div>
									<h2>
										<span>${totalAmount}</span>원
									</h2>
									<small> <a style="color: red;">7일 동안 누적된</a> 결제금액 입니다.
									</small>
								</div>
								<div class="card-chart danger">
									<span class="las la-chart-line" style="color: rgba(255, 99, 132, 1);"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-lg-4">
						<div class="card-single my-1">
							<div class="card-flex">
								<div class="card-into">
									<div class="card-head">
										<span>DAY PAYMENT</span> <small>일별 결제금액</small>
									</div>
									<h2>
										<span>${todayAmount}</span>원
									</h2>
									<small><a style="color: red;">지난 일주일간</a> 일별 결제금액 입니다.</small>
								</div>
								<div class="card-chart success">
									<span class="las la-chart-line" style="color: rgb(135, 206, 235);"></span>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-lg-4">
						<div class="card-single my-1">
							<div class="card-flex">
								<div class="card-into">
									<div class="card-head">
										<span>SUPPORTER</span> <small>누적 서포터 수</small>
									</div>
									<h2>
										<span>${todaySupporterCount}</span>명
									</h2>
									<small><a style="color: red;">7일 동안 등록된</a> 총 서포터 수입니다.</small>
								</div>
								<div class="card-chart yellow">
									<span class="las la-chart-line" style="color: rgba(153, 102, 255, 0.2);"></span>
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
						<button class="datepicker-button ms-2" id="updateButton">조회</button>
					</div>
					<!-- 차트 영역  -->
					<div id="chartContainer">
						<canvas id="myChart2" style="height: 40vh; width: 50vw"></canvas>
					</div>
				</div>
			</div>

		</main>
	</div>

<label for="sidebar-toggle" class="body-label"></label>
    
<!-- 페이지 로드 시 출력되는 차트 -->
<script type="text/javascript">
    let payJson = JSON.parse('${payListAmount}');
    let supporterJson = JSON.parse('${supporterListCount}');

    let labelList = [];
    let dailyAmountList = []; // 일별 결제 금액
    let acmlAmountList = []; // 누적 결제 금액
    let acmlAmount = 0; // 누적 결제 금액 초기값

    let acmlSupporterCounts = []; // 누적 서포터 수 리스트
    let acmlSupporterCount = 0; // 누적 서포터 수 초기값

    // 결제 금액 구하기
    for (let i = 0; i < payJson.length; i++) {
        let d = payJson[i];
        labelList.push(d.date); // 날짜 라벨
        dailyAmountList.push(d.amount); // 일별 결제 금액 추가
        acmlAmount += d.amount; // 누적 결제 금액
        acmlAmountList.push(acmlAmount); // 누적 결제 금액 추가
    }

 	// 누적 서포터 수 구하기
    for (let i = 0; i < supporterJson.length; i++) {
        let supporter = supporterJson[i];
        acmlSupporterCount += supporter.supporterCount; // 누적 서포터 수 갱신
        acmlSupporterCounts.push(acmlSupporterCount); // 누적 서포터 수 추가
    }
 	
 	// 누락된 데이터 채우기
    for (let i = 1; i < labelList.length; i++) {
        // 결제 금액의 누적 값 채우기
        if (dailyAmountList[i] === undefined) {
            dailyAmountList[i] = dailyAmountList[i - 1];
            acmlAmountList[i] = acmlAmountList[i - 1];
        }

        // 누적 서포터 수 채우기
        if (acmlSupporterCounts[i] === undefined) {
            acmlSupporterCounts[i] = acmlSupporterCounts[i - 1];
        }
    }

    // 결제 금액과 누적 서포터 수 데이터 설정
    let chartData = {
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
                data: acmlAmountList,
                backgroundColor: 'rgb(135, 206, 235)',
                borderColor: 'rgb(135, 206, 235)',
                borderWidth: 4,
                fill: false,
                yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                type: 'line', // line 차트로 설정
            },
            {
                label: '누적 서포터 수',
                data: acmlSupporterCounts,
                backgroundColor: 'rgba(153, 102, 255, 0.2)',
                borderColor: 'rgba(153, 102, 255, 0.2)',
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
//             	responsive: false,
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
	
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<!-- datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
 	
</body>
</html>