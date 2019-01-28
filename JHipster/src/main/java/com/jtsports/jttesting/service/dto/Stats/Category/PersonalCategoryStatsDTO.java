package com.jtsports.jttesting.service.dto.Stats.Category;

import com.jtsports.jttesting.service.dto.ActivityCategoryDTO;

import java.util.List;

public class PersonalCategoryStatsDTO {

    private ActivityCategoryDTO category;

    private PersonalCategoryResultsStatsDTO primaryCategoryResultsStats;

    private PersonalCategoryResultsStatsDTO secondaryCategoryResultsStats;

    private List<PersonalCategoryStatsDTO> childCategoryPersonalStats;

    public ActivityCategoryDTO getCategory() {
        return category;
    }

    public void setCategory(ActivityCategoryDTO category) {
        this.category = category;
    }

    public PersonalCategoryResultsStatsDTO getPrimaryCategoryResultsStats() {
        return primaryCategoryResultsStats;
    }

    public void setPrimaryCategoryResultsStats(PersonalCategoryResultsStatsDTO primaryCategoryResultsStats) {
        this.primaryCategoryResultsStats = primaryCategoryResultsStats;
    }

    public PersonalCategoryResultsStatsDTO getSecondaryCategoryResultsStats() {
        return secondaryCategoryResultsStats;
    }

    public void setSecondaryCategoryResultsStats(PersonalCategoryResultsStatsDTO secondaryCategoryResultsStats) {
        this.secondaryCategoryResultsStats = secondaryCategoryResultsStats;
    }

    public List<PersonalCategoryStatsDTO> getChildCategoryPersonalStats() {
        return childCategoryPersonalStats;
    }

    public void setChildCategoryPersonalStats(List<PersonalCategoryStatsDTO> childCategoryPersonalStats) {
        this.childCategoryPersonalStats = childCategoryPersonalStats;
    }
}
