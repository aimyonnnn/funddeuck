<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1">
	<%--line-awesome icon 사용을 위한 스타일 시트 --%>
	<link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <title>관리자 페이지</title>
    <link href="${pageContext.request.contextPath}/resources/css/adminDetail.css" rel="stylesheet" type="text/css"/>
    <link rel="shortcut icon" href="#">
  </head>
  <body>
<!-- --------------------사이드 바 영역----------------------------  -->
   <input type="checkbox" name="" id="sidebar-toggle">
   
    <div class="sidebar">
      <div class="sidebar-main"> 
        <div class="sidebar-user">
            <img src="${pageContext.request.contextPath }/resources/images/adminProfile.png">
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
                <a href="adminMain">
                  <span class="las la-user"></span>
                  관리자 메인
                </a>
              </li>
              <li>
                <a href="adminStatistics">
                  <span class="las la-chart-line"></span>
                  주간 데이터 통계
                </a>
              </li>
            </ul>

          <div class="menu-head">
            <span>MENU</span>
          </div>
          <ul>
            <li>
                <a href="adminMember">
                 <span class="las la-users"></span>
                 회원 관리
                 </a>
            </li>
            <li>
                <a href="adminStore">
                 <span class="las la-store"></span>
                 가게 관리
                 </a>
             </li>
             <li>
                <a href="adminReservation">
                  <span class="las la-history"></span>
                  예약 관리
                </a>
             </li>
            <li>
              <a href="adminAssignment">
                  <span class="las la-exchange-alt"></span>
                 양도 관리
              </a>
            </li>
            <li>
              <a href="adminReview">
                  <span class="las la-comment-dots"></span>
                 리뷰 관리
              </a>
            </li>
           </ul>
           <div class="menu-head">
             <span>2 TEAM</span>
           </div>
            <li><a><span class="las la-crown"></span>박수민</a></li>
            <li><a><span class="las la-laugh"></span>김민진</a></li>
            <li><a><span class="las la-laugh"></span>김보희</a></li>
            <li><a><span class="las la-laugh"></span>이재승</a></li>
            <li><a><span class="las la-laugh"></span>김묘정</a></li>
            <li><a><span class="las la-laugh"></span>이건무</a></li>
        </div>
      </div>
    </div>
<!-- ------------------------------------------------------------------ -->
    <div class="main-content">
      <header>
        <div class="menu-toggle">
          <label for="sidebar-toggle">
            <span class="las la-bars"></span>
          </label>
        </div>
      </header>

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

                <h2>${memberList.size()+ceoMemberList.size()} 명</h2>
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
                  <span>RESTAURANT</span>
                  <small>총 가게 수</small>
                </div>

                <h2>${RestaurantList.size()} 개</h2>

                <small>현재 영업 중인 총 가게 수입니다.</small>
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
                  <span>RESERVATION</span>
                  <small>총 예약 수</small>
                </div>

                <h2>${reservationList.size()} 개</h2>

                <small><a style="color: red;">취소된 예약을 포함한</a> 총 예약 건수입니다.</small>
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
              <h3>오늘 총 예약 수</h3>
            </div>

            <form method="post" class="analytics-chart">
              <div class="chart-circle">
                <h1>${todayReservationCount.count} 개</h1>
              </div>
              <small>예약 일자가 <a style="color: blue;">오늘</a>인 예약 데이터만 카운팅합니다.</small>
            </form>
          </div>

          <div class="jobs">
            <h2>최근 예약
                <small>
                    <a href="adminReservation">전체 예약 확인하기</a>
                    <span class="las la-arrow-right"></span>
                </small>
            </h2>
            
            <div class="table-responsive">
            <table width="100%">
              <tbody>
              <tr>
                  <td><div><span class = "indicator"></span></div></td>
                  <td><div>예약 번호 :</div></td>
                  <td><div>예약 인원 :</div></td>
                  <td><div>예약 날짜 :</div></td>
                  <td><div>총 금액 :</div></td>
                  <td><div><button type="button"
                                   onclick="location.href='adminReservation'">관리</button></div></td>
              </tr>
                  <c:forEach items="${reservationDESCList }" var="reservationDESCList" begin="0" end="4" >
                  <tr>
                  <td></td>
                  <td>&nbsp;${reservationDESCList.r_idx }</td>
                  <td>&nbsp;${reservationDESCList.r_personnel }명</td>
                  <td><fmt:formatDate value="${reservationDESCList.r_date }" pattern="yy-MM-dd HH:mm" /></td>
                  <td><fmt:formatNumber value="${reservationDESCList.r_amount }" />원</td>
                  </tr>
                 </c:forEach>
              </tbody>
            </table>  
          </div>
        </div>
       </div>
      </main>
    </div> 
    
    <label for="sidebar-toggle" class="body-label"></label>
  </body>
</html>