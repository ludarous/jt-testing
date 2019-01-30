package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity ActivityResult and its DTO ActivityResultDTO.
 */
@Mapper(componentModel = "spring", uses = {ActivityGroupResultMapper.class, ActivityMapper.class, ActivityGroupMapper.class, EventMapper.class, PersonMapper.class})
public interface ActivityResultMapper extends EntityMapper<ActivityResultDTO, ActivityResult> {

    @Mapping(source = "activityGroupResult.id", target = "activityGroupResultId")
    @Mapping(source = "activity.id", target = "activityId")
    @Mapping(source = "activity.name", target = "activityName")
    @Mapping(source = "activityGroup.id", target = "activityGroupId")
    @Mapping(source = "activityGroup.name", target = "activityGroupName")
    @Mapping(source = "event.id", target = "eventId")
    @Mapping(source = "event.name", target = "eventName")
    @Mapping(source = "person.id", target = "personId")
    @Mapping(source = "person.email", target = "personEmail")
    ActivityResultDTO toDto(ActivityResult activityResult);

    @Mapping(source = "activityGroupResultId", target = "activityGroupResult")
    @Mapping(source = "activityId", target = "activity")
    @Mapping(source = "activityGroupId", target = "activityGroup")
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
