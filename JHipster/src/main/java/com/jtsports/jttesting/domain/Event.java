package com.jtsports.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.Set;
import java.util.Objects;

/**
 * A Event.
 */
@Entity
@Table(name = "event")
@Document(indexName = "event")
public class Event implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @NotNull
    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "jhi_date")
    private ZonedDateTime date;

    @Column(name = "min_age")
    private Integer minAge;

    @Column(name = "max_age")
    private Integer maxAge;

    @OneToMany(mappedBy = "event")
    private Set<EventResult> eventResults = new HashSet<>();

    @ManyToOne
    @JsonIgnoreProperties("")
    private Address address;

    @ManyToMany
    @JoinTable(name = "event_activity_groups",
               joinColumns = @JoinColumn(name = "events_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "activity_groups_id", referencedColumnName = "id"))
    private Set<ActivityGroup> activityGroups = new HashSet<>();

    @ManyToMany
    @JoinTable(name = "event_attached_persons",
               joinColumns = @JoinColumn(name = "events_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "attached_persons_id", referencedColumnName = "id"))
    private Set<Person> attachedPersons = new HashSet<>();

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public Event name(String name) {
        this.name = name;
        return this;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ZonedDateTime getDate() {
        return date;
    }

    public Event date(ZonedDateTime date) {
        this.date = date;
        return this;
    }

    public void setDate(ZonedDateTime date) {
        this.date = date;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public Event minAge(Integer minAge) {
        this.minAge = minAge;
        return this;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public Event maxAge(Integer maxAge) {
        this.maxAge = maxAge;
        return this;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Set<EventResult> getEventResults() {
        return eventResults;
    }

    public Event eventResults(Set<EventResult> eventResults) {
        this.eventResults = eventResults;
        return this;
    }

    public Event addEventResults(EventResult eventResult) {
        this.eventResults.add(eventResult);
        eventResult.setEvent(this);
        return this;
    }

    public Event removeEventResults(EventResult eventResult) {
        this.eventResults.remove(eventResult);
        eventResult.setEvent(null);
        return this;
    }

    public void setEventResults(Set<EventResult> eventResults) {
        this.eventResults = eventResults;
    }

    public Address getAddress() {
        return address;
    }

    public Event address(Address address) {
        this.address = address;
        return this;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Set<ActivityGroup> getActivityGroups() {
        return activityGroups;
    }

    public Event activityGroups(Set<ActivityGroup> activityGroups) {
        this.activityGroups = activityGroups;
        return this;
    }

    public Event addActivityGroups(ActivityGroup activityGroup) {
        this.activityGroups.add(activityGroup);
        return this;
    }

    public Event removeActivityGroups(ActivityGroup activityGroup) {
        this.activityGroups.remove(activityGroup);
        return this;
    }

    public void setActivityGroups(Set<ActivityGroup> activityGroups) {
        this.activityGroups = activityGroups;
    }

    public Set<Person> getAttachedPersons() {
        return attachedPersons;
    }

    public Event attachedPersons(Set<Person> people) {
        this.attachedPersons = people;
        return this;
    }

    public Event addAttachedPersons(Person person) {
        this.attachedPersons.add(person);
        person.getEvents().add(this);
        return this;
    }

    public Event removeAttachedPersons(Person person) {
        this.attachedPersons.remove(person);
        person.getEvents().remove(this);
        return this;
    }

    public void setAttachedPersons(Set<Person> people) {
        this.attachedPersons = people;
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
        Event event = (Event) o;
        if (event.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), event.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "Event{" +
            "id=" + getId() +
            ", name='" + getName() + "'" +
            ", date='" + getDate() + "'" +
            ", minAge=" + getMinAge() +
            ", maxAge=" + getMaxAge() +
            "}";
    }
}
