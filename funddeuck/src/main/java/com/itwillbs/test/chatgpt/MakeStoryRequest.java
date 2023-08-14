package com.itwillbs.test.chatgpt;

import lombok.Builder;
import lombok.Getter;

@Getter
public class MakeStoryRequest {
    private String projectName; 	 	// 프로젝트 제목
    private String projectCategory; 	// 프로젝트 카테코리
    private String projectIntroduce; 	// 프로젝트 소개

    public MakeStoryRequest() {}

    @Builder
    public MakeStoryRequest(String projectName, String projectIntroduce, String projectCategory) {
        this.projectName = projectName;
        this.projectIntroduce = projectIntroduce;
        this.projectCategory = projectCategory;
    }

//    // 프로젝트 소개서 작성하기
    public String toPromptString() {
    	return projectIntroduce + "위의 프로젝트 소개글을 바탕으로 100byte 이내의 짧은 매력적인 문구를 작성해주세요";
    			
    }
    
}

// 최신 Qi 무선 충전 기술을 활용하여 스마트폰 및 기타 기기를 간편하게 충전할 수 있는 제품입니다. 별도의 충전 케이블 없이도 무선으로 배터리를 충전할 수 있어 편의성이 크게 향상되었습니다. 고속 충전 기능을 통해 빠르게 기기를 충전하고, LED 인디케이터를 통해 실시간 충전 상태를 확인할 수 있습니다. 또한 내장된 안전 기능으로 과열 및 과충전을 예방하여 기기와 배터리의 수명을 보호합니다.스마트하고 심플한 디자인은 어떤 환경에도 잘 어울리며, 휴대하기도 편리합니다.







