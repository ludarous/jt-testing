package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity ActivityResult and its DTO ActivityResultDTO.
 */
@Mapper(componentModel = "spring", uses = {TestResultMapper.class, ActivityMapper.class, JTTestMapper.class, EventMapper.class, PersonMapper.class})
public interface ActivityResultMapper extends EntityMapper<ActivityResultDTO, ActivityResult> {

    @Mapping(source = "testResult.id", target = "testResultId")
    @Mapping(source = "activity.id", target = "activityId")
    @Mapping(source = "activity.name", target = "activityName")
    @Mapping(source = "test.id", target = "testId")
    @Mapping(source = "test.name", target = "testName")
    @Mapping(source = "event.id", target = "eventId")
    @Mapping(source = "event.name", target = "eventName")
    @Mapping(source = "person.id", target = "personId")
    @Mapping(source = "person.email", target = "personEmail")
    ActivityResultDTO toDto(ActivityResult activityResult);

    @Mapping(source = "testResultId", target = "testResult")
    @Mapping(source = "activityId", target = "activity")
    @Mapping(source = "testId", target = "test")
    @Mapping(source = "eventId", target = "event")
    @Mapping(source = "personId", target = "person")
    ActivityResult toEntity(ActivityResultDTO activityResultDTO);

    default ActivityResult fromId(Long id) {
        if (id == null) {
            return null;
        }
        ActivityResult activityResult = new ActivityResult();
        activityResult.setId(id);
        return activityResult;
    }
}
