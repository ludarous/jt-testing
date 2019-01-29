package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityGroupResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity ActivityGroupResult and its DTO ActivityGroupResultDTO.
 */
@Mapper(componentModel = "spring", uses = {EventResultMapper.class, ActivityGroupMapper.class})
public interface ActivityGroupResultMapper extends EntityMapper<ActivityGroupResultDTO, ActivityGroupResult> {

    @Mapping(source = "eventResult.id", target = "eventResultId")
    @Mapping(source = "activityGroup.id", target = "activityGroupId")
    @Mapping(source = "activityGroup.name", target = "activityGroupName")
    ActivityGroupResultDTO toDto(ActivityGroupResult activityGroupResult);

    @Mapping(source = "eventResultId", target = "eventResult")
    @Mapping(target = "activitiesResults", ignore = true)
    @Mapping(source = "activityGroupId", target = "activityGroup")
    ActivityGroupResult toEntity(ActivityGroupResultDTO activityGroupResultDTO);

    default ActivityGroupResult fromId(Long id) {
        if (id == null) {
            return null;
        }
        ActivityGroupResult activityGroupResult = new ActivityGroupResult();
        activityGroupResult.setId(id);
        return activityGroupResult;
    }
}
