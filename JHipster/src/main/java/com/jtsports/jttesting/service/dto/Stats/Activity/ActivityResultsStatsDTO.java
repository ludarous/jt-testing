package com.jtsports.jttesting.service.dto.Stats.Activity;

public class ActivityResultsStatsDTO {

    private Float resultsMinValue;

    private Float resultsAverageValue;

    private Float resultsMedianValue;

    private Float resultsMaxValue;

    private Integer resultsCount;

    public Float getResultsMinValue() {
        return resultsMinValue;
    }

    public void setResultsMinValue(Float resultsMinValue) {
        this.resultsMinValue = resultsMinValue;
    }

    public Float getResultsMaxValue() {
        return resultsMaxValue;
    }

    public void setResultsMaxValue(Float resultsMaxValue) {
        this.resultsMaxValue = resultsMaxValue;
    }

    public Integer getResultsCount() {
        return resultsCount;
    }

    public void setResultsCount(Integer resultsCount) {
        this.resultsCount = resultsCount;
    }

    public Float getResultsAverageValue() {
        return resultsAverageValue;
    }

    public void setResultsAverageValue(Float resultsAverageValue) {
        this.resultsAverageValue = resultsAverageValue;
    }

    public Float getResultsMedianValue() { return resultsMedianValue; }

    public void setResultsMedianValue(Float resultsMedianValue) { this.resultsMedianValue = resultsMedianValue; }
}
