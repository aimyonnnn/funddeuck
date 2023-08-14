<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>펀뜩 공지 사항</title>
	<!-- 공용 css -->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/mypage.css"/>

</head>
<body>
    <!-- 헤더  -->
		<jsp:include page="../Header.jsp"></jsp:include>
    <div class="container text-center mb-4">
    	<p>
    		&nbsp;&nbsp;<br>
    		&nbsp;&nbsp;<br>
    	</p>
    </div>
    <div class="container text-center">
    	<div class="row p-2 mt-3">
	        <span class="fs-1 fw-bold">공지 사항</span>
    	</div>
    </div>
    <div class="container text-center">
		<ul class="nav justify-content-center">
			<li class="nav-item">
				<a class="nav-link active" aria-current="page" href="#">전체</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">공지</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#">이벤트</a>
			</li>
			<li class="nav-item">
				<a class="nav-link disabled" aria-disabled="true">서버 점검 안내</a>
			</li>
		</ul>    	
    </div>
    <div class="container text-center ml-10 mr-10">
	    <form action="" method="post" enctype="multipart/form-data">
			<div class="row justify-content-center">
				<div class="col">
					<table class="table my-2">
		                <tr>
		                    <th class="col">구분<b>*</b></th>
		                    <td class="col">
			                    <input type="radio" id="normal_category" name="no_category" value="1" checked>
			                    <label for="normal_category">일반 공지</label>
			                    <input type="radio" id="top_category" value="2" name="no_category">
			                    <label for="top_category">상위 고정</label>
		                    </td>
		                </tr>
		                <tr>
		                    <th class="col-1">제목<b>*</b></th>
		                    <td><input type="text" class="form-control" name="no_subject" required="required"></td>
		                </tr>
		                <tr>
		                    <th class="col-1">내용<b>*</b></th>
		                    <td class="col">
		                        <textarea class="form-control" name="no_content" rows="8" required="required"></textarea>
		                    </td>
		                </tr>
		                <tr>
		                    <th class="col-1">썸네일 이미지</th>
		                    <td class="col">
		                        <input type="file" class="form-control" name="file" style="width:300px;">
		                    <b>* 용량제한: 5MB이하</b></td>
		                </tr>
					</table>
				</div>
    		</div>
    		<div class="row justify-content-center">
	        	<div class="col-3">
		            <div class="d-grid gap-2">
		                <button type="submit" class="btn btn-primary">등록</button>
		            </div>
				</div>
			</div>
		</form>
    </div>
</body>
</html>