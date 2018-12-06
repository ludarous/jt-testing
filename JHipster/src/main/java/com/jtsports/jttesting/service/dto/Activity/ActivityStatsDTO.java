package com.jtsports.jttesting.service.dto.Activity;

import com.jtsports.jttesting.service.dto.ActivityDTO;

public class ActivityStatsDTO {

    private ActivityDTO activity;

    private ActivityResultsStatsDTO activityResultsStats;

    public ActivityDTO getActivity() {
        return activity;
    }

    public void setActivity(ActivityDTO activity) {
        this.activity = activity;
    }

    public ActivityResultsStatsDTO getActivityResultsStats() {
        return activityResultsStats;
    }

    public void setActivityResultsStats(ActivityResultsStatsDTO activityResultsStats) {
        this.activityResultsStats = activityResultsStats;
    }
}
