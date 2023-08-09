package com.itwillbs.test.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.MakerMapper;
import com.itwillbs.test.mapper.MissionMapper;

@Service
public class MissionService {
	
	@Autowired
	private MissionMapper mapper;
	@Autowired
	private MakerMapper makerMapper;

	public boolean isMissionCompleted(int maker_idx, String mission_name) {
        int count = makerMapper.countCompletedMission(maker_idx, mission_name);
        Integer currentPoints = mapper.acmlCurrentPoints(maker_idx);
        if(count > 0) {
        	System.out.println("■■■■■■■■미션상태:"+count+" ====== 1-이미수행한미션입니다");
        	 if (currentPoints != null) {
        		 System.out.println("◆◆◆◆◆◆◆◆현재 점수: " + currentPoints);
        		 return count > 0; // true
        	 }
        }
        System.out.println("■■■■■■■■미션상태:"+count+" ====== 0-첫미션입니다");
        System.out.println("◆◆◆◆◆◆◆◆현재 점수: " + currentPoints);
        return count > 0; // false
    }

    public int addMissionPoints(int maker_idx, String mission_name, int points) {
        int updatedRows = 0;
    	
        if (!isMissionCompleted(maker_idx, mission_name)) {		
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("maker_idx", maker_idx);
            paramMap.put("mission_name", mission_name);
            paramMap.put("points", points);
            System.out.println("■■■■■■■■1점추가됨");
            
            updatedRows = makerMapper.insertMission(paramMap);

            if (updatedRows > 0) {
            	// 등급 업데이트 진행하기
                int updateGradeCount = makerMapper.updateMakerGrade(maker_idx);
                if (updateGradeCount > 0) {
                	// 현재 점수 조회
                    Integer currentPoints = mapper.acmlCurrentPoints(maker_idx);
                    int currentGrade = makerMapper.getMakerGrade(maker_idx);
                    System.out.println("◆◆◆◆◆◆◆◆등급이 업데이트되었습니다! 현재 등급: " + currentGrade);
                    System.out.println("◆◆◆◆◆◆◆◆현재 점수: " + currentPoints);
                }
            }
        }

        return updatedRows;
    }
	
	
}
