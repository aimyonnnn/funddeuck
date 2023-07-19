// 관리자 피드백 구역
function scrollHandler() {
    // 관리자 피드백 요소를 가져옴
    var adminFeedbackElement = document.querySelector(".admin-feedback");
    // 관리자 피드백 요소의 위치(offsetTop)를 가져옴
    var adminFeedbackOffsetTop = adminFeedbackElement.offsetTop;
    // 스크롤 위치가 관리자 피드백 요소의 위치와 같을 때
    if (window.pageYOffset = adminFeedbackOffsetTop) {
    // sticky 클래스를 추가하여 고정
    adminFeedbackElement.classList.add("sticky");
  	} else {
    // sticky 클래스를 제거하여 고정 해제
    adminFeedbackElement.classList.remove("sticky");
 	}
}

// 스크롤 이벤트 핸들러 등록
window.addEventListener("scroll", function() {
	// 스크롤 타임아웃이 없을 경우에만 실행
	if (!window.scrollTimeout) {
		// 스크롤 이벤트를 지연시킴
		window.scrollTimeout = setTimeout(function() {
		window.scrollTimeout = null;
	    	scrollHandler();
	    }, 250); // 250ms 지연
  	}
});

// 네비게이션탭	
const toggleTab = document.querySelector('.toggleTab');
const subMenu = document.querySelector('.subMenu');

toggleTab.addEventListener('click', function(e) {
    e.preventDefault();
    subMenu.classList.toggle('showSubMenu');
    toggleTab.querySelector('i').classList.toggle('fa-caret-down');
    toggleTab.querySelector('i').classList.toggle('fa-caret-up');
});
	

	
	
	
	
	
	
	