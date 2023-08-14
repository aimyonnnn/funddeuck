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

    // 프로젝트 소개서 작성하기
//    public String toPromptString() {
//        return "제가 제시할 단어는 다음과 같습니다. " +
//               "프로젝트 소개 : " + projectIntroduce + "." +
//               "해당 정보를 바탕으로 1줄 이내의 짧은 펀딩 사이트 메이커 페이지에 어울리는 매력적인 문구를 만들어주세요";
//    }
    
    // 프로젝트 소개서 작성하기
    public String toPromptString() {
    	return "제가 제시할 단어는 다음과 같습니다. " +
    			"  프로젝트 제목 : " + projectName +
    			", 프로젝트 카테고리 : " + projectCategory +
    			", 프로젝트 소개 : " + projectIntroduce + "." +
    			"해당 정보를 바탕으로 펀딩 사이트 메인에 소개될 프로젝트를 200byte 이내의 한 줄로 소개해 주세요.";
    }
    
}








