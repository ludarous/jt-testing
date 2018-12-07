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

    public Float getPrimaryPlacementInPercents() {
        if(this.personalActivityResultsStats.getPrimaryPlacement() != null && this.getActivityResultsStats().getPrimaryResultsCount() != null) {
            return (float) this.personalActivityResultsStats.getPrimaryPlacement() / (float) this.getActivityResultsStats().getPrimaryResultsCount();
        }
        return null;
    }

    public Float getSecondaryPlacementInPercents() {
        if(this.personalActivityResultsStats.getSecondaryPlacement() != null && this.getActivityResultsStats().getSecondaryResultsCount() != null) {
            return (float) this.personalActivityResultsStats.getSecondaryPlacement() / (float) this.getActivityResultsStats().getSecondaryResultsCount();
        }
        return null;
    }
}
