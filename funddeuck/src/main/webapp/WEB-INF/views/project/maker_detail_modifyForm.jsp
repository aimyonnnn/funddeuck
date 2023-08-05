<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Maker</title>
	<!-- bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jquery -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.0.js"></script>
	<!-- font awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- css -->
	<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="styleSheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>
</head>
<body>
<jsp:include page="../Header.jsp"></jsp:include>

<div class="container" style="max-width: 600px;">
	<div class="row">
		<div class="col">

			<!-- 메이커 이미지 출력 -->
			<div class="d-flex justify-content-center my-2">
				<img src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file4}"
				     alt="메이커 사진을 업로드 해주세요" class="img-fluid" style="max-height: 400px;">
			</div>

			<div class="my-4">

				<div class="text-center my-2">
					<button class="btn btn-primary w-100">
						+Follow<span></span>
					</button>
				</div>

				<div class="tab-buttons text-center">
					<button class="btn btn-outline-primary tab-button w-100" data-tab="tab1">공지사항 작성하기</button>
					<button class="btn btn-outline-primary tab-button w-100 active" data-tab="tab2">공지사항 리스트</button>
					<button class="btn btn-outline-primary tab-button w-100 " data-tab="tab3">메이커정보 수정하기</button>
				</div>

				<!-- 공지사항 작성하기 -->
				<div class="content-area" id="tab1">
					<form action="makerBoardWritePro" method="post" enctype="multipart/form-data">
					   	<!-- hidden 필드 추가 -->
        				<input type="hidden" id="project_idx" name="project_idx" value="">
						<input type="hidden" name="maker_idx" value="${maker.maker_idx}">
						<table class="table">
							<tr class="text-center">
								<th>프로젝트</th>
								<td>
									<select id="projectSelect" class="form-select">
										<option value="">선택</option>
									</select>
								</td>
							</tr>
							<tr class="text-center">
								<th>제목</th>
								<td><input type="text" name="maker_board_subject" id="maker_board_subject" class="form-control"></td>
							</tr>
							<tr class="text-center">
								<th>내용</th>
								<td>
									<textarea cols="10" rows="10" name="maker_board_content" id="maker_baord_content" class="form-control"></textarea>
								</td>
							</tr>
							<tr>
								<th class="text-center">첨부파일</th>
								<td><input type="file" name="file1"></td>
							</tr>
						</table>
						<div class="d-flex justify-content-center">
							<input type="submit" value="글 등록하기" class="btn btn-outline-primary">
						</div>
					</form>
				</div>
				
				<!-- 공지사항 리스트 -->
				<div class="content-area" id="tab2">
				
					<div class="accordion" id="accordionExample">
					
					    <c:forEach var="mList" items="${mList}">
					        <div class="accordion-item">
					            <h2 class="accordion-header" id="heading${mList.maker_board_idx}">
					                <button class="accordion-button" type="button" data-bs-toggle="collapse"
					                    data-bs-target="#collapse${mList.maker_board_idx}" aria-expanded="true"
					                    aria-controls="collapse${mList.maker_board_idx}">
					                    ${mList.maker_board_subject}
					                </button>	
					            </h2>
					            <div id="collapse${mList.maker_board_idx}" class="accordion-collapse collapse show"
					                aria-labelledby="heading${mList.maker_board_idx}" data-bs-parent="#accordionExample">
					                <div class="accordion-body">
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
<!-- 					                		<tr> -->
<!-- 					                			<td colspan="2" class="text-center"> -->
<!-- 						                			<input type="button" value="삭제하기" class="btn btn-outline-danger btn-sm" -->
<%-- 													onclick="deleteMakerBoard(${mList.maker_board_idx})"> --%>
<!-- 					                			</td> -->
<!-- 					                		<tr> -->
					                	</table>
					                </div>
					            </div>
					        </div>
					    </c:forEach>
					    
					</div>
				</div>
				
				<!-- 메이커 정보 -->
				<div class="content-area" id="tab3">
					<!-- 폼 태그 -->
					<form action="modifyMaker" method="post" id="modifyForm"
						enctype="multipart/form-data">
						<input type="hidden" name="maker_idx" value="${maker.maker_idx}">
						<table class="table text-center">
							<tr>
								<th>상호명</th>
								<td><input type="text" name="maker_name" class="form-control"
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
							
							<%-- 파일이 존재할 경우 파일명과 삭제버튼 표시하고, 아니면 파일 등록 버튼 표시 --%>
							
							<tr>
								<th>메이커 사진</th>
								<c:choose>
									<c:when test="${empty maker.maker_file4}">
										<td style="text-align: left;">
											<input type="file" name="file4" onchange="checkFileInput('file4')">
											<button type="button" id="resetBtn4" onclick="resetFileInput('file4')" class="btn btn-outline-danger btn-sm" style="display: none;">선택해제</button>
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
											<input type="file" name="file5" onchange="checkFileInput('file5')">
											<button type="button" id="resetBtn5" onclick="resetFileInput('file5')" class="btn btn-outline-danger btn-sm" style="display: none;">선택해제</button>
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
						</table>
						<div class="d-flex justify-content-center">
							<input type="submit" value="수정하기" class="btn btn-outline-primary">
						</div>
					</form>
					<!-- 폼 태그 -->
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 공지사항 수정 모달 -->
<div class="modal fade" id="modifyNoticeBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="noticeStaticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="noticeStaticBackdropLabel">공지사항 수정하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="noticeDetail">
	     <form action="modifyMakerBoard" method="post" enctype="multipart/form-data">
			<input type="hidden" name="maker_idx" value="${maker.maker_idx}">
			<table class="table">
				<tr class="text-center">
					<th>제목</th>
					<td><input type="text" name="maker_board_subject" value="" class="form-control"></td>
				</tr>
				<tr class="text-center">
					<th>내용</th>
					<td>
						<textarea cols="10" rows="10" name="maker_board_content" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<th class="text-center">첨부파일</th>
					<td><input type="file" name="file1"></td>
				</tr>
			</table>
			<div class="d-flex justify-content-center">
				<input type="submit" value="수정하기" class="btn btn-outline-primary">
			</div>
		</form>
      </div>
    </div>
  </div>
</div>

<script>
//탭 버튼 클릭 시
$(document).ready(function() {
	
	$("#tab2").addClass("active");
	$(".tab-button").click(function() {
		
		var tabId = $(this).data("tab");
		$(".content-area").removeClass("active");
		$("#" + tabId).addClass("active");
		
	});
	
});

// 탭 버튼 클릭시 active 효과
$(document).ready(function() {
	
	// 버튼1 클릭 시
	$(".tab-button[data-tab='tab1']").click(function() {
		$(".tab-button[data-tab='tab1']").addClass("active");
	  	$(".tab-button[data-tab='tab2']").removeClass("active");
	  	$(".tab-button[data-tab='tab3']").removeClass("active");
	});
	
	// 버튼2 클릭 시
	$(".tab-button[data-tab='tab2']").click(function() {
	  	$(".tab-button[data-tab='tab1']").removeClass("active");
	  	$(".tab-button[data-tab='tab2']").addClass("active");
	  	$(".tab-button[data-tab='tab3']").removeClass("active");
	});
	
	// 버튼3 클릭 시
	$(".tab-button[data-tab='tab3']").click(function() {
	  	$(".tab-button[data-tab='tab1']").removeClass("active");
	 	$(".tab-button[data-tab='tab2']").removeClass("active");
	 	$(".tab-button[data-tab='tab3']").addClass("active");
	});
	
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
				//에러 처리
				console.log(error);
			}
		});	// ajax
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
					location.reload();
					
				}
				
			},
			error: function(){
				console.log('공지사항 삭제에 실패하였습니다.');
			}
		});
		
	}
}

//서버에서 프로젝트 리스트를 받아와서 셀렉트 박스에 추가
function getProjectList() {
	
	let selectElement = document.getElementById("projectSelect");
	
		$.ajax({
			method: 'post',
			data: {
				maker_idx: ${maker_idx}
			},
			url: '<c:url value="getProjectListByMakerIdx"/>',
		  	success: function (data) {
		  		
		  		console.log(data);
		  		
		  		data.forEach((project) => {
			        let option = document.createElement("option");
			        option.value = project.project_idx;
			        option.textContent = project.project_subject;
			        selectElement.appendChild(option);
			    });
			    
		  		// 프로젝트 선택 값이 변경될 때 이벤트 처리
	            selectElement.addEventListener("change", function () {				// #projectSelect에 이벤트 리스너 등록
	                let selectedValue = selectElement.value;						// 셀렉트박스에 선택된 값을 변수에 저장하고
	                let hiddenField = document.getElementById("project_idx");		// id가 project_idx인 값을 선택 후
	                hiddenField.value = selectedValue;								// 셀렉트박스에 선택된 값을 히든필드에 저장한다!
	            });
			    
		  	},
		  	error: function (error) {
		    console.error(error);
		  }
	  });
		
}

// 페이지 로드 호 getProjectList 실행하기
// 셀렉트박스에 프로젝트 리스트를 출력
$(() => {
		
	getProjectList();	
	
});
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>