package com.itwillbs.test.chatgpt;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MakeStoryController {
    private final MakeStoryService makeStoryService;

    public MakeStoryController(MakeStoryService makeStoryService) {
        this.makeStoryService = makeStoryService;
    }

    @PostMapping("MakeStory")
    @ResponseBody
    public ChatGptResponse makeMakeStory(@RequestBody MakeStoryRequest makeStoryRequest) throws Exception {
    	System.out.println("makeMakeStory");
        ChatGptResponse response = makeStoryService.askQuestionToChatGpt(makeStoryRequest);
        return response;
    }
    
    
}
