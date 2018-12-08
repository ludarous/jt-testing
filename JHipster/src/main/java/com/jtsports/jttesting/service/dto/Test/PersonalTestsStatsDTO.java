package com.jtsports.jttesting.service.dto.Test;

import com.jtsports.jttesting.service.dto.Activity.PersonalActivityStatsDTO;
import com.jtsports.jttesting.service.dto.Category.PersonalCategoryStatsDTO;

import java.util.List;

public class PersonalTestsStatsDTO {

    private PersonalCategoryStatsDTO personalCategoryStats;

    private List<PersonalActivityStatsDTO> personalActivitiesStats;

    public PersonalCategoryStatsDTO getPersonalCategoryStats() {
        return personalCategoryStats;
    }

    public void setPersonalCategoryStats(PersonalCategoryStatsDTO personalCategoryStats) {
        this.personalCategoryStats = personalCategoryStats;
    }

    public List<PersonalActivityStatsDTO> getPersonalActivitiesStats() {
        return personalActivitiesStats;
    }

    public void setPersonalActivitiesStats(List<PersonalActivityStatsDTO> personalActivitiesStats) {
        this.personalActivitiesStats = personalActivitiesStats;
    }
}
