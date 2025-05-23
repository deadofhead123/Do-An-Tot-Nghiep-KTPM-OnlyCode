package com.javaweb.service.statistic;

import com.javaweb.model.statistic.ExcessProductStatistic;
import com.javaweb.model.statistic.HotProductStatistic;

import java.util.List;

public interface IStatisticService {
    List<HotProductStatistic> findProductWithHighestQuantitySold(String date);
    List<ExcessProductStatistic> findProductWithLowestQuantitySold(String date);
}
