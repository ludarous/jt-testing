package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

/**
 * A DTO for the ActivityCategory entity.
 */
public class ActivityCategoryDTO implements Serializable {

    private Long id;

    @NotNull
    private String name;

    private String key;

    private String description;

    private Long parentId;

    private String parentName;

    private Set<ActivityCategoryDTO> children = new HashSet<ActivityCategoryDTO>();

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

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long activityCategoryId) {
        this.parentId = activityCategoryId;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String activityCategoryName) {
        this.parentName = activityCategoryName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ActivityCategoryDTO activityCategoryDTO = (ActivityCategoryDTO) o;
        if (activityCategoryDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityCategoryDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityCategoryDTO{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", key='" + getKey() + "'" +
            ", description='" + getDescription() + "'" +
            ", parent=" + getParentId() +
            ", parent='" + getParentName() + "'" +
            "}";
    }

    public Set<ActivityCategoryDTO> getChildren() {
        return children;
    }

    public void setChildren(Set<ActivityCategoryDTO> children) {
        this.children = children;
    }
}
