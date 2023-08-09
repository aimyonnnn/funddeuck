

function showRandomProjects() {
    $.ajax({
        url: './randomProjects',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
            const projectContainer = $('#projectContainer');
            projectContainer.empty();

            const filteredProjects = data.filter(project =>
                project.project_status == 2 && project.project_approve_status == 5
            );

            const randomIndices = getRandomIndices(filteredProjects.length, 3);
            randomIndices.forEach(index => {
                const project = filteredProjects[index];
                const cardHTML = createCardHTML(project);
                projectContainer.append(cardHTML);
            });
        },
        error: function(error) {
            console.error('Error: ', error);
        }
    });
}

function createCardHTML(project) {
    return `
        <div class="col-md-4 mb-4">
            <article class="card">
                <div class="card-thumbnail" style="background-image: url('${project.project_thumnails1 || ''}');"></div>
                <div class="card-body">
                    <em class="card-title"><b>${project.project_subject || ''}</b></em>
                    <p class="card-text">
                        <div class="progress" style="height: 10px">
                            <div class="progress-bar bg-success" id="progressbar" role="progressbar" aria-label="Success example" 
                            style="height:10px; width: ${project.project_cumulative_amount / project.project_target * 100}%" 
                            aria-valuenow="${project.project_cumulative_amount / project.project_target * 100}" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
						<span class="light-gray-text">
							${(project.project_cumulative_amount / project.project_target * 100).toLocaleString(undefined, { maximumFractionDigits: 0 })}%
						</span>
						<br>${project.project_category || ''} | ${project.project_representative_name || ''}
                    </p>
                </div>
				<hr>
                <a href="fundingDetail?project_idx=${project.project_idx || ''}" class="stretched-link">
                    <p style="text-align: center;"><b>지금 참여하기></b></p>
                </a>
            </article>
        </div>
    `;
}

function getRandomIndices(max, count) {
    const indices = [];
    for (let i = 0; i < count; i++) {
        let index;
        do {
            index = Math.floor(Math.random() * max);
        } while (indices.includes(index));
        indices.push(index);
    }
    return indices;
}
