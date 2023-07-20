function showRanking() {
    console.log('1');
    $.ajax({
        type: "GET",
        url: "./get_ranking_data",
        dataType: "json",
        success: function (data) {
            var rankingList = $("#rankingList");
            console.log('2');
            rankingList.empty(); // 기존 리스트 초기화
            for (var i = 0; i < data.length; i++) {
                var rank = i + 1;
                var projectName = data[i].p_name;
                var projectIntro = data[i].p_intro;

                var anchorTag = $("<a>").attr("href", "#");
                
                // Add a class to the ranking number span
                var listItem = $("<li>").html("<span class='project-rank'>" + rank + "위</span>  <span class='project-name'>" + projectName + "</span> - " + projectIntro);
                anchorTag.append(listItem);
                
                anchorTag.addClass("ranking-item");
                rankingList.append(anchorTag);
            }
        },
        error: function (xhr, status, error) {
            // 오류 메시지를 브라우저 콘솔에 출력
            console.error("AJAX Error:", status, error);
        }
    });
}

// 페이지 로드 시 showRanking() 함수를 호출합니다.
$(window).on("load", function () {
    showRanking();
});
