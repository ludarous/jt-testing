package com.jtsports.jttesting.service.dto;

import java.time.ZonedDateTime;
import java.util.List;

public class StatsRequestDTO {

    private Long personId;

    private Long activityId;

    private Long workoutId;

    private Long eventId;

    private ZonedDateTime dateFrom;

    private ZonedDateTime dateTo;

    private ZonedDateTime usersBirthdayFrom;

    private ZonedDateTime usersBirthDayTo;

    private List<Long> categoriesId;

    private Boolean virtual;

    public ZonedDateTime getDateFrom() {
        return dateFrom;
    }

    public void setDateFrom(ZonedDateTime dateFrom) {
        this.dateFrom = dateFrom;
    }

    public ZonedDateTime getDateTo() {
        return dateTo;
    }

    public void setDateTo(ZonedDateTime dateTo) {
        this.dateTo = dateTo;
    }

    public ZonedDateTime getUsersBirthdayFrom() {
        return usersBirthdayFrom;
    }

    public void setUsersBirthdayFrom(ZonedDateTime usersBirthdayFrom) {
        this.usersBirthdayFrom = usersBirthdayFrom;
    }

    public ZonedDateTime getUsersBirthDayTo() {
        return usersBirthDayTo;
    }

    public void setUsersBirthDayTo(ZonedDateTime usersBirthDayTo) {
        this.usersBirthDayTo = usersBirthDayTo;
    }

    public Long getWorkoutId() {
        return workoutId;
    }

    public void setWorkoutId(Long workoutId) {
        this.workoutId = workoutId;
    }

    public Long getEventId() {
        return eventId;
    }

    public void setEventId(Long eventId) {
        this.eventId = eventId;
    }

    public Boolean getVirtual() {
        return virtual;
    }

    public void setVirtual(Boolean virtual) {
        this.virtual = virtual;
    }

    public Long getPersonId() {
        return personId;
    }

    public void setPersonId(Long personId) {
        this.personId = personId;
    }

    public Long getActivityId() {
        return activityId;
    }

    public void setActivityId(Long activityId) {
        this.activityId = activityId;
    }

    public List<Long> getCategoriesId() {
        return categoriesId;
    }

    public void setCategoriesId(List<Long> categoriesId) {
        this.categoriesId = categoriesId;
    }
}
