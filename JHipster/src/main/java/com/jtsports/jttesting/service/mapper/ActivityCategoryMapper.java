package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityCategoryDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity ActivityCategory and its DTO ActivityCategoryDTO.
 */
@Mapper(componentModel = "spring", uses = {})
public interface ActivityCategoryMapper extends EntityMapper<ActivityCategoryDTO, ActivityCategory> {



    default ActivityCategory fromId(Long id) {
        if (id == null) {
            return null;
        }
        ActivityCategory activityCategory = new ActivityCategory();
        activityCategory.setId(id);
        return activityCategory;
    }
}
