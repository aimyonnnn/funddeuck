let visibleProjects = 6; // 최초에 보여질 프로젝트 개수

    function loadMoreProjects() {
        const projects = document.querySelectorAll('.col-12.col-sm-6.col-md-4');
        const moreButton = document.getElementById('moreButton');

        // 다음 6개의 프로젝트를 보이도록 처리
        for (let i = visibleProjects; i < visibleProjects + 6 && i < projects.length; i++) {
            projects[i].style.display = 'block';
        }

        visibleProjects += 6; // 다음에 보여질 프로젝트 개수 갱신

        // 더이상 추가적인 프로젝트가 없으면 더보기 버튼을 비활성화
        if (visibleProjects >= projects.length) {
            moreButton.disabled = true;
        }
    }

    // 페이지가 로드되면 초기에 6개의 프로젝트만 보이도록 설정
    document.addEventListener('DOMContentLoaded', function () {
        const projects = document.querySelectorAll('.col-12.col-sm-6.col-md-4');
        const moreButton = document.getElementById('moreButton');

        // 초기에는 6개의 프로젝트만 보이도록 설정
        for (let i = 0; i < projects.length; i++) {
            if (i < visibleProjects) {
                projects[i].style.display = 'block';
            } else {
                projects[i].style.display = 'none';
            }
        }

        // 더보기 버튼 활성화 여부 설정
        if (visibleProjects >= projects.length) {
            moreButton.disabled = true;
        }
    });