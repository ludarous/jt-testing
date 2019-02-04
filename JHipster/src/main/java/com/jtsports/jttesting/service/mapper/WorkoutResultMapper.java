package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.WorkoutResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity WorkoutResult and its DTO WorkoutResultDTO.
 */
@Mapper(componentModel = "spring", uses = {EventResultMapper.class, WorkoutMapper.class})
public interface WorkoutResultMapper extends EntityMapper<WorkoutResultDTO, WorkoutResult> {

    @Mapping(source = "eventResult.id", target = "eventResultId")
    @Mapping(source = "workout.id", target = "workoutId")
    @Mapping(source = "workout.name", target = "workoutName")
    WorkoutResultDTO toDto(WorkoutResult workoutResult);

    @Mapping(source = "eventResultId", target = "eventResult")
    @Mapping(target = "activitiesResults", ignore = true)
    @Mapping(source = "workoutId", target = "workout")
    WorkoutResult toEntity(WorkoutResultDTO workoutResultDTO);

    default WorkoutResult fromId(Long id) {
        if (id == null) {
            return null;
        }
        WorkoutResult workoutResult = new WorkoutResult();
        workoutResult.setId(id);
        return workoutResult;
    }
}
