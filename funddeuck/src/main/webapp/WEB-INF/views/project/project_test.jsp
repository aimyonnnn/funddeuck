<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link href="${pageContext.request.contextPath }/resources/css/project.css" rel="styleSheet" type="text/css">
</head>
<body>
    <jsp:include page="../common/project_top.jsp"/>
    <div class="container mt-5">
        <div class="row">
            <div class="col">
                <h4>메이커 페이지 테스트</h4>
                <!-- 버튼을 클릭하면 'maker_id' 값을 변경하여 'makerDetail' 페이지로 이동 -->
                <button onclick="goToMakerDetail(1)" class="btn btn-outline-secondary my-3" style="width: 500px;">makerDetail로 이동하기(1)</button><br>
                <button onclick="goToMakerDetail(2)" class="btn btn-outline-secondary my-3" style="width: 500px;">makerDetail로 이동하기(2)</button><br>
                <input type="text" id="paramTest1" class="form-control my-3" placeholder="파라미터를 입력하세요" style="width: 500px;">
                <button class="btn btn-outline-secondary my-3" onclick="goToCustomMakerDetail()" style="width: 500px;">파라미터를 입력하세요</button>
            </div>
            <div class="col">
                <h4>그래프 테스트</h4>
                <a href="${pageContext.request.contextPath}/projectStatus?maker_idx=1">Test with maker_idx=1</a><br>
                <a href="${pageContext.request.contextPath}/projectStatus?maker_idx=2">Test with maker_idx=2</a><br>
                <input type="text" id="paramTest2" class="form-control my-3" placeholder="Enter maker_idx" style="width: 500px;"><br>
                <button class="btn btn-outline-secondary my-3" onclick="goToCustomMakerStatus()" style="width: 500px;">파라미터를 입력하세요</button>    
            </div>
        </div>
    </div>
    <script>
    // maker_idx 값을 가지고 makerDetail 페이지로 이동
    function goToMakerDetail(maker_idx) {
        let url = 'makerDetail?maker_idx=' + maker_idx;
        location.href = url;
    }
    // 입력한 maker_idx 값을 가져와서 makerDetail 페이지로 이동
    function goToCustomMakerDetail() {
        let paramTest1 = document.getElementById('paramTest1').value;
        let url = 'makerDetail?maker_idx=' + paramTest1;
        location.href = url;
    }

    function goToCustomMakerStatus() {
        let paramTest2 = document.getElementById('paramTest2').value;
        let url = '/funddeuck/projectStatus?maker_idx=' + paramTest2;
        location.href = url;
    }
    </script>

    <script src="${pageContext.request.contextPath}/resources/js/project.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>
