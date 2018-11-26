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
 * A EventResult.
 */
@Entity
@Table(name = "event_result")
@Document(indexName = "eventresult")
public class EventResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @Column(name = "note")
    private String note;

    @Column(name = "actual_height_in_cm")
    private Float actualHeightInCm;

    @Column(name = "actual_weight_in_kg")
    private Float actualWeightInKg;

    @ManyToOne
    @JsonIgnoreProperties("eventResults")
    private Event event;

    @OneToMany(mappedBy = "eventResult", cascade = CascadeType.ALL)
    private Set<TestResult> testResults = new HashSet<>();

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private Person person;

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

    public EventResult note(String note) {
        this.note = note;
        return this;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Float getActualHeightInCm() {
        return actualHeightInCm;
    }

    public EventResult actualHeightInCm(Float actualHeightInCm) {
        this.actualHeightInCm = actualHeightInCm;
        return this;
    }

    public void setActualHeightInCm(Float actualHeightInCm) {
        this.actualHeightInCm = actualHeightInCm;
    }

    public Float getActualWeightInKg() {
        return actualWeightInKg;
    }

    public EventResult actualWeightInKg(Float actualWeightInKg) {
        this.actualWeightInKg = actualWeightInKg;
        return this;
    }

    public void setActualWeightInKg(Float actualWeightInKg) {
        this.actualWeightInKg = actualWeightInKg;
    }

    public Event getEvent() {
        return event;
    }

    public EventResult event(Event event) {
        this.event = event;
        return this;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public Set<TestResult> getTestResults() {
        return testResults;
    }

    public EventResult testResults(Set<TestResult> testResults) {
        this.testResults = testResults;
        return this;
    }

    public EventResult addTestResults(TestResult testResult) {
        this.testResults.add(testResult);
        testResult.setEventResult(this);
        return this;
    }

    public EventResult removeTestResults(TestResult testResult) {
        this.testResults.remove(testResult);
        testResult.setEventResult(null);
        return this;
    }

    public void setTestResults(Set<TestResult> testResults) {
        this.testResults = testResults;
    }

    public Person getPerson() {
        return person;
    }

    public EventResult person(Person person) {
        this.person = person;
        return this;
    }

    public void setPerson(Person person) {
        this.person = person;
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
        EventResult eventResult = (EventResult) o;
        if (eventResult.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), eventResult.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "EventResult{" +
            "id=" + getId() +
            ", note='" + getNote() + "'" +
            ", actualHeightInCm=" + getActualHeightInCm() +
            ", actualWeightInKg=" + getActualWeightInKg() +
            "}";
    }
}
