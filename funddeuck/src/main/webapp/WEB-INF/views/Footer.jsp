<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<style>
  /* 스타일 시트 */
  footer {
    background-color: #f8f8f8;
    padding: 20px;
    font-size: 14px;
    color: #888;
  }

  .footer-logo {
    display: block;
    margin: 0 auto 10px;
    max-width: 100px;
  }

  .footer-links {
    list-style: none;
    padding: 0;
    margin-bottom: 10px;
  }

  .footer-links li {
    display: inline-block;
    margin: 0 10px;
  }

  .footer-links a {
    color: #888;
    text-decoration: none;
  }

  .footer-links a:hover {
    text-decoration: underline;
  }

  .footer-contact {
    margin-top: 10px;
    text-align: justify;
  }

  .menu-container {
    padding-right: 70px; /* Add a 70px margin from the right side of the screen */
  }

  .dropdown-wrapper {
    display: flex;
    justify-content: flex-end;
  }

  .dropdown-menu-container {
    display: flex;
    margin-right: 30px; /* Add a 30px gap between the two dropdown menus */
  }

  .dropdown-menu-item {
    margin-left: 10px; /* Adjust the spacing between each dropdown menu item */
    position: relative;
  }

  .dropdown-menu {
    position: absolute;
    top: 100%;
    right: 0;
    display: none;
    z-index: 1;
  }

  .dropdown-menu-item:hover .dropdown-menu {
    display: block;
  }

  /* 데스크탑 화면 스타일 */
  @media screen and (min-width: 768px) {
    .footer-contact {
      text-align: justify;
    }
  }

  /* 모바일 화면 스타일 */
  @media screen and (max-width: 767px) {
    .footer-contact {
      text-align: center;
    }
  }
</style>

</head>
<body>
  <footer>
    <img src="logo.png" alt="로고" class="footer-logo">
    <ul class="footer-links" style="font-size: 110%; text-align: center;" >
      <li><a href="#">홈</a></li>
      <li><a href="#">서비스</a></li>
      <li><a href="#">소개</a></li>
      <li><a href="#">문의</a></li>
    </ul>
    <hr>
	<div class="menu-container">
	  <div class="dropdown-wrapper">
	    <div class="dropdown-menu-container">
	      <div class="dropdown-menu-item">
	        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">제휴문의</a>
	        <ul class="dropdown-menu">
	          <li><a class="dropdown-item" href="#">광고 서비스 문의 ad@funddeuck.kr</a></li>
	          <li><a class="dropdown-item" href="#">제휴 문의 partner@funddeuck.kr</a></li>
	          <li><a class="dropdown-item" href="#">마케팅 제휴/PR 문의 mktpr@funddeuck.kr</a></li>
	        </ul>
	      </div>
	      <div class="dropdown-menu-item">
	        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">SNS</a>
	        <ul class="dropdown-menu">
	          <li><a class="dropdown-item" href="#">블로그</a></li>
	          <li><a class="dropdown-item" href="#">인스타그램</a></li>
	          <li><a class="dropdown-item" href="#">유튜브</a></li>
	        </ul>
	      </div>
	    </div>
	  </div>
	</div>
    <hr>
	<div class="footer-contact">
	  펀뜩이(주) | 대표이사 2조 | 사업자등록번호 123-45-6789 | 통신판매업신고번호 2023-부산 | 부산광역시 진구 서면 아이티윌로 
	  <br>
	  이메일 상담 contact@example.com | 유선상담 123-456-7890 <b>ⓒFUNDDEUCK Cp.,Ltd.</b>
	  <br>
	  © 2023 웹사이트. 모든 저작권은 보유합니다.
	  <br><br>
	  <p>일부 상품의 경우 와디즈는 통신판매중개자이며 통신판매 당사자가 아닙니다.
	  <br>해당되는 상품의 경우 상품, 상품정보, 거래에 관한 의무와 책임은 판매자에게 있으므로, 각 상품 페이지에서 구체적인 내용을 확인하시기 바랍니다.</p>
	</div>
  </footer>

</body>
</html>