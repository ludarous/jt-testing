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

    @OneToMany(mappedBy = "event")
    private Set<EventResult> eventResults = new HashSet<>();

    @ManyToOne
    @JsonIgnoreProperties("")
    private Address address;

    @ManyToMany
    @JoinTable(name = "event_tests",
               joinColumns = @JoinColumn(name = "events_id", referencedColumnName = "id"),
               inverseJoinColumns = @JoinColumn(name = "tests_id", referencedColumnName = "id"))
    private Set<JTTest> tests = new HashSet<>();

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

    public Set<JTTest> getTests() {
        return tests;
    }

    public Event tests(Set<JTTest> jTTests) {
        this.tests = jTTests;
        return this;
    }

    public Event addTests(JTTest jTTest) {
        this.tests.add(jTTest);
        return this;
    }

    public Event removeTests(JTTest jTTest) {
        this.tests.remove(jTTest);
        return this;
    }

    public void setTests(Set<JTTest> jTTests) {
        this.tests = jTTests;
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
            "}";
    }
}
