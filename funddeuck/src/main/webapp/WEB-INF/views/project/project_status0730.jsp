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
    // datepicker
    $(() => {
        $.datepicker.setDefaults({ dateFormat: 'yy-mm-dd' });
        $('.datepicker').datepicker();
    });

    <!-- 시작일, 종료일 => 지정 가능 -->
    <!-- maker_idx(파라미터)를 받아서 차트를 불러옴 -->
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
//                 type: 'bar', // 바 차트로 초기 설정
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
<!-- pageNum 파라미터 가져와서 저장(기본값 1로 지정함) -->
<c:set var="pageNum" value="1"/>
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }" />
</c:if>

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
					<li><a href="projectStatus?maker_idx=${param.maker_idx}&project_idx=${param.project_idx}" id="active-tab">프로젝트 현황</a></li>
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
						
						<!-- 메이커의 프로젝트별 차트 시작 -->
						<div class="container mt-5 mb-3">
							<div class="row justify-content-center">
								<p class="subheading">프로젝트별 매출 분석</p>
								<p class="projectContent"><strong>${param.project_idx}번 </strong> 프로젝트의 매출 분석 그래프 입니다.</p>
								
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
												<i class="las la-chart-line" style="color: rgba(255, 99, 132, 1);"></i>
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
													${projectTotalSupporterCount}<span class="sideDescription">명</span>
												</h1>
											</div>
											<div class="">
												<i class="las la-chart-line" style="color: rgba(75, 192, 192, 0.2);"></i>
											</div>
										</div>
									</div>
								</div>

								<!-- 프로젝트 선택을 위한 드롭다운 메뉴 -->
								<div class="d-flex flex-row justify-content-end mt-3">
									<select id="projectSelect" class="datepicker-button" onchange="loadChartData()">
									</select>
								</div>
								<!-- 프로젝트 선택을 위한 드롭다운 메뉴 -->
							
							</div>
						</div>
						
						<!-- myChart3 -->
						<div id="chartContainer3">
							<canvas id="myChart3"></canvas>
						</div>
						<!-- myChart3 -->
						<!-- 메이커의 프로젝트별 차트 끝 -->
						
						<!-- 구분선 -->
						<hr>
						
						<!-- 메이커의 전체 프로젝트 차트 시작 -->					
						<div class="container mt-5 mb-3">
							<div class="row justify-content-center">
								<p class="subheading">메이커의 전체 프로젝트 매출 분석</p>
								<p class="projectContent">메이커님이 소유한 전체 프로젝트의 매출을 확인할 수 있습니다.</p>

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
												<i class="las la-chart-line" style="color: rgba(255, 99, 132, 1);"></i>
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
													${totalSupporterCount}<span class="sideDescription">명</span>
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
						<!-- 데이트피커 -->

						<!-- myChart2 -->
						<div id="chartContainer">
							<canvas id="myChart2"></canvas>
						</div>
						<!-- myChart2 -->
						<!-- 메이커의 전체 프로젝트 차트 끝 -->
						
						<!-- 전체 결제 내역 조회 -->
						<div class="container mt-5 mb-3">
							<div class="row justify-content-center">
								<p class="subheading">전체 결제 내역 조회</p>
								<p class="projectContent">결제 내역을 실시간으로 조회 할 수 있습니다.</p>
							
								<!-- 셀렉트 박스 -->
								<div class="container mt-5">
									<div class="d-flex justify-content-end row mb-3">
									    <div class="col-md-2">
									        <select class="form-select"  onchange="filterNotifications()">
									            <option value="">전체</option>
									        </select>
									    </div>
									</div>
								</div>
								<!-- 셀렉트 박스 -->
								
								<div class="row">
									<div class="d-flex justify-content-center">
									
									<!-- 결제 테이블 -->
									<table class="table" style="font-size: 15px">
										<tr>
											<th class="text-center" style="width: 3%;">번호</th>
											<th class="text-center" style="width: 13%;">프로젝트명</th>
											<th class="text-center" style="width: 15%;">리워드명</th>
											<th class="text-center" style="width: 3%;">수량</th>
											<th class="text-center" style="width: 5%;">결제금액</th>
											<th class="text-center" style="width: 7%;">주문날짜</th>
											<th class="text-center" style="width: 5%;">상태</th>
											<th class="text-center" style="width: 7%;">상세보기</th>
										</tr>
										<c:forEach var="pList" items="${pList}">
											<tr>
												<th class="text-center">${pList.payment_idx }</th>
												<th class="text-center">[${pList.project_idx}]-${pList.project_subject }</th>
												<th class="text-center">[${pList.reward_idx}]-${pList.reward_name }</th>
												<th class="text-center">${pList.payment_quantity }</th>
												<th class="text-center">${pList.total_amount }</th>
												<th class="text-center">${pList.payment_date }</th>
												<c:choose>
													<c:when test="${pList.payment_confirm eq 1}">
														<th class="text-center">결제완료</th>
													</c:when>
													<c:when test="${pList.payment_confirm eq 2}">
														<th class="text-center">취소요청</th>
													</c:when>
													<c:otherwise>
														<th class="text-center">취소완료</th>
													</c:otherwise>
												</c:choose>
												<th class="text-center"><button class="btn btn-outline-primary btn-sm">상세보기</button></th>
											</tr>
										</c:forEach> 
									</table>
									</div>
								</div>
							
							</div>
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
    let pPayData = JSON.parse('${projectPayListAmount}');
    let prSupporterData = JSON.parse('${projectSupporterListCount}');
    let pTotalAmount = ${projectTotalAmount};
    let pTodayAmount = ${projectTodayAmount};
    let pTotalSupporterCount = ${projectTotalSupporterCount};

    let pLabelList = [];
    let pDailyAmountList = [];
    let pAcmlAmountList = [];
    let pAcmlAmount = 0;

    let pAcmlSupporterCounts = [];
    let pAcmlSupporterCount = 0;

    // 결제 금액 구하기
    for (let i = 0; i < pPayData.length; i++) {
        let pData = pPayData[i];
        pLabelList.push(pData.date); // 날짜 라벨
        pDailyAmountList.push(pData.amount); // 일별 결제 금액 추가
        pAcmlAmount += pData.amount; // 누적 결제 금액
        pAcmlAmountList.push(pAcmlAmount); // 누적 결제 금액 추가
    }

    // 누적 서포터 수 구하기
    for (let i = 0; i < prSupporterData.length; i++) {
        let supporter = prSupporterData[i];
        pAcmlSupporterCount += supporter.projectSupporterCount; // 누적 서포터 수 갱신
        pAcmlSupporterCounts.push(pAcmlSupporterCount); // 누적 서포터 수 추가
    }

    // 누락된 데이터 채우기
    for (let i = 1; i < pLabelList.length; i++) {
        // 결제 금액의 누적 값 채우기
        if (pDailyAmountList[i] === undefined) {
            pDailyAmountList[i] = pDailyAmountList[i - 1];
            pAcmlAmountList[i] = pAcmlAmountList[i - 1];
        }

        // 누적 서포터 수 채우기
        if (pAcmlSupporterCounts[i] === undefined) {
            pAcmlSupporterCounts[i] = pAcmlSupporterCounts[i - 1];
        }
    }

    // 결제 금액과 누적 서포터 수 데이터 설정
    let projectChartData = {
        labels: pLabelList,
        datasets: [
            {
                label: '일별 결제 금액',
                data: pDailyAmountList,
                backgroundColor: 'rgba(255, 99, 132, 1)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 4,
                fill: false,
                yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                type: 'line', // line 차트로 설정
            },
            {
                label: '누적 결제 금액',
                data: pAcmlAmountList,
                backgroundColor: 'rgb(135, 206, 235)',
                borderColor: 'rgb(135, 206, 235)',
                borderWidth: 4,
                fill: false,
                yAxisID: 'y-axis-1', // 왼쪽 축에 연결될 Y축 ID
                type: 'line', // line 차트로 설정
            },
            {
                label: '누적 서포터 수',
                data: pAcmlSupporterCounts,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 0.2)',
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
	
	<script>
	// 서버에서 프로젝트 리스트를 받아와서 셀렉트 박스에 추가하는 함수
	function getProjectList() {
		
		$.ajax({
			method: 'get',
			data: {
				maker_idx: ${param.maker_idx}
			},
			url: '<c:url value="getProjectListByMakerIdx"/>',
		  	success: function (data) {
		  		
		  		console.log(data);
		  		
			    let selectElement = document.getElementById("projectSelect");
			    
			    data.forEach((project) => {
			      let option = document.createElement("option");
			      option.value = project.project_idx;
			      option.textContent = project.project_subject;
			      selectElement.appendChild(option);
			    });
			    
			    let selectedProjectIdx = ${param.project_idx};
			    selectElement.value = selectedProjectIdx;
			    
		  	},
		  	error: function (error) {
		    console.error(error);
		  }
		});
	}
	// 선택한 프로젝트의 차트 데이터를 서버로 요청하는 함수
	function loadChartData() {
		
	  let selectedProjectIdx = document.getElementById("projectSelect").value;
	  let maker_idx = "${param.maker_idx}";
	  
	  // 현재 도메인과 포트를 동적으로 가져옴
	  let currentDomain = window.location.protocol + '//' + window.location.host;

	  // 현재 도메인과 포트를 사용하여 동적인 URL을 생성
	  let url = `${currentDomain}/funddeuck/projectStatus?maker_idx=${'${maker_idx}'}&project_idx=${'${selectedProjectIdx}'}`;

	  // 생성된 동적인 URL로 이동
	  window.location.href = url;
	  
	}

	// 페이지 로드 후 프로젝트 리스트를 조회
	$(document).ready(function () {
		getProjectList();
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