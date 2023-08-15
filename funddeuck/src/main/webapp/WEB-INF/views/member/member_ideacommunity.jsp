<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>IdeaCommunity</title>
    <%@ include file="../Header.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<!--     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<!--     <link rel="stylesheet" type="text/css" href="../resources/css/mypage.css" /> -->
    <link rel="stylesheet" type="text/css" href="../resources/css/member_ideacommunity.css" />
</head>

	<style>
	    .container h3 {
	        margin-top: 40px;
	    }
        .card-body {
            text-align: center;
        }
        .card-title b {
            font-weight: bold;
        }
        .card-text {
            text-align: left;
        }
        .card {
            margin-bottom: 20px;
        }
        .card .card-header {
            background-color: #f4f5f7;
            border-bottom: none;
        }
        .card .card-body {
            padding: 15px;
        }
        .card .card-title {
            margin-bottom: 10px;
        }
        .card .card-text {
            margin-bottom: 0;
        }
            @media (max-width: 768px) {
        .nav-link span {
            font-size: 12px;
        }
    }
    </style>
    
</head>
<body>
    <section style="background-color: #f4f5f7;">
        <div style="height:150px;"></div>
        <div class="page-content container note-has-grid">
			<ul class="nav nav-pills p-3 bg-white mb-3 rounded-pill align-items-center" style="flex-wrap: wrap;">
			    <li class="nav-item col-6 col-md-3 mb-2">
			        <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex flex-column align-items-center justify-content-center px-2 px-md-3 mr-0 mr-md-2" id="all-category" style="background-color: #FF9300; color: #000; border: 2px solid #FF9300;">
			            <i class="icon-layers mr-1"></i>
			            <span class="d-none d-md-block font-14" style="text-align: center;">모든 아이디어 보기</span>
			        </a>
			    </li>
			    <li class="nav-item col-6 col-md-3 mb-2">
			        <a href="javascript:void(0)" class="nav-link btn-primary rounded-pill d-flex flex-column align-items-center justify-content-center px-3" id="add-notes" style="background-color: #f8f9fa; color: #000; border: 2px solid #FF9300;">
			            <i class="icon-layers mr-1"></i>
			            <span class="d-none d-md-block font-14" style="text-align: center;">아이디어 제시하기</span>
			        </a>
			    </li>
			</ul>

            <br>
            <div class="container mt-4">
                <div class="card-body">
                    <h5 class="card-title">우리는 함께하는 힘으로 혁신적인 아이디어들을 실현시킬 수 있는 특별한 공간. <b>아이디어 펀딩 커뮤니티</b>에 여러분을 초대합니다!</h5><br>
                    <div class="image-container">
                        <img src="${pageContext.request.contextPath}/resources/images/ideacommunity.png" style="max-width: 100%; ">
                    </div><br>
                    <p class="card-text">이제 여러분은 자유롭게 각종 분야의 창의적인 아이디어를 공유하고 다양한 사람들로부터 찬사를 받을 수 있는 기회를 갖게 되었습니다. 게시판에 올리신 아이디어가 다른 회원들에게 좋아요를 많이 받을수록 해당 아이디어의 실현 가능성을 높일 수 있습니다.</p>
                    <p class="card-text">
                        어떤 아이디어가 가능성이 있는지는 회원 여러분들의 손에 달려 있습니다. 주제나 분야를 제한하지 않으며, 다음과 같은 방식으로 게시판이 운영됩니다.<br>
                        ＊ 아이디어 게시: 여러분이 고안한 아이디어를 게시판에 올려주세요. 제목과 내용을 자세히 설명하여 다른 회원들이 쉽게 이해하고 지지할 수 있도록 도와주세요.
                    </p>
                </div>
            </div>
            <br>
            <div class="tab-content bg-transparent">
                <div id="note-full-container" class="note-has-grid row">
                    <c:forEach var="cardData" items="${data}">
                        <div class="col-md-4 single-note-item all-category mb-4">
                            <div class="card">
                                <div class="card-header">
                                    <!-- 작성자: ${cardData.member_idx} <br> -->
                                    <h5 class="card-title"><b>${cardData.title}</b></h5>
                                    작성 시간: ${cardData.today}
                                </div>
                                <div class="card-body">
                                    <p class="card-text">${cardData.description}</p>
                                    <div style="text-align: right;">
                                        <img src="https://cdn-icons-png.flaticon.com/512/70/70245.png" alt="삭제" width="20" height="20" style="cursor: pointer;" onclick="deleteData(${cardData.idea_idx})">
                                        <img src="https://cdn-icons-png.flaticon.com/512/1216/1216656.png?w=740&t=st=1691318684~exp=1691319284~hmac=77832eaa223611f6a84a833c33ce0ecbbc67e5b6cdddb4cfc0b3b757b0e20439"
                                            alt="좋아요" width="20" height="20" style="cursor: pointer;" onclick="likeIdea(${cardData.idea_idx})">
                                        <span id="likeCount_${cardData.idea_idx}">${cardData.likecount}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
					</div>


                </div>
            </div>


            <!-- Modal Add notes -->
            <div class="modal fade" id="addnotesmodal" tabindex="-1" role="dialog" aria-labelledby="addnotesmodalTitle" style="display: none;" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content border-0">
                        <div class="modal-header bg-info text-white">
                            <h5 class="modal-title text-white">새로운 아이디어를 제시합니다.</h5>
                        </div>
                        <div class="modal-body">
                            <div class="notes-box">
                                <div class="notes-content">
                                    <form id="addnotesform">
                                        <div class="col-md-12 mb-3">
                                            <div class="ideatitle">
                                                <label>제목</label>
                                                <input type="text" id="idea_title" name="title" class="form-control" minlength="25" placeholder="Title" />
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="ideadescription">
                                                <label>내용</label>
                                                <textarea id="idea_description" name="description" class="form-control" minlength="60" placeholder="Description" rows="3"></textarea>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button id="btn-n-save" class="float-left btn btn-success" style="display: none;" style="background-color: #FF9300;">Save</button>
                                            <button class="btn btn-danger" data-dismiss="modal">취소</button>
                                            <button id="btn-n-add" class="btn btn-info" disabled="disabled">저장</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>

    <script>
        var userId = '<%= session.getAttribute("sId") %>';

        $(document).ready(function() {
            $('#add-notes').click(function() {
                $('#addnotesmodal').modal('show');
            });

            $('#btn-n-add').click(function() {
                var title = $('#idea_title').val();
                var description = $('#idea_description').val();
                $.ajax({
                    url: '${pageContext.request.contextPath}/saveIdea',
                    type: 'POST',
                    data: {title: title, description: description},
                    success: function() {
                        $('#addnotesmodal').modal('hide');
                        location.reload();
                    }
                });
            });

            $('#addnotesform input, #addnotesform textarea').keyup(function() {
                var title = $('#idea_title').val();
                var description = $('#idea_description').val();
                if (title.length > 0 && description.length > 0) {
                    $('#btn-n-add').prop('disabled', false);
                } else {
                    $('#btn-n-add').prop('disabled', true);
                }
            });

            function generateCards(cardsData) {
                var cardsContainer = $('#note-full-container');
                cardsContainer.empty();

                cardsData.forEach(function(cardData) {
                	
                	
                	console.log(cardData.idea_idx);
                	
                	
                    var cardHtml = `
                        <div class="col-md-4 single-note-item all-category">
                            <div class="card">
                                <div class="card-header">
                                    작성자: ${cardData.member_idx} <br>
                                    작성 시간: ${cardData.today}
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">${cardData.title}</h5>
                                    <p class="card-text">${cardData.description}</p>
                                    <button class="btn btn-primary">Like</button>
                                </div>
                            </div>
                        </div>
                    `;
                    
                    
                    cardsContainer.append(cardHtml);
                });
            }

            $.ajax({
                url: '${pageContext.request.contextPath}/getCardsData',
                type: 'GET',
                success: function(data) {
                    generateCards(data);
                }
            });
        });
        
        function likeIdea(ideaIdx) {
            $.ajax({
                url: '${pageContext.request.contextPath}/likeIdea',
                type: 'POST',
                data: { ideaIdx: ideaIdx }, 
                success: function () {
                    var likeCountElement = $('#likeCount_' + ideaIdx);
                    var currentLikeCount = parseInt(likeCountElement.text());
                    likeCountElement.text(currentLikeCount + 1);
                },
                error: function (xhr, status, error) {
                    console.error(error);
                }
            });
        }
        
        function deleteData(ideaIdx) {
        	
            var member_id = userId;
            
            console.log(member_id);
            console.log(ideaIdx);
            
            if (member_id === "admin") {
                $.ajax({
                    type: 'POST',
                    url: '${pageContext.request.contextPath}/deleteIdea',
                    data: { ideaIdx: ideaIdx },
                    success: function (data) {
                    	
                    	 if(data.trim() === 'true') {
                    		 console.log('삭제되었음');
                    		 location.reload();
                    	 }
                    },
                    error: function () {
                    }
                });
            } else {
                alert("이 동작을 수행할 권리가 없습니다.");
            }
        }
        
    </script>

    <%@ include file="../Footer.jsp" %>

</body>
</html>
