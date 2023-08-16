package com.itwillbs.test.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.ChatRoomVO;
import com.itwillbs.test.vo.ChatVO;


public interface ChatMapper {

	ChatRoomVO selectChatRoom(ChatRoomVO chatRoom);

	List<ChatRoomVO> selectChatList(String id);

	int insertChatRoom(ChatRoomVO chatRoom);

	int insertChat(ChatVO chatVO);

	List<ChatVO> selectmemberChatList(@Param("room_id") String room_id, @Param("startRow") int startRow, @Param("listLimit") int listLimit);

	int selecCountMemberChat(String room_id);

	List<Map<String, Object>> selectMakerChatRoomList(@Param("listLimit") int listLimit,@Param("startRow") int startRow, @Param("sId") String sId);

	int selectCountMakerChattingRoom(String sId);

	List<Map<String, Object>> selectMemberChatRoomList(@Param("listLimit") int listLimit,@Param("startRow") int startRow, @Param("sId") String sId);

	int getCountMemberChattingRoom(String sId);


}
