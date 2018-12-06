package com.jtsports.jttesting.service.dto.Event;

import com.jtsports.jttesting.service.dto.EventDTO;
import com.jtsports.jttesting.service.dto.PersonFullDTO;
import com.jtsports.jttesting.service.dto.Test.PersonalTestStatsDTO;

import java.util.List;

public class PersonalEventStatsDTO {

    private PersonFullDTO person;

    private EventDTO event;

    private List<PersonalTestStatsDTO> personalTestsStats;

    public PersonFullDTO getPerson() {
        return person;
    }

    public void setPerson(PersonFullDTO person) {
        this.person = person;
    }

    public EventDTO getEvent() {
        return event;
    }

    public void setEvent(EventDTO event) {
        this.event = event;
    }

    public List<PersonalTestStatsDTO> getPersonalTestsStats() {
        return personalTestsStats;
    }

    public void setPersonalTestsStats(List<PersonalTestStatsDTO> personalTestsStats) {
        this.personalTestsStats = personalTestsStats;
    }
}
