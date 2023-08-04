package com.itwillbs.test.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.test.service.ChatService;
import com.itwillbs.test.service.MemberService;
import com.itwillbs.test.vo.ChatRoomVO;
import com.itwillbs.test.vo.ChatVO;

@Controller
public class ChatController {
	
	@Autowired
	ChatService service;
	
	@Autowired
	MemberService memberService;
	
	@PostMapping("createRoom")
	@ResponseBody	
	public ChatRoomVO createRoom(@RequestParam int maker_idx, HttpSession session) {
		
		ChatRoomVO ChatRoom = new ChatRoomVO();
		ChatRoom.setMember_id((String)session.getAttribute("sId"));
		
		String maker_member_id = memberService.getMakerMemberId(maker_idx);
		
		ChatRoom.setMaker_member_id(maker_member_id);
		
		ChatRoomVO isChatroom = service.getChatRoom(ChatRoom);
		
		if(isChatroom != null) {
			return isChatroom;
		}
		
		String roomId = UUID.randomUUID().toString().split("-")[0];
		
		ChatRoom.setRoom_id(roomId);
		
		int insertCount = service.addChatRoom(ChatRoom);
		if(insertCount > 0) {
			return ChatRoom;
		}
		return null;
	}
	
	@GetMapping("chatList")
	public String chatList(HttpSession session, Model model) {
		
		List<ChatRoomVO> RoomList = service.getChatRoomList((String)session.getAttribute("id"));
		
		model.addAttribute("RoomList",RoomList);
		
		return "websoket/chatList";
	}
	
	
    @GetMapping("chat")
    public String chat(HttpSession session, Model model, @RequestParam String room_id) {
    	
    	if((String)session.getAttribute("sId") == null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	System.out.println(room_id);
    	
    	List<ChatVO> chatList = service.getMemberChatList(room_id.split("=")[0]);
    	
    	model.addAttribute("chatList",chatList);
    	
    	return "chat/chat";
    }

}
