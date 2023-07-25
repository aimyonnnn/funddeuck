package com.itwillbs.test.handler;

import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMailClient {
	
	// 인증 메일 발송을 수행할 sendMail() 메서드 정의
	// => 파라미터: 이메일, 제목, 본문 리턴타입 : boolean(isSuccess)
	public boolean sendMail(String email, String subject, String content) {
		// mail_form.jsp 페이지로부터 전달받은 폼 파라미터 가져와서 확인

				
//				System.out.println("보내는 사람 : " + sender);
//				System.out.println("받는 사람 : " + receiver);
//				System.out.println("제목 : " + title);
//				System.out.println("내용 : " + content);
				try {
					//--------------------------- 메일 전송에 필요한 정보 설정 작업 ----------------------------------
					// 메일 전송 프로토콜 : SHMP(Simeple Mail Transfer protocal)
					// <-> 메일 수신 프로토콜 : POPJ, IMAP 등
					// 1. 시스템(현제 서버 = 톰켓)의 속성 정보(= 서버 정보)를 관리하는 객체를
					//    java.util.Properties 객체로 리턴받기
					Properties properties = System.getProperties();
					
					// 2. Properties 객체를 활용하여 메일 전송에 필요한 기본 정보를 서버 정보에 추가
					//    => put() 메서드 활용
					// 메일 전송에 사용할 메일 서버에 대한 정보 설정(구글, 네이버 ,아웃룩 등)
					properties.put("mail.smtp.host", "smtp.gmail.com"); // 구글(Gmail) SMTP 서버
					properties.put("mail.smtp.auth", "true"); // SMTP 서버 접근 시 인증 여부설정
					properties.put("mail.smtp.port", "587"); // Gmail 서버의 서비스 포트 설정(TLS)
					//메일 서버 인증 관련 추가 정보 설정(설정 내용에 따라 port 정보가 바뀜)
					properties.put("mail.smtp.starttls.enable", "true"); //TLS 라는 인증 프로토콜 사용 
					properties.put("mail.smtp.ssl.protocols", "TLSv1.2"); //TLS 인증 프로토콜 버전 설정 
					//만약, 메일 발송 과정에서 TLS 관련 오류 발생 시
					properties.put("mail.smtp.ssl.trust", "smtp.gmail.com"); //SSL 인증 신뢰 서버
					
					//3. 메일 서버 인증 정보를 관리하는 사용자 정의 클래스의 이니스턴스 생성
					//   => javax.Mail.Authenticator 타입으로 업캐스팅하여 사용
					Authenticator authenticator = new GoogleMailAuthenticator();
					
					//4. 자바 메일 전송을 수행하는 작업을 javax.mail.Session 객체 단위로 관리하므로
					//	 Session 클래스의 getDefaultInstance() ㅁ세ㅓ드를 호출하여 Session 객체 리턴받음
					Session mailSession = Session.getDefaultInstance(properties, authenticator);
					
					//5. 서버 정보와 인증 정보를 함께 관리할 javax.mail.MimMessage 객체 생성
					// 	 => javax.mail.Message 타입으로 업케스팅
					//	 => 파라미터 : javax.mail.Session 객체
					Message message = new MimeMessage(mailSession);
					
					//-------------------
					// 6. 전송할 메일 정보 설정
					// 1) 발신자 정보 설정 - InternetAddress 객체 생성(=> address 타입 업케스팅)
					//	  => 파라미터 : 발신자 주소, 발신자 이름
					//	  => 단, 사용 메일 서버(구글, 네이버 등)의 경우 스펨 정책으로 인해
					//	     기본적인 방법으로 발신자 주소 변경 불가(기본 계정 주소 그래도 사용됨.)
					Address senderAddress = new InternetAddress("rjsan200020@gmail.com","아이티윌");
					
					// 2. 수신자 정보 설정
					//    - InternetAddress 객체 생성
					//	 => 파라미터 : 수신자 정보
					//	 => AddressExcapction 처리 필요
					Address reciverAddress = new InternetAddress(email);
					
					// 3. Message 객체를 통해 전송할 메일에 대한 내용 설정
					// 3-1) 메일 해더 정보 설정
					message.setHeader("content-type", "text/html; charset=UTF-8");
					// 3-2) 발신자 정보 설정
					message.setFrom(senderAddress);
					// 3-2) 수신자 정보 설정
					//	=> 파라미터 : 수신 타입, 수신자 정보 객체
					message.addRecipient(RecipientType.TO, reciverAddress);
					//	=> RecipientType.To : 수신자에게 직접 정송(직접 받을 수신자 = 업무 담당자)
					//	=> RecipientType.CC : 참조. Carbon Copy 의 약자. 직접적 수신자는 아니나 참조용으로 수신
					//	=> RecipientType.Bcc : 숨은  참조, Blind CC 약자. 다른 사람들이 누가 참조하는지
					// 3-4) 메일 제목 설정
					message.setSubject(subject);
					// 3-5) 메일 본문 설정
					//	=> 파라미터 : 본문, 본문의 컨텐츠 타입
					//		(만약, 파일 전송을 포함하려면 Multipart 타입 파라미터 객체 필요)
					message.setContent(content, "text/html; charset=UTF-8");
					// 3-6) 메일 전송 날짜 및 시각 설정
					// => java.util.Date 객체 활용하여 현제 시스탬 시각 정보 활용
					message.setSentDate(new Date());
					
					// 7. 메일 전송
					//java.mail.Transport 클래스의 static 메서드 send() 호출
					// => 파라미터 : 6번에서 생성한 message 객체
					Transport.send(message);
					
					return true;
					
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("이메일 전송 실패");
				}
				
				return false;
				
	}
	
}
