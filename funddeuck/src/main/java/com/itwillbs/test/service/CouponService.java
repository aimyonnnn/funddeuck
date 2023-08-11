package com.itwillbs.test.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import com.itwillbs.test.mapper.CouponMapper;
import com.itwillbs.test.vo.CouponBannerVO;
import com.itwillbs.test.vo.CouponVO;

@Service
public class CouponService {
	
	@Autowired
    private CouponMapper couponMapper;

    public void registerCoupon(CouponVO couponVO) {
        couponMapper.insertCoupon(couponVO);
    }
    
    public List<CouponVO> getCouponList() {
        return couponMapper.getCouponList();
    }

    public List<CouponVO> getExpiredCoupons() {
        return couponMapper.getExpiredCoupons();
    }

    public void updateCoupon(CouponVO couponVO) {
        couponMapper.updateCoupon(couponVO);
    }

    public List<CouponVO> getExpiredCoupons(LocalDateTime now) {
        return couponMapper.getExpiredCoupons(now);
    }

    //-----------------------------------------------------------------------------------------
    
	public CouponVO getCouponInfoByNumber(String couponNumber) {
        return couponMapper.getCouponInfoByNumber(couponNumber);
	} 
	
	public List<CouponVO> getCouponsByMemberAndStatus(int memberIdx, int couponUse) {
	    return couponMapper.getCouponsByMemberAndStatus(memberIdx, couponUse);
	}

    public List<CouponVO> getUsedCoupons(int memberIdx) {
        return couponMapper.getUsedCoupons(memberIdx);
    }


    //--------------------------------------------------------------------------------------------
    
    public void insertCouponBanner(CouponBannerVO couponBannerVO, String uploadedFileName, HttpSession session) {
        // 중복 처리 방지를 위해 이미 업로드된 파일 이름을 체크
        if (uploadedFileName == null || !uploadedFileName.equals(couponBannerVO.getFile().getOriginalFilename())) {
            // 이미 업로드된 파일이 아니라면, 파일 업로드 수행
            String uploadDir = "/resources/upload";
            String saveDir = session.getServletContext().getRealPath(uploadDir);
            String subDir = "";

            try {
                Date date = new Date();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
                subDir = sdf.format(date);
                saveDir += "/" + subDir;
                Path path = Paths.get(saveDir);
                Files.createDirectories(path);
            } catch (IOException e) {
                e.printStackTrace();
            }

            MultipartFile file = couponBannerVO.getFile();

            String uuid = UUID.randomUUID().toString();
            String fileName = null;

            if (file != null && !file.getOriginalFilename().equals("")) {
                fileName = uuid.substring(0, 8) + "_" + file.getOriginalFilename();
                couponBannerVO.setNewCouponImage(subDir + "/" + fileName);
                try {
                    // 파일 업로드 처리
                    file.transferTo(new File(saveDir, fileName));
                    System.out.println("확인3");
                } catch (IllegalStateException | IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // 쿠폰 광고 등록 처리
        couponMapper.insertCouponBanner(couponBannerVO);
    }

	public List<CouponBannerVO> getNewCouponList() {
		return couponMapper.getNewCouponList();
	}


}
