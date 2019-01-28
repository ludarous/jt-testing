package com.jtsports.jttesting.service.dto.Stats;

import com.jtsports.jttesting.service.dto.Stats.Activity.PersonalActivityStatsDTO;
import com.jtsports.jttesting.service.dto.Stats.Category.PersonalCategoryStatsDTO;

import java.util.List;

public class PersonalStatsDTO {

    private List<PersonalActivityStatsDTO> activitiesStats;

    private List<PersonalCategoryStatsDTO> categoriesStats;

    public List<PersonalActivityStatsDTO> getActivitiesStats() {
        return activitiesStats;
    }

    public void setActivitiesStats(List<PersonalActivityStatsDTO> activitiesStats) {
        this.activitiesStats = activitiesStats;
    }

    public List<PersonalCategoryStatsDTO> getCategoriesStats() {
        return categoriesStats;
    }

    public void setCategoriesStats(List<PersonalCategoryStatsDTO> categoriesStats) {
        this.categoriesStats = categoriesStats;
    }
}
