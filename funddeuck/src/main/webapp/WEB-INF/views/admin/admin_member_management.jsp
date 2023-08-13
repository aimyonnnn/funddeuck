<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- bootstrap -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<!-- jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
<!-- line-awesome -->
<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
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
	document.addEventListener('DOMContentLoaded', function() {
		<c:if test="${not empty membersData}">
	      var memberCounts = [
	        <c:forEach items="${membersData}" var="member" varStatus="status">
	          {
	            date: '${member.date}',
	            count: ${member.count}
	          }<c:if test="${not status.last}">,</c:if>
	        </c:forEach>
	      ];
	    </c:if>
	    
	    let labels = [];
	    let total = [];
	    let members = [];
	    let today = new Date().toISOString().slice(0, 10);
	    let accumulatedCount = 0;
	    let prevDate;
	    
	    for (let i = 0; i < memberCounts.length; i++) {
	      let memberCount = memberCounts[i];
	      labels.push(memberCount.date);
	      accumulatedCount += memberCount.count;
	      total.push(accumulatedCount);

	      // 오늘 가입한 회원 수 계산
	      let joinedToday = 0;
	      if (prevDate === today) {
	        joinedToday = memberCount.count;
	      } else {
	        joinedToday = (i > 0) ? (accumulatedCount - total[i - 1]) : memberCount.count;
	      }
	      members.push(joinedToday);
	      prevDate = memberCount.date;
	    }

		const v_data = {
		  labels: labels,
		  datasets: [
		    {
		      label: "오늘 가입한 회원수",
		      data: members,
		      borderColor: "#36a2eb",
		      backgroundColor: "#36a2eb",
		      fill: false,
		      yAxisID: "y",
		    },
		    {
		      label: "누적 회원수",
		      data: total,
		      borderColor: "#ffb0c1",
		      backgroundColor: "#ffb0c1",
		      fill: false,
		      yAxisID: "y1",
		      type: "bar",
		    },
		  ],
		};

		const v_config = {
			    type: 'line',
			    data: v_data,
			    options: {
			        interaction: {
			            intersect: false,
			            mode: 'index',
			        },

			        scales: {
			            y: {
			                type: 'linear',
			                display: true,
			                position: 'left',
			                suggestedMin: 0,
			                suggestedMax: 50,
			            },
			            y1: {
			                type: 'linear',
			                display: true,
			                position: 'right',
			                suggestedMin: 0,
			                suggestedMax: 50,
			                // grid line settings
			                grid: {
			                    // only want the grid lines for one axis to show up
			                    drawOnChartArea: false,
			                }
			            }
			        }
			    }
			};
		
		new Chart(document.getElementById('myChart'), v_config);
	});
</script>
</head>
<body>
<!-- 페이징 처리를 위한 pageNum 셋팅 -->
<c:set var="pageNum" value="1"/>
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }" />
</c:if>

<!-- sidebar -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<!-- top -->
<div class="main-content">
<jsp:include page="../common/admin_top.jsp"/>

<div class="container my-5">

	<div class="container">
		<h2 class="fw-bold mt-5">회원 관리</h2>
		<p class="projectContent">전체 회원을 확인 할 수 있습니다.</p>
	</div>
	
	<div>
	    <canvas id="myChart" style="height: 40vh; width: 50vw"></canvas>
	</div>

	<!-- 검색 버튼 -->
	<div class="d-flex flex-row justify-content-center my-5">
		<!-- form 태그 시작 -->
		<form action="adminMemberManagement" class="d-flex flex-row justify-content-end">
			<!-- 셀렉트 박스 -->
			<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
				<option value="name" <c:if test="${param.searchType eq 'name'}">selected</c:if>>회원</option>
				<option value="email" <c:if test="${param.searchType eq 'email'}">selected</c:if>>이메일</option>
			</select>
			<!-- 검색타입, 검색어 -->
			<div class="input-group">
				<input type="text" class="form-control form-control-sm" name="searchKeyword" value="${param.searchKeyword}" id="searchKeyword"
					aria-describedby="button-addon2" style="width: 500px;">
				<button class="btn btn-outline-secondary btn-sm" type="submit" value="검색" id="button-addon2">검색</button>
			</div>
		</form>
		<!-- form 태그 끝 -->	
	</div>
	<!-- 검색 버튼 -->
		
	<div class="row">
		<div class="d-flex justify-content-center">
			
			<table class="table">
				<tr>
					<th class="text-center" style="width: 5%;">번호</th>
					<th class="text-center" style="width: 5%;">아이디</th>
					<th class="text-center" style="width: 5%;">이름</th>
					<th class="text-center" style="width: 7%;">전화번호</th>
					<th class="text-center" style="width: 10%;">이메일</th>
					<th class="text-center" style="width: 5%;">상세정보</th>
				</tr>
				
				<c:forEach var="memberList" items="${memberList}">
					<tr>
						<td class="text-center">${memberList.member_idx}</td>
						<td class="text-center">${memberList.member_id}</td>
						<td class="text-center">${memberList.member_name}</td>
						<td class="text-center">${memberList.member_phone}</td>
						<td class="text-center">${memberList.member_email}</td>
						<td class="text-center">
							<button class="btn btn-outline-primary btn-sm" 
							onclick="location.href='adminMemberDetail?member_idx=${memberList.member_idx}&pageNum=${pageNum}'">보기</button>
						</td>
					</tr>
				</c:forEach>
				
			</table>
	
			</div>
		</div>
	</div>		
	
	<!-- 페이징 처리 -->
	<div class="my-5">
	    <nav aria-label="Page navigation example" class="d-flex flex-row justify-content-center">
	        <ul class="pagination">
	            <%-- 현재 페이지 번호(pageNum)가 1보다 클 경우 [이전] 버튼 활성화 --%>
	            <c:choose>
	                <c:when test="${pageNum > 1}">
	                	<c:choose>
	                		<c:when test="${not empty param.searchType and not empty param.searchKeyword}">
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Previous" href="adminMemberManagement?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Previous" href="adminMemberManagement?pageNum=${pageNum - 1}">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
	                		</c:otherwise>
	                	</c:choose>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item">
	                        <a class="page-link" aria-label="Previous" onclick="alert('첫 페이지 입니다!')">
	                            <span aria-hidden="true">&laquo;</span>
	                        </a>
	                    </li>
	                </c:otherwise>
	            </c:choose>
	
	            <%-- 페이지번호 목록은 시작페이지(startPage) 부터 끝페이지(endPage) 까지 표시 --%>
	            <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
	                <c:choose>
	                    <%-- 현재 페이지면 하이퍼링크 제거 --%>
	                    <c:when test="${pageNum eq i}">
	                        <li class="page-item"><a class="page-link">${i}</a></li>
	                    </c:when>
	                    <c:otherwise>
	                        <%-- 검색 키워드가 있을 때와 없을 때를 구분하여 페이지 이동 URL 생성 --%>
	                        <c:choose>
	                            <c:when test="${not empty param.searchType and not empty param.searchKeyword}">
	                                <li class="page-item"><a class="page-link" href="adminMemberManagement?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a></li>
	                            </c:when>
	                            <c:otherwise>
	                                <li class="page-item"><a class="page-link" href="adminMemberManagement?pageNum=${i}">${i}</a></li>
	                            </c:otherwise>
	                        </c:choose>
	                    </c:otherwise>
	                </c:choose>
	            </c:forEach>
	
	            <c:choose>
	                <%-- 현재 페이지 번호(pageNum)가 최대 페이지 번호(maxPage) 보다 작을 경우 [다음] 버튼 활성화 --%>
	                <c:when test="${pageNum < pageInfo.maxPage}">
	                	<c:choose>
	                		<c:when test="${not empty param.searchType and not empty param.searchKeyword}">
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Next" href="adminMemberManagement?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Next" href="adminMemberManagement?pageNum=${pageNum + 1}">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
	                		</c:otherwise>
	                	</c:choose>
	                </c:when>
	                <c:otherwise>
	                    <li class="page-item">
	                        <a class="page-link" aria-label="Next" onclick="alert('마지막 페이지 입니다!')">
	                            <span aria-hidden="true">&raquo;</span>
	                        </a>
	                    </li>
	                </c:otherwise>
	            </c:choose>
	        </ul>
	    </nav>
	</div>
</div>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>