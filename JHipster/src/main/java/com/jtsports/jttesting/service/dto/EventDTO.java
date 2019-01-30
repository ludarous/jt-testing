package com.jtsports.jttesting.service.dto;

import java.time.ZonedDateTime;
import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A DTO for the Event entity.
 */
public class EventDTO implements Serializable {

    private Long id;

    @NotNull
    private String name;

    private ZonedDateTime date;

    private Integer minAge;

    private Integer maxAge;

    private Long addressId;

    private String addressStreet;

    private Set<ActivityGroupDTO> activityGroups = new HashSet<>();

    private Set<PersonFullDTO> attachedPersons = new HashSet<>();

    private Set<EventResultDTO> eventResults = new HashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ZonedDateTime getDate() {
        return date;
    }

    public void setDate(ZonedDateTime date) {
        this.date = date;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
        this.addressId = addressId;
    }

    public String getAddressStreet() {
        return addressStreet;
    }

    public void setAddressStreet(String addressStreet) {
        this.addressStreet = addressStreet;
    }

    public Set<ActivityGroupDTO> getActivityGroups() {
        return activityGroups;
    }

    public void setActivityGroups(Set<ActivityGroupDTO> activityGroups) {
        this.activityGroups = activityGroups;
    }

    public Set<PersonFullDTO> getAttachedPersons() {
        return attachedPersons;
    }

    public void setAttachedPersons(Set<PersonFullDTO> people) {
        this.attachedPersons = people;
    }

    public Set<EventResultDTO> getEventResults() {
        return eventResults;
    }

    public void setEventResults(Set<EventResultDTO> eventResults) {
        this.eventResults = eventResults;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        EventDTO eventDTO = (EventDTO) o;
        if (eventDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), eventDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "EventDTO{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", date='" + getDate() + "'" +
            ", minAge=" + getMinAge() +
            ", maxAge=" + getMaxAge() +
            ", address=" + getAddressId() +
            ", address='" + getAddressStreet() + "'" +
            "}";
    }
}
