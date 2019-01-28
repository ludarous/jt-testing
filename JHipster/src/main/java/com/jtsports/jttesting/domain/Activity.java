package com.jtsports.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

import com.jtsports.jttesting.domain.enumeration.ActivityResultUnits;

import com.jtsports.jttesting.domain.enumeration.ResultType;

/**
 * A Activity.
 */
@Entity
@Table(name = "activity")
@Document(indexName = "activity")
public class Activity implements Serializable {

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

    @Column(name = "help")
    private String help;

    @Column(name = "jhi_key")
    private String key;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "primary_result_value_unit", nullable = false)
    private ActivityResultUnits primaryResultValueUnit;

    @Enumerated(EnumType.STRING)
    @Column(name = "secondary_result_value_unit")
    private ActivityResultUnits secondaryResultValueUnit;

    @Column(name = "min_age")
    private Integer minAge;

    @Column(name = "max_age")
    private Integer maxAge;

    @Enumerated(EnumType.STRING)
    @Column(name = "primary_result_type")
    private ResultType primaryResultType;

    @Enumerated(EnumType.STRING)
    @Column(name = "secondary_result_type")
    private ResultType secondaryResultType;

    @Column(name = "creation_time")
    private ZonedDateTime creationTime;

    @ManyToMany
    @JoinTable(name = "activity_categories",
               joinColumns = @JoinColumn(name = "activities_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "categories_id", referencedColumnName = "id"))
    private Set<ActivityCategory> categories = new HashSet<>();

    @ManyToOne
    @JsonIgnoreProperties("")
    private Person author;

    @ManyToOne
    @JsonIgnoreProperties("")
    private Group group;

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

    public Activity name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public Activity description(String description) {
        this.description = description;
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getHelp() {
        return help;
    }

    public Activity help(String help) {
        this.help = help;
        return this;
    }

    public void setHelp(String help) {
        this.help = help;
    }

    public String getKey() {
        return key;
    }

    public Activity key(String key) {
        this.key = key;
        return this;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public ActivityResultUnits getPrimaryResultValueUnit() {
        return primaryResultValueUnit;
    }

    public Activity primaryResultValueUnit(ActivityResultUnits primaryResultValueUnit) {
        this.primaryResultValueUnit = primaryResultValueUnit;
        return this;
    }

    public void setPrimaryResultValueUnit(ActivityResultUnits primaryResultValueUnit) {
        this.primaryResultValueUnit = primaryResultValueUnit;
    }

    public ActivityResultUnits getSecondaryResultValueUnit() {
        return secondaryResultValueUnit;
    }

    public Activity secondaryResultValueUnit(ActivityResultUnits secondaryResultValueUnit) {
        this.secondaryResultValueUnit = secondaryResultValueUnit;
        return this;
    }

    public void setSecondaryResultValueUnit(ActivityResultUnits secondaryResultValueUnit) {
        this.secondaryResultValueUnit = secondaryResultValueUnit;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public Activity minAge(Integer minAge) {
        this.minAge = minAge;
        return this;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public Activity maxAge(Integer maxAge) {
        this.maxAge = maxAge;
        return this;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public ResultType getPrimaryResultType() {
        return primaryResultType;
    }

    public Activity primaryResultType(ResultType primaryResultType) {
        this.primaryResultType = primaryResultType;
        return this;
    }

    public void setPrimaryResultType(ResultType primaryResultType) {
        this.primaryResultType = primaryResultType;
    }

    public ResultType getSecondaryResultType() {
        return secondaryResultType;
    }

    public Activity secondaryResultType(ResultType secondaryResultType) {
        this.secondaryResultType = secondaryResultType;
        return this;
    }

    public void setSecondaryResultType(ResultType secondaryResultType) {
        this.secondaryResultType = secondaryResultType;
    }

    public ZonedDateTime getCreationTime() {
        return creationTime;
    }

    public Activity creationTime(ZonedDateTime creationTime) {
        this.creationTime = creationTime;
        return this;
    }

    public void setCreationTime(ZonedDateTime creationTime) {
        this.creationTime = creationTime;
    }

    public Set<ActivityCategory> getCategories() {
        return categories;
    }

    public Activity categories(Set<ActivityCategory> activityCategories) {
        this.categories = activityCategories;
        return this;
    }

    public Activity addCategories(ActivityCategory activityCategory) {
        this.categories.add(activityCategory);
        return this;
    }

    public Activity removeCategories(ActivityCategory activityCategory) {
        this.categories.remove(activityCategory);
        return this;
    }

    public void setCategories(Set<ActivityCategory> activityCategories) {
        this.categories = activityCategories;
    }

    public Person getAuthor() {
        return author;
    }

    public Activity author(Person person) {
        this.author = person;
        return this;
    }

    public void setAuthor(Person person) {
        this.author = person;
    }

    public Group getGroup() {
        return group;
    }

    public Activity group(Group group) {
        this.group = group;
        return this;
    }

    public void setGroup(Group group) {
        this.group = group;
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
        Activity activity = (Activity) o;
        if (activity.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activity.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Activity{" +
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
            ", creationTime='" + getCreationTime() + "'" +
            "}";
    }
}
