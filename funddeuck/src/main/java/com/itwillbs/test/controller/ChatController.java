package com.itwillbs.test.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
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
import com.mysql.cj.Session;

@Controller
public class ChatController {
	
	@Autowired
	ChatService service;
	
	@Autowired
	MemberService memberService;
	
	//채팅방 생성 및 존재시 채팅방으로 이동
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
	
	
	// 채팅방 이동
    @GetMapping("chat")
    public String chat(HttpSession session, Model model) {
    	
    	if((String)session.getAttribute("sId") == null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	return "chat/chat";
    }
    
    // 채팅 내용 가져오기
    @PostMapping("lodeChatList")
    @ResponseBody
    public String lodeChatList(@RequestParam(defaultValue = "1") int pageNum, @RequestParam String room_id) {
    	
		int listLimit = 15; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
    	
    	List<ChatVO> chatList = service.getMemberChatList(room_id, startRow, listLimit);
    	
		int listCount = service.getCountMemberChat(room_id);
		
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
    	
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("chatList", chatList);
		jsonObject.put("maxPage", maxPage);
		
    	return jsonObject.toString();
    }
    
    // 메이커 채팅방 리스트 보기
    @GetMapping("makerChattingRoomList")
    public String makerChattingRoomList(HttpSession session, Model model){
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	return "chat/maker_chat_list";
    }
    
    //메이커 채팅방
    @PostMapping("makerChatRoomList")
    @ResponseBody
    public String makerChatRoomList(@RequestParam(defaultValue = "1") int pageNum, HttpSession session) {
    	
		int listLimit = 30; // 한 페이지에서 표시할 목록 갯수 지정
		int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
    	
		List<Map<String, Object>> makerChatRoomList = service.getMakerChatRoomList(listLimit,startRow, (String)session.getAttribute("sId"));
		
		int listCount = service.getCountMakerChattingRoom((String)session.getAttribute("sId"));
		
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("makerChatRoomList", makerChatRoomList);
		jsonObject.put("maxPage", maxPage);
		
    	return jsonObject.toString();
    }
    
    //서포터 채팅방 폼
    @GetMapping("memberChattingRoomList")
    public String memberChattingRoomList(HttpSession session, Model model){
    	
    	if(session.getAttribute("sId") == null) {
    		model.addAttribute("msg", "잘못된 접근입니다.");
    		return "fail_back";
    	}
    	
    	return "chat/member_chat_list";
    }
    
    //서포터 채팅방
    @PostMapping("memberChatRoomList")
    @ResponseBody
    public String memberChatRoomList(@RequestParam(defaultValue = "1") int pageNum, HttpSession session) {
    	
    	int listLimit = 30; // 한 페이지에서 표시할 목록 갯수 지정
    	int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
    	
    	List<Map<String, Object>> memberChatRoomList = service.getMemberChatRoomList(listLimit,startRow, (String)session.getAttribute("sId"));
    	
    	int listCount = service.getCountMakerChattingRoom((String)session.getAttribute("sId"));
    	
    	int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
    	
    	JSONObject jsonObject = new JSONObject();
    	jsonObject.put("memberChatRoomList", memberChatRoomList);
    	jsonObject.put("maxPage", maxPage);
    	
    	return jsonObject.toString();
    }
    

}
