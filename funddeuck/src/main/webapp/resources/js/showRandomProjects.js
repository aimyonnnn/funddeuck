function showRandomProjects() {
    $.ajax({
        url: './randomProjects',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            const projectContainer = $('#projectContainer');
            projectContainer.empty();

            for (var i = 0; i < data.length; i++) {
                var projectShow = data[i];
                if (projectShow.project_status == 2 && projectShow.project_approve_status == 5) {
                    const cardHTML2 = `
                        <div class="col-md-4 mb-4">
                            <article class="card">
                                <div class="card-thumbnail" style="background-image: url('${projectShow.project_thumnails1 || ''}');"></div>
                                <div class="card-body">
                                    <em class="card-title"><b>${projectShow.project_subject || ''}</b></em>
                                    <p class="card-text">
                                        <div class="progress" style="height: 10px">
                                            <div class="progress-bar bg-success" id="progressbar" role="progressbar" aria-label="Success example" 
                                            style="height:10px; width: ${projectShow.project_cumulative_amount / projectShow.project_target * 100}%" 
                                            aria-valuenow="${projectShow.project_cumulative_amount / projectShow.project_target * 100}" aria-valuemin="0" aria-valuemax="100"></div>
                                        </div>
                                        ${projectShow.project_category || ''}
                                    </p>
                                </div>
                                <p style="text-align: center;"><b>지금 참여하기></b></p>
                            </article>
                        </div>
                    `;
                    projectContainer.append(cardHTML2);
                }
            }
        },
        error: function(error) {
            console.error('Error : ', error);
        }
    });
}
