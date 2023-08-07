<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>IdeaCommunity</title>
    <%@ include file="../Header.jsp" %>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="../resources/css/mypage.css" />
    <link rel="stylesheet" type="text/css" href="../resources/css/member_ideacommunity.css" />
</head>
<style>
    .container h3 {
        margin-top: 40px;
    }
</style>

<body>
    <section style="background-color: #f4f5f7;">
        <div style="height: 70px;"></div>
        <div class="page-content container note-has-grid">
            <ul class="nav nav-pills p-3 bg-white mb-3 rounded-pill align-items-center">
                <li class="nav-item">
                    <a href="javascript:void(0)" class="nav-link rounded-pill note-link d-flex align-items-center px-2 px-md-3 mr-0 mr-md-2 active" id="all-category">
                        <i class="icon-layers mr-1"></i><span class="d-none d-md-block">모든 아이디어 보기</span>
                    </a>
                </li>
                <li class="nav-item ml-auto">
                    <a href="javascript:void(0)" class="nav-link btn-primary rounded-pill d-flex align-items-center px-3" id="add-notes"> <i class="icon-note m-1"></i><span class="d-none d-md-block font-14">아이디어 제시하기</span></a>
                </li>
            </ul>
            <div class="tab-content bg-transparent">
                <div id="note-full-container" class="note-has-grid row">
			<!-- 아이디어 출력 -->
			<div id="note-full-container" class="note-has-grid row">
			    <c:forEach var="cardData" items="${data}">
			        <div class="col-md-4 single-note-item all-category">
			            <div class="card">
			                <div class="card-header">
			                    <!-- 작성자: ${cardData.member_idx} <br> -->
			                    <h5 class="card-title"><b>${cardData.title}</b></h5>
			                    작성 시간: ${cardData.today}
			                </div>
			                <div class="card-body">
			                    <p class="card-text">${cardData.description}</p>
			                    <div style="text-align: right;">
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
                                            <button id="btn-n-save" class="float-left btn btn-success" style="display: none;">Save</button>
                                            <button class="btn btn-danger" data-dismiss="modal">Discard</button>
                                            <button id="btn-n-add" class="btn btn-info" disabled="disabled">Add</button>
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
                    url: '${pageContext.request.contextPath}/member/saveIdea',
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
                url: '${pageContext.request.contextPath}/member/getCardsData',
                type: 'GET',
                success: function(data) {
                    generateCards(data);
                }
            });
        });
        
        function likeIdea(ideaIdx) {
            $.ajax({
                url: '${pageContext.request.contextPath}/member/likeIdea',
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
        
    </script>

    <%@ include file="../Footer.jsp" %>

</body>
</html>