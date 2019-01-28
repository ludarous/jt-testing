package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A DTO for the ActivityGroup entity.
 */
public class ActivityGroupDTO implements Serializable {

    private Long id;

    @NotNull
    private String name;

    private String description;

    private Integer minAge;

    private Integer maxAge;

    private Set<ActivityDTO> activities = new HashSet<>();

    private Set<ActivityGroupCategoryDTO> activityGroupCategories = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Set<ActivityDTO> getActivities() {
        return activities;
    }

    public void setActivities(Set<ActivityDTO> activities) {
        this.activities = activities;
    }

    public Set<ActivityGroupCategoryDTO> getActivityGroupCategories() {
        return activityGroupCategories;
    }

    public void setActivityGroupCategories(Set<ActivityGroupCategoryDTO> activityGroupCategories) {
        this.activityGroupCategories = activityGroupCategories;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ActivityGroupDTO activityGroupDTO = (ActivityGroupDTO) o;
        if (activityGroupDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityGroupDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityGroupDTO{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", description='" + getDescription() + "'" +
            ", minAge=" + getMinAge() +
            ", maxAge=" + getMaxAge() +
            "}";
    }
}
