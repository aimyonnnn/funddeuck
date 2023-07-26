<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Admin</title>
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1">
    <!--bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jquery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- line-awesome -->
	<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
	<!-- css -->
    <link href="${pageContext.request.contextPath}/resources/css/adminDetail.css" rel="stylesheet" type="text/css"/>
    <link rel="shortcut icon" href="#">
  </head>
  <body>

   <!-- 사이드바 -->
   <input type="checkbox" name="" id="sidebar-toggle">
   
    <div class="sidebar">
      <div class="sidebar-main"> 
        <div class="sidebar-user">
            <img src="${pageContext.request.contextPath}/resources/images/adminProfile.png">
          <div>
            <span>관리자 페이지</span>
          </div>
        </div>

        <div class="sidebar-menu">
          <div class="menu-head">
              <span></span>
            </div>
            <ul>
              <li>
                <a href="./">
                  <span class="las la-home"></span>
                  홈페이지
                </a>
              </li>
              <li>
                <a href="admin">
                  <span class="las la-user"></span>
                  관리자 메인
                </a>
              </li>
              <li>
                <a href="adminChart">
                  <span class="las la-chart-line"></span>
                  데이터 분석
                </a>
              </li>
            </ul>

          <div class="menu-head">
            <span>MENU</span>
          </div>
          <ul>
            <li>
                <a href="adminProjectList">
                 <span class="las la-store"></span>
                 프로젝트 관리
                 </a>
             </li>
            <li>
                <a href="adminMember">
                 <span class="las la-users"></span>
                 회원 관리
                 </a>
            </li>
            <li>
              <a href="adminPayment">
                  <span class="las la-exchange-alt"></span>
                 결제 관리
              </a>
            </li>
             <li>
                <a href="#">
                  <span class="las la-history"></span>
                  점검중
                </a>
             </li>
            <li>
              <a href="#">
                  <span class="las la-comment-dots"></span>
                 점검중
              </a>
            </li>
           </ul>
           <div class="menu-head">
             <span>2 TEAM</span>
           </div>
           <ul>
	           <li><a><span class="las la-crown"></span>박수민</a></li>
	           <li><a><span class="las la-laugh"></span>김민진</a></li>
	           <li><a><span class="las la-laugh"></span>김보희</a></li>
	           <li><a><span class="las la-laugh"></span>이재승</a></li>
	           <li><a><span class="las la-laugh"></span>김묘정</a></li>
	           <li><a><span class="las la-laugh"></span>이건무</a></li>
           </ul>
        </div>
      </div>
    </div>
<!-- ------------------------------------------------------------------ -->
    <div class="main-content">
<!--       <header> -->
<!--         <div class="menu-toggle"> -->
<!--           <label for="sidebar-toggle"> -->
<!--             <span class="las la-bars"></span> -->
<!--           </label> -->
<!--         </div> -->
     	   <jsp:include page="../common/admin_top.jsp"/>  
<!--       </header> -->

      <main>
        <div class="page-header">
          <div>
            <h1>관리자 페이지</h1>
            <small>각종 통계 확인 및 관리</small>
          </div>
        </div> 

        <div class="cards">
          <div class="card-single">
            <div class="card-flex">
              <div class="card-into">
                <div class="card-head">
                  <span>MEMBER</span>
                  <small>총 회원 수</small>
                </div>

                <h2>11 명</h2>
                <small><a style="color: red;">활동 정지된 회원을 포함한</a> 총 회원 수입니다.</small>
              </div>
              <div class="card-chart danger">
                <span class="las la-chart-line"></span>
              </div>
            </div>
          </div>

          <div class="card-single">
            <div class="card-flex">
              <div class="card-into">
                <div class="card-head">
                  <span>Project</span>
                  <small>총 프로젝트 수</small>
                </div>

                <h2>5개</h2>

                <small>현재 등록된 총 프로젝트 수입니다.</small>
              </div>
              <div class="card-chart success">
                <span class="las la-chart-line"></span>
              </div>
            </div>
          </div>

          <div class="card-single">
            <div class="card-flex">
              <div class="card-into">
                <div class="card-head">
                  <span>SUPPORTER</span>
                  <small>오늘 등록된 서포터 수</small>
                </div>

                <h2>7명</h2>

                <small><a style="color: red;">취소된 서포터를 포함한</a> 총 서포터 수입니다.</small>
              </div>
              <div class="card-chart yellow">
                <span class="las la-chart-line"></span>
              </div>
            </div>
          </div>
        </div>

        <div class="jobs-grid">
          <div class="analytics-card">
            <div class="analytics-head">
              <h3>오늘 총 서포터 수</h3>
            </div>

            <form method="post" class="analytics-chart">
              <div class="chart-circle">
                <h1>명</h1>
              </div>
              <small>결제 일자가<a style="color: blue;"> 오늘</a>인 서포터 수를 카운팅합니다.</small>
            </form>
          </div>

          <div class="jobs">
            <h2>최근 프로젝트
                <small>
                    <a href="adminProject">전체 프로젝트 확인하기</a>
                    <span class="las la-arrow-right"></span>
                </small>
            </h2>
            
            <div class="table-responsive">
            <table width="100%">
              <tbody>
              <tr>
                  <td><div><span class = "indicator"></span></div></td>
                  <td><div>프로젝트번호 :</div></td>
                  <td><div>프로젝트명 :</div></td>
                  <td><div>승인 상태 :</div></td>
                  <td><div>등록 일자 :</div></td>
                  <td><div><button type="button"
                                   onclick="location.href='adminProject'">관리</button></div></td>
              </tr>
                  <tr>
	                  <td></td>
	                  <td>&nbsp;</td>
	                  <td>&nbsp;</td>
	                  <td>&nbsp;</td>
	                  <td>&nbsp;</td>
                  </tr>
              </tbody>
            </table>  
          </div>
        </div>
       </div>
      </main>
    </div> 
    
    <label for="sidebar-toggle" class="body-label"></label>
    
    <!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    
  </body>
</html>