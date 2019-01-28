package com.jtsports.jttesting.service.dto.Stats.Activity;

import com.jtsports.jttesting.service.dto.ActivityDTO;
import com.jtsports.jttesting.service.dto.ActivityResultDTO;

import java.util.List;

public class PersonalActivityStatsDTO {

    private ActivityDTO activity;

    private ActivityResultsStatsDTO primaryResultsStats;

    private ActivityResultsStatsDTO secondaryResultsStats;

    private PersonalActivityResultsStatsDTO primaryPersonalActivityStats;

    private PersonalActivityResultsStatsDTO secondaryPersonalActivityStats;

    private List<ActivityResultDTO> personalActivityResults;

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

    public PersonalActivityResultsStatsDTO getPrimaryPersonalActivityStats() {
        return primaryPersonalActivityStats;
    }

    public void setPrimaryPersonalActivityStats(PersonalActivityResultsStatsDTO primaryPersonalActivityStats) {
        this.primaryPersonalActivityStats = primaryPersonalActivityStats;
    }

    public PersonalActivityResultsStatsDTO getSecondaryPersonalActivityStats() {
        return secondaryPersonalActivityStats;
    }

    public void setSecondaryPersonalActivityStats(PersonalActivityResultsStatsDTO secondaryPersonalActivityStats) {
        this.secondaryPersonalActivityStats = secondaryPersonalActivityStats;
    }

    public List<ActivityResultDTO> getPersonalActivityResults() {
        return personalActivityResults;
    }

    public void setPersonalActivityResults(List<ActivityResultDTO> personalActivityResults) {
        this.personalActivityResults = personalActivityResults;
    }

}
