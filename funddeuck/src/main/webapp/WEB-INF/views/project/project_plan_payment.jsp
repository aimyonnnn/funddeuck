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
<c:if test="${project.project_plan eq 1}">
	<c:set var="project_plan" value="FUNDDEUCK회원제" />
	<c:set var="project_plan_payment" value="7800" />
</c:if>
<c:if test="${project.project_plan ne 1}">
	<c:set var="project_plan" value="INFLUENCER회원제" />
	<c:set var="project_plan_payment" value="5800" />
</c:if>

<button type="button" class="btn btn-outline-primary btn-sm mx-2" data-bs-toggle="modal" data-bs-target="#orderModal" style="display: none;">결제하기</button>
	
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
                <c:choose>
                	<c:when test="${project.project_plan eq 1}">
               			<td>FUNDDEUCK 회원제</td>
                	</c:when>
					<c:otherwise>
               			<td>INFLUENCER 회원제</td>
					</c:otherwise>                	
                </c:choose>
              </tr>
              <tr>
                <th scope="row" width="150"><label for="pay">결제금액</label></th>
               	<c:choose>
	               	<c:when test="${project.project_plan eq 1}">
             			<td>7800</td>
	               	</c:when>
					<c:otherwise>
	              		<td>5800</td>
					</c:otherwise>                	
                </c:choose>
              </tr>
              <tr>
                <th scope="row"><label for="userName">이름</label></th>
                <td>${project.project_representative_name}</td>
              </tr>
              <tr>
                <th scope="row"><label for="userTel">전화번호</label></th>
                <td>${member.member_phone}</td>
              </tr>
              <tr>
                <th scope="row"><label for="userEmail">이메일</label></th>
                <td>${project.project_representative_email}</td>
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
   
   let IMP = window.IMP;
   IMP.init("imp61372336");
   
    $('#requestPay').on('click', function() {
    	
        IMP.request_pay({
        	
			pg: "kakopay",
			pay_method: "card",
			merchant_uid: createOrderNum(),
			name: "${project_plan}",
			amount: "${project_plan_payment}",
			buyer_email: "${project.project_representative_email}",
			buyer_name: "${project.project_representative_name}"
			
       },
       function(rsp) {
       console.log(rsp);
         
         // ================= 결제 성공 시 =================
       		if(rsp.success) {
	     		console.log('결제가 완료되었습니다.');
	        
	       		let payment_num = rsp.imp_uid; 					// 아임포트 주문번호
	 		 	let p_orderNum = rsp.merchant_uid; 				// 주문번호-자동생성한것
	 		 	let payment_total_price = rsp.paid_amount; 		// 결제가격
	        
		        // ================= DB 작업 =================
		        // 1. project_approve_status = 5일 경우 결제테이블 결제 정보 저장하기
		        // 2. 프로젝트 상태컬럼을 5-결제완료 상태로 변경(펀딩+ 페이지에 출력 가능한 상태)
		        
		        $.ajax({
					method: 'post',
					url: "<c:url value='completePaymentStatus'/>",
					data: {
						
						project_idx: ${project.project_idx},
						project_approve_status: 5,
						payment_num: payment_num,
						p_orderNum: p_orderNum,
						payment_total_price: payment_total_price,
						
					},
					success: function(data){
						
						if(data.trim() == 'true') {
							
							Swal.fire({
								icon: 'success',
								title: '프로젝트 요금제 결제완료',
								text: '펀딩+ 페이지에서 프로젝트를 확인해주세요!'
							}).then(function(data) {
								
								if(data) {
									console.log('결제 완료되었습니다.');
								}
								
								// 결제 완료 시 이동 할 페이지
								$('#orderModal').modal('hide');
								location.href='confirmNotification';
								
							});
							
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

// 결제 모달창 자동으로 실행
$(document).ready(function () {
    let projectStatus = ${project.project_approve_status};
    if (projectStatus === 3) {
        $('#orderModal').modal('show');
    }

    $('#orderModal .btn-close').on('click', function () {
        history.back();
    });
});
</script>
<!-- bootstrap -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>