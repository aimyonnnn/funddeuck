package com.itwillbs.test.mapper;

import java.util.List;

import com.itwillbs.test.vo.ChatRoomVO;
import com.itwillbs.test.vo.ChatVO;


public interface ChatMapper {

	ChatRoomVO selectChatRoom(ChatRoomVO chatRoom);

	List<ChatRoomVO> selectChatList(String id);

	int insertChatRoom(ChatRoomVO chatRoom);

	int insertChat(ChatVO chatVO);

	List<ChatVO> selectmemberChatList(String room_id);


}
