package com.jtsports.jttesting.service.dto.Category;

import java.time.ZonedDateTime;

public class CategoryStatsRequestDTO {

    private Long parentCategoryId;

    private Long testId;

    private Long eventId;

    private ZonedDateTime dateFrom;

    private ZonedDateTime dateTo;

    private ZonedDateTime usersBirthdayFrom;

    private ZonedDateTime usersBirthDayTo;

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

    public Long getTestId() {
        return testId;
    }

    public void setTestId(Long testId) {
        this.testId = testId;
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

    public Long getParentCategoryId() {
        return parentCategoryId;
    }

    public void setParentCategoryId(Long parentCategoryId) {
        this.parentCategoryId = parentCategoryId;
    }
}
