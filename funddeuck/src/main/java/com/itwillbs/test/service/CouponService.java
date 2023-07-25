package com.itwillbs.test.service;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.itwillbs.test.mapper.*;
import com.itwillbs.test.vo.*;

@Service
public class CouponService {

    private final CouponMapper couponMapper;

    @Autowired
    public CouponService(CouponMapper couponMapper) {
        this.couponMapper = couponMapper;
    }

    public CouponVO getCouponByNumber(String coupon_num) {
        return couponMapper.getCouponByNumber(coupon_num);
    }
}