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
 * A ActivityGroupResult.
 */
@Entity
@Table(name = "activity_group_result")
@Document(indexName = "activitygroupresult")
public class ActivityGroupResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @Column(name = "note")
    private String note;

    @ManyToOne
    @JsonIgnoreProperties("")
    private EventResult eventResult;

    @OneToMany(mappedBy = "activityGroupResult", cascade = CascadeType.ALL)
    private Set<ActivityResult> activitiesResults = new HashSet<>();

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private ActivityGroup activityGroup;

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

    public ActivityGroupResult note(String note) {
        this.note = note;
        return this;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public EventResult getEventResult() {
        return eventResult;
    }

    public ActivityGroupResult eventResult(EventResult eventResult) {
        this.eventResult = eventResult;
        return this;
    }

    public void setEventResult(EventResult eventResult) {
        this.eventResult = eventResult;
    }

    public Set<ActivityResult> getActivitiesResults() {
        return activitiesResults;
    }

    public ActivityGroupResult activitiesResults(Set<ActivityResult> activityResults) {
        this.activitiesResults = activityResults;
        return this;
    }

    public ActivityGroupResult addActivitiesResults(ActivityResult activityResult) {
        this.activitiesResults.add(activityResult);
        activityResult.setActivityGroupResult(this);
        return this;
    }

    public ActivityGroupResult removeActivitiesResults(ActivityResult activityResult) {
        this.activitiesResults.remove(activityResult);
        activityResult.setActivityGroupResult(null);
        return this;
    }

    public void setActivitiesResults(Set<ActivityResult> activityResults) {
        this.activitiesResults = activityResults;
    }

    public ActivityGroup getActivityGroup() {
        return activityGroup;
    }

    public ActivityGroupResult activityGroup(ActivityGroup activityGroup) {
        this.activityGroup = activityGroup;
        return this;
    }

    public void setActivityGroup(ActivityGroup activityGroup) {
        this.activityGroup = activityGroup;
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
        ActivityGroupResult activityGroupResult = (ActivityGroupResult) o;
        if (activityGroupResult.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityGroupResult.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityGroupResult{" +
            "id=" + getId() +
            ", note='" + getNote() + "'" +
            "}";
    }

    public static ActivityGroupResult createActivityGroupResult(ActivityGroup activityGroup, EventResult eventResult, Event event, Person person) {
        String personName =  eventResult.getPerson().getPersonalData().getFirstName() + " " + eventResult.getPerson().getPersonalData().getLastName();
        ActivityGroupResult activityGroupResult = new ActivityGroupResult();
        activityGroupResult.setActivityGroup(activityGroup);
        activityGroupResult.setEventResult(eventResult);
        activityGroupResult.setNote("Poznámka k testu " + activityGroup.getName() + ". Osooba: " + personName);

        HashSet<ActivityResult> activitiesResults = new HashSet<>();
        for(Activity activity : activityGroup.getActivities()) {
            activitiesResults.add(ActivityResult.craeteActivityResult(activity, activityGroupResult, activityGroup, event, person));
        }
        activityGroupResult.setActivitiesResults(activitiesResults);

        return activityGroupResult;
    }
}
