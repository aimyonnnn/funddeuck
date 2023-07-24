function showProjects(data) {
  var rankingList = $("#rankingList");
  rankingList.empty(); // 기존 리스트 초기화
  for (var i = 0; i < data.length; i++) {
    var rank = i + 1;
    var project = data[i];

    // 프로젝트 종료일을 yyyy-mm-dd 형식으로 변환
    var endDate = new Date(project.project_end_date);
    var endDateStr = endDate.toISOString().slice(0, 10);

    // 리스트 아이템 생성
    var listItem = $("<li>").html(
      "<span class='project-rank'>" + rank + "위</span>  " +
      "<span class='project-name'>" + project.project_subject + "</span> - " +
      "종료일: " + endDateStr + " (" + project.project_end_date + ")");

    rankingList.append(listItem);
  }
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
