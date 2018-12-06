package com.jtsports.jttesting.service.dto.Activity;

public class ActivityResultsStatsDTO {

    private Float primaryMin;

    private Float secondaryMin;

    private Float primaryAverage;

    private Float secondaryAverage;

    private Float primaryMedian;

    private Float secondaryMedian;

    private Float primaryMax;

    private Float secondaryMax;

    private Integer primaryResultsCount;

    private Integer secondaryResultsCount;

    public Float getPrimaryMin() {
        return primaryMin;
    }

    public void setPrimaryMin(Float primaryMin) {
        this.primaryMin = primaryMin;
    }

    public Float getSecondaryMin() {
        return secondaryMin;
    }

    public void setSecondaryMin(Float secondaryMin) {
        this.secondaryMin = secondaryMin;
    }

    public Float getPrimaryMedian() {
        return primaryMedian;
    }

    public void setPrimaryMedian(Float primaryMedian) {
        this.primaryMedian = primaryMedian;
    }

    public Float getSecondaryMedian() {
        return secondaryMedian;
    }

    public void setSecondaryMedian(Float secondaryMedian) {
        this.secondaryMedian = secondaryMedian;
    }

    public Float getPrimaryMax() {
        return primaryMax;
    }

    public void setPrimaryMax(Float primaryMax) {
        this.primaryMax = primaryMax;
    }

    public Float getSecondaryMax() {
        return secondaryMax;
    }

    public void setSecondaryMax(Float secondaryMax) {
        this.secondaryMax = secondaryMax;
    }

    public Float getPrimaryAverage() {
        return primaryAverage;
    }

    public void setPrimaryAverage(Float primaryAverage) {
        this.primaryAverage = primaryAverage;
    }

    public Float getSecondaryAverage() {
        return secondaryAverage;
    }

    public void setSecondaryAverage(Float secondaryAverage) {
        this.secondaryAverage = secondaryAverage;
    }

    public Integer getPrimaryResultsCount() {
        return primaryResultsCount;
    }

    public void setPrimaryResultsCount(Integer primaryResultsCount) {
        this.primaryResultsCount = primaryResultsCount;
    }

    public Integer getSecondaryResultsCount() {
        return secondaryResultsCount;
    }

    public void setSecondaryResultsCount(Integer secondaryResultsCount) {
        this.secondaryResultsCount = secondaryResultsCount;
    }
}
