package com.jtsports.jttesting.service.dto.Category;

import com.jtsports.jttesting.service.dto.ActivityCategoryDTO;

public class PersonalCategoryResultsStatsDTO {

    private ActivityCategoryDTO category;

    private Float primaryPlacement;

    private Float secondaryPlacement;

    public ActivityCategoryDTO getCategory() {
        return category;
    }

    public void setCategory(ActivityCategoryDTO category) {
        this.category = category;
    }

    public Float getPrimaryPlacement() {
        return primaryPlacement;
    }

    public void setPrimaryPlacement(Float primaryPlacement) {
        this.primaryPlacement = primaryPlacement;
    }

    public Float getSecondaryPlacement() {
        return secondaryPlacement;
    }

    public void setSecondaryPlacement(Float secondaryPlacement) {
        this.secondaryPlacement = secondaryPlacement;
    }
}
