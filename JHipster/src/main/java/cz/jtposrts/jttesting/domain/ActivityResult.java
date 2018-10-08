package cz.jtposrts.jttesting.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import javax.persistence.*;
import javax.validation.constraints.*;

import org.springframework.data.elasticsearch.annotations.Document;
import java.io.Serializable;
import java.util.Objects;

/**
 * A ActivityResult.
 */
@Entity
@Table(name = "activity_result")
@Cache(usage = CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
@Document(indexName = "activityresult")
public class ActivityResult implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceGenerator")
    @SequenceGenerator(name = "sequenceGenerator")
    private Long id;

    @NotNull
    @Column(name = "primary_result_value", nullable = false)
    private Float primaryResultValue;

    @Column(name = "secondary_result_value")
    private Float secondaryResultValue;

    @Column(name = "note")
    private String note;

    @ManyToOne
    @JsonIgnoreProperties("activitiesResults")
    private TestResult testResult;

    @ManyToOne(optional = false)
    @NotNull
    @JsonIgnoreProperties("")
    private Activity activity;

    // jhipster-needle-entity-add-field - JHipster will add fields here, do not remove
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Float getPrimaryResultValue() {
        return primaryResultValue;
    }

    public ActivityResult primaryResultValue(Float primaryResultValue) {
        this.primaryResultValue = primaryResultValue;
        return this;
    }

    public void setPrimaryResultValue(Float primaryResultValue) {
        this.primaryResultValue = primaryResultValue;
    }

    public Float getSecondaryResultValue() {
        return secondaryResultValue;
    }

    public ActivityResult secondaryResultValue(Float secondaryResultValue) {
        this.secondaryResultValue = secondaryResultValue;
        return this;
    }

    public void setSecondaryResultValue(Float secondaryResultValue) {
        this.secondaryResultValue = secondaryResultValue;
    }

    public String getNote() {
        return note;
    }

    public ActivityResult note(String note) {
        this.note = note;
        return this;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public TestResult getTestResult() {
        return testResult;
    }

    public ActivityResult testResult(TestResult testResult) {
        this.testResult = testResult;
        return this;
    }

    public void setTestResult(TestResult testResult) {
        this.testResult = testResult;
    }

    public Activity getActivity() {
        return activity;
    }

    public ActivityResult activity(Activity activity) {
        this.activity = activity;
        return this;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
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
        ActivityResult activityResult = (ActivityResult) o;
        if (activityResult.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityResult.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityResult{" +
            "id=" + getId() +
            ", primaryResultValue=" + getPrimaryResultValue() +
            ", secondaryResultValue=" + getSecondaryResultValue() +
            ", note='" + getNote() + "'" +
            "}";
    }
}
