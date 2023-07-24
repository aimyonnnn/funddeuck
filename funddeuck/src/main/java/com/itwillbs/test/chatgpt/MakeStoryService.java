package com.itwillbs.test.chatgpt;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

// https://platform.openai.com/account/api-keys
@Service
public class MakeStoryService {
//	 @Value("${gpt.apiKey}")
	 @Value("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")
	    private String API_KEY;
	    private static RestTemplate restTemplate = new RestTemplate();

	    public HttpEntity<ChatGptRequest> createHttpEntity(ChatGptRequest chatGptRequest) {
	        HttpHeaders headers = new HttpHeaders();
	        headers.setContentType(MediaType.parseMediaType(ChatGptConfig.MEDIA_TYPE));
	        headers.add(ChatGptConfig.AUTHORIZATION, ChatGptConfig.BEARER + API_KEY);
	        return new HttpEntity<>(chatGptRequest, headers);
	    }

	    public ChatGptResponse getResponse(HttpEntity<ChatGptRequest> chatGptRequest) throws Exception {
	        ResponseEntity<ChatGptResponse> responseEntity = restTemplate.postForEntity(
	                ChatGptConfig.URL,
	                chatGptRequest,
	                ChatGptResponse.class);
	        if (isGptCannotResponse(responseEntity)) {
	            throw new Exception();
	        }
	        return responseEntity.getBody();
	    }

	    public ChatGptResponse askQuestionToChatGpt(MakeStoryRequest MakeStoryRequest) throws Exception {
	        return this.getResponse(
	                this.createHttpEntity(
	                        ChatGptRequest.builder()
	                                .model(ChatGptConfig.MODEL)
	                                .prompt(MakeStoryRequest.toPromptString())
	                                .maxTokens(ChatGptConfig.MAX_TOKEN)
	                                .temperature(ChatGptConfig.TEMPERATURE)
	                                .topP(ChatGptConfig.TOP_P)
	                                .build()));
	    }

	    public boolean isGptCannotResponse(HttpEntity<ChatGptResponse> chatGptResponseEntity) {
	        if (chatGptResponseEntity.getBody().getChoices().isEmpty() || chatGptResponseEntity.getBody().getChoices() == null) {
	            return true;
	        }
	        return false;
	    }
}
	
	
