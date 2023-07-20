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
	</script>
	
	<!-- 페이지 로드 시 출력되는 차트 -->
	<script type="text/javascript">
	// 전역 변수 설정
	var jsonData = JSON.parse('${boardListCount}');
	var memberJson = JSON.parse('${memberListCount}');

	var labelList = [];
	var dailyCountList = []; // 일별 게시물 수
	var cumulativeCountList = []; // 누적 게시물 수
	var cumulativeCount = 0; // 누적 게시물 수

	var memberLabelList = []; // 회원가입 수의 날짜 라벨 리스트
	var memberDailyCountList = []; // 일별 회원가입 수 리스트
	var memberCumulativeCountList = []; // 누적 회원가입 수 리스트
	var memberCumulativeCount = 0; // 누적 회원가입 수 초기값

	// 게시판 게시물 수 데이터 처리
	for (var i = 0; i < jsonData.length; i++) {
	    var d = jsonData[i];
	    labelList.push(d.date); // 날짜 라벨 추가
	    dailyCountList.push(d.count); // 일별 게시물 수 추가
	    cumulativeCount += d.count; // 누적 게시물 수 계산
	    cumulativeCountList.push(cumulativeCount); // 누적 게시물 수 추가
	}

	// 회원가입 수 데이터 처리
	var memberIndex = 0; // 회원가입 수 데이터 인덱스
	for (var i = 0; i < labelList.length; i++) {
	    var label = labelList[i]; // 현재 라벨
	    var memberData = memberJson[memberIndex]; // 현재 회원가입 수 데이터

	    if (memberData && label === memberData.date) { // 현재 라벨과 회원가입 수 데이터의 날짜가 일치하는 경우
	        memberLabelList.push(label); // 라벨 추가
	        memberDailyCountList.push(memberData.count); // 일별 회원가입 수 추가
	        memberCumulativeCount += memberData.count; // 누적 회원가입 수 갱신
	        memberCumulativeCountList.push(memberCumulativeCount); // 누적 회원가입 수 추가
	        memberIndex++; // 다음 회원가입 수 데이터로 이동
	    } else { // 누락된 날짜에 대해 0으로 처리
	        memberLabelList.push(label); // 라벨 추가
	        memberDailyCountList.push(0); // 0으로 처리된 일별 회원가입 수 추가
	        memberCumulativeCountList.push(memberCumulativeCount); // 이전의 누적 회원가입 수 추가 (이전 데이터를 그대로 사용)
	    }
	}

	// 오늘 게시물 수
	var todayCount = dailyCountList[dailyCountList.length - 1];

	// 차트 데이터 설정
	var BoardListCount = {
	    labels: labelList,
	    datasets: [
	        {
	            label: '일별 게시물수',
	            data: dailyCountList,
	            backgroundColor: 'rgba(255, 99, 132, 1)',
	            borderColor: 'rgba(255, 99, 132, 1)',
	            borderWidth: 4
	        },
	        {
	            label: '누적 게시물수',
	            data: cumulativeCountList,
	            backgroundColor: 'rgb(135, 206, 235)',
	            borderColor: 'rgb(135, 206, 235)',
	            borderWidth: 4
	        },
	        {
	            label: '누적 회원가입수',
	            data: memberCumulativeCountList,
	            backgroundColor: 'orange',
	            borderColor: 'orange',
	            borderWidth: 4
	        }
	    ],
	    options: {
	        title: {
	            display: true,
	            text: '게시물수'
	        }
	    }
	};

	$(()=>{
	    // 게시판 게시물 수 차트
	    var ctx2 = document.getElementById('myChart2').getContext('2d');
	    var myChart2 = new Chart(ctx2, {
	        type: 'line',
	        data: BoardListCount
	    });
	});
	</script>
	
	<script type="text/javascript">
    $(() => {
        // datepicker 클래스를 가진 요소에 datepicker 기능 적용
        $('.datepicker').datepicker();

        let myChart2 = null; // Chart 객체를 저장하기 위한 변수

        $('#updateButton').click(() => {
            let startDate = $('#startDate').val(); // 시작일 입력값 가져오기
            let endDate = $('#endDate').val(); // 종료일 입력값 가져오기
            let chartType = $('#chartType').val(); // 선택된 차트 유형 가져오기

            console.log(`${startDate}, ${endDate}, ${chartType}`); // 입력된 시작일, 종료일, 차트 유형 콘솔에 출력

            $.ajax({
                url: '<c:url value="chartData"/>', // 차트 데이터를 가져올 URL 설정
                type: 'GET',
                data: {
                    startDate, // 시작일 파라미터 설정
                    endDate, // 종료일 파라미터 설정
                    chartType // 차트 유형 파라미터 설정
                },
                success: (response) => {
                    console.log(response); // 서버로부터 받은 응답 데이터 콘솔에 출력
                    updateChart(response, chartType); // 차트 업데이트 함수 호출
                },
                error: (xhr, status, error) => {
                    console.error(error); // 에러 발생 시 콘솔에 출력
                }
            });
        });

        let updateChart = (data, chartType) => {
            // 응답 데이터에서 라벨, 일별 게시물 수, 누적 게시물 수를 추출
            let { labels, boardDailyCounts, boardCumulativeCounts, memberDailyCounts, memberCumulativeCounts } = data;

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
		                            label: '일별 게시물수',
		                            data: boardDailyCounts, // 일별 게시물 수 설정
		                            backgroundColor: 'rgba(255, 99, 132, 1)',
		                            borderColor: 'rgba(255, 99, 132, 1)',
		                            borderWidth: 4
		                        },
		                        {
		                            label: '누적 게시물수',
		                            data: boardCumulativeCounts, // 누적 게시물 수 설정
		                            backgroundColor: 'rgb(135, 206, 235)',
		                            borderColor: 'rgb(135, 206, 235)',
		                            borderWidth: 4
		                        },
		                        {
		                            label: '누적 회원가입수',
		                            data: memberCumulativeCounts,
		                            backgroundColor: 'orange',
		                            borderColor: 'orange',
		                            borderWidth: 4
		                        }
                    		  ]
                },
                options: {
                    title: {
                        display: true,
                        text: '게시물수' // 차트 제목 설정
                    }
                }
            });
        };

        // 누적 게시물 수 표시 업데이트
        $('#cumulativePostCount').text(cumulativeCount);
        // 오늘 게시물 수 표시 업데이트
        $('#todayPostCount').text(todayCount || '0');

    }); // ready
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
					            <span class="sideDescription">펀딩 달성률</span>
					            <h1 class="card-title">120<span class="sideDescription">%</span></h1>
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
					            <span class="sideDescription">펀딩 건 수</span>
					            <h1 class="card-title">91<span class="sideDescription">건</span></h1>
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
	            	
		           <div class="container my-5">
				    	<div class="row justify-content-center">
			          	  <p class="subheading">그래프 테스트</p>
			              <p class="projectContent">결제가 갱신될 때 마다 아래 현황이 업데이트 됩니다.</p>
			              
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
					            <span class="sideDescription">펀딩 달성률</span>
					            <h1 class="card-title">120<span class="sideDescription">%</span></h1>
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
					            <span class="sideDescription">펀딩 건 수</span>
					            <h1 class="card-title">91<span class="sideDescription">건</span></h1>
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
	
	  <!-- 차트 -->
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