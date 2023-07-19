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
    <!-- jQuery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
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
</head>
<body>
	<jsp:include page="../common/project_top.jsp"/>
	<div class="container my-5">
		<!-- 셀렉트 박스 -->
		<div class="d-flex justify-content-end row mb-3">
		    <div class="col-md-2">
		        <select class="form-select" id="filterStatus" onchange="filterNotifications()">
		            <option value="">전체</option>
		            <option value="읽지않음">읽지않음</option>
		            <option value="읽음">읽음</option>
		        </select>
		    </div>
		</div>
		<div class="d-flex justify-content-end mb-3">
		    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="markAllAsRead('${sessionScope.sId}')">전체읽음처리</button>
		</div>
		<div class="row">
			<div class="d-flex justify-content-center">
			
				<table class="table">
					<tr>
						<th class="text-center" style="width: 5%;">번호</th>
						<th class="text-center" style="width: 20%;">내용</th>
						<th class="text-center" style="width: 10%;">받은시각</th>
						<th class="text-center" style="width: 5%;">상태</th>
						<th class="text-center" style="width: 5%;">읽음처리하기</th>
					</tr>
					
					<c:forEach var="nList" items="${nList}">
						<tr>
							<td class="text-center" style="width: 5%;">${nList.notification_idx}</td>
							<td class="text-center" style="width: 20%;">${nList.notification_content}</td>
							<td class="text-center" style="width: 10%;">
								<fmt:formatDate value="${nList.notification_regdate}" pattern="yy-MM-dd HH:mm:ss"/>
							</td>
							<c:choose>
								<c:when test="${nList.notification_read_status eq 1}">
									<td class="text-center text-danger" style="width: 5%;">읽지않음</td>
								</c:when>
								<c:otherwise>
									<td class="text-center" style="width: 5%;">읽음</td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${nList.notification_read_status eq 1}">
									<td class="text-center" style="width: 5%;">
										<input type="checkbox" class="form-check-input" onclick="markNotificationAsRead(${nList.notification_idx}, this)"/>
									</td>
								</c:when>
								<c:otherwise>
									<td class="text-center" style="width: 5%;">
										<input type="checkbox" class="form-check-input" onclick="markNotificationAsRead(${nList.notification_idx}, this)" disabled="disabled"/>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
					
				</table>
		
			</div>
		</div>
	</div>		
	
	<script type="text/javascript">
	// 메시지 읽음 처리 하기
	function markNotificationAsRead(notification_idx, checkbox) {
		let confirmation = confirm("메시지를 읽음 처리 하시겠습니까?");
		if(confirmation) {
			console.log("알림번호 : " + notification_idx);
			$.ajax({
				method: 'get',
				url: '<c:url value="markNotificationAsRead"/>',
				data: {
					notification_idx: notification_idx
				},
				success: function(response){
					if(response.trim() == 'true') {
						// 알림 갯수 변경
						getNotificationCount();
						alert('읽음 처리 하였습니다!');
						location.reload();
						checkbox.checked = false;
					} 
				},
				error: function(error) {
					console.log("읽음 처리 실패!")
				}
			})
		} else {
			// 취소 선택 시 체크박스 해제
			checkbox.checked = false;
		}
	}
	
	// 셀렉트 박스
	function filterNotifications() {
	       let statusFilter = $("#filterStatus").val();
	       $("table tr").each(function() {
	           let statusCell = $(this).find("td:nth-child(4)").text().trim();
	           if (statusFilter === "" || statusCell === statusFilter) {
	               $(this).show();
	           } else {
	               $(this).hide();
	           }
	       });
	}
	
	// 전체 읽음 처리
	function markAllAsRead(member_id){
		let confirmation = confirm("모든 메시지를 읽음 처리 하시겠습니까?");
		if(confirmation) {
			$.ajax({
				method: 'get',
				url: '<c:url value="markAllAsRead"/>',
				data: {
					member_id: member_id
				},
				dataType: 'text',
				success: function(response){
					
					if(response.trim() == 'true') {
						//알림 갯수 변경
						getNotificationCount();
						alert('모든 메시지를 읽음처리 하였습니다!');
						location.reload();
					}
				},
				error: function(){
					alert("ajax 요청이 실패하였습니다");
				}
			});			
		}
	}
	</script>
		
    <!-- bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>