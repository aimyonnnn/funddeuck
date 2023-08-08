function showProjects(data) {
  var rankingList = $("#rankingList");
  rankingList.empty(); // 기존 리스트 초기화

  // data 배열을 역순으로 변경
//  data.reverse();

  var table = $("<table class='table project-table'></table>");

  var headers = $("<tr><th>순위</th><th>프로젝트 이름</th><th>펀딩 종료일</th></tr>");
  table.append(headers);

  for (var i = 0; i < data.length; i++) {
    var rank = i + 1;
    var project = data[i];

    // 프로젝트 종료일을 yyyy-mm-dd 형식으로 변환
    var endDate = new Date(project.project_end_date);
    var endDateStr = endDate.toISOString().slice(0, 10);

    var row = $(`
      <tr>
        <td>${rank}위</td>
        <td class="project-name">${project.project_subject}</td>
        <td class="project-end-date">${endDateStr}</td>
      </tr>
    `);

    table.append(row);
  }

  rankingList.append(table);
}


// API를 통해 프로젝트 정보 가져오기
function getProjectList() {
  $.ajax({
    type: "GET",
    url: "./list", 
    dataType: "json",
    success: function (data) {
      console.log('프로젝트 정보 가져오기 성공:');
      console.log(data);
      showProjects(data); // 프로젝트 리스트 출력
    },
    error: function (xhr, status, error) {
      // 오류 메시지를 브라우저 콘솔에 출력
      console.error(xhr);
    }
  });
}


// 페이지 로드 시 프로젝트 정보 가져오기
$(document).ready(function () {
  getProjectList();
});

// 24시간마다 프로젝트 정보 업데이트
setInterval(getProjectList, 24 * 60 * 60 * 1000); // 24시간 (1일)마다 호출
