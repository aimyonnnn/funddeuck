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

	// 클라이언트가 서버로 연결되었을 때
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("afterConnectionEstablished");
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
	        
	        if (strs != null && strs.length == 5) {
	        	
	            String type = strs[0];
	            String target = strs[1];
	            String subject = strs[2];
	            String content = strs[3];
	            String url = strs[4];
	            
	            WebSocketSession targetSession = users.get(target);
	            
	            if(type.equals("message")) {
	            	System.out.println("여기까지옴");
	            	if(targetSession != null) {
	            		type = "메시지가 도착했어요!";
	            		TextMessage tmpMsg = new TextMessage("<a target='_blank' href='" + url + "'>[<b>" + type + "</b>] " + subject + "</a>");
	            		targetSession.sendMessage(tmpMsg);
	            	}
	            	
	            } else if(type.equals("notification")) {
	            	
	            	if(targetSession != null) {
	            		type = "알림이 도착했어요!";
	            		TextMessage tmpMsg = new TextMessage("<a target='_blank' href='" + url + "'>[<b>" + type + "</b>] " + subject + "</a>");
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
		System.out.println("getMemberId");
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
		System.out.println("sendNotificationToAllUsers");
	    for (WebSocketSession session : users.values()) {
	        TextMessage message = new TextMessage(notification);
	        session.sendMessage(message);
	    }
	}
}
