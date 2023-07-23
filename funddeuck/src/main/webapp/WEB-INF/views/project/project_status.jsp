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
	    // datepicker의 기본 날짜 형식을 'yy-mm-dd'로 설정
	    $.datepicker.setDefaults({ dateFormat: 'yy-mm-dd' });
	    // 모든 요소에 datepicker 기능을 적용
	    $('.datepicker').datepicker();
	});
	
	// java 차트
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
                    startDate, 		// 시작일
                    endDate, 		// 종료일
                    chartType,  	// 차트
                    maker_idx 		// 메이커 번호
                },
                success: (response) => {
                    console.log(response);
                    updateChart(response, chartType); // 차트 업데이트 함수 호출
                }
            });
        });

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
            if (myChart2) {
                myChart2.destroy();
            }

            // 새로운 차트 객체를 생성
            myChart2 = new Chart(ctx2, {
                type: chartType, // 선택된 차트 유형 설정
                data: {
                    labels, // 라벨 설정
                    datasets: [
                        {
                            label: '일별 결제 금액',
                            data: dailyPaymentAmounts, // 일별 결제 금액 설정
                            backgroundColor: 'rgba(255, 99, 132, 1)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 4
                        },
                        {
                            label: '누적 결제 금액',
                            data: cumulativePaymentAmounts, // 누적 결제 금액 설정
                            backgroundColor: 'rgb(135, 206, 235)',
                            borderColor: 'rgb(135, 206, 235)',
                            borderWidth: 4
                        },
                        {
                            label: '일별 서포터 수',
                            data: dailySupporterCounts, // 일별 서포터 수 설정
                            backgroundColor: 'orange',
                            borderColor: 'orange',
                            borderWidth: 4
                        }
                    ]
                },
                options: {
                    title: {
                        display: true,
                        text: 'Payment and Supporter Data' // 차트 제목 설정
                    }
                }
            });
        };
    }); // ready
	
    // js 차트
    // 페이지 로드 시 불러오는 차트
    // 변수 초기화
    let payJson = JSON.parse('${payListAmount}');
    let labelList = [];
    let dailyAmountList = [];
    let cumulativeAmountList = [];
    let cumulativeAmount = 0;
    
    // 결제 금액 구하기
    for(let i = 0; i < payJson.length; i++) {
    	let d = payJson[i];
    	labelList.push(d.date); 						// 날짜 라벨
    	dailyAmountList.push(d.amount); 				// 일별 결제 금액 추가
    	cumulativeAmount += d.amount; 					// 누적 결제 금액
    	cumulativeAmountList.push(cumulativeAmount);	// 누적 결제 금액 추가
    }
    
    // 차트 데이터 설정
    let payListAmount = {
    		labels: labelList,
    		datasets: [
    					{
	    					label: '일별 결제 금액',
	    					data: dailyAmountList,
	    					backgroundColor: 'rgba(255, 99, 132, 1)',
	    		            borderColor: 'rgba(255, 99, 132, 1)',
	    		            borderWidth: 4
    					},
    					{
	    					label: '누적 결제 금액',
	    					data: cumulativeAmountList,
    					    backgroundColor: 'rgb(135, 206, 235)',
    			            borderColor: 'rgb(135, 206, 235)',
	    		            borderWidth: 4
    					}
    		],
    		option:{
    			title: {
    				display: true,
    				test: '결제금액'
    			}
    		}
    }
	
    // 페이지 로드 시 차트 호출하기
    $(()=>{
	    let ctx2 = document.getElementById('myChart2').getContext('2d');
	    let myChart2 = new Chart(ctx2, {
	        type: 'line',
	        data: payListAmount
	    });
    })
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
	             	<p class="projectContent mb-4">프로젝트 진행 상황을 실시간으로 한 번에 볼 수 있습니다.</p>
		            
		            <div class="container mb-2">
				    	<div class="row justify-content-center">
			              
					      <div class="col-md-12 col-lg-4 d-md-block my-1">
					        <div class="card">
					          <div class="card-body d-flex flex-row justify-content-evenly">
					          <div>
					            <span class="sideDescription">누적 결제 금액</span>
					            <h1 class="card-title">919,999<span class="sideDescription">원</span></h1>
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
					            <span class="sideDescription">오늘 결제 금액</span>
					            <h1 class="card-title">100,000<span class="sideDescription">원</span></h1>
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
					            <span class="sideDescription">펀딩 달성률</span>
					            <h1 class="card-title">110<span class="sideDescription">%</span></h1>
					          </div>
					          <div class="">
					            <i class="las la-chart-line" style="color: green;"></i>
					          </div>
					          </div>
					        </div>
					      </div>
					      
				      </div>
			      	</div>
	            
		            <!-- 펀딩 결제 현황 그래프 -->
		            <div>
			            <canvas id="myChart"></canvas>
		            </div>
	            	
		           <div class="container mt-5 mb-3">
				    	<div class="row justify-content-center">
			          	  <p class="subheading">그래프 테스트</p>
			              <p class="projectContent">결제가 갱신될 때 마다 아래 현황이 업데이트 됩니다.</p>
			              
					      <div class="col-md-12 col-lg-4 d-md-block my-1">
					        <div class="card">
					          <div class="card-body d-flex flex-row justify-content-evenly">
					          <div>
					            <span class="sideDescription">누적 결제 금액</span>
					            <h1 class="card-title">${totalAmount}<span class="sideDescription">원</span></h1>
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
					            <h1 class="card-title">${todayAmount}<span class="sideDescription">원</span></h1>
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
					            <span class="sideDescription">펀딩 달성률</span>
					            <h1 class="card-title">110<span class="sideDescription">%</span></h1>
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
		            
		            <!--  -->
		            <div id="chartContainer">
						<canvas id="myChart2"></canvas>
					</div>
	
        		</div>
      	  	</article>
	      </section>
	      <!-- 중앙 섹션 끝 -->
	
	    </div>
	  </main>
	
	  <!-- 임시 차트 -->
	  <script>
	    // 펀딩 결제 현황 그래프
	    var ctx = document.getElementById('myChart').getContext('2d');
	    var myChart = new Chart(ctx, {
	        type: 'line',
	        data: {
	            labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
	            datasets: [
	              {
	                label: '누적결제금액',
	                data: [1, 3, 4, 7, 8, 9],
	                backgroundColor: 'rgb(135, 206, 235)',
	                borderColor: 'rgb(135, 206, 235)',
	                borderWidth: 4
	              },
	              {
	                label: '일별 결제금액',
	                data: [1, 2, 1, 3, 1, 5],
	                backgroundColor: 'rgba(255, 99, 132, 1)',
	                borderColor: 'rgba(255, 99, 132, 1)',
	                borderWidth: 4
	              },
	              {
	                label: '누적 서포터 수',
	                data: [1, 2, 3, 5, 7, 9],
	                backgroundColor: 'orange',
	                borderColor: 'orange',
	                borderWidth: 4
	              }
	            ]
	        },
	        options: {
	            scales: {
	                y: {
	                    beginAtZero: true
	                }
	            }
	        }
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