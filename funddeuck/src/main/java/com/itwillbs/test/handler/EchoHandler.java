package com.itwillbs.test.handler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.itwillbs.test.service.ChatService;
import com.itwillbs.test.vo.ChatVO;

public class EchoHandler extends TextWebSocketHandler {

	// 로그인중인 개별 유저를 관리하는 맵
	// 웹소켓 세션과 사용자 ID를 매핑하는 맵
	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	Map<WebSocketSession, String> sessions = new ConcurrentHashMap<WebSocketSession, String>();

	// 채팅에 필요한 map
	private final Map<String, List<WebSocketSession>> chatRoomId = new HashMap<String, List<WebSocketSession>>();

	// 채팅 내용을 저장 할 서비스
	@Autowired
	private ChatService chatService;

	// 클라이언트가 서버로 연결되었을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String senderId = getMemberId(session);
		
		if (senderId != null) {
			if(users.get(senderId) != null) {
				session.sendMessage(new TextMessage("이미 창이 열려있습니다."));
			} else {
				log(senderId + " 연결됨");
				users.put(senderId, session);
				sessions.put(session, senderId);

		
		// -------------------------------------- 채팅 부분 ------------------------------------------
				String url = session.getUri().getQuery();
				
				if(url != null) {
					
					System.out.println("첫번째");
					
					if (session.getUri().getQuery().split("=")[0].equals("room_id")) {
						System.out.println("두번째");
						String room_id = session.getUri().getQuery().split("=")[1];
						List<WebSocketSession> chatSessions = chatRoomId.getOrDefault(room_id, new ArrayList<WebSocketSession>());
						
						System.out.println("점검1 : " +chatSessions.size());
						
						if (chatSessions.size() >= 2) {
							// 두 개 이상의 세션이 존재하면 클라이언트에게 메시지 보내기
							String message = "잘못된 접근입니다.";
							session.sendMessage(new TextMessage(message));
							session.close(CloseStatus.NORMAL.withReason(message));
							return;
						}
						System.out.println("끝까지 옴");
						chatSessions.add(session);
						chatRoomId.put(room_id, chatSessions);
						System.out.println("점검2 : " +chatSessions.size());
					}
				}
			}
		}
		// --------------------------------------------------------------------------------------------

	}

	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("handleTextMessage");
		String senderId = getMemberId(session);
		String msg = message.getPayload();

		if (msg != null) {
			String[] strs = msg.split(",");
			String type = strs[0];


			log(strs.toString());
			if (strs != null && strs.length == 4) {
				String target = strs[1];
				String content = strs[2];
				String url = strs[3];
				WebSocketSession targetSession = users.get(target);
				if (type.equals("message")) {
					// ---------------------------------- 채팅 -----------------------------------------
					String roomId = session.getUri().getQuery().split("=")[1];
					String receiver = session.getUri().getQuery().split("=")[2];
					String sender = strs[1];
					System.out.println(sender);
					targetSession = users.get(receiver);

					List<WebSocketSession> sessionList = chatRoomId.getOrDefault(roomId, new ArrayList<WebSocketSession>());

					for (WebSocketSession s : sessionList) {
						if (type.equals("message")) {

							System.out.println("message");

							int insertCount = chatService.addMessage(new ChatVO(roomId, sender, receiver, content));
							if (insertCount > 0) {
								s.sendMessage(new TextMessage(sender + "," + content));
							}
						}
					}
					// ---------------------------------------------------------------------------------
					if(sessions.size() == 1) {
						if (targetSession != null) {
							type = "메시지가 도착했어요!";
							TextMessage tmpMsg = new TextMessage(
									"<a target='_blank' href='" + url + "'>[<b>" + type + "</b>] " + content + "</a>");
							targetSession.sendMessage(tmpMsg);
						}
					}
				} else if (type.equals("notification")) {
					if (targetSession != null) {
						type = "알림이 도착했어요!";
						TextMessage tmpMsg = new TextMessage(
								"<a target='_blank' href='" + url + "'>[<b>" + type + "</b>] " + content + "</a>");
						targetSession.sendMessage(tmpMsg);
					}
				}
			}

		}

	}

	// 연결 해제
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getMemberId(session);
		if (senderId != null) {
			log(senderId + " 연결 종료됨");
			users.remove(senderId);
			sessions.remove(session);
		}
		
		String url = session.getUri().getQuery();
		
		if(url != null) {

			if (session.getUri().getQuery().split("=")[0].equals("room_id")) {
				String room_id = session.getUri().getQuery().split("=")[1];
				List<WebSocketSession> sessions = chatRoomId.getOrDefault(room_id, new ArrayList<WebSocketSession>());
				sessions.remove(session);
				chatRoomId.put(room_id, sessions);
			}
		}
	}

	// 에러 처리
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		log(session.getId() + " 익셉션 발생: " + exception.getMessage());
		String senderId = sessions.get(session);
		if (senderId != null) {
			users.remove(senderId);
			sessions.remove(session);
			log(senderId + " 연결 종료됨");
		}
	}

	// 로그 메시지
	private void log(String logmsg) {
		System.out.println(new Date() + " : " + logmsg);
	}

	// 접속한 유저의 세션을 조회하여 ID를 얻기
	private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String sId = (String) httpSession.get("sId");
		return sId == null ? null : sId;
	}

	// 특정 회원
	public void sendNotificationToUser(String target, String notification) throws IOException {
		System.out.println("sendNotificationToUser");
		WebSocketSession targetSession = users.get(target);
		if (targetSession != null) {
			TextMessage message = new TextMessage(notification);
			System.out.println(message);
			targetSession.sendMessage(message);
		}
	}

	// 전체 회원
	public void sendNotificationToAllUsers(String notification) throws IOException {
		for (WebSocketSession session : users.values()) {
			TextMessage message = new TextMessage(notification);
			session.sendMessage(message);
		}
	}
}
