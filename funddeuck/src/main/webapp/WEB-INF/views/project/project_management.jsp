<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<!-- Bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.0.js"></script>
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<!-- CSS -->
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
	<link href="${pageContext.request.contextPath }/resources/css/project.css" rel="stylesheet" type="text/css">
	<script> 
	// datepicker
	$(function() {
	$(".datepicker").datepicker({
	    dateFormat: 'yy-mm-dd'
	    ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
	    ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
	    ,changeYear: true //콤보박스에서 년 선택 가능
	    ,changeMonth: true //콤보박스에서 월 선택 가능                
	    ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
	    ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
	    ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
	    ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
	    ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
	    ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	    ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	    ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	    ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	    ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
	    ,maxDate: "+3M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                
	});                    

	//초기값을 오늘 날짜로 설정
	$('#projectStartDate').datepicker('setDate', 'today'); // 시작일(오늘)
	$('#projectEndDate').datepicker('setDate', '+1M'); // 종료일(한달후)
	});

	// 약관 전체동의 체크박스
	$(document).ready(function() {
	  $("#agreeAll").click(function() {
	    if($("#agreeAll").is(":checked")) $("input[name=agreeCheck]").prop("checked", true);
	    else $("input[name=agreeCheck]").prop("checked", false);
	  });

	  $("input[name=agreeCheck]").click(function() {
	    var total = $("input[name=agreeCheck]").length;
	    var checked = $("input[name=agreeCheck]:checked").length;

	    if(total != checked) $("#agreeAll").prop("checked", false);
	    else $("#agreeAll").prop("checked", true); 
	  });
	});
	
	// 해시태그 
	$(document).ready(function () {
		var tag = {};
		var counter = 0;
	
		// 입력한 값을 태그로 생성한다.
		function addTag (value) {
			tag[counter] = value;
			counter++; // del-btn 의 고유 id 가 된다.
		}
	
		// tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
		function marginTag () {
			return Object.values(tag).filter(function (word) {
			    return word !== "";
			});
		}
	
		// 서버에 제공
		$("#project-form").on("submit", function (e) {
			var value = marginTag().join(', '); // return 
			$("#searchTag").val(value); 
		});
	
		$("#tag").on("keypress", function (e) {
	    	var self = $(this);
	
		    // 엔터나 스페이스바 눌렀을 때 실행
		    if (e.key === "Enter" || e.keyCode == 32) {
	
	        	var tagValue = self.val(); // 값 가져오기
	
		        // 해시태그 값이 없거나 3개를 초과하면 실행X
		        if (tagValue !== "" && marginTag().length < 3) {
	
		            // 같은 태그가 있는지 검사한다. 있다면 해당값이 array로 return된다.
		            var result = Object.values(tag).filter(function (word) {
		        		return word === tagValue;
	            	})
	
		            // 해시태그가 중복되었는지 확인
		            if (result.length == 0) {
		                $("#tag-list").append("<li class='tag-item'>" + tagValue + "<span class='del-btn' idx='" + counter + "'>x</span></li>");
		                addTag(tagValue);
		                self.val("");
		            } else {
		            	alert("태그값이 중복됩니다.");
		            }
				} else if (tagValue !== "" && marginTag().length == 3) {
				    alert("해시태그는 3개까지만 입력 가능합니다!"); // 해시태그 제한 메시지
				}
	        	e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지
			}
		});
		
		// 인덱스 검사 후 삭제
		$(document).on("click", ".del-btn", function (e) {
			var index = $(this).attr("idx");
			tag[index] = "";
			$(this).parent().remove();
		});
	})
	
	// 임시 저장
	$(function () {
		// 저장 함수 정의
		function save(key, value) {
			localStorage.setItem(key, value);
		}
	
		// 불러오기 함수 정의
	    function load(key) {
			return localStorage.getItem(key);
	    }
	
		// 해시태그 추가 함수 정의
	    function addTag(tag) {
			const tagList = $("#tag-list");
			const counter = tagList.children().length;
			const newTag = $('<li class="tag-item">' + tag + '<span class="del-btn" idx="' + counter + '">x</span></li>');
			tagList.append(newTag);
			
			newTag.find(".del-btn").on("click", function () {
			    $(this).parent().remove();
			});
		}
	
		// 배열 정의
		const fields = [
			"#projectCategory",
			"#projectSubject",
			"#managementDetail",
			"#managementSemiDetail",
			"#targetAmount",
			"#projectStartDate",
			"#projectEndDate",
			"#representativeName",
			"#representativeEmail",
			"#representativeBirth1",
			"#representativeBirth2",
			"#taxEmail",
			"#bankCategory",
			"#bankAccount",
			"#bankName"
		];
	
		// 저장하기 버튼 
		$("#saveButton").click(function () {
			fields.forEach(f => save(f.substring(1), $(f).val()));
			
			// 해시태그 저장하기 
			var hashtagValue = "";
			$("#tag-list").children().each(function () {
			    hashtagValue += $(this).text().replace("x", "").trim() + ", ";
			});
			save("project_hashtag", hashtagValue.substring(0, hashtagValue.length - 2));
			
			console.log("임시저장 완료");
		});
	
		// 삭제하기 버튼
	    $("#deleteButton").click(function () {
			localStorage.clear();
			console.log("임시저장 삭제 완료");
	    });
	
		// 불러오기 버튼 
	    $("#loadButton").click(function () {
			fields.forEach(f => {
				var value = load(f.substring(1));
				if (value) {
					$(f).val(value);
				}
			});
	
			// 해시태그 불러오기 
	        const hashtagValue = load("project_hashtag");
	        if (hashtagValue) {
	            $("#tag-list").empty();
				hashtagValue.split(",").forEach(tag => {
				    tag = tag.trim();
				    if (tag) {
				        addTag(tag);
				    }
				});
			}
		});
		
	    // 계좌 본인 인증 
	    $("#btnAccountAuth").on("click", function() {
	    	
			// 새 창에서 사용자 인증 페이지 요청
			let requestUri = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?"
					+ "response_type=code"
					+ "&client_id=4066d795-aa6e-4720-9383-931d1f60d1a9"
					+ "&redirect_uri=http://localhost:8089/test/callback"
					+ "&scope=login inquiry transfer"
					+ "&state=12345678901234567890123456789012"
					+ "&auth_type=0";
			window.open(requestUri, "authWindow", "width=600, height=800");
		});
	    
	    
	    
	    
	});
	</script>
</head>
<body>
	<!-- ajax loading -->
	<div id="loadingIndicator" style="display: none;">
	    <img src="${pageContext.request.contextPath }/resources/images/loading.gif" alt="Loading..." />
	</div>
	<!-- include -->
 	<jsp:include page="../common/project_top.jsp"/>

	<main id="main">
		<div class="containerCSS">
      
      	<!-- 왼쪽 네비게이션 시작 -->
		<aside id="aisdeLeft">
		    <div id="projectManagement">
				<img src="${pageContext.request.contextPath}/resources/images/managementImage.jpg" class="img-fluid me-auto" width="200px" height="150px">
		    	${sessionScope.sId}님의 프로젝트
		    </div>
		    <ul id="navMenu">
		        <li>
		            <a href="#" class="toggleTab">
		                &nbsp;&nbsp;&nbsp;프로젝트 관리
		                <i class="fas fa-caret-down"></i>
		            </a>
		            <ul class="subMenu">
		                <li><a href="projectMaker">메이커 정보</a></li>
		                <li><a href="projectManagement" id="active-tab">프로젝트 등록</a></li>
		                <li><a href="projectReward">리워드 설계</a></li>
		            </ul>
		        </li>
		        <li><a href="projectStatus">프로젝트 현황</a></li>
		        <li><a href="projectShipping">발송·환불 관리</a></li>
		        <li><a href="projectSettlement">수수료·정산 관리</a></li>
		    </ul>
		</aside>

		<!-- 중앙 섹션 시작 -->
		<section id="section">
	      	<article id="article">
	      		<div class="projectProcess img-fluid me-auto">
	      			<img src="${pageContext.request.contextPath}/resources/images/projectManagementImage.png">
	      		</div>
	      		
		      	<!-- 프로젝트 관리 시작 -->
				<div class="projectArea">
	            <p class="projectTitle">프로젝트 등록</p>
	            <p class="projectContent">프로젝트에 필요한 내용을 작성해 주세요.</p>
            
				<!-- 폼 태그 시작 -->
				<form id="project-form" action="projectManagementPro" class="projectContent" method="post" enctype="multipart/form-data">
					<!-- 히든 처리하는 부분 -->
	            	<!-- 마이페이지, 메이커 등록에서 넘어올 때 파라미터로 받아와야함 -->
	            	<input type="hidden" name="maker_idx" id="maker_idx" value="${param.maker_idx}" class="form-control" style="width:500px;">
					<!-- 기본 요금제 -->
					<div class="mt-4">
						<p class="subheading">기본 요금제</p>
						<p class="sideDescription">프로젝트 등록 시 수수료에 대한 요금제가 부과됩니다.</p>
						<div class="flex-container">
					    	<div class="card">
								<div class="card-header bg-primary text-white">
					                <input type="radio" id="basic_plan" name="project_plan" value="1" class="card-radio" checked>
					                <label for="basic_plan">
										FUNDDEUCK 회원제(5%) (VAT 별도)
					                </label>
								</div>
								<div class="card-body">
									<blockquote class="blockquote mb-0">
										<span class="card-detail">
											· 기본 요금제<br>
										    · 프로젝트 공개<br>
										    · 오픈예정 서비스<br>
										    · 새소식 알림<br>
										</span>
									</blockquote>
								</div>
							</div>
						    <div class="mx-2"></div> <!-- 가운데 마진 추가 -->
							<div class="card">
								<div class="card-header bg-success text-white">
									<input type="radio" id="influencer_plan" name="project_plan" value="2" class="card-radio">
									<label for="influencer_plan">
										INFLUENCER 회원제(3%) (VAT 별도)
									</label>
								</div>
								<div class="card-body">
									<blockquote class="blockquote mb-0">
										<span class="card-detail">
											· 긍정적 영향을 미치는 인플루언서들의 요금제<br>
											· 친환경/기부/동물보호 카테고리 이용자<br>
											· 수수료 할인<br>
										    · 프로젝트 공개<br>
										    · 오픈예정 서비스<br>
										    · 새소식 알림<br>
										</span>
									</blockquote>
								</div>
							</div>
						</div>
					</div>

					<!-- 프로젝트 정보 -->
					<div class="mt-4">
						<label class="subheading" for="projectCategory">프로젝트 정보</label>
						<p class="sideDescription">카테고리를 선택해주세요.</p>
						<div class="d-flex flex-row">
							<select class="form-control" name="project_category" id="projectCategory">
								<option value="">선택</option>
								<option value="테크/가전">테크/가전</option>
								<option value="패션/잡화">패션/잡화</option>
								<option value="홈/리빙">홈/리빙</option>
								<option value="뷰티">뷰티</option>
								<option value="출판">출판</option>
								<option value="친환경">친환경</option>
								<option value="기부">기부</option>
								<option value="동물보호">동물보호</option>
							</select>
						</div>
					</div>

					<!-- 프로젝트 제목 -->
					<div class="mt-4">
						<label class="subheading" for="projectSubject">프로젝트 제목</label>
						<p class="sideDescription">리워드의 장점과 특징이 잘 드러나는 키워드를 한 가지 이상 포함해 주세요.</p>
						<input class="form-control" type="text" name="project_subject" id="projectSubject" placeholder="제목을 입력해 주세요">
					</div>

					<!-- 프로젝트 썸네일 -->
					<div class="mt-5">
						<p class="subheading">썸네일 이미지</p>
						<p class="sideDescription">
							· 3MB 이하의 JPG, JPEG, PNG 파일<br>
							· 텍스트나 로고는 넣을 수 없어요.<br>
							· 최소 1개에서 최대 3개까지 업로드가 가능해요.
						</p>
						<input type="file" name="file1"><br>
						<input type="file" class="mt-2" name="file2"><br>
						<input type="file" class="mt-2" name="file3"><br>
					</div>
              
					<!-- 검색용 해시태그 -->
					<div class="tr_hashTag_area">
					    <p class="subheading">검색용 태그(#)</p>
					    <p class="sideDescription">
						    프로젝트가 더 잘 검색될 수 있도록 연관성이 높은 태그를 입력해 주세요.<br>
						    해시태그는 3개까지 등록이 가능해요.
					    </p>
						<div class="form-group">
							<input type="hidden" value="" name="project_hashtag" id="searchTag" />
						</div>
						             
						<div class="form-group">
							<input type="text" id="tag" size="7" placeholder="엔터로 해시태그를 등록해주세요." class="w-100 form-control"/>
						</div>
						<ul id="tag-list" class="mt-3"></ul>
					</div>

					<!-- 프로젝트 소개 -->
					<div class="mt-4">
						<label class="subheading" for="managementDetail">프로젝트 소개</label>
						<button class="btn btn-outline-primary btn-sm" onclick="makeGpt(event)">AI로 입력</button>
						<p class="sideDescription">
							준비하고 계신 리워드의 특별한 점을 작성해 주세요.<br>
							기존 제품 ・ 서비스 ・ 콘텐츠를 개선했다면 어떤 점이 달라졌는지 작성해 주세요.<br>
							위에 입력 된 정보를 바탕으로 AI로 자동 입력도 가능해요. 
						</p>
						<textarea class="form-control management-info" name="project_introduce" id="managementDetail" placeholder="예시 : 우리집 아이가 ○○ 인형을 좋아하는 모습을 보고 만들게 되었습니다." style="height: 300px; resize: none;"></textarea>
					</div>
					
					<!-- 프로젝트 한줄 소개 -->
					<div class="mt-4">
						<label class="subheading" for="managementSemiDetail">프로젝트 요약</label>
						<p class="sideDescription">
							메인에 소개될 프로젝트를 한 줄로 소개해 주세요.<br>
						</p>
						<input type="text" class="form-control" name="project_semi_introduce" id="managementSemiDetail" placeholder="150자까지 작성 가능해요.">
					</div>

					<!-- 프로젝트 상세정보 이미지 -->
					<div class="mt-5">
						<p class="subheading">상세정보 이미지</p>
						<p class="sideDescription">
							· 3MB 이하의 JPG, JPEG, PNG 파일<br>
							· 프로젝트를 설명할 상세정보를 업로드해요. 
						</p>
						<input type="file" name="file4"><br>
					</div>

					<!-- 목표 금액 -->
					<div class="mt-4">
						<label class="subheading" for="targetAmount">목표 금액</label>
						<p class="sideDescription">최소 50만 원~최대 1억 원 사이에서 설정해 주세요.</p>
						<input class="form-control" type="text" name="project_target" id="targetAmount" placeholder="금액을 입력해 주세요">
					</div>

					<!-- 프로젝트 일정 -->
					<div class="mt-4">
						<p class="subheading">프로젝트 일정</p>
						<p class="sideDescription">
							프로젝트 심사부터 리워드 제작 기간 등 전체 일정을 고려해 설정해 주세요.<br>
							리워드 발송은 프로젝트 종료 후 결제까지 완료되어야 가능해요.
						</p>
						<label class="sideDescription fw-bold" for="projectStartDate">시작일</label>
						<input type="text" name="project_start_date" id="projectStartDate" class="datepicker"><br>
						<label class="sideDescription mt-3 fw-bold" for="projectEndDate">종료일</label>
						<input type="text" name="project_end_date" id="projectEndDate" class="datepicker"><br>
					</div>

					<!-- 대표자 및 정산 정보 입력 -->
					<div class="mt-5">
						<p class="subheading">대표자 정보</p>
						<label class="sideDescription" for="representativeName">대표자명</label>
						<input class="form-control" type="text" name="project_representative_name" id="representativeName" placeholder="법인 사업자는 법인등기부상 법인명 / 개인은 성명을 입력해 주세요">
						<label class="sideDescription" for="representativeEmail">대표 이메일</label>
						<input class="form-control" type="text" name="project_representative_email" id="representativeEmail" placeholder="대표자의 이메일을 입력해 주세요"><br>
					</div>
              
					<!-- 정산 정보 -->
					<div>
						<p class="subheading">정산 정보</p>
						<div class="mt-5">
							<img src="${pageContext.request.contextPath}/resources/images/settlementInfo.png" class="img-fluid me-auto">
						</div>
					</div>

					<!-- 세금계산서 발행 정보 -->
					<div class="mt-5">
					<p class="subheading">세금계산서 발행 정보</p>
					<label class="sideDescription" for="representativeBirth1">대표자 주민등록번호</label>
					<div class="row">
						<div class="col-sm-6">
							<input class="form-control" type="text" name="representativeBirth1" id="representativeBirth1" placeholder="앞 6자리 입력">
						</div>
						<div class="col-sm-6">
							<input class="form-control" type="text" name="representativeBirth2" id="representativeBirth2" placeholder="뒤 7자리 입력">
						</div>
					</div>
					<label class="sideDescription" for="taxEmail">세금계산서 발행 이메일</label>
					<input class="form-control" type="text" name="project_tax_email" id="taxEmail" placeholder="세금계산서를 발행할 이메일을 입력해 주세요"><br>
					<label class="sideDescription" for="taxEmail">계좌정보</label>
					<p class="sideDescription">
						· 개인사업자의 경우 본인/사업자 명의 계좌 등록이 가능하며, 법인사업자의 경우 법인계좌만 등록 가능해요.<br>
						· 입금이 가능한 계좌인지 확인 후 입력해 주세요.<br>
						· 저축성 예금 계좌, 외화 예금 계좌, CMA 계좌, 평생 계좌번호(휴대전화 번호) 등은 입금이 불가합니다.
					</p>
					<div class="d-flex flex-row">
						<select class="form-control" name="project_settlement_bank" id="bankCategory">
							<option value="">은행 선택</option>
							<option value="산업은행">산업은행</option>
							<option value="신한은행">신한은행</option>
							<option value="국민은행">국민은행</option>
							<option value="농협은행">농협은행</option>
							<option value="우리은행">우리은행</option>
							<option value="기업은행">기업은행</option>
							<option value="KEB하나은행">KEB하나은행</option>
							<option value="부산은행">부산은행</option>
							<option value="카카오뱅크">카카오뱅크</option>
						</select>
					</div>
					<input class="form-control mt-1" type="text" name="project_settlement_account" id="bankAccount" placeholder="계좌번호 '-' 없이 숫자만 입력">
					<input class="form-control mt-1" type="text" name="project_settlement_name" id="bankName" placeholder="예금주명"><br>
					<button class="btn btn-primary" id="btnAccountAuth">본인 인증</button>
					<input type="hidden" name="token_idx" id="token_idx" value="">
					</div>

					<!-- 통장 사본 -->
					<div class="mt-5">
						<p class="subheading">통장사본</p>
						<p class="sideDescription">
							· 10MB 이하의 JPG, JPEG, PNG 파일<br>
							· 위 계좌 정보와 동일한 명의의 통장 사본을 제출해 주세요.
						</p>
						<input type="file" name="file5"><br>
					</div>

					<!-- 약관 시작 -->
					<div class="mt-5">
					<span class="subheading">서비스 이용 동의</span>
					<p class="sideDescription">아래 내용을 반드시 확인해 주세요.</p>
					<div class="agree_box">
						<ul class="agree_article">
							<li>
							    <div class="InpBox">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" id="agreeAll">
										<label class="form-check-label" for="agreeAll">
										  <strong class="all_agree">위 사실을 모두 확인하였고 동의합니다.</strong>
										</label>
									</div>
									<input type="hidden" name="hidden_check_all" value="0" id="hidden_check_all">
							    </div>
							</li>
						</ul>
					    <ul class="agree_article depth2">
							<li>
								<div class="agree_desc">
									<div class="InpBox">
										<div class="form-check">
										<input class="form-check-input" type="checkbox" name="agreeCheck" id="agree_rule1" required>
										    <label class="form-check-label" for="agree_rule1">
										    	<span><strong>제출한 프로젝트와 공지의 내용이 모두 사실임을 보증하며 사실이 아닐 경우 모든 책임을 부담하겠습니다.(제10조)</strong></span>
										    </label>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="agree_desc">
									<div class="InpBox">
										<div class="form-check">
										<input class="form-check-input" type="checkbox" name="agreeCheck" id="agree_rule2" required>
										    <label class="form-check-label" for="agree_rule2">
										    	<span><strong>동의한 약관 및 정책에 반하는 행위를 할 경우 프로젝트가 취소될 수 있고(제35조), 이용 계약이 해지될 수 있습니다.(제31조, 제40조)</strong></span>
										    </label>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="agree_desc">
									<div class="InpBox">
										<div class="form-check">
										<input class="form-check-input" type="checkbox" name="agreeCheck" id="agree_rule3" required>
										    <label class="form-check-label" for="agree_rule3">
										    	<span><strong>프로젝트를 공개한 후 취소하거나 취소되면 손해 배상과는 별도로 위약벌이 발생할 수 있음(제32조, 제41조)을 확인했습니다.</strong></span>
										    </label>
										</div>
									</div>
								</div>
								<a id="popupClausePrivacyPerson" class="view_indetail popup_clause_open" target="_blank">
									<span class="blind">서비스 이용 동의 상세보기</span>
								</a>
							</li>
					   </ul>
					  </div>
					</div>
					<!-- 약관 끝 -->

					<!-- 환불 정책 -->
					<div class="mt-5">
						<p class="subheading">환불 정책</p>
						<p class="sideDescription">이 프로젝트는 환불 정책이 적용돼요.</p>
						<a href="#">환불 정책 상세보기</a>
					</div>
					
					<div class="d-flex justify-content-center my-3">
						<input type="submit" value="신청하기" class="btn btn-primary" id="projectSubmit">
					</div>
				</form>
				<!-- 폼 태그 끝-->
			</div>
			<!-- 프로젝트 등록 끝-->

			</article>
		</section>
		<!-- 중앙 섹션 끝 -->
	        
		<!-- 오른쪽 네비게이션 -->
		<aside id="aisdeRight"> 
			<!-- 관리자 피드백 -->
			<div class="admin-feedback">
			<div class="admin-title">관리자 피드백</div>
			<div class="admin-content">관리자로부터 수정, 요청사항 피드백을 받으면 이곳에 피드백 메시지가 출력됩니다.</div>
		   
				<!-- 메시지 시작 -->
				<!-- DB저장된 알림 메시지를 반복문으로 출력 -->
				<!-- 관리자 페이지에서 프로젝트를 승인, 반려 할 때
				반려되는 경우에는 해당 프로젝트를 작성한 id에게 알림 메시지로 수정해야할 내용을 전송함-->
				<!-- 해당 id가 로그인을 하게되면 상단 종모양 알림 아이콘에 읽지 않은 메시지 갯수가 표시가 됨 -->
				<!-- DB에 알림 메시지를 저장하기때문에 꼭 실시간으로 로그인을 안해도 알림내역 들어가서 확인할 수 있음 -->
				<!-- 로그인이 되어 있는 경우에는 하단에 toast팝업으로 알림도착 팝업 띄워주고 종모양 아이콘에 갯수도 변화시킴 -->
				<!-- 알림 status가 X번 일 때는 프로젝트 수정하는 url도 같이 넣어줘서 바로 프로젝트 수정 페이지로 이동시킴 -->
				<!-- 관리자가 보낸 메시지를 참고해서 내용을 수정하면 됨 -->
				<div id="notificationContainer">
				  	<div class="alert alert-primary" role="alert">
						<i class="fas fa-exclamation-circle"></i><a>&nbsp;알림이 없습니다.</a>
					</div>
				</div>
				<button id="saveButton" class="btn btn-outline-secondary btn-sm me-3">임시저장</button>
				<button id="loadButton" class="btn btn-outline-secondary btn-sm me-3">불러오기</button>
				<button id="deleteButton" class="btn btn-outline-secondary btn-sm">삭제하기</button>
			</div>
		</aside>
		<!-- 오른쪽 네비게이션 끝 -->
		</div>
	</main>
	
	<script>
	$(document).ready(function () {
        // 탭 1을 기본으로 활성화
        $("#tab1").addClass("active");
        $(".tab-button[data-tab='tab1']").addClass("active"); // 기본 탭 버튼에도 active 클래스 추가

        $(".tab-button").click(function (e) {
            e.preventDefault(); // form 태그와의 충돌 방지
            var tabId = $(this).data("tab");
            $(".content-area").removeClass("active");
            $("#" + tabId).addClass("active");

            // 탭 버튼에도 active 클래스 추가 (활성화된 탭 표시)
            $(".tab-button").removeClass("active");
            $(this).addClass("active");
        });
    });
	
	// 관리자 피드백
	function getNotifications() {
		$.ajax({
			url: '<c:url value="getNotificationByAjax"/>',
			method: 'get',
			success: function(response) {
				
			var notifications = response;
		    var notificationContainer = $('#notificationContainer');
		    notificationContainer.empty();
		    
		    $.each(notifications.slice(0, 5), function(index, notification) {
		    	var notificationContent = notification.notification_content;
		        var alertDiv = $('<div class="alert alert-primary" role="alert"></div>');
		        var icon = $('<i class="fas fa-exclamation-circle"></i>');
		        var content = $('<span>&nbsp;' + notificationContent + '</span>');
		      	
		        // 읽음 처리 하기
		        content.click(function() {
        	  		markNotificationAsRead(notification.notification_idx);
	        	});
		        
		   		alertDiv.append(icon);
			    alertDiv.append(content);
    		    notificationContainer.append(alertDiv);
		   });
		},
		error: function(xhr, status, error) {
		  console.log('Error:', error);
		    }
	  });
	}
	
	$(()=>{
		getNotifications();
// 		setInterval(getNotifications, 5000);
	})
	
	// 메시지 읽음 처리 하기
	function markNotificationAsRead(notification_idx) {
		let confirmation = confirm("메시지를 읽음 처리 하시겠습니까?");
		if(confirmation) {
			console.log("알림번호 : " + notification_idx);
			$.ajax({
				method: 'get',
				url: '<c:url value="markNotificationAsRead"/>',
				data: {
					notification_idx: notification_idx
				},
				success: function(response){
					if(response.trim() == 'true') {
						// 알림 갯수 변경
						getNotificationCount();
						alert('읽음 처리 하였습니다!')
					} 
				},
				error: function(error) {
					console.log("읽음 처리 실패!")
				}
			})
		}
	}
	// ai로 입력하기
	function makeGpt(event) {
	    event.preventDefault(); // 기본 동작 중지

     	// 로딩 이미지 표시
         $('#loadingIndicator').show();
     	
         var makeStoryRequest = {
             projectName: $('#projectSubject').val(),
             projectCategory: $('#projectCategory').val(),
             projectIntroduce: $('#managementDetail').val()
         };

         $.ajax({
             type: "POST",
             url: "<c:url value='MakeStory'/>",
             contentType: "application/json",
             data: JSON.stringify(makeStoryRequest),
             beforeSend: function() {
                 $('#loadingIndicator').show();
             },
             success: function (response) {
                 $('#loadingIndicator').hide();
             	
                 console.log(response);
                 var responseObject = response; // 이미 json 형식의 응답이므로 파싱하지 않음
                 var result = responseObject.choices[0].text; // 필요한 필드 추출
                 $("#managementDetail").val(result).focus(); // textarea에 입력
                 
             },
             error: function (xhr, status, error) {
             	
                 console.log(error);
             }
         });
     }
	</script>
	
	<!-- datepicker -->
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<!-- bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
	<!-- js -->
	<script src="${pageContext.request.contextPath }/resources/js/project.js"></script>
</body>
</html>