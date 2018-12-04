package com.jtsports.jttesting.service.dto.Activity;

import com.jtsports.jttesting.service.dto.ActivityDTO;

public class ActivityStatsDTO {

    private ActivityDTO activity;

    private ActivityResultsStatsDTO virtualStats;

    private ActivityResultsStatsDTO realStats;

    public ActivityDTO getActivity() {
        return activity;
    }

    public void setActivity(ActivityDTO activity) {
        this.activity = activity;
    }

    public ActivityResultsStatsDTO getVirtualStats() {
        return virtualStats;
    }

    public void setVirtualStats(ActivityResultsStatsDTO virtualStats) {
        this.virtualStats = virtualStats;
    }

    public ActivityResultsStatsDTO getRealStats() {
        return realStats;
    }

    public void setRealStats(ActivityResultsStatsDTO realStats) {
        this.realStats = realStats;
    }
}
