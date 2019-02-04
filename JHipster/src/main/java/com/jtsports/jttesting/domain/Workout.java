package com.jtsports.jttesting.domain;


import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A Workout.
 */
@Entity
@Table(name = "workout")
@Document(indexName = "workout")
public class Workout implements Serializable {

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
    @JoinTable(name = "workout_activities",
               joinColumns = @JoinColumn(name = "workouts_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "activities_id", referencedColumnName = "id"))
    private Set<Activity> activities = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "workout_workout_categories",
               joinColumns = @JoinColumn(name = "workouts_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "workout_categories_id", referencedColumnName = "id"))
    private Set<WorkoutCategory> workoutCategories = new HashSet<>();

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

    public Workout name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public Workout description(String description) {
        this.description = description;
        return this;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public Workout minAge(Integer minAge) {
        this.minAge = minAge;
        return this;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public Workout maxAge(Integer maxAge) {
        this.maxAge = maxAge;
        return this;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Set<Activity> getActivities() {
        return activities;
    }

    public Workout activities(Set<Activity> activities) {
        this.activities = activities;
        return this;
    }

    public Workout addActivities(Activity activity) {
        this.activities.add(activity);
        return this;
    }

    public Workout removeActivities(Activity activity) {
        this.activities.remove(activity);
        return this;
    }

    public void setActivities(Set<Activity> activities) {
        this.activities = activities;
    }

    public Set<WorkoutCategory> getWorkoutCategories() {
        return workoutCategories;
    }

    public Workout workoutCategories(Set<WorkoutCategory> workoutCategories) {
        this.workoutCategories = workoutCategories;
        return this;
    }

    public Workout addWorkoutCategories(WorkoutCategory workoutCategory) {
        this.workoutCategories.add(workoutCategory);
        return this;
    }

    public Workout removeWorkoutCategories(WorkoutCategory workoutCategory) {
        this.workoutCategories.remove(workoutCategory);
        return this;
    }

    public void setWorkoutCategories(Set<WorkoutCategory> workoutCategories) {
        this.workoutCategories = workoutCategories;
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
        Workout workout = (Workout) o;
        if (workout.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), workout.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Workout{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", description='" + getDescription() + "'" +
            ", minAge=" + getMinAge() +
            ", maxAge=" + getMaxAge() +
            "}";
    }
}
