package com.jtsports.jttesting.service.dto;

import javax.validation.constraints.*;
import java.io.Serializable;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

/**
 * A DTO for the WorkoutResult entity.
 */
public class WorkoutResultDTO implements Serializable {

    private Long id;

    private String note;

    private Long eventResultId;

    private Long workoutId;

    private String workoutName;

    private Set<ActivityResultDTO> activitiesResults = new HashSet<>();

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

    public Long getWorkoutId() {
        return workoutId;
    }

    public void setWorkoutId(Long workoutId) {
        this.workoutId = workoutId;
    }

    public String getWorkoutName() {
        return workoutName;
    }

    public void setWorkoutName(String workoutName) {
        this.workoutName = workoutName;
    }

    public Set<ActivityResultDTO> getActivitiesResults() {
        return activitiesResults;
    }

    public void setActivitiesResults(Set<ActivityResultDTO> activitiesResults) {
        this.activitiesResults = activitiesResults;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        WorkoutResultDTO workoutResultDTO = (WorkoutResultDTO) o;
        if (workoutResultDTO.getId() == null || getId() == null) {
            return false;
        }
        return Objects.equals(getId(), workoutResultDTO.getId());
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(getId());
    }

    @Override
    public String toString() {
        return "WorkoutResultDTO{" +
            "id=" + getId() +
            ", note='" + getNote() + "'" +
            ", eventResult=" + getEventResultId() +
            ", workout=" + getWorkoutId() +
            ", workout='" + getWorkoutName() + "'" +
            "}";
    }

}
