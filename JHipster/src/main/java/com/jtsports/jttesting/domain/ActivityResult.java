package com.jtsports.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import javax.validation.constraints.*;

import com.jtsports.jttesting.domain.util.RandomNumbers;
import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.Objects;

/**
 * A ActivityResult.
 */
@Entity
@Table(name = "activity_result", indexes = {@Index(name = "filter_index", columnList = "jhi_date, activity_id, workout_id, event_id, person_id")})
@Document(indexName = "activityresult")
public class ActivityResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @Column(name = "primary_result_value")
    private Float primaryResultValue;

    @Column(name = "secondary_result_value")
    private Float secondaryResultValue;

    @Column(name = "note")
    private String note;

    @Column(name = "jhi_date")
    private ZonedDateTime date;

    @Column(name = "official")
    private Boolean official;

    @ManyToOne
    @JsonIgnoreProperties("activitiesResults")
    private WorkoutResult workoutResult;

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private Activity activity;

    @ManyToOne
    @JsonIgnoreProperties("")
    private Workout workout;

    @ManyToOne
    @JsonIgnoreProperties("")
    private Event event;

    @ManyToOne
    @JsonIgnoreProperties("")
    private Person person;

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Float getPrimaryResultValue() {
        return primaryResultValue;
    }

    public ActivityResult primaryResultValue(Float primaryResultValue) {
        this.primaryResultValue = primaryResultValue;
        return this;
    }

    public void setPrimaryResultValue(Float primaryResultValue) {
        this.primaryResultValue = primaryResultValue;
    }

    public Float getSecondaryResultValue() {
        return secondaryResultValue;
    }

    public ActivityResult secondaryResultValue(Float secondaryResultValue) {
        this.secondaryResultValue = secondaryResultValue;
        return this;
    }

    public void setSecondaryResultValue(Float secondaryResultValue) {
        this.secondaryResultValue = secondaryResultValue;
    }

    public String getNote() {
        return note;
    }

    public ActivityResult note(String note) {
        this.note = note;
        return this;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ZonedDateTime getDate() {
        return date;
    }

    public ActivityResult date(ZonedDateTime date) {
        this.date = date;
        return this;
    }

    public void setDate(ZonedDateTime date) {
        this.date = date;
    }

    public Boolean isOfficial() {
        return official;
    }

    public ActivityResult official(Boolean official) {
        this.official = official;
        return this;
    }

    public void setOfficial(Boolean official) {
        this.official = official;
    }

    public WorkoutResult getWorkoutResult() {
        return workoutResult;
    }

    public ActivityResult workoutResult(WorkoutResult workoutResult) {
        this.workoutResult = workoutResult;
        return this;
    }

    public void setWorkoutResult(WorkoutResult workoutResult) {
        this.workoutResult = workoutResult;
    }

    public Activity getActivity() {
        return activity;
    }

    public ActivityResult activity(Activity activity) {
        this.activity = activity;
        return this;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    public Workout getWorkout() {
        return workout;
    }

    public ActivityResult workout(Workout workout) {
        this.workout = workout;
        return this;
    }

    public void setWorkout(Workout workout) {
        this.workout = workout;
    }

    public Event getEvent() {
        return event;
    }

    public ActivityResult event(Event event) {
        this.event = event;
        return this;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public Person getPerson() {
        return person;
    }

    public ActivityResult person(Person person) {
        this.person = person;
        return this;
    }

    public void setPerson(Person person) {
        this.person = person;
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
        ActivityResult activityResult = (ActivityResult) o;
        if (activityResult.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityResult.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityResult{" +
            "id=" + getId() +
            ", primaryResultValue=" + getPrimaryResultValue() +
            ", secondaryResultValue=" + getSecondaryResultValue() +
            ", note='" + getNote() + "'" +
            ", date='" + getDate() + "'" +
            ", official='" + isOfficial() + "'" +
            "}";
    }

    public static ActivityResult craeteActivityResult(Activity activity, WorkoutResult workoutResult, Workout workout, Event event, Person person) {
        String personName =  workoutResult.getEventResult().getPerson().getPersonalData().getFirstName() + " " + workoutResult.getEventResult().getPerson().getPersonalData().getLastName();
        ActivityResult activityResult = new ActivityResult();
        activityResult.setWorkoutResult(workoutResult);
        activityResult.setActivity(activity);
        activityResult.setNote("Poznámka k aktivitě " + activity.getName() + ". Osooba: " + personName);
        activityResult.setDate(event.getDate());
        activityResult.setEvent(event);
        activityResult.setWorkout(workout);
        activityResult.setPerson(person);

        activityResult.setPrimaryResultValue(new Float(RandomNumbers.getRandomNumberInRange(20,100)));

        if(activity.getSecondaryResultValueUnit() != null) {
            activityResult.setSecondaryResultValue(new Float(RandomNumbers.getRandomNumberInRange(30,50)));
        }
        return activityResult;
    }

    public static ActivityResult activityResultWithDate(ActivityResult activityResult, ZonedDateTime resultDate) {
        activityResult.setDate(resultDate);
        return activityResult;
    }

}
