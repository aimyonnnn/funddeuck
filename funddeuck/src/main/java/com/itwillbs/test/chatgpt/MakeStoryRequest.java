package com.itwillbs.test.chatgpt;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;

@Getter
@Data
public class MakeStoryRequest {
    private String projectIntroduce; 	// 프로젝트 소개
    private String makerIntroduce; 		// 메이커 소개

    public MakeStoryRequest() {}

    @Builder
    public MakeStoryRequest(String projectIntroduce, String makerIntroduce) {
        this.projectIntroduce = projectIntroduce;
        this.makerIntroduce = makerIntroduce;
    }

//    // 프로젝트 소개서 작성하기
    public String toPromptString() {
    	
    	if(projectIntroduce != null) {
    		System.out.println("프로젝트소개글임");
    		return projectIntroduce + "위의 프로젝트 소개글을 바탕으로 100byte 이내의 짧은 매력적인 문구를 작성해주세요";
    	} else {
    		System.out.println("메이커소개글임");
    		return makerIntroduce + "위의 소개글을 바탕으로 100byte 이내의 짧은 매력적인 문구를 작성해주세요";
    	}
    	
    }
    
    
}

// 고속 충전 기능을 통해 빠르게 기기를 충전할 수 있으며, 친환경 프로젝트의 일환으로서, 에너지 효율성을 강조하고 배터리 수명 연장을 통한 자원 절약을 실현합니다. 스마트하고 심플한 디자인은 어떤 환경에서도 조화롭게 어울리며, 제품의 휴대성은 더욱 강화되어 사용자가 어디서든 손쉽게 사용할 수 있습니다. 이를 통해 우리의 생활을 편리하게 만들면서도 환경을 지켜나가는 노력에 일조하고 있습니다. 
// 최신 Qi 무선 충전 기술을 활용하여 스마트폰 및 기타 기기를 간편하게 충전할 수 있는 제품입니다. 별도의 충전 케이블 없이도 무선으로 배터리를 충전할 수 있어 편의성이 크게 향상되었습니다. 고속 충전 기능을 통해 빠르게 기기를 충전하고, LED 인디케이터를 통해 실시간 충전 상태를 확인할 수 있습니다. 또한 내장된 안전 기능으로 과열 및 과충전을 예방하여 기기와 배터리의 수명을 보호합니다.스마트하고 심플한 디자인은 어떤 환경에도 잘 어울리며, 휴대하기도 편리합니다.







