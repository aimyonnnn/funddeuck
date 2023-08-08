function showRandomunProjects() {
    $.ajax({
        url: './randomProjects',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            const projectContainer = $('#unprojectContainer');
            projectContainer.empty();

            for (var i = 0; i < data.length; i++) {
                var projectShow = data[i];
                if (projectShow.project_status == 1 && projectShow.project_approve_status == 5) {
                    const cardHTML = `
                        <div class="col-md-4 mb-4">
                            <article class="card">
                                <div class="card-thumbnail" style="background-image: url('${projectShow.project_thumnails1 || ''}');"></div>
                                <div class="card-body">
                                    <em class="card-title"><b>${projectShow.project_subject || ''}</b></em>
                                    <p class="card-text">
                                        ${projectShow.project_category || ''}
                                    </p>
                                </div>
                                <p style="text-align: center;"><b>지금 살펴보기></b></p>
                            </article>
                        </div>
                    `;
                    projectContainer.append(cardHTML);
                }
            }
        },
        error: function(error) {
            console.error('Error : ', error);
        }
    });
}
