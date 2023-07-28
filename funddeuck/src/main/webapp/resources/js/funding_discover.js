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

//펀딩 리스트 조회 스크립트

let pageNum = 1;
let maxPage = 1;

$(function() {
	let searchType = $("#searchType").val();
	let searchKeyword = $("#searchKeyword").val();
	
	loadList(searchType, searchKeyword);
	
	// 스크롤 기능
	$(window).on("scroll", function() { 
		
		let scrollTop = $(window).scrollTop();
		let windowHeight = $(window).height();
		let documentHeight = $(document).height();
		
		// 스크롤바가 x 값 만큼 내려갔을 경우
		let x = 30;
		if(scrollTop + windowHeight + x >= documentHeight) {
			if(pageNum < maxPage) {
				pageNum++;
				loadList(searchType, searchKeyword);
			} else {
					alert("가져올 데이터가 더 없습니다!");
			}
		}
	});
});

function loadList(searchType, searchKeyword) {
	let url;
	
	url = "fundingDiscoverList?pageNum=" + pageNum + "&searchType=" + searchType + "&searchKeyword=" + searchKeyword;
	var now = new Date();
	var date = now.getDate();
	
	$.ajax({
		type: "GET",
		url: url,
		dataType: "json",
		success: function(data) {
			maxPage = data.maxPage;
			
				// 테이블에 표시할 JSON 객체 1개 출력문 생성(= 1개 게시물) => 반복
				for(project of data.projectList) {
				let item = 
						"<div class='col'>"
							+ "<div class='card h-100 w-100 p-3 border-0'>" 
								+ "<img src='https://tumblbug-pci.imgix.net/4f7b81d5f6644ab0546c1550830b087fee9731e2/e43c362af955a9ab1e07587af2ceb05707fc28ac/b1ccc39baa075d4a16c99c789999706243c7b79a/dc4f106d-679f-446f-9990-77cbdab35281.jpeg?ixlib=rb-1.1.0&w=1240&h=930&auto=format%2Ccompress&lossless=true&fit=crop&s=e2257d31ad60c43dbd844924646d8355' class = 'card-img-top object-fit-contain' alt = '' >"
								+ "<div class='card-body'>"
									+ "<small class='card-title opacity-75'>" + project.project_hashtag +  project.project_representative_name + "</small>"
									+ "<p class='card-text fw-bold text-start'>" + project.project_subject + "</p>"
									+ "<small class='opacity-50'>" + project.project_semi_introduce +"</small>"
								+ "</div>" 
								+ "<a href='fundingDetail' class='stretched-link'></a>"
							+ "<div class='card-footer bg-white'>" 
								+ "<small class='fw-bold text-success'>"+ project.project_target/project.project_amount + "%" + "</small>&nbsp;" 
								+ "<small class='opacity-75'>" + project.project_amount + "원"
								+ "<small class='fw-bold float-end'>" + project.project_end_date - date + " 일 남음" + "</small></small>"
							+ "<div class='progress'>"
								+ "<div class='progress-bar bg-success' role='progressbar' aria-label='Success example' style='width:" + project.project_target/project.project_amount + "%' aria-valuenow=" + project.project_target/project.project_amount + " aria-valuemin='0' aria-valuemax='100'></div>"	
							+ "</div>"
							+ "</div>"
						+ "</div>"	
				$("table").append(item);
			}
		},
		error: function() {
			alert("데이터 목록 요청 실패!");
		}
	});
	
}

function getFormatDate(date) {
	let targetDate = /(\d\d)(\d\d)-(\d\d)-(\d\d)\s(\d\d):(\d\d):(\d\d).(\d)/g;
	let formatDate = "$2-$3-$4 $5:$6";
	return date.replace(targetDate, formatDate);
}
