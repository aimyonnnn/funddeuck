package com.itwillbs.test.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CreditMapper {

	int insertCreditInfo(
			@Param("p_orderNum") String p_orderNum, 
			@Param("payment_num") String payment_num, 
			@Param("payment_total_price") int payment_total_price, 
			@Param("member_idx") Integer member_idx);

}
