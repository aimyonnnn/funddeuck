package com.itwillbs.test.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ChartDataVO {
    private List<String> labels;
    private List<Integer> dailyPaymentAmounts;
    private List<Integer> acmlPaymentAmounts;
    private List<Integer> dailySupporterCounts;
    private List<Integer> acmlSupporterCounts;
}


