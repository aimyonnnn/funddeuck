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
    <!-- iamport -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
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
		/* 테이블의 각 행에 마우스를 올렸을 때 */
		table tr:hover td {
		  	background-color: rgba(211, 211, 211, 0.5);
		}
		/* 페이지네이션 글자색 변경 */
		.page-link {
			color: black;
		}
	</style>
</head>
<body>
<jsp:include page="../common/project_top.jsp"/>
<!-- pageNum 파라미터 가져와서 저장(기본값 1로 지정함) -->
<c:set var="pageNum" value="1"/>
<c:if test="${not empty param.pageNum }">
	<c:set var="pageNum" value="${param.pageNum }" />
</c:if>
	
	<div class="container my-5">
		<!-- 검색 버튼 -->
		<div class="d-flex flex-row justify-content-center my-3">
			<!-- form 태그 시작 -->
			<form action="confirmNotification" class="d-flex flex-row justify-content-end">
				<!-- 셀렉트 박스 -->
				<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
					<option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
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
		    <button type="button" class="btn btn-outline-primary btn-sm mx-2" data-bs-toggle="modal" data-bs-target="#orderModal">결제하기</button>
		    <button type="button" class="btn btn-outline-primary btn-sm" onclick="markAllAsRead('${sessionScope.sId}')">전체읽음처리</button>
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
        $("table tr:not(:first-child)").each(function () {
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
	
<!-- 요금제 결제하기 모달창 -->
<div class="modal fade" id="orderModal" tabindex="-1" aria-labelledby="orderModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="orderModalLabel">프로젝트 요금 결제하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <table class="table text-center">
              <tr>
                <th scope="row" width="150"><label for="companyName">결제처</label></th>
                <td>Funddeuck</td>
              </tr>
              <tr>
                <th scope="row" width="150"><label for="resName">결제상품</label></th>
                <td>기본 요금제</td>
              </tr>
              <tr>
                <th scope="row" width="150"><label for="pay">결제금액</label></th>
                <td>10000</td>
              </tr>
              <tr>
                <th scope="row"><label for="userName">이름</label></th>
                <td>아이유</td>
              </tr>
              <tr>
                <th scope="row"><label for="userTel">전화번호</label></th>
                <td>010-1234-5678</td>
              </tr>
              <tr>
                <th scope="row"><label for="userEmail">이메일</label></th>
                <td>admin@admin.com</td>
              </tr>
              <tr>
		        <td colspan="2"><button id="requestPay" class="btn btn-primary w-100">결제하기</button></td>
              </tr>
          </table>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
$(()=>{
   
   var IMP = window.IMP;
   IMP.init("imp61372336");
   
    $('#requestPay').on('click', function() {
       IMP.request_pay({
    	pg: "kakopay",
    	pay_method: "card",
        merchant_uid: createOrderNum(),
        name: "아이유",
        amount: "10",
        buyer_email: "admin@admin.com",
        buyer_name: "아이유", 
        buyer_tel: "01012345678"
       }, 
       
       function(rsp) {
         console.log(rsp);
         
         // ================= 결제 성공 시 =================
         if (rsp.success) {
         	
	        alert('결제가 완료되었습니다.');
	        console.log('결제가 완료되었습니다.');
	        
// 	        let payment_num = rsp.imp_uid; // 아임포트 주문번호
//  		 	let p_orderNum = rsp.merchant_uid; // 주문번호-자동생성한것
//  		 	let payment_total_price = rsp.paid_amount; // 결제가격
	        
	        // ================= DB 작업 =================
	        // 1. project_approve_status = 5일 경우 결제테이블 결제 정보 저장하기
	        // 2. 프로젝트 상태컬럼을 5-결제완료 상태로 변경(펀딩+ 페이지에 출력 가능한 상태)
	        $.ajax({
				method: 'get',
				url: "<c:url value='updateProjectStatus'/>",
				data: {
					project_idx: 4,
					project_approve_status: 5
				},
				success: function(data){
					
					if(data.trim() == 'true') {
						alert('펀딩+ 페이지에서 프로젝트를 확인해주세요!');
						$('#orderModal').modal('hide');
// 						location.reload();
					} 
				},
				error: function(){
					console.log('ajax 요청이 실패하였습니다!');	
				}
			});
	     	// ================= DB 작업 =================
	         
         // ================= 결제 실패 시 =================
         } else {
           var msg = '결제에 실패하였습니다.';
           msg += '에러내용: ' + rsp.error_msg;
           alert(msg);
         }
       });
   });
}); // ready

// 주문번호 만들기
function createOrderNum() {
	const date = new Date();
	const year = date.getFullYear();
	const month = String(date.getMonth() + 1).padStart(2, "0");
	const day = String(date.getDate()).padStart(2, "0");
	
	let orderNum = year + month + day;
	for(let i=0;i<10;i++) {
		orderNum += Math.floor(Math.random() * 8);	
	}
		return orderNum;
}
</script>
	
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
   
</body>
</html>