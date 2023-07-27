package com.itwillbs.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.test.mapper.CouponMapper;
import com.itwillbs.test.vo.CouponVO;

@Service
public class CouponService {

    @Autowired
    private CouponMapper couponMapper;

    public List<CouponVO> getCouponsByNumAndUse(String couponNum, int couponUse) {
        return couponMapper.getCouponsByNumAndUse(couponNum, couponUse);
    }

    public List<CouponVO> getUsedCoupons() {
        return couponMapper.getCouponsByUse(1);
    }
}