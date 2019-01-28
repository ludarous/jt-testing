package com.jtsports.jttesting.service.dto.Stats.Activity;

import com.jtsports.jttesting.service.dto.ActivityDTO;

public class ActivityStatsDTO {

    private ActivityDTO activity;

    private ActivityResultsStatsDTO primaryResultsStats;

    private ActivityResultsStatsDTO secondaryResultsStats;

    public ActivityDTO getActivity() {
        return activity;
    }

    public void setActivity(ActivityDTO activity) {
        this.activity = activity;
    }

    public ActivityResultsStatsDTO getPrimaryResultsStats() {
        return primaryResultsStats;
    }

    public void setPrimaryResultsStats(ActivityResultsStatsDTO primaryResultsStats) {
        this.primaryResultsStats = primaryResultsStats;
    }

    public ActivityResultsStatsDTO getSecondaryResultsStats() {
        return secondaryResultsStats;
    }

    public void setSecondaryResultsStats(ActivityResultsStatsDTO secondaryResultsStats) {
        this.secondaryResultsStats = secondaryResultsStats;
    }

}
