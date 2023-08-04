package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.ChatMapper;
import com.itwillbs.test.vo.ChatRoomVO;
import com.itwillbs.test.vo.ChatVO;

@Service
public class ChatService {
	
	@Autowired
	ChatMapper mapper;

	public ChatRoomVO getChatRoom(ChatRoomVO chatRoom) {
		return mapper.selectChatRoom(chatRoom);
	}

	public List<ChatRoomVO> getChatRoomList(String id) {
		return mapper.selectChatList(id);
	}

	public int addChatRoom(ChatRoomVO chatRoom) {
		return mapper.insertChatRoom(chatRoom);
	}

	public int addMessage(ChatVO chatVO) {
		return mapper.insertChat(chatVO);
	}

	public List<ChatVO> getMemberChatList(String room_id) {
		return mapper.selectmemberChatList(room_id);
	}


	
	
}
