/**
펀딩 프로젝트 탐색 페이지 스크립트 
 */
 
// 상단 이동 버튼 스크립트
jQuery(document).ready(function () {
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      $('#go-top').fadeIn(500);
    } else {
      $('#go-top').fadeOut('fast');
    }
  });
  $('#go-top').click(function (e) {
    e.preventDefault();
    $('html, body').animate({scrollTop: 0}, 200);
  });
});