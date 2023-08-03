package com.itwillbs.test.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.CouponMapper;
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

}
