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

// 펀딩 목록 가져오기
function showRandomProjects() {
    $.ajax({
      url: './randomProjects', 
      type: 'GET',
      dataType: 'json',
      success: function(data) {
        const projectContainer = $('#projectContainer');
        projectContainer.empty();

        data.forEach(project => {
          const cardHTML = `
            <div class="col-md-4 mb-4">
              <article class="card">
                <div class="card-thumbnail" style="background-image: url('${project.project_thumnails1}');"></div>
                <div class="card-body">
                  <em class="card-title">${project.project_subject}</em>
                  <p class="card-text">
                    <span class="badge dbadge-primary">${project.project_target}원</span>
                    ${project.project_category}
                  </p>
                </div>
              </article>
            </div>
          `;
          projectContainer.append(cardHTML);
        });
      },
      error: function(error) {
        console.error('Error : ', error);
      }
    });
  }
