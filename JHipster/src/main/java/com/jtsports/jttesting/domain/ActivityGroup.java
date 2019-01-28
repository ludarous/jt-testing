package com.jtsports.jttesting.domain;


import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A ActivityGroup.
 */
@Entity
@Table(name = "activity_group")
@Document(indexName = "activitygroup")
public class ActivityGroup implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "min_age")
    private Integer minAge;

    @Column(name = "max_age")
    private Integer maxAge;

    @ManyToMany
    @JoinTable(name = "activity_group_activities",
               joinColumns = @JoinColumn(name = "activity_groups_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "activities_id", referencedColumnName = "id"))
    private Set<Activity> activities = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "activity_group_activity_group_categories",
               joinColumns = @JoinColumn(name = "activity_groups_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "activity_group_categories_id", referencedColumnName = "id"))
    private Set<ActivityGroupCategory> activityGroupCategories = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public ActivityGroup name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public ActivityGroup description(String description) {
        this.description = description;
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public ActivityGroup minAge(Integer minAge) {
        this.minAge = minAge;
        return this;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public ActivityGroup maxAge(Integer maxAge) {
        this.maxAge = maxAge;
        return this;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Set<Activity> getActivities() {
        return activities;
    }

    public ActivityGroup activities(Set<Activity> activities) {
        this.activities = activities;
        return this;
    }

    public ActivityGroup addActivities(Activity activity) {
        this.activities.add(activity);
        return this;
    }

    public ActivityGroup removeActivities(Activity activity) {
        this.activities.remove(activity);
        return this;
    }

    public void setActivities(Set<Activity> activities) {
        this.activities = activities;
    }

    public Set<ActivityGroupCategory> getActivityGroupCategories() {
        return activityGroupCategories;
    }

    public ActivityGroup activityGroupCategories(Set<ActivityGroupCategory> activityGroupCategories) {
        this.activityGroupCategories = activityGroupCategories;
        return this;
    }

    public ActivityGroup addActivityGroupCategories(ActivityGroupCategory activityGroupCategory) {
        this.activityGroupCategories.add(activityGroupCategory);
        return this;
    }

    public ActivityGroup removeActivityGroupCategories(ActivityGroupCategory activityGroupCategory) {
        this.activityGroupCategories.remove(activityGroupCategory);
        return this;
    }

    public void setActivityGroupCategories(Set<ActivityGroupCategory> activityGroupCategories) {
        this.activityGroupCategories = activityGroupCategories;
    }
    // jhipster-needle-entity-add-getters-setters - JHipster will add getters and setters here, do not remove

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }
        ActivityGroup activityGroup = (ActivityGroup) o;
        if (activityGroup.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityGroup.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityGroup{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", description='" + getDescription() + "'" +
            ", minAge=" + getMinAge() +
            ", maxAge=" + getMaxAge() +
            "}";
    }
}
