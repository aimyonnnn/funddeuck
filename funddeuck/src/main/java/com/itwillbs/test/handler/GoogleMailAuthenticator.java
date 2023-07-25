package com.itwillbs.test.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

// 자바 메일 기능 사용 시 메일 서버 (ex. Gmail 등) 인증을 위한 정보 관리 용도의
// javax.mail.Authenticator 클래스를 상속받는 서브클래스 정의
public class GoogleMailAuthenticator extends Authenticator {
	//인증 정보(아이디, 패스워드(앱비밀번호))를
	//javax.mail.PasswordAuthentication 타입 변수 선언
	private PasswordAuthentication passwordAuthentication;
	
	//기본 생성자 정의
	public GoogleMailAuthenticator() {
		passwordAuthentication = new PasswordAuthentication("rjsan200020", "rcrkokckhjiohgda");
	}
	
	//인증 정보 관리하는 객체 (PasswordAuthentication) 를 외부로 리턴하는 
	// getPasswordAuthentication() 메서드 정의
	// => 주의! Getter 메서드 정의 시 변수명에 따라 메서디ㅡ명이 달라질 수 있음
	//	  또한, 외부에서 getPasswordAuthentication() 메서드를 직접 호출하지 않음
	// => 그러나, Authenticat 클래스 내부의 getPasswordAuthentication() 메서드를 오버라이딩 할 것
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return passwordAuthentication;
	}
	
	
}
