package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.test.vo.CreditVO;

@Mapper
public interface CreditMapper {

	CreditVO insertCreditInfo(
			@Param("p_orderNum") int p_orderNum, 
			@Param("payment_num") int payment_num, 
			@Param("payment_total_price") int payment_total_price, 
			@Param("member_idx") Integer member_idx);
}
