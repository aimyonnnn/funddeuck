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
<!-- datepicker -->
<script>
$(() => {
    $.datepicker.setDefaults({ dateFormat: 'yy-mm-dd' });
    $('.datepicker').datepicker();
});
// 차트 출력
$(() => {
    $('.datepicker').datepicker();

    let myChart2 = null; // Chart 객체를 저장하기 위한 변수

    $('#updateButton').click(() => {
        let startDate = $('#startDate').val(); 									// 시작일 입력값 가져오기
        let endDate = $('#endDate').val(); 										// 종료일 입력값 가져오기
        let chartType = $('#chartType').val(); 									// 선택된 차트 유형 가져오기

        // 날짜 유효성 검사
        if (!startDate || !endDate) {
            alert("시작 날짜와 종료 날짜를 모두 입력해주세요.");
            return;
        }

        let makerStartDate = new Date(startDate);
        let makerEndDate = new Date(endDate);

        if (makerStartDate > makerEndDate) {
            alert("끝 날짜가 시작 날짜보다 빠릅니다. 올바른 날짜를 선택해주세요.");
            return;
        }

        // 차트 유형 유효성 검사
        if (!chartType) {
            alert("차트 유형을 선택해주세요.");
            return;
        }

        $.ajax({
            type: 'GET',
            url: '<c:url value="/chartData2"/>',
            data: {
                startDate,
                endDate
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
    // 새로운 차트를 위한 캔버스 요소
    let ctx2 = document.getElementById('myChart2').getContext('2d');
    // 기존의 차트 객체가 존재하는 경우 제거함
    if (myChart2 && myChart2 instanceof Chart) {
        myChart2.destroy();
    }
    // 새로운 차트 객체를 생성
    myChart2 = new Chart(ctx2, {
        type: chartType, // 차트 타입
        data: {
            labels, // 라벨
            datasets: [
                {
                    label: '일별 결제 금액',
                    data: dailyPaymentAmounts, 									// 일별 결제 금액 설정
                    type: 'line', 												// 라인 차트로 설정
                    backgroundColor: 'rgb(135, 206, 235)',
                    borderColor: 'rgb(135, 206, 235)',
                    borderWidth: 4,
                    fill: false,
                    yAxisID: 'y-axis-1', 										// 왼쪽 축에 연결될 Y축 ID
                },
                {
                    label: '누적 결제 금액',
                    data: acmlPaymentAmounts, 									// 누적 결제 금액 설정
                    type: 'line',
                    backgroundColor: 'rgba(255, 99, 132, 1)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 4,
                    fill: false,
                    yAxisID: 'y-axis-1', 										// 왼쪽 축에 연결될 Y축 ID
                },
                {
                    label: '누적 서포터 수',
                    data: acmlSupporterCounts, 									// 누적 서포터 수 설정
                    type: chartType,
                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
                    borderColor: 'rgba(153, 102, 255, 1)',
                    borderWidth: 1,
                    yAxisID: 'y-axis-2', 										// 오른쪽 축에 연결될 Y축 ID
                }
            ]
        },
        options: {
            title: {
                display: true,
                text: '결제 금액과 누적 회원 수 데이터'
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
    
	// 텍스트 업데이트 작업 시작
	// 누적 결제 금액 업데이트
	let makerAcmlPaymentElem = document.getElementById('acmlPaymentAmount');
	let makerAcmlPayment = acmlPaymentAmounts[acmlPaymentAmounts.length - 1];
	
	if (makerAcmlPayment !== undefined) {
	    makerAcmlPaymentElem.textContent = makerAcmlPayment;
	} else {
	    makerAcmlPaymentElem.textContent = '0';
	}
	
	// 일별 평균 결제 금액 업데이트
	let makerTodayPaymentElem = document.getElementById('todayPaymentAmount');
	let makerTotalDays = dailyPaymentAmounts.length;
	let makerTotalPayment = dailyPaymentAmounts.reduce((acc, amount) => acc + amount, 0);
	let makerTodayPayment = makerTotalDays > 0 ? Math.round(makerTotalPayment / makerTotalDays) : 0;
	makerTodayPaymentElem.textContent = makerTodayPayment;
	
	// 누적 서포터 수 업데이트
	let makerAcmlSupporterElem = document.getElementById('acmlSupporterCount');
	let makerAcmlSupporter = acmlSupporterCounts[acmlSupporterCounts.length - 1];
	
	if (makerAcmlSupporter !== undefined) {
	    makerAcmlSupporterElem.textContent = makerAcmlSupporter;
	} else {
	    makerAcmlSupporterElem.textContent = '0';
	}

};
//페이지 로드시에 차트 출력하기
window.addEventListener('load', function() {
	const today = new Date();                        							// 현재 날짜를 생성
	const sevenDaysAgo = new Date(today);            							// 새로운 날짜 객체 생성    
	sevenDaysAgo.setDate(today.getDate() - 7);       							// 7일 전의 날짜로 설정
	
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


// 지난 7일간 판매량이 높은 상위 프로젝트 3개
$(() => {
    $('.datepicker').datepicker();
    
    let myChart3 = null; // Chart 객체를 저장하기 위한 변수
    let dataEntries = [];
    let project_idx = [];

    $("#projectUpdateButton").click(function() {
        let projectStartDate = $("#projectStartDate").val();
        let projectEndDate = $("#projectEndDate").val();

        $.ajax({
            url: "<c:url value='ChartDataEntry'/>",
            method: "get",
            data: {
                projectStartDate,
                projectEndDate
            },
            success: function(dataEntries) {
                console.log('이거출력됨');
                console.log(dataEntries);
                renderChart(dataEntries);
            },
            error: function(error) {
                console.error("차트 데이터를 가져오는 중 오류 발생:", error);
            }
        });
    });

    function renderChart(dataEntries) {
        // 차트 컨테이너 요소
        let chartContainer3 = document.getElementById('chartContainer3');
        // 기존의 차트 캔버스를 제거
        chartContainer3.innerHTML = '<canvas id="myChart3"></canvas>';
        // 새로운 차트를 위한 캔버스 요소
        let ctx3 = document.getElementById('myChart3').getContext('2d');
        // 기존의 차트 객체가 존재하는 경우 제거함
        if (myChart3 && myChart3 instanceof Chart) {
            myChart3.destroy();
        }
        
        const labels = dataEntries.map(entry => entry.label);
        const values = dataEntries.map(entry => entry.value);
        const project_idx = dataEntries.map(entry => entry.project_idx);
        
        const backgroundColors = [
            'rgba(255, 206, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(153, 102, 255, 0.2)'
        ];

        const borderColors = [
            'rgba(255, 206, 86, 1)',
            'rgba(75, 192, 192, 1)',
            'rgba(153, 102, 255, 1)'
        ];

        const datasets = [{
            label: "판매량",
            data: values,
            backgroundColor: backgroundColors,
            borderColor: borderColors,
            borderWidth: 1
        }];

        myChart3 = new Chart(ctx3, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: datasets
            },
            options: {
            	 onClick: function(event, chartElements) {
            		 
            		 console.log(event + ", " + chartElements);
//             		 alert(event + ", " + chartElements);
            		 
                     if (chartElements && chartElements.length > 0) {
                    	 
                         const clickedIndex = chartElements[0].index;
                         const clickedProjectIdx = dataEntries[clickedIndex].project_idx; // 데이터 직접 접근
                         
                         const redirectUrl = "adminProjectDetail?project_idx=" + clickedProjectIdx;
                         window.location.href = redirectUrl; // 페이지로 이동
                     }
                 }
            }
        });
    } // renderChart

    
    
});

//페이지 로드시에 차트 출력하기
window.addEventListener('load', function() {
	let today = new Date();                        							// 현재 날짜를 생성
	let sevenDaysAgo = new Date(today);            							// 새로운 날짜 객체 생성    
	sevenDaysAgo.setDate(today.getDate() - 7);       							// 7일 전의 날짜로 설정
	
	// 시작 날짜 입력란에 7일 전 날짜 설정
	document.getElementById("projectStartDate").valueAsDate = sevenDaysAgo;
	
	// 끝 날짜 입력란에 오늘 날짜 설정
	document.getElementById("projectEndDate").valueAsDate = today;
	
	// 페이지 로드 후 자동으로 조회 버튼 클릭 (1초 후에 실행하도록 설정)
	setTimeout(function () {
	    document.getElementById("projectUpdateButton").click();
	}, 1000); 
});

</script>

</head>
<body>
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>
<div class="main-content">
<jsp:include page="../common/admin_top.jsp" />
	<main>
	    <div class="container mt-3 mb-2">
	        <div class="row justify-content-center">
	            <div class="col-md-12 col-lg-4">
	                <div class="card-single my-1">
	                    <div class="card-flex">
	                        <div class="card-into">
	                            <div class="card-head">
	                                <span>WEEK PAYMENT</span>
	                                <small>누적 결제금액</small>
	                            </div>
	                            <h2>
	                                <span id="acmlPaymentAmount"></span>원
	                            </h2>
	                            <small>해당 기간의 누적 결제금액 입니다.</small>
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
	                                <span>DAY PAYMENT</span>
	                                <small>일별 평균 결제금액</small>
	                            </div>
	                            <h2>
	                                <span id="todayPaymentAmount"></span>원
	                            </h2>
	                            <small>해당 기간의 평균 결제금액 입니다.</small>
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
	                                <span>SUPPORTER</span>
	                                <small>누적 서포터 수</small>
	                            </div>
	                            <h2>
	                                <span id="acmlSupporterCount"></span>명
	                            </h2>
	                            <small>해당 기간의 누적 서포터 수입니다.</small>
	                        </div>
	                        <div class="card-chart yellow">
	                            <span class="las la-chart-line" style="color: rgba(153, 102, 255, 0.2);"></span>
	                        </div>
	                    </div>
	                </div>
	            </div>
	
	            <!-- 날짜 선택 -->
	            <div class="d-flex flex-row justify-content-end">
	                <input type="date" class="datepicker" id="startDate" placeholder="시작 날짜">
	                <input type="date" class="datepicker mx-2" id="endDate" placeholder="끝 날짜">
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
	
	            <!-- 차트 -->
	            <div id="chartContainer">
	                <canvas id="myChart2" style="height: 40vh; width: 50vw"></canvas>
	            </div>
	            
	            
	           <div class="container">
					<h2 class="fw-bold mt-5">상위 프로젝트 3개</h2>
					<p class="projectContent">지난 7일간 매출액이 높은 프로젝트를 확인할 수 있습니다.</p>
				</div>
	            
	            <!-- 날짜 선택 -->
	            <div class="d-flex flex-row justify-content-end">
	                <input type="date" class="datepicker" id="projectStartDate" placeholder="시작 날짜">
	                <input type="date" class="datepicker mx-2" id="projectEndDate" placeholder="끝 날짜">
	                <button class="datepicker-button ms-2" id="projectUpdateButton">조회</button>
	            </div>
	            
	            <!-- 차트 -->
	            <div id="chartContainer3">
	                <canvas id="myChart3" style="height: 40vh; width: 50vw"></canvas>
	            </div>
	            
	        </div>
	    </div>
	</main>
</div>
<label for="sidebar-toggle" class="body-label"></label>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<!-- datepicker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</body>
</html>