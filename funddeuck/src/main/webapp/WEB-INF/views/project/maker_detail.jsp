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
.maker-img {
  max-height: 200px; /* 원하는 높이 값으로 변경 */
  object-fit: cover; /* 이미지가 캐러셀 영역에 꽉 차도록 조절 */
}
</style>
</head>
<body>
<jsp:include page="../Header.jsp"></jsp:include>
<div class="container" style="max-width: 600px;">
	<div class="row">
		<div class="col">

			<!-- 메이커 이미지 -->
			<div class="d-flex justify-content-center my-2">
				<img
					src="${pageContext.request.contextPath}/resources/upload/${maker.maker_file4}"
					alt="메이커 사진을 업로드 해주세요" class="img-fluid" style="max-height: 400px;">
			</div>
			
			<div class="my-4">
				<h4>
					<b>${maker.maker_name}</b>
				</h4>
				<!-- 메이커 소개 -->
				<p>${maker.maker_intro}</p>

				<div class="container">
					<div class="row">
						<div class="col-sm-6">
						
							<div>
								<!-- 만족도 -->
								<a class="star-rating"> <svg
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-star-fill"
										viewBox="0 0 16 16">
			            				<path
											d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z" />
			          				</svg>만족도:&nbsp;<span>4.0</span>
								</a> <br>
								<!-- 서포터 수 -->
								<a class="supporters"> <svg
										xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-person-plus-fill"
										viewBox="0 0 16 16">
			           					<path
											d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
			            				<path fill-rule="evenodd"
											d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5z" />
			          				</svg>서포터:&nbsp;<span>19명</span>
								</a>
							</div>
							
						</div>
					</div>
				</div>
				
				<%-- maker 테이블의 member_idx와 세션아이디로 조회한 member_idx가 같을 때 수정하기 버튼 출력 --%>
				<c:if test="${sessionScope.sId != null && (maker.member_idx eq member_idx)}">
				    <div class="d-flex justify-content-end">
				        <form action="modifyMakerForm" method="post">
				            <input type="hidden" name="maker_idx" value="${maker.maker_idx}" />
				            <button type="submit" class="btn btn-outline-primary">메이커 페이지 수정하기</button>
				        </form>
				    </div>
				</c:if>
				
				<!-- 팔로우 -->
				<div class="text-center my-2">
					<button class="btn btn-primary w-100">
						+Follow<span></span>
					</button>
				</div>

				<!-- 탭 -->
				<div class="tab-buttons text-center">
					<button class="btn btn-outline-primary tab-button w-100 active"
						data-tab="tab1">프로젝트</button>
					<button class="btn btn-outline-primary tab-button w-100"
						data-tab="tab2">공지사항</button>
					<button class="btn btn-outline-primary tab-button w-100"
						data-tab="tab3">메이커정보</button>
				</div>

				<!-- 메이커의 프로젝트 리스트 출력 -->
				<div class="content-area" id="tab1">
					<div>
						<c:forEach var="pList" items="${pList}">
							<div class="container">
								<div class="row">
									<div class="card col-md-6 col-lg-12">
									  <img src="${pageContext.request.contextPath}/resources/upload/${pList.project_image}"
											 alt="project_image를 업로드 해주세요. 후원하기 클릭 시 상세페이지로 이동합니다." class="img-fluid maker-img mt-2">
									  <div class="card-body">
									    <div class="card-text makerSubject">${pList.project_subject}</div>
									    <div class="card-text">${pList.project_semi_introduce}</div>
									    <div>
									    	<button type="button" class="btn btn-outline-primary w-100 mt-2"
									    	onclick="location.href='fundingDetail?project_idx=${pList.project_idx}'">프로젝트 후원하기</button>
									    </div>
									  </div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
				
				<!-- 공지사항 -->
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
				                        </table>
				                    </div>
				                </div>
				            </div>
				        </c:forEach>
				    </div>
				</div>

				<!-- 메이커 정보 -->
				<div class="content-area" id="tab3">
					<table class="table text-center">
						<tr>
							<th>상호명</th>
							<td>${maker.maker_name}</td>
						</tr>
						<tr>
							<th>메이커 소개</th>
							<td>${maker.maker_intro}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${maker.maker_email}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${maker.maker_tel}</td>
						</tr>
						<tr>
							<th>홈페이지</th>
							<td>${maker.maker_url}</td>
						</tr>
						<c:choose>
							<c:when test="${not empty maker.corporate_biz_num or not empty maker.individual_biz_num}">
								<tr>
									<th>사업자등록번호</th>
									<c:if test="${not empty maker.corporate_biz_num}">
										<td>${maker.corporate_biz_num}</td>
									</c:if>
									<c:if test="${not empty maker.individual_biz_num}">
										<td>${maker.individual_biz_num}</td>
									</c:if>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th>사업자등록번호</th>
									<td>120-88-00767</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
// 탭 버튼 클릭 시
$(document).ready(function() {
	
	$("#tab1").addClass("active");
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

// 수정하기 버튼 클릭 시 메이커 수정하기 폼으로 이동
function redirectToModifyMakerForm(makerIdx) {
	var newUrl = 'modifyMakerForm?maker_idx=' + makerIdx;
	window.location.href = newUrl;
}
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
