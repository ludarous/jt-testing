package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the ActivityGroupCategory entity.
 */
public class ActivityGroupCategoryDTO implements Serializable {

    private Long id;

    @NotNull
    private String name;

    private String key;

    private String description;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ActivityGroupCategoryDTO activityGroupCategoryDTO = (ActivityGroupCategoryDTO) o;
        if (activityGroupCategoryDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityGroupCategoryDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityGroupCategoryDTO{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", key='" + getKey() + "'" +
            ", description='" + getDescription() + "'" +
            "}";
    }
}
