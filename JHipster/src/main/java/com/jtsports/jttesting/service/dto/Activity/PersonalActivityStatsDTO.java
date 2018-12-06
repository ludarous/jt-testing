package com.jtsports.jttesting.service.dto.Activity;

import com.jtsports.jttesting.service.dto.ActivityDTO;

public class PersonalActivityStatsDTO extends ActivityStatsDTO {

    private PersonalActivityResultsStatsDTO personalActivityResultsStats;

    public PersonalActivityResultsStatsDTO getPersonalActivityResultsStats() {
        return personalActivityResultsStats;
    }

    public void setPersonalActivityResultsStats(PersonalActivityResultsStatsDTO personalActivityResultsStats) {
        this.personalActivityResultsStats = personalActivityResultsStats;
    }
}
