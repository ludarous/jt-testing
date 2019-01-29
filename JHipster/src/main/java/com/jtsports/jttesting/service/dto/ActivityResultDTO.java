package com.jtsports.jttesting.service.dto;

import java.time.ZonedDateTime;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the ActivityResult entity.
 */
public class ActivityResultDTO implements Serializable {

    private Long id;

    private Float primaryResultValue;

    private Float secondaryResultValue;

    private String note;

    private ZonedDateTime date;

    private Boolean official;

    private Long activityGroupResultId;

    private Long activityId;

    private String activityName;

    private Long activityGroupId;

    private String activityGroupName;

    private Long eventId;

    private String eventName;

    private Long personId;

    private String personEmail;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Float getPrimaryResultValue() {
        return primaryResultValue;
    }

    public void setPrimaryResultValue(Float primaryResultValue) {
        this.primaryResultValue = primaryResultValue;
    }

    public Float getSecondaryResultValue() {
        return secondaryResultValue;
    }

    public void setSecondaryResultValue(Float secondaryResultValue) {
        this.secondaryResultValue = secondaryResultValue;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public ZonedDateTime getDate() {
        return date;
    }

    public void setDate(ZonedDateTime date) {
        this.date = date;
    }

    public Boolean isOfficial() {
        return official;
    }

    public void setOfficial(Boolean official) {
        this.official = official;
    }

    public Long getActivityGroupResultId() {
        return activityGroupResultId;
    }

    public void setActivityGroupResultId(Long activityGroupResultId) {
        this.activityGroupResultId = activityGroupResultId;
    }

    public Long getActivityId() {
        return activityId;
    }

    public void setActivityId(Long activityId) {
        this.activityId = activityId;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public Long getActivityGroupId() {
        return activityGroupId;
    }

    public void setActivityGroupId(Long activityGroupId) {
        this.activityGroupId = activityGroupId;
    }

    public String getActivityGroupName() {
        return activityGroupName;
    }

    public void setActivityGroupName(String activityGroupName) {
        this.activityGroupName = activityGroupName;
    }

    public Long getEventId() {
        return eventId;
    }

    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public Long getPersonId() {
        return personId;
    }

    public void setPersonId(Long personId) {
        this.personId = personId;
    }

    public String getPersonEmail() {
        return personEmail;
    }

    public void setPersonEmail(String personEmail) {
        this.personEmail = personEmail;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ActivityResultDTO activityResultDTO = (ActivityResultDTO) o;
        if (activityResultDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityResultDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityResultDTO{" +
            "id=" + getId() +
            ", primaryResultValue=" + getPrimaryResultValue() +
            ", secondaryResultValue=" + getSecondaryResultValue() +
            ", note='" + getNote() + "'" +
            ", date='" + getDate() + "'" +
            ", official='" + isOfficial() + "'" +
            ", activityGroupResult=" + getActivityGroupResultId() +
            ", activity=" + getActivityId() +
            ", activity='" + getActivityName() + "'" +
            ", activityGroup=" + getActivityGroupId() +
            ", activityGroup='" + getActivityGroupName() + "'" +
            ", event=" + getEventId() +
            ", event='" + getEventName() + "'" +
            ", person=" + getPersonId() +
            ", person='" + getPersonEmail() + "'" +
            "}";
    }
}
