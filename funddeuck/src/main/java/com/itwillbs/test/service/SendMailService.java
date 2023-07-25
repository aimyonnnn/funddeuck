package com.itwillbs.test.service;


import org.springframework.stereotype.Service;

import com.itwillbs.test.handler.SendMailClient;


@Service
public class SendMailService {
	// 인증메일 발송을 수행하기 위한 sendAuthMail() 메서드 정의
	// => 파라미터 : 아이디, 이메일 리턴타입 : boolean (isSendSuccess)
	public boolean sendAuthMail(String email, String authCode) {
		boolean isSendSuccess = false;
		
		
		// 제목과 본문 생성
		String subject = "Funddeuck 인증코드 입니다.";
//		String content = "인증코드 : " + authCode;
		// 사용자가 링크를 클릭하면 인증 수행을 위한 서블릿 주소를 요청하도록 본문에 하이퍼링크를 포함
		String content = "<!DOCTYPE html>\r\n"
				+ "<html>\r\n"
				+ "<head>\r\n"
				+ "    <title>메일인증 안내</title>\r\n"
				+ "    <style>\r\n"
				+ "        body {\r\n"
				+ "            font-family: 'Apple SD Gothic Neo', 'sans-serif' !important;\r\n"
				+ "        }\r\n"
				+ "        .container {\r\n"
				+ "            width: 540px;\r\n"
				+ "            height: 600px;\r\n"
				+ "            \r\n"
				+ "            margin: 100px auto;\r\n"
				+ "            padding: 30px 0;\r\n"
				+ "            box-sizing: border-box;\r\n"
				+ "            flex-direction: column; /* 요소들을 수직으로 배치 */\r\n"
				+ "        }\r\n"
				+ "        .title {\r\n"
				+ "            margin: 0;\r\n"
				+ "            padding: 0 5px;\r\n"
				+ "            font-size: 28px;\r\n"
				+ "            font-weight: 400;\r\n"
				+ "        }\r\n"
				+ "        .subtitle {\r\n"
				+ "            border-bottom: 4px solid #ff9300; /* 메인 테마 색상 적용 */\r\n"
				+ "            font-size: 20px;\r\n"
				+ "            margin: 0 0 10px 3px;\r\n"
				+ "            padding: 10px 0px;\r\n"
				+ "			   display: inherit;"
				+ "            \r\n"
				+ "        }\r\n"
				+ "        .point-text {\r\n"
				+ "            color: #ff9300; /* 메인 테마 색상 적용 */\r\n"
				+ "        }\r\n"
				+ "        .content {\r\n"
				+ "            font-size: 16px;\r\n"
				+ "            line-height: 26px;\r\n"
				+ "            margin: 50px 0;\r\n"
				+ "            padding: 0 5px;\r\n"
				+ "        }\r\n"
				+ "        .number {\r\n"
				+ "            font-size: 30px;\r\n"
				+ "            text-align: center;\r\n"
				+ "            border: 3px solid #ff9300;\r\n"
				+ "            margin: 15px 100px;\r\n"
				+ "        }\r\n"
				+ "    </style>\r\n"
				+ "</head>\r\n"
				+ "<body>\r\n"
				+ "    <div class=\"container\">\r\n"
				+ "        <span class=\"subtitle\">Funddeuck</span>\r\n"
				+ "        <h1 class=\"title\">\r\n"
				+ "            <span class=\"point-text\">메일인증</span> 안내입니다.\r\n"
				+ "        </h1>\r\n"
				+ "        <p class=\"content\">\r\n"
				+ "            아래 <b class=\"point-text\">'메일 인증 번호'</b> 를 입력하여 회원가입을 완료해 주세요.<br />\r\n"
				+ "            감사합니다.\r\n"
				+ "        </p>\r\n"
				+ "        <!-- 메일 인증 번호 -->\r\n"
				+ "        <div class=\"number\" >"
				+ authCode
				+"</div>\r\n"
				+ "    </div>\r\n"
				+ "</body>\r\n"
				+ "</html>\r\n"
				+ "";
		
		//sendMailClient 인스턴스 생성 후 sendMail() 메서드를 호출하여 인증 메일 발송 요청
		// => 파라미터 : 이메일, 제목, 본문
		
		SendMailClient mailClient = new SendMailClient();
		
		isSendSuccess = mailClient.sendMail(email, subject, content);
		
		return isSendSuccess;
		
	}

}
