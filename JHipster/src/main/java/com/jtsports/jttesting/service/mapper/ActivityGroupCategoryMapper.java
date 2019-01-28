package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityGroupCategoryDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity ActivityGroupCategory and its DTO ActivityGroupCategoryDTO.
 */
@Mapper(componentModel = "spring", uses = {})
public interface ActivityGroupCategoryMapper extends EntityMapper<ActivityGroupCategoryDTO, ActivityGroupCategory> {



    default ActivityGroupCategory fromId(Long id) {
        if (id == null) {
            return null;
        }
        ActivityGroupCategory activityGroupCategory = new ActivityGroupCategory();
        activityGroupCategory.setId(id);
        return activityGroupCategory;
    }
}
