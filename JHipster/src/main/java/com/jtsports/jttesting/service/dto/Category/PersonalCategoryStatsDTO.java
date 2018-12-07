package com.jtsports.jttesting.service.dto.Category;

import com.jtsports.jttesting.service.dto.ActivityCategoryDTO;
import io.undertow.conduits.ByteActivityCallback;

import java.util.List;

public class PersonalCategoryStatsDTO {

    private ActivityCategoryDTO parentCategory;

    private List<PersonalCategoryResultsStatsDTO> personalCategoriesResultsStats;

    public List<PersonalCategoryResultsStatsDTO> getPersonalCategoriesResultsStats() {
        return personalCategoriesResultsStats;
    }

    public void setPersonalCategoriesResultsStats(List<PersonalCategoryResultsStatsDTO> personalCategoriesResultsStats) {
        this.personalCategoriesResultsStats = personalCategoriesResultsStats;
    }

    public ActivityCategoryDTO getParentCategory() {
        return parentCategory;
    }

    public void setParentCategory(ActivityCategoryDTO parentCategory) {
        this.parentCategory = parentCategory;
    }
}
