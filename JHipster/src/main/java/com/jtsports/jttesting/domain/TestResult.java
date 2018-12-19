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
 * A TestResult.
 */
@Entity
@Table(name = "test_result")
@Document(indexName = "testresult")
public class TestResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @Column(name = "note")
    private String note;

    @ManyToOne
    @JsonIgnoreProperties("testResults")
    private EventResult eventResult;

    @OneToMany(mappedBy = "testResult", cascade = CascadeType.ALL)
    private Set<ActivityResult> activitiesResults = new HashSet<>();

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private JTTest test;

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

    public TestResult note(String note) {
        this.note = note;
        return this;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public EventResult getEventResult() {
        return eventResult;
    }

    public TestResult eventResult(EventResult eventResult) {
        this.eventResult = eventResult;
        return this;
    }

    public void setEventResult(EventResult eventResult) {
        this.eventResult = eventResult;
    }

    public Set<ActivityResult> getActivitiesResults() {
        return activitiesResults;
    }

    public TestResult activitiesResults(Set<ActivityResult> activityResults) {
        this.activitiesResults = activityResults;
        return this;
    }

    public TestResult addActivitiesResults(ActivityResult activityResult) {
        this.activitiesResults.add(activityResult);
        activityResult.setTestResult(this);
        return this;
    }

    public TestResult removeActivitiesResults(ActivityResult activityResult) {
        this.activitiesResults.remove(activityResult);
        activityResult.setTestResult(null);
        return this;
    }

    public void setActivitiesResults(Set<ActivityResult> activityResults) {
        this.activitiesResults = activityResults;
    }

    public JTTest getTest() {
        return test;
    }

    public TestResult test(JTTest jTTest) {
        this.test = jTTest;
        return this;
    }

    public void setTest(JTTest jTTest) {
        this.test = jTTest;
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
        TestResult testResult = (TestResult) o;
        if (testResult.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), testResult.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "TestResult{" +
            "id=" + getId() +
            ", note='" + getNote() + "'" +
            "}";
    }

    public static TestResult createTestResult(JTTest test, EventResult eventResult, Event event, Person person) {
        String personName =  eventResult.getPerson().getPersonalData().getFirstName() + " " + eventResult.getPerson().getPersonalData().getLastName();
        TestResult testResult = new TestResult();
        testResult.setTest(test);
        testResult.setEventResult(eventResult);
        testResult.setNote("Poznámka k testu " + test.getName() + ". Osooba: " + personName);

        HashSet<ActivityResult> activitiesResults = new HashSet<>();
        for(Activity activity : test.getActivities()) {
            activitiesResults.add(ActivityResult.craeteActivityResult(activity, testResult, test, event, person));
        }
        testResult.setActivitiesResults(activitiesResults);

        return testResult;
    }
}
