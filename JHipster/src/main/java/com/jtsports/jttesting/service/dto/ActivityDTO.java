package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;
import com.jtsports.jttesting.domain.enumeration.ActivityResultUnits;
import com.jtsports.jttesting.domain.enumeration.ActivityResultUnits;
import com.jtsports.jttesting.domain.enumeration.ResultType;
import com.jtsports.jttesting.domain.enumeration.ResultType;

/**
 * A DTO for the Activity entity.
 */
public class ActivityDTO implements Serializable {

    private Long id;

    @NotNull
    private String name;

    private String description;

    private String help;

    private String key;

    @NotNull
    private ActivityResultUnits primaryResultValueUnit;

    private ActivityResultUnits secondaryResultValueUnit;

    private Integer minAge;

    private Integer maxAge;

    private ResultType primaryResultType;

    private ResultType secondaryResultType;

    private Set<ActivityCategoryDTO> categories = new HashSet<>();

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

    public String getHelp() {
        return help;
    }

    public void setHelp(String help) {
        this.help = help;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public ActivityResultUnits getPrimaryResultValueUnit() {
        return primaryResultValueUnit;
    }

    public void setPrimaryResultValueUnit(ActivityResultUnits primaryResultValueUnit) {
        this.primaryResultValueUnit = primaryResultValueUnit;
    }

    public ActivityResultUnits getSecondaryResultValueUnit() {
        return secondaryResultValueUnit;
    }

    public void setSecondaryResultValueUnit(ActivityResultUnits secondaryResultValueUnit) {
        this.secondaryResultValueUnit = secondaryResultValueUnit;
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

    public ResultType getPrimaryResultType() {
        return primaryResultType;
    }

    public void setPrimaryResultType(ResultType primaryResultType) {
        this.primaryResultType = primaryResultType;
    }

    public ResultType getSecondaryResultType() {
        return secondaryResultType;
    }

    public void setSecondaryResultType(ResultType secondaryResultType) {
        this.secondaryResultType = secondaryResultType;
    }

    public Set<ActivityCategoryDTO> getCategories() {
        return categories;
    }

    public void setCategories(Set<ActivityCategoryDTO> activityCategories) {
        this.categories = activityCategories;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ActivityDTO activityDTO = (ActivityDTO) o;
        if (activityDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityDTO{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", description='" + getDescription() + "'" +
            ", help='" + getHelp() + "'" +
            ", key='" + getKey() + "'" +
            ", primaryResultValueUnit='" + getPrimaryResultValueUnit() + "'" +
            ", secondaryResultValueUnit='" + getSecondaryResultValueUnit() + "'" +
            ", minAge=" + getMinAge() +
            ", maxAge=" + getMaxAge() +
            ", primaryResultType='" + getPrimaryResultType() + "'" +
            ", secondaryResultType='" + getSecondaryResultType() + "'" +
            "}";
    }
}
