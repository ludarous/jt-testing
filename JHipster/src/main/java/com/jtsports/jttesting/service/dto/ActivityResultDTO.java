package com.jtsports.jttesting.service.dto;

import java.time.ZonedDateTime;
import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.NamedNativeQuery;
import javax.persistence.SqlResultSetMapping;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the ActivityResult entity.
 */

public class ActivityResultDTO implements Serializable {

    public ActivityResultDTO() {

    }

    public ActivityResultDTO(Long id, Float primaryResultValue) {
        this.id = id;
        this.primaryResultValue = primaryResultValue;
    }

    private Long id;

    private Float primaryResultValue;

    private Float secondaryResultValue;

    private String note;

    @NotNull
    private ZonedDateTime eventDate;

    private ZonedDateTime personBirthDate;

    private Long testResultId;

    private Long activityId;

    private String activityName;

    private Long testId;

    private String testName;

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

    public ZonedDateTime getEventDate() {
        return eventDate;
    }

    public void setEventDate(ZonedDateTime eventDate) {
        this.eventDate = eventDate;
    }

    public ZonedDateTime getPersonBirthDate() {
        return personBirthDate;
    }

    public void setPersonBirthDate(ZonedDateTime personBirthDate) {
        this.personBirthDate = personBirthDate;
    }

    public Long getTestResultId() {
        return testResultId;
    }

    public void setTestResultId(Long testResultId) {
        this.testResultId = testResultId;
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

    public Long getTestId() {
        return testId;
    }

    public void setTestId(Long jtTestId) {
        this.testId = jtTestId;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String jtTestName) {
        this.testName = jtTestName;
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
            ", eventDate='" + getEventDate() + "'" +
            ", personBirthDate='" + getPersonBirthDate() + "'" +
            ", testResult=" + getTestResultId() +
            ", activity=" + getActivityId() +
            ", activity='" + getActivityName() + "'" +
            ", test=" + getTestId() +
            ", test='" + getTestName() + "'" +
            ", event=" + getEventId() +
            ", event='" + getEventName() + "'" +
            ", person=" + getPersonId() +
            ", person='" + getPersonEmail() + "'" +
            "}";
    }
}
