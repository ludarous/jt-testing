package com.jtsports.jttesting.service.dto.Test;

import com.jtsports.jttesting.service.dto.Activity.PersonalActivityStatsDTO;

import java.util.List;

public class PersonalTestStatsDTO {

    private List<PersonalActivityStatsDTO> personalActivitiesStats;

    public List<PersonalActivityStatsDTO> getPersonalActivitiesStats() {
        return personalActivitiesStats;
    }

    public void setPersonalActivitiesStats(List<PersonalActivityStatsDTO> personalActivitiesStats) {
        this.personalActivitiesStats = personalActivitiesStats;
    }
}
