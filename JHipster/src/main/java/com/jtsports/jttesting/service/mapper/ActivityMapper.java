package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity Activity and its DTO ActivityDTO.
 */
@Mapper(componentModel = "spring", uses = {ActivityCategoryMapper.class})
public interface ActivityMapper extends EntityMapper<ActivityDTO, Activity> {



    default Activity fromId(Long id) {
        if (id == null) {
            return null;
        }
        Activity activity = new Activity();
        activity.setId(id);
        return activity;
    }
}
