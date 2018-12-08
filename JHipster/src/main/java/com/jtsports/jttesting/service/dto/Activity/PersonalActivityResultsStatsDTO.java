package com.jtsports.jttesting.service.dto.Activity;

public class PersonalActivityResultsStatsDTO {

    private Integer primaryPlacement;

    private Integer secondaryPlacement;

    private Integer totalPrimaryResults;

    private Integer totalSecondaryResults;

    public Integer getPrimaryPlacement() {
        return primaryPlacement;
    }

    public void setPrimaryPlacement(Integer primaryPlacement) {
        this.primaryPlacement = primaryPlacement;
    }

    public Integer getSecondaryPlacement() {
        return secondaryPlacement;
    }

    public void setSecondaryPlacement(Integer secondaryPlacement) {
        this.secondaryPlacement = secondaryPlacement;
    }

    public Integer getTotalPrimaryResults() {
        return totalPrimaryResults;
    }

    public void setTotalPrimaryResults(Integer totalPrimaryResults) {
        this.totalPrimaryResults = totalPrimaryResults;
    }

    public Integer getTotalSecondaryResults() {
        return totalSecondaryResults;
    }

    public void setTotalSecondaryResults(Integer totalSecondaryResults) {
        this.totalSecondaryResults = totalSecondaryResults;
    }
}
