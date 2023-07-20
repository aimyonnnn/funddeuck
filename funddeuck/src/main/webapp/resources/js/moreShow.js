// 현재 보이는 이미지의 인덱스를 추적하는 변수
let currentIndex = 0;

// 이미지를 변경하여 보이도록 하는 함수
function showImages() {
  const images = document.querySelectorAll('.swiper-slide');
  for (let i = 0; i < images.length; i++) {
    if (i >= currentIndex && i < currentIndex + 6) {
      images[i].style.display = 'block';  // 이미지를 보이게 함
    } else {
      images[i].style.display = 'none';   // 이미지를 숨김
    }
  }
}

// 이전 이미지를 보여주는 함수
function previousImages() {
  if (currentIndex > 0) {
    currentIndex -= 6;
    showImages();
  }
}

// 다음 이미지를 보여주는 함수
function nextImages() {
  const images = document.querySelectorAll('.swiper-slide');
  if (currentIndex + 6 < images.length) {
    currentIndex += 6;
    showImages();
  }
}

// 페이지 로드 시 초기 이미지 출력
document.addEventListener('DOMContentLoaded', function() {
  // swiper 초기화
  const swiper = new Swiper('.swiper-container', {
    slidesPerView: '3',
    spaceBetween:'20px',
  });

  // 초기 이미지 출력
  showImages();
});
