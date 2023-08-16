package com.itwillbs.test.service;

import java.util.List;
import java.util.Map;

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


	public int addChatRoom(ChatRoomVO chatRoom) {
		return mapper.insertChatRoom(chatRoom);
	}

	public int addMessage(ChatVO chatVO) {
		return mapper.insertChat(chatVO);
	}

	public List<ChatVO> getMemberChatList(String room_id, int startRow, int listLimit) {
		return mapper.selectmemberChatList(room_id, startRow, listLimit);
	}

	public int getCountMemberChat(String room_id) {
		return mapper.selecCountMemberChat(room_id);
	}

	public List<Map<String, Object>> getMakerChatRoomList(int listLimit, int startRow, String sId) {
		return mapper.selectMakerChatRoomList(listLimit,startRow, sId);
	}


	public int getCountMakerChattingRoom(String sId) {
		return mapper.selectCountMakerChattingRoom(sId);
	}


	public List<Map<String, Object>> getMemberChatRoomList(int listLimit, int startRow, String sId) {
		return mapper.selectMemberChatRoomList(listLimit,startRow, sId);
	}


	public int getCountMemberChattingRoom(String sId) {
		return mapper.getCountMemberChattingRoom(sId);
	}


	
	
}
