package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityGroupDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity ActivityGroup and its DTO ActivityGroupDTO.
 */
@Mapper(componentModel = "spring", uses = {ActivityMapper.class, ActivityGroupCategoryMapper.class})
public interface ActivityGroupMapper extends EntityMapper<ActivityGroupDTO, ActivityGroup> {



    default ActivityGroup fromId(Long id) {
        if (id == null) {
            return null;
        }
        ActivityGroup activityGroup = new ActivityGroup();
        activityGroup.setId(id);
        return activityGroup;
    }
}
