package com.itwillbs.test.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
/*
-- 메이커 테이블 생성
CREATE TABLE maker (
    maker_idx INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '메이커 번호',
    project_idx INT NOT NULL COMMENT '프로젝트 번호',
    maker_img VARCHAR(255) NOT NULL COMMENT '메이커 사진',
    maker_logo VARCHAR(255) NOT NULL COMMENT '메이커 로고',
    personal_id VARCHAR(255) COMMENT '메이커 유형-개인신분증',
    individual_biz_num INT COMMENT '메이커 유형-개인사업자등록번호',
    individual_biz_name VARCHAR(255) COMMENT '메이커 유형-개인사업자명',
    individual_biz_id VARCHAR(255) COMMENT '메이커 유형-개인사업자등록증',
    corporate_biz_num INT COMMENT '메이커 유형-법인사업자등록번호',
    corporate_biz_name VARCHAR(255) COMMENT '메이커 유형-법인사업자명',
    corporate_biz_id VARCHAR(255) COMMENT '메이커 유형-법인사업자등록증',
    maker_name VARCHAR(255) NOT NULL COMMENT '메이커 이름',
    maker_email VARCHAR(255) NOT NULL COMMENT '메이커 이메일',
    maker_tel VARCHAR(255) NOT NULL COMMENT '메이커 전화번호',
    maker_url VARCHAR(255) NOT NULL COMMENT '메이커 홈페이지'
-- 	foreign key (project_idx) references project(project_idx)    
);
*/
@Data
public class MakerVO {
    private int maker_idx;                  // 메이커 번호
    private int project_idx;                // 프로젝트 번호
    private int individual_biz_num;         // 메이커 유형 - 개인사업자 등록번호
    private String individual_biz_name;     // 메이커 유형 - 개인사업자명
    private int corporate_biz_num;          // 메이커 유형 - 법인사업자 등록번호
    private String corporate_biz_name;      // 메이커 유형 - 법인사업자명
    private String maker_name;              // 메이커 이름
    private String maker_email;             // 메이커 이메일
    private String maker_tel;               // 메이커 전화번호
    private String maker_url;               // 메이커 홈페이지
    // 사진
    private String maker_img;               // 메이커 사진
    private String maker_logo;              // 메이커 로고
    private String personal_id;             // 메이커 유형 - 개인신분증
    private String corporate_biz_id;        // 메이커 유형 - 법인사업자 등록증
    private String individual_biz_id;       // 메이커 유형 - 개인사업자 등록증
 // input type="file" 태그의 name 속성명(파라미터명)과 동일해야함
 	private MultipartFile file1;
 	private MultipartFile file2;
 	private MultipartFile file3;
 	private MultipartFile file4;
 	private MultipartFile file5;
}


