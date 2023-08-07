package com.itwillbs.test.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatVO {
	String room_id;
	String sender;
	String receiver;
	String content;	
}
