package com.itwillbs.test.handler;

import org.apache.commons.lang3.*;

// 특정 난수 생성
public class GenerateRandomCode {
	public static String getRandomCode(int length) {
		return RandomStringUtils.randomAlphanumeric(length); // 전달받은 length 에 해당하는 길이의 난수 리턴
	}	
}
