package com.jtsports.jttesting.service.dto.Activity;

import java.time.ZonedDateTime;

public class ActivityStatsRequestDTO {

    private ZonedDateTime dateFrom;

    private ZonedDateTime dateTo;

    private ZonedDateTime usersBirthdayFrom;

    private ZonedDateTime usersBirthDayTo;

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
}
