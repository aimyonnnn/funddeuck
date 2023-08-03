function showRandomProjects() {
    $.ajax({
        url: './randomProjects',
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            const projectContainer = $('#projectContainer');
            projectContainer.empty();

            const projectsToShow = data.filter(project => project.project_status === 1).slice(0, 3);

            while (projectsToShow.length < 3) {
                projectsToShow.push(data[0]);
            }

            projectsToShow.forEach(project => {
                const cardHTML = `
                    <div class="col-md-4 mb-4">
                        <article class="card">
                            <div class="card-thumbnail" style="background-image: url('${project.project_thumnails1 || ''}');"></div>
                            <div class="card-body">
                                <em class="card-title"><b>${project.project_subject || ''}</b></em>
                                <p class="card-text">
                                    <span class="badge dbadge-primary">${project.project_target || '0'}원</span>
                                    ${project.project_category || ''}
                                </p>
                            </div>
                            <p style="text-align: center;"><b>지금 참여하기></b></p>
                        </article>
                    </div>
                `;
                projectContainer.append(cardHTML);
            });
        },
        error: function (error) {
            console.error('Error : ', error);
        }
    });
}
