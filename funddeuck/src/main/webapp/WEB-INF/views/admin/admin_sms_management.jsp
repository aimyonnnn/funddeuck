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
		<h2 class="fw-bold mt-5">문자 관리</h2>
		<p class="projectContent">회원에게 문자를 전송할 수 있으며, 발송내역을 확인 할 수 있습니다.</p>
	</div>

	<!-- 검색 버튼 -->
	<div class="d-flex flex-row justify-content-center my-5">
		<!-- form 태그 시작 -->
		<form action="adminSmsManagement" class="d-flex flex-row justify-content-end">
			<!-- 셀렉트 박스 -->
			<select class="form-select form-select-sm me-2" name="searchType" id="searchType" style="width: 100px;">
				<option value="content" <c:if test="${param.searchType eq 'content'}">selected</c:if>>내용</option>
				<option value="memberId" <c:if test="${param.searchType eq 'memberId'}">selected</c:if>>아이디</option>
				<option value="phone" <c:if test="${param.searchType eq 'phone'}">selected</c:if>>전화번호</option>
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
	
	<!-- 문자 아이콘 - 휴대폰 메시지 전송용 -->
<!--     <a class="nav-link py-0 me-4" href="#" data-bs-toggle="modal" data-bs-target="#sendPhoneMessageModal"> -->
<!-- 	    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-chat-dots-fill" viewBox="0 0 16 16"> -->
<!-- 			<path d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/> -->
<!-- 		</svg> -->
<!--     </a> -->
    
    <!-- 문자 보내기 버튼 -->
    <div class="d-flex justify-content-end">
		<button class="btn btn-outline-primary btn-sm mb-2" data-bs-toggle="modal" data-bs-target="#sendPhoneMessageModal">문자 보내기</button>
	</div>
		
	<div class="row">
		<div class="d-flex justify-content-center">
			
			<table class="table">
				<tr>
					<th class="text-center" style="width: 5%;">번호</th>
					<th class="text-center" style="width: 30%;">문자 내용</th>
					<th class="text-center" style="width: 10%;">발송 일시</th>
					<th class="text-center" style="width: 7%;">아이디</th>
					<th class="text-center" style="width: 7%;">전화번호</th>
				</tr>
				
				<c:forEach var="sList" items="${sList}">
					<tr>
						<td class="text-center">${sList.sms_idx}</td>
						<td class="text-center">${sList.message}</td>
						<td class="text-center">${sList.sent_date}</td>
						<td class="text-center">${sList.member_id}</td>
						<td class="text-center">${sList.recipient}</td>
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
			                        <a class="page-link" aria-label="Previous" href="adminSmsManagement?pageNum=${pageNum - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&laquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Previous" href="adminSmsManagement?pageNum=${pageNum - 1}">
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
	                                <li class="page-item"><a class="page-link" href="adminSmsManagement?pageNum=${i}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${i}</a></li>
	                            </c:when>
	                            <c:otherwise>
	                                <li class="page-item"><a class="page-link" href="adminSmsManagement?pageNum=${i}">${i}</a></li>
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
			                        <a class="page-link" aria-label="Next" href="adminSmsManagement?pageNum=${pageNum + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">
			                            <span aria-hidden="true">&raquo;</span>
			                        </a>
			                    </li>
	                		</c:when>
	                		<c:otherwise>
			                    <li class="page-item">
			                        <a class="page-link" aria-label="Next" href="adminSmsManagement?pageNum=${pageNum + 1}">
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

<!-- 휴대폰 문자 메시지 모달창 -->
<div class="modal fade" id="sendPhoneMessageModal" tabindex="-1" role="dialog" aria-labelledby="sendPhoneMessageModalLabel" style="display: none;" aria-hidden="true">
   <div class="modal-dialog modal-dialog-centered" role="document">
       <div class="modal-content border-0">
           <div class="modal-header bg-primary text-white">
               <h5 class="modal-title text-white">문자메시지 보내기</h5>
           </div>
           <div class="modal-body">
               <div class="notes-box">
                   <div class="notes-content">
                       <form id="sendMessageForm">
                           <div class="col-md-12 mb-3">
                               <div class="ideatitle">
                                   <label>ID</label>
								   <input id="send_memberId" type="text" class="form-control" placeholder="아이디를 입력하세요" onchange="fetchPhoneNumber()">
                               </div>
                           </div>
                           
                           <div class="col-md-12 mb-3">
                               <div class="ideatitle">
                                   <label>Number</label>
								   <input id="send_phoneNum" type="text" class="form-control" placeholder="아이디 입력 시 자동으로 조회됩니다" disabled="disabled">
                               </div>
                           </div>

                           <div class="col-md-12">
                               <div class="ideadescription">
                                   <label>Content</label>
                                   <textarea id="send_content" class="form-control" placeholder="내용을 입력하세요" rows="3" maxlength="80"></textarea>
                               </div>
                           </div>
                        </form>
                     	<div class="modal-footer">
	                        <button id="sendPhoneMessageBtn" class="btn btn-primary">전송</button>
	                        <button class="btn btn-primary" data-bs-dismiss="modal" aria-label="Close">닫기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// 문자 보내기 모달창 호출 시 아이디 입력하면 전화번호 조회해서 자동으로 입력
function fetchPhoneNumber() {
	
    let memberId = document.getElementById("send_memberId").value;

    $.ajax({
        url: '<c:url value="getPhoneNumber"/>',
        method: "post",
        data: { member_id: memberId },
        success: function (data) {
        	
        	console.log(data);
            document.getElementById("send_phoneNum").value = data.trim();
            
        },
        error: function () {
        	console.log('번호 조회 안됨');
        }
    });
}

//문자메시지 발송하기
$(() => {
	
    $('#sendPhoneMessageBtn').click(function(e) {
    	
   	  	e.preventDefault();

   	  	if ($('#send_memberId').val() === '') {
	   	    alert('아이디를 입력해주세요');
	   	    $('#send_memberId').focus();
	   	    return;
   	  	}

   	  	if ($('#send_content').val() === '') {
	   	    alert('내용을 입력해주세요');
	  	    $('#send_content').focus();
	   	    return;
   	  	}
    	
        let modal = $('.modal-content').has(e.target);
        let send_memberId = modal.find('.modal-body input[id="send_memberId"]').val();
        let send_content = modal.find('.modal-body textarea[id="send_content"]').val();

       	// 메시지 DB 저장하기
        $.ajax({
            type: 'post',
            url: '<c:url value="savePhoneMessage"/>',
            data: {
            	
            	member_id: send_memberId,
            	message: send_content
                
            },
            dataType: 'text',
            success: function(data) {
            	
                console.log(data);
                
                if (data == 'true') { 
                	
                    Swal.fire({
					      icon: 'success',
					      title: '문자 메시지 발송 성공!',
					      text: '문자 메시지가 성공적으로 발송되었습니다!',
				    }).then(function(){
				    	// 메시지 보내기 입력창 비우기
	                    modal.find('.modal-body textarea').val('');
	                    modal.find('.modal-body input').val('');
				    });
                    
                } else {
                	
                    alert('존재하지 않는 회원입니다.');
                    
                } 
                
            },
            error: function() {
                alert("문자 메시지 발송 실패!");
            }
        });
        
    });
});
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>