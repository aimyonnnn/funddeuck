<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
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
<!-- sidebar -->
<input type="checkbox" name="" id="sidebar-toggle">
<jsp:include page="../common/admin_side.jsp"/>

<!-- top -->
<div class="main-content">
<jsp:include page="../common/admin_top.jsp"/>

<div class="container">
	<h2 class="fw-bold mt-5">메이커 정보 변경</h2>
	<p class="projectContent">메이커의 모든 정보를 수정 할 수 있습니다.</p>
</div>
		
<div class="container mt-2" style="max-width: 800px;">
	<div class="row">
		<div class="col">
	
			<div class="tab-buttons text-center">
				<button class="btn btn-outline-primary tab-button w-100" data-tab="tab1">메이커 정보변경</button>
				<button class="btn btn-outline-primary tab-button w-100" data-tab="tab2">공지사항 관리</button>
			</div>
				
			<!-- 메이커 정보수정 -->
			<div class="content-area" id="tab1">
				<!-- 폼 태그 -->
				<form action="adminModifyMaker" method="post" id="modifyForm"
					enctype="multipart/form-data">
					<input type="hidden" name="pageNum" value="${param.pageNum}">
					<input type="hidden" name="maker_idx" value="${maker.maker_idx}">
					<table class="table text-center">
						<tr>
							<th style="width: 30%">메이커 이름</th>
							<td style="width: 70%"><input type="text" name="maker_name" class="form-control"
								value="${maker.maker_name}"></td>
						</tr>
						<tr>
							<th>메이커 소개</th>
							<td><input type="text" name="maker_intro" class="form-control"
								value="${maker.maker_intro}"></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="text" name="maker_email" class="form-control"
								value="${maker.maker_email}"></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td><input type="text" name="maker_tel" class="form-control"
								value="${maker.maker_tel}"></td>
						</tr>
						<tr>
							<th>홈페이지</th>
							<td><input type="text" name="maker_url" class="form-control"
								value="${maker.maker_url}"></td>
						</tr>
						<tr>
							<th>사업자등록번호(개인)</th>
							<td><input type="text" name="individual_biz_num" class="form-control"
								value="${maker.individual_biz_num}"></td>
						</tr>
						
						<tr>
							<th>개인사업자명</th>
							<td><input type="text" name="individual_biz_name" class="form-control"
								value="${maker.individual_biz_name}"></td>
						</tr>
							
						<tr>
							<th>사업자등록번호(법인)</th>
							<td><input type="text" name="corporate_biz_num" class="form-control"
								value="${maker.corporate_biz_num}"></td>
						</tr>
						
						<tr>
							<th>법인사업자명</th>
							<td><input type="text" name="corporate_biz_name" class="form-control"
								value="${maker.corporate_biz_name}"></td>
						</tr>
							
						<%-- 파일이 존재할 경우 파일명과 삭제버튼 표시하고, 아니면 파일 등록 버튼 표시 --%>
						
						<tr>
							<th>메이커 사진</th>
							<c:choose>
								<c:when test="${empty maker.maker_file4}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file4" onchange="checkFileInput('file4')">
											<button type="button" id="resetBtn4" onclick="resetFileInput('file4')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(maker.maker_file4, '_')[1] }
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${maker.maker_idx}', '${maker.maker_file4}', 4)">
										</div>
									</td>
								</c:otherwise>										
							</c:choose>
						</tr>
						
						<tr>
							<th>메이커 로고</th>
							<c:choose>
								<c:when test="${empty maker.maker_file5}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file5" onchange="checkFileInput('file5')">
											<button type="button" id="resetBtn5" onclick="resetFileInput('file5')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(maker.maker_file5,'_')[1]}
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${maker.maker_idx}', '${maker.maker_file5}', 5)" >
										</div>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						
						<tr>
							<th>개인신분증</th>
							<c:choose>
								<c:when test="${empty maker.maker_file1}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file1" onchange="checkFileInput('file1')">
											<button type="button" id="resetBtn5" onclick="resetFileInput('file1')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(maker.maker_file1,'_')[1]}
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${maker.maker_idx}', '${maker.maker_file1}', 1)" >
										</div>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						
						<tr>
							<th>사업자등록증(개인)</th>
							<c:choose>
								<c:when test="${empty maker.maker_file2}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											<input type="file" name="file2" onchange="checkFileInput('file2')">
											<button type="button" id="resetBtn5" onclick="resetFileInput('file2')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(maker.maker_file2,'_')[1]}
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${maker.maker_idx}', '${maker.maker_file2}', 2)" >
										</div>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						
						
						<tr>
							<th>사업자등록증(법인)</th>
							<c:choose>
								<c:when test="${empty maker.maker_file3}">
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">	
											<input type="file" name="file3" onchange="checkFileInput('file3')">
											<button type="button" id="resetBtn5" onclick="resetFileInput('file3')" class="btn btn-outline-danger btn-sm me-1" style="display: none;">선택해제</button>
										</div>
									</td>
								</c:when>
								<c:otherwise>
									<td style="text-align: left;">
										<div class="d-flex justify-content-between">
											${fn:split(maker.maker_file3,'_')[1]}
											<input type="button" value="파일삭제" class="btn btn-outline-danger btn-sm me-1"
											onclick="deleteFile('${maker.maker_idx}', '${maker.maker_file3}', 3)" >
										</div>
									</td>
								</c:otherwise>
							</c:choose>
						</tr>
						
					</table>
					<div class="d-flex justify-content-center">
						<input type="submit" value="수정하기" class="btn btn-outline-primary">
					</div>
				</form>
				<!-- 폼 태그 -->
			</div>
			
			<!-- 공지사항 리스트 -->
			<div class="content-area" id="tab2">
			
				<c:if test="${empty mList}">
					<div class="d-flex justify-content-center mt-5">
			        	<p>등록된 공지사항이 없습니다.&nbsp;&nbsp;<a href="makerDetail?maker_idx=${param.maker_idx}">공지사항 등록하러 가기</a></p>
			        </div>
				</c:if>
			
				<div class="accordion" id="accordionExample">
				    <c:forEach var="mList" items="${mList}">
				        <div class="accordion-item">
				            <h2 class="accordion-header" id="heading${mList.maker_board_idx}">
				                <button class="accordion-button bg-primary text-white" type="button" data-bs-toggle="collapse"
				                    data-bs-target="#collapse${mList.maker_board_idx}" aria-expanded="true"
				                    aria-controls="collapse${mList.maker_board_idx}">
				                    ${mList.maker_board_subject}
				                </button>	
				            </h2>
				            <div id="collapse${mList.maker_board_idx}" class="accordion-collapse collapse show"
				                aria-labelledby="heading${mList.maker_board_idx}" data-bs-parent="#accordionExample">
				                <div class="accordion-body">
				                	<form action="">
					                	<table class="table text-center">
					                		<tr>
					                			<td style="width: 20%">작성내용</td>
					                			<td style="width: 80%">${mList.maker_board_content}</td>
					                		</tr>
					                		<tr>
					                			<td>작성일자</td>
					                			<td><fmt:formatDate value="${mList.maker_board_regdate}" pattern="yy-MM-dd HH:mm" /></td>
					                		</tr>
					                		<tr>
					                			<td>첨부파일</td>
					                			<td>
					                				<c:choose>
					                					<c:when test="${not empty mList.maker_board_file1}">
							                				<a href="${pageContext.request.contextPath}/resources/upload/${mList.maker_board_file1}" download="${fn:split(mList.maker_board_file1, '_')[1]}">
												                ${fn:split(mList.maker_board_file1, '_')[1]}
												            </a>
					                					</c:when>
					                					<c:otherwise>
					                						첨부파일 없음
					                					</c:otherwise>
					                				</c:choose>
					                			</td>
					                		</tr>
					                		<tr>
					                			<td colspan="2" class="text-center">
<!-- 						                			<input type="button" value="수정하기" class="btn btn-outline-primary btn-sm" -->
<%-- 													onclick="updateMakerBoard(${mList.maker_board_idx})"> --%>
						                			<input type="button" value="삭제하기" class="btn btn-outline-primary btn-sm"
													onclick="deleteMakerBoard(${mList.maker_board_idx})">
					                			</td>
					                		<tr>
					                	</table>
				                	</form>
				                </div>
				            </div>
				        </div>
				    </c:forEach>
				</div>
				
			</div>
			
				
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
	
    $(".tab-button").click(function() {
    	
        var tabId = $(this).data("tab");
        $(".content-area").removeClass("active");
        $("#" + tabId).addClass("active");

        // 탭 버튼 클릭시 active 효과 설정
        $(".tab-button").removeClass("active"); // 모든 탭 버튼의 active 클래스 제거
        $(this).addClass("active"); // 클릭한 탭 버튼에 active 클래스 추가
        
    });

    // URL 파라미터 확인하여 탭 활성화 설정
    let urlParams = new URLSearchParams(window.location.search);
    let activeTab = urlParams.get("tab");

    // 모든 탭 버튼의 active 클래스 제거
    $(".tab-button").removeClass("active");

    if (activeTab === "1" || activeTab === "2") {
    	
        // 클릭한 탭 버튼에 active 클래스 추가
        $(".tab-button[data-tab='tab" + activeTab + "']").addClass("active");
        // 해당 탭의 컨텐트 영역에 active 클래스 추가
        $(".content-area").removeClass("active");
        $("#tab" + activeTab).addClass("active");
        
    } else {
    	
        // 기본적으로 활성화될 탭 설정 (여기선 1번 탭으로 설정)
        $(".tab-button[data-tab='tab1']").addClass("active");
        $(".content-area").removeClass("active");
        $("#tab1").addClass("active");
        
    }
    
});

// 파일 실시간 삭제
function deleteFile(maker_idx, fileName, fileNumber) {
	
	if(confirm('파일을 삭제 하시겠습니까?')) {
		
		$.ajax({
			type: 'post',
			url: "<c:url value='deleteFile'/>",
			data: {
				maker_idx: maker_idx,
				fileName: fileName,
				fileNumber: fileNumber
			},
			success: function(result){
				
				if(result.trim() === 'success') {
					// 파일 삭제 성공 시
					alert('파일이 삭제되었습니다.');
					location.reload();
				} else {
					alert('파일 삭제 실패!');
				}
			},
			error: function (error) {
				console.log(error);
			}
		});
	}
}

// 개별 파일 첨부 입력 필드 초기화 함수
function resetFileInput(inputName) {
	let fileInput = $('input[name="' + inputName + '"]');
	fileInput.val(null);
	alert('파일이 삭제되었습니다.');
	fileInput.next().hide(); // "지우기" 버튼 숨김
}

// 파일 첨부 입력 필드 상태 감지 함수
function checkFileInput() {
	let fileInputs = $('input[type="file"]');
	
	fileInputs.each(function() {
		
	   	if (this.files.length > 0) {
	     	$(this).next().show(); // "지우기" 버튼 표시
	   	} else {
	     	$(this).next().hide(); // "지우기" 버튼 숨김
	  	}
	   	
	});
}

// 페이지 로드 시 파일 첨부 입력 필드 상태 감지 함수 호출
$(document).ready(function() {
	checkFileInput();
});

// 공지사항 게시글 삭제하기
function deleteMakerBoard(maker_board_idx) {
	
	if(confirm('공지사항을 삭제하시겠습니까?')) {
		
		$.ajax({
			method: 'post',
			url: "<c:url value='deleteMakerBoard'/>",
			data: { 
				maker_board_idx: maker_board_idx
			},
			success: function(data) {
				
				console.log(data);
				
				if(data.trim() == 'true') {
					
					alert("공지사항이 성공적으로 삭제되었습니다.");
					location.href='adminMakerDetail?maker_idx=${param.maker_idx}&tab=2';
					
				}
				
			},
			error: function(){
				console.log('공지사항 삭제에 실패하였습니다.');
			}
		});
		
	}
}
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>