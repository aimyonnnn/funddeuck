package com.itwillbs.test.vo;

import java.util.List;

import lombok.Data;

@Data
public class ChartDataVO {
    private List<String> labels;
    private List<Integer> dailyPaymentAmounts;
    private List<Integer> cumulativePaymentAmounts;
    private List<Integer> dailySupporterCounts;
    private List<Integer> cumulativeSupporterCounts;

    public ChartDataVO() {}

    public ChartDataVO(List<String> labels, List<Integer> dailyPaymentAmounts, List<Integer> cumulativePaymentAmounts,
                       List<Integer> dailySupporterCounts, List<Integer> cumulativeSupporterCounts) {
        this.labels = labels;
        this.dailyPaymentAmounts = dailyPaymentAmounts;
        this.cumulativePaymentAmounts = cumulativePaymentAmounts;
        this.dailySupporterCounts = dailySupporterCounts;
        this.cumulativeSupporterCounts = cumulativeSupporterCounts;
    }
}

