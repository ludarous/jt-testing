package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.WorkoutDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity Workout and its DTO WorkoutDTO.
 */
@Mapper(componentModel = "spring", uses = {ActivityMapper.class, WorkoutCategoryMapper.class})
public interface WorkoutMapper extends EntityMapper<WorkoutDTO, Workout> {



    default Workout fromId(Long id) {
        if (id == null) {
            return null;
        }
        Workout workout = new Workout();
        workout.setId(id);
        return workout;
    }
}