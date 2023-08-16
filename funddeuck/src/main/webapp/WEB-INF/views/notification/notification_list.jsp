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
<!-- css -->
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet" type="text/css">
<style>
table {
    width: 100%; /* 테이블의 전체 너비를 100%로 설정 */
    table-layout: fixed; /* 테이블 레이아웃을 고정으로 설정 */
}
/* 각 셀의 너비를 20%로 설정 */
th, td {
    width: 10%; 
}
/* 마우스 올리면 커서 보이게 하기 */
td a:hover {
    cursor: pointer;
}
.hover-effect:hover {
 	text-decoration: underline; /* 제목 클릭 시 밑줄 효과 */
}
/* 테이블의 각 행에 마우스를 올렸을 때 */
table tr:hover td {
  	background-color: rgba(211, 211, 211, 0.5);
}
/* 페이지네이션 글자색 변경 */
.page-link {
	color: black !important; /* 또는 다른 적절한 색상 사용 */
}
</style>
<script type="text/javascript">
//메시지 제목 클릭 시 메시지 정보 조회 후 모달창에 출력
function openNotificationModal(notification_idx) {
	
	$.ajax({
		
		method: 'post',
		url: "<c:url value='getNotificationInfo'/>",
		data: { notification_idx : notification_idx },
		success: function(data) {
			
			console.log(data);
			
			let modalBody2 = $('#messageDetail');
			modalBody2.empty();
			
			let tableHtml = `
				<table class="table">
					<tr>
						<td class="text-center" style="width:15%">제목</td>
						<td style="width:85%">${'${data.notification_subject}'}</td>
					</tr>
					<tr>
						<td class="text-center">내용</td>
						<td>
							${'${data.notification_content}'}
						</td>
					</tr>
				</table>
			`;
			
			modalBody2.html(tableHtml);
			
			// 메시지 읽음처리 하기
			updateMessageStatus(notification_idx);
			
		}
	});
}

// 메시지 클릭 시 읽음처리 하기
function updateMessageStatus(notification_idx) {
	
	$.ajax({
		method: 'get',
		url: '<c:url value="markNotificationAsRead"/>',
		data: {	notification_idx: notification_idx },
		success: function(data) {
			
			if(data.trim() == 'true') {
				
				console.log("메시지 조회하기 클릭 시 메시지 읽음 처리 완료");
				
			} 
			
		},
		error: function(error) {
			console.log("메시지 읽음 처리 실패!")
		}
	});
	
	// 모달 창 닫힐 때 페이지 새로고침
	$('#messageStaticBackdrop').on('hidden.bs.modal', function (e) {
		location.reload();
	});
	
}

// 메시지 삭제하기
function deleteNotification(notification_idx) {
		
	Swal.fire({
		title: '메시지 삭제 진행',
		text: '메시지를 삭제 하시겠습니까?',
		icon: 'question',
		showCancelButton: true,
		confirmButtonText: '예',
		cancelButtonText: '아니오'
	})
	.then((result) => {
		if (result.isConfirmed) {
		
			$.ajax({
				method: 'get',
				url: "<c:url value='deleteNotification'/>",
				data: {
					notification_idx: notification_idx
				},
				success: function(data){
					
					if(data.trim() == 'true') {
						Swal.fire({
							icon: 'success',
							title: '메시지 삭제처리 완료.',
							text: '메시지가 성공적으로 삭제되었습니다.'
						}).then(function() {
							location.reload();
						});
					} else {
						Swal.fire({
							icon: 'error',
							title: '메시지 삭제처리 실패',
							text: '메시지 삭제에 실패하였습니다.' 
						})
					}
					
				},
				error: function(){
					console.log('ajax 요청이 실패하였습니다!');	
				}
			});
		}
	});
}

//메시지 읽음 처리 하기
function markNotificationAsRead(notification_idx, checkbox) {
	
	Swal.fire({
	    title: '읽음처리 하시겠습니까?',
	    icon: 'question',
	    showCancelButton: true,
	    confirmButtonText: '확인',
	    cancelButtonText: '취소'
  	}).then((result) => {
  		
	    if (result.isConfirmed) {
	    	console.log("알림번호 : " + notification_idx);
	    	
			$.ajax({
				method: 'get',
				url: '<c:url value="markNotificationAsRead"/>',
				data: {
					notification_idx: notification_idx
				},
				success: function(response){
					
					if(response.trim() == 'true') {
						
						Swal.fire({
							icon: 'success',
							title: '메시지 읽음처리 완료!',
							text: '메시지 읽음처리가 완료되었습니다.'
						}).then(function() {
							getNotificationCount(); // 알림 갯수 변경하기
							location.reload();
							checkbox.checked = false;
						});
					} 
					
				},
				error: function(error) {
					console.log("읽음 처리 실패!")
				}
			});
			
		} else {
			// 취소 선택 시 체크박스 해제
			checkbox.checked = false;
		}
	});
}

// 전체 읽음 처리
function markAllAsRead(member_id) {
	
	Swal.fire({
	    title: '전체읽음처리 하시겠습니까?',
	    icon: 'question',
	    showCancelButton: true,
	    confirmButtonText: '확인',
	    cancelButtonText: '취소'
  	}).then((result) => {
  		
	    if (result.isConfirmed) {
	    	
			$.ajax({
				method: 'get',
				url: '<c:url value="markAllAsRead"/>',
				data: {
					member_id: member_id
				},
				dataType: 'text',
				success: function(response){
					
					if(response.trim() == 'true') {
						
						Swal.fire({
							icon: 'success',
							title: '모든 메시지 읽음처리 완료!',
							text: '모든 메시지가 읽음처리 되었습니다.'
						}).then(function() {
							getNotificationCount(); // 알림 갯수 변경하기
							location.reload();
							checkbox.checked = false;
						});
						
					}
				},
				error: function(){
					console.log("ajax 요청이 실패하였습니다");
				}
			});			
		}
  	});
}
</script>
</head>
<body>
<div style="height:150px;"></div>
<jsp:include page="../Header.jsp"/>
<c:set var="pageNum" value="1"/>
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }" />
</c:if>
	
<div class="container my-5">

	<div class="container">
		<h2 class="fw-bold mt-5">받은 메시지함</h2>
	</div>
	
	<!-- 검색 버튼 -->
	<div class="d-flex flex-row justify-content-center my-3">
		<!-- 폼 태그 -->
		<form action="confirmNotification" class="d-flex flex-row justify-content-end">
			<!-- 셀렉트 박스 -->
			<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
				<option value="subject" <c:if test="${param.searchType eq 'subject'}">selected</c:if>>제목</option>
				<option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
			</select>
			<!-- 검색타입 & 검색어 -->
			<div class="input-group">
				<input type="text" class="form-control form-control-sm" name="searchKeyword" value="${param.searchKeyword}" id="searchKeyword"
					aria-describedby="button-addon2" style="width: 500px;">
				<button class="btn btn-outline-secondary btn-sm" type="submit" value="검색" id="button-addon2">검색</button>
			</div>
		</form>
	</div>
		
	<div class="d-flex justify-content-end mb-3">
		<button type="button" class="btn btn-outline-primary btn-sm" onclick="markAllAsRead('${sessionScope.sId}')">전체읽음처리</button>
	</div>
	
	<!-- pc사이즈에서만 보임 -->
	<div class="row col-md-12 d-none d-md-block">
		<div class="d-flex justify-content-center">
			<table class="table">
				<tr>
					<th class="text-center" style="width: 5%;">번호</th>
					<th class="text-center" style="width: 20%;">제목</th>
					<th class="text-center" style="width: 7%;">받은시각</th>
					<th class="text-center" style="width: 5%;">상태</th>
					<th class="text-center" style="width: 5%;">읽음처리하기</th>
					<th class="text-center" style="width: 5%;">삭제하기</th>
				</tr>
				<c:forEach var="nList" items="${nList}">
					<tr>
						<td class="text-center" style="width: 5%;">${nList.notification_idx}</td>
						<td class="text-center" style="width: 20%;">
							<a onclick="openNotificationModal(${nList.notification_idx})" data-bs-toggle="modal" data-bs-target="#messageStaticBackdrop">
								${nList.notification_subject}
							</a>
						</td>
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
						<td class="text-center">
							<input type="checkbox" class="form-check-input" onclick="deleteNotification(${nList.notification_idx}, this)"/>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	
	<!-- 모바일 사이즈에서만 보임 -->
	<div class="row col-md-12 d-md-none">
		<div class="d-flex justify-content-center">
			<table class="table">
				<tr>
					<th class="text-center" style="width: 5%;">번호</th>
					<th class="text-center" style="width: 20%;">제목</th>
					<th class="text-center" style="width: 6%;">받은시각</th>
					<th class="text-center" style="width: 5%;">상태</th>
				</tr>
				<c:forEach var="nList" items="${nList}">
					<tr>
						<td class="text-center" style="width: 5%;">${nList.notification_idx}</td>
						<td class="text-center" style="width: 20%;">
							<a onclick="openNotificationModal(${nList.notification_idx})" data-bs-toggle="modal" data-bs-target="#messageStaticBackdrop">
								${nList.notification_subject}
							</a>
						</td>
						<td class="text-center" style="width: 10%;">
							<fmt:formatDate value="${nList.notification_regdate}" pattern="yy-MM-dd"/>
						</td>
						<c:choose>
							<c:when test="${nList.notification_read_status eq 1}">
								<td class="text-center text-danger" style="width: 5%;">읽지않음</td>
							</c:when>
							<c:otherwise>
								<td class="text-center" style="width: 5%;">읽음</td>
							</c:otherwise>
						</c:choose>
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
	                        <a class="page-link" aria-label="Previous" href="confirmNotification?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
	                            <span aria-hidden="true">&laquo;</span>
	                        </a>
                		</c:when>
                		<c:otherwise>
	                        <a class="page-link" aria-label="Previous" href="confirmNotification?pageNum=${pageNum - 1}">
	                            <span aria-hidden="true">&laquo;</span>
	                        </a>
                		</c:otherwise>
                	</c:choose>
                    <li class="page-item">
                    </li>
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
                                <li class="page-item"><a class="page-link" href="confirmNotification?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="confirmNotification?pageNum=${i}">${i}</a></li>
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
		                        <a class="page-link" aria-label="Next" href="confirmNotification?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
		                            <span aria-hidden="true">&raquo;</span>
		                        </a>
		                    </li>
                		</c:when>
                		<c:otherwise>
		                    <li class="page-item">
		                        <a class="page-link" aria-label="Next" href="confirmNotification?pageNum=${pageNum + 1}">
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
<!-- 페이징 처리 -->

<!-- 메시지 모달창 -->
<div class="modal fade" id="messageStaticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">메시지 조회하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body2" id="messageDetail">
        <!-- 테이블 출력 되는 부분 -->	
      </div>
        <button type="button" class="btn btn-primary m-2" data-bs-dismiss="modal">메시지 닫기</button>
    </div>
  </div>
</div>

<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>