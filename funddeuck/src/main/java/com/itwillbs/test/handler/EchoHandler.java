package com.itwillbs.test.handler;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler{

	// 로그인중인 개별 유저를 관리하는 맵
	// 웹소켓 세션과 사용자 ID를 매핑하는 맵
	Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	Map<WebSocketSession, String> sessions = new ConcurrentHashMap<WebSocketSession, String>();

	// 클라이언트가 서버로 연결되었을 때 호출되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	    String senderId = getMemberId(session);
	    if (senderId != null) {
	        log(senderId + " 연결됨");
	        users.put(senderId, session);
	        sessions.put(session, senderId);
	    }
	}
	
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    System.out.println("handleTextMessage");
	    String senderId = getMemberId(session);
	    
	    String msg = message.getPayload();
	    if (msg != null) {
	        String[] strs = msg.split(",");
	        log(strs.toString());

	        if (strs != null && strs.length == 4) { // 분리된 메시지가 유효한 형식인지 확인
	            String type = strs[0]; // 메시지 유형 추출
	            String target = strs[1]; // 대상 유저의 member_id 추출
	            String content = strs[2]; // 메시지 내용 추출
	            String url = strs[3]; // 메시지 링크 추출
	            WebSocketSession targetSession = users.get(target); // 메시지를 받을 세션 조회

	            if (targetSession != null) {
	                TextMessage tmpMsg = new TextMessage("<a target='_blank' href='" + url + "'>[<b>" + type + "</b>] " + content + "</a>");
	                targetSession.sendMessage(tmpMsg);
	            }
	        }
	    }
	}
	
	// 연결 해제될 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    String senderId = getMemberId(session);
	    if (senderId != null) {
	        log(senderId + " 연결 종료됨");
	        users.remove(senderId);
	        sessions.remove(session);
	    }
	}
	
	// 에러 발생시
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
	
	// 접속한 유저의 HTTP 세션을 조회하여 ID를 얻기
	private String getMemberId(WebSocketSession session) {
	    Map<String, Object> httpSession = session.getAttributes();
	    String sId = (String) httpSession.get("sId");
	    return sId == null ? null : sId;
	}

	// 특정 상대방에게 알림을 보내기
	public void sendNotificationToUser(String target, String notification) throws IOException {
	    System.out.println("sendNotificationToUser");
	    WebSocketSession targetSession = users.get(target);
	    if (targetSession != null) {
	        TextMessage message = new TextMessage(notification);
	        System.out.println(message);
	        targetSession.sendMessage(message);
	    }
	}
	
	// 전체 회원에게 알림 보내기
	public void sendNotificationToAllUsers(String notification) throws IOException {
	    for (WebSocketSession session : users.values()) {
	        TextMessage message = new TextMessage(notification);
	        session.sendMessage(message);
	    }
	}
}
