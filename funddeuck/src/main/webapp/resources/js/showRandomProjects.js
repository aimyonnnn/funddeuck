const projectList = [
  {
    project_thumnails1: 'project1.jpg',
    project_subject: '프로젝트 1',
    project_target: '100,000',
    project_category: '카테고리 1'
  },
  {
    project_thumnails2: 'project2.jpg',
    project_subject: '프로젝트 2',
    project_target: '100,000',
    project_category: '카테고리 2'
  },
  {
    project_thumnails3: 'project2.jpg',
    project_subject: '프로젝트 3',
    project_target: '100,000',
    project_category: '카테고리 3'
  },
  {
    project_thumnails4: 'project2.jpg',
    project_subject: '프로젝트 4',
    project_target: '100,000',
    project_category: '카테고리 4'
  },
  {
    project_thumnails5: 'project2.jpg',
    project_subject: '프로젝트 5',
    project_target: '100,000',
    project_category: '카테고리 5'
  }
  
  ];

// 랜덤으로 4개의 프로젝트를 출력하는 함수
function showRandomProjects() {
  const container = document.querySelector('.row'); // 결과를 출력할 컨테이너 요소
  container.innerHTML = ''; // 이전에 출력된 내용 초기화

  const projectsToShow = getRandomProjects(4); // 랜덤으로 4개의 프로젝트를 가져옴

  let row = document.createElement('div'); // 새로운 row 요소 생성
  row.className = 'row'; // 클래스 이름 설정

  // 랜덤으로 가져온 프로젝트들을 HTML로 출력
  projectsToShow.forEach((project, index) => {
    const projectElement = `
      <div class="col-md-6 mb-4">
        <article class="card">
          <div class="card-thumbnail" style="background-image: url('${project.project_thumnails1}');"></div>
          <div class="card-body">
            <em class="card-title">${project.project_subject}</em>
            <p class="card-text">
              <span class="badge badge-primary">${project.project_target}원</span>
              ${project.project_category}
            </p>
          </div>
        </article>
      </div>
    `;

    // 2열씩 출력하기 위해, index가 짝수일 때마다 새로운 row 요소 생성
    if (index % 2 === 0) {
      row = document.createElement('div'); // 새로운 row 요소 생성
      row.className = 'row'; // 클래스 이름 설정
    }

    row.innerHTML += projectElement; // 프로젝트 요소를 row에 추가

    // 2열씩 출력하기 위해, index가 홀수이거나 마지막 요소일 때 row를 container에 추가
    if (index % 2 === 1 || index === projectsToShow.length - 1) {
      container.appendChild(row); // container에 row 추가
    }
  });
}

// 배열에서 랜덤으로 count개의 요소를 가져오는 함수
function getRandomProjects(count) {
  const shuffledProjects = projectList.sort(() => 0.5 - Math.random());
  return shuffledProjects.slice(0, count);
}