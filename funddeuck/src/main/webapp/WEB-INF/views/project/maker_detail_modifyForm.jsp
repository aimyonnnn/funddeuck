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
	<style>
    .content-area {
        /* 원하는 크기 값으로 설정 */
        width: 100%; /* 예시로 가로폭을 100%로 설정 */
        max-width: 800px; /* 최대 가로폭을 800px로 설정 */
    }
</style>
</head>
<body>
<jsp:include page="../Header.jsp"></jsp:include>

<div class="container" style="max-width: 600px;">
	<div class="row">
		<div class="col">

			<div class="my-4">
			
				<div class="d-flex justify-content-center">
					<button class="btn btn-outline-primary" onclick="location.href='makerDetail?maker_idx=${param.maker_idx}'">뒤로가기</button>
				</div>
				
				<div class="tab-buttons text-center">
					<button class="btn btn-outline-primary tab-button w-100" data-tab="tab1">공지사항 작성하기</button>
					<button class="btn btn-outline-primary tab-button w-100" data-tab="tab2">메이커정보 수정하기</button>
				</div>
				
				<!-- 공지사항 작성하기 -->
				<div class="content-area" id="tab1">
					<form action="makerBoardWritePro" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
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
								<td><input type="text" name="maker_board_subject" id="maker_board_subject" class="form-control" placeholder="제목을 입력해주세요"></td>
							</tr>
							<tr class="text-center">
								<th>내용</th>
								<td>
									<textarea cols="10" rows="10" name="maker_board_content" id="maker_board_content" class="form-control" placeholder="내용을 입력해주세요"></textarea>
								</td>
							</tr>
							<tr>
								<th class="text-center">첨부파일</th>
								<td><input type="file" name="file1"></td>
							</tr>
						</table>
						<div class="d-flex justify-content-center">
							<input type="submit" value="등록하기" class="btn btn-outline-primary">
						</div>
					</form>
				</div>
				
				<!-- 공지사항 리스트 -->
<!-- 				<div class="content-area" id="tab2"> -->
<!-- 					<div id="note-full-container" class="note-has-grid row"> -->
<%-- 					    <c:forEach var="mList" items="${mList}"> --%>
<!-- 					        <div class="col-md-12 single-note-item all-category mb-4"> -->
<!-- 					            <div class="card"> -->
<!-- 					                <div class="card-header"> -->
<%-- 					                    <h5 class="card-title"><b>${mList.maker_board_subject}</b></h5> --%>
<%-- 					                    작성 시간: <fmt:formatDate value="${mList.maker_board_regdate}" pattern="yy-MM-dd HH:mm" /> --%>
<!-- 					                </div> -->
<!-- 					                <div class="card-body"> -->
<%-- 					                    <p class="card-text">${mList.maker_board_content}</p> --%>
<!-- 					                    <div style="text-align: right;"> -->
<%-- 					                        <c:choose> --%>
<%-- 					                            <c:when test="${not empty mList.maker_board_file1}"> --%>
<%-- 					                                <a href="${pageContext.request.contextPath}/resources/upload/${mList.maker_board_file1}" download="${fn:split(mList.maker_board_file1, '_')[1]}"> --%>
<%-- 					                                    첨부파일: ${fn:split(mList.maker_board_file1, '_')[1]} --%>
<!-- 					                                </a> -->
<%-- 					                            </c:when> --%>
<%-- 					                            <c:otherwise> --%>
<!-- 					                                첨부파일 없음 -->
<%-- 					                            </c:otherwise> --%>
<%-- 					                        </c:choose> --%>
<!-- 					                    </div> -->
<!-- 					                </div> -->
<!-- 					            </div> -->
<!-- 					        </div> -->
<%-- 					    </c:forEach> --%>
<!-- 					</div> -->
<!-- 				</div> -->
				
				<!-- 메이커 정보 -->
				<div class="content-area" id="tab2">
					<!-- 폼 태그 -->
					<form action="modifyMaker" method="post" id="modifyForm"
						enctype="multipart/form-data">
						<input type="hidden" name="maker_idx" value="${maker.maker_idx}">
						<table class="table text-center">
							<tr>
								<th>메이커 이름</th>
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
								<td><input type="number" name="maker_tel" class="form-control"
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

// 공지사항 등록 시 유효성 검사
function validateForm() {
    var projectSelect = document.getElementById("projectSelect");
    var makerBoardSubject = document.getElementById("maker_board_subject");
    var makerBoardContent = document.getElementById("maker_board_content");

    if (projectSelect.value === "") {
        alert("프로젝트를 선택해주세요.");
        projectSelect.focus();
        return false;
    }
    if (makerBoardSubject.value === "") {
        alert("제목을 입력해주세요.");
        makerBoardSubject.focus();
        return false;
    }
    if (makerBoardContent.value.trim() === "") {
        alert("내용을 입력해주세요.");
        makerBoardContent.focus();
        return false;
    }

    return true;
}
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>