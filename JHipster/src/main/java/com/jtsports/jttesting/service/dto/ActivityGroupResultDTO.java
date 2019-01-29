package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.Objects;

/**
 * A DTO for the ActivityGroupResult entity.
 */
public class ActivityGroupResultDTO implements Serializable {

    private Long id;

    private String note;

    private Long eventResultId;

    private Long activityGroupId;

    private String activityGroupName;

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

    public Long getActivityGroupId() {
        return activityGroupId;
    }

    public void setActivityGroupId(Long activityGroupId) {
        this.activityGroupId = activityGroupId;
    }

    public String getActivityGroupName() {
        return activityGroupName;
    }

    public void setActivityGroupName(String activityGroupName) {
        this.activityGroupName = activityGroupName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ActivityGroupResultDTO activityGroupResultDTO = (ActivityGroupResultDTO) o;
        if (activityGroupResultDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), activityGroupResultDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "ActivityGroupResultDTO{" +
            "id=" + getId() +
            ", note='" + getNote() + "'" +
            ", eventResult=" + getEventResultId() +
            ", activityGroup=" + getActivityGroupId() +
            ", activityGroup='" + getActivityGroupName() + "'" +
            "}";
    }
}
