package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.ActivityCategoryDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity ActivityCategory and its DTO ActivityCategoryDTO.
 */
@Mapper(componentModel = "spring", uses = {})
public interface ActivityCategoryMapper extends EntityMapper<ActivityCategoryDTO, ActivityCategory> {

    @Mapping(source = "parent.id", target = "parentId")
    @Mapping(source = "parent.name", target = "parentName")
    @Mapping(source = "children", target = "children")
    ActivityCategoryDTO toDto(ActivityCategory activityCategory);

    @Mapping(source = "parentId", target = "parent")
    @Mapping(source = "children", target = "children")
    ActivityCategory toEntity(ActivityCategoryDTO activityCategoryDTO);

    default ActivityCategory fromId(Long id) {
        if (id == null) {
            return null;
        }
        ActivityCategory activityCategory = new ActivityCategory();
        activityCategory.setId(id);
        return activityCategory;
    }
}
