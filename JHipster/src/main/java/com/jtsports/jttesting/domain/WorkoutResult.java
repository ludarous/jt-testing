package com.jtsports.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A WorkoutResult.
 */
@Entity
@Table(name = "workout_result")
@Document(indexName = "workoutresult")
public class WorkoutResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @Column(name = "note")
    private String note;

    @ManyToOne
    @JsonIgnore
    private EventResult eventResult;

    @OneToMany(mappedBy = "workoutResult", cascade = CascadeType.ALL)
    private Set<ActivityResult> activitiesResults = new HashSet<>();

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private Workout workout;

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public WorkoutResult note(String note) {
        this.note = note;
        return this;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public EventResult getEventResult() {
        return eventResult;
    }

    public WorkoutResult eventResult(EventResult eventResult) {
        this.eventResult = eventResult;
        return this;
    }

    public void setEventResult(EventResult eventResult) {
        this.eventResult = eventResult;
    }

    public Set<ActivityResult> getActivitiesResults() {
        return activitiesResults;
    }

    public WorkoutResult activitiesResults(Set<ActivityResult> activityResults) {
        this.activitiesResults = activityResults;
        return this;
    }

    public WorkoutResult addActivitiesResults(ActivityResult activityResult) {
        this.activitiesResults.add(activityResult);
        activityResult.setWorkoutResult(this);
        return this;
    }

    public WorkoutResult removeActivitiesResults(ActivityResult activityResult) {
        this.activitiesResults.remove(activityResult);
        activityResult.setWorkoutResult(null);
        return this;
    }

    public void setActivitiesResults(Set<ActivityResult> activityResults) {
        this.activitiesResults = activityResults;
    }

    public Workout getWorkout() {
        return workout;
    }

    public WorkoutResult workout(Workout workout) {
        this.workout = workout;
        return this;
    }

    public void setWorkout(Workout workout) {
        this.workout = workout;
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
        WorkoutResult workoutResult = (WorkoutResult) o;
        if (workoutResult.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), workoutResult.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "WorkoutResult{" +
            "id=" + getId() +
            ", note='" + getNote() + "'" +
            "}";
    }

    public static WorkoutResult createWorkoutResult(Workout workout, EventResult eventResult, Event event, Person person) {
        String personName =  eventResult.getPerson().getPersonalData().getFirstName() + " " + eventResult.getPerson().getPersonalData().getLastName();
        WorkoutResult workoutResult = new WorkoutResult();
        workoutResult.setWorkout(workout);
        workoutResult.setEventResult(eventResult);
        workoutResult.setNote("Poznámka k testu " + workout.getName() + ". Osooba: " + personName);

        HashSet<ActivityResult> activitiesResults = new HashSet<>();
        for(Activity activity : workout.getActivities()) {
            activitiesResults.add(ActivityResult.craeteActivityResult(activity, workoutResult, workout, event, person));
        }
        workoutResult.setActivitiesResults(activitiesResults);

        return workoutResult;
    }
}
