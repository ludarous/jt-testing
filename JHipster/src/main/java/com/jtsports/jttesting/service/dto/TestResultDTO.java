package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the TestResult entity.
 */
public class TestResultDTO implements Serializable {

    private Long id;

    private String note;

    private Long eventResultId;

    private Long testId;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Long getEventResultId() {
        return eventResultId;
    }

    public void setEventResultId(Long eventResultId) {
        this.eventResultId = eventResultId;
    }

    public Long getTestId() {
        return testId;
    }

    public void setTestId(Long jTTestId) {
        this.testId = jTTestId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        TestResultDTO testResultDTO = (TestResultDTO) o;
        if (testResultDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), testResultDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "TestResultDTO{" +
            "id=" + getId() +
            ", note='" + getNote() + "'" +
            ", eventResult=" + getEventResultId() +
            ", test=" + getTestId() +
            "}";
    }
}
