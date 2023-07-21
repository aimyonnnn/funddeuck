<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!--bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- CSS -->
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
</head>
<body>
	<div class="container mt-5">
		<div class="row">
			<div class="col">
				<!-- 버튼을 클릭하면 'maker_id' 값을 변경하여 'makerDetail' 페이지로 이동 -->
			    <button onclick="goToMakerDetail(1)">makerDetail로 이동하기(1)</button><br>
				<button onclick="goToMakerDetail(2)" class="my-3">makerDetail로 이동하기(2)</button><br>
				<button onclick="goToMakerDetail(3)">Maker 3</button><br>
			</div>
		</div>
	</div>
	
	<script>
    // 함수를 통해 버튼을 클릭하면 해당 maker_idx 값을 가지고 makerDetail 페이지로 이동
    function goToMakerDetail(maker_idx) {
      var url = 'makerDetail?maker_idx=' + maker_idx;
      location.href = url;
    }
  	</script>
	
	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>