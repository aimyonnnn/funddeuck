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
      text-align: center;
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
    }
  </style>
</head>
<body>
  <footer>
    <img src="logo.png" alt="로고" class="footer-logo">
    <ul class="footer-links">
      <li><a href="#">홈</a></li>
      <li><a href="#">서비스</a></li>
      <li><a href="#">소개</a></li>
      <li><a href="#">문의</a></li>
    </ul>
    <div class="footer-contact">
      연락처: contact@example.com | 전화번호: 123-456-7890
    </div>
    <div>
      © 2023 웹사이트. 모든 저작권은 보유합니다.
      <p>일부 상품의 경우 와디즈는 통신판매중개자이며 통신판매 당사자가 아닙니다.
      <br>해당되는 상품의 경우 상품, 상품정보, 거래에 관한 의무와 책임은 판매자에게 있으므로, 각 상품 페이지에서 구체적인 내용을 확인하시기 바랍니다.</p>
    </div>
  </footer>
</body>
</html>