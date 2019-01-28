package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.GroupDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity Group and its DTO GroupDTO.
 */
@Mapper(componentModel = "spring", uses = {})
public interface GroupMapper extends EntityMapper<GroupDTO, Group> {



    default Group fromId(Long id) {
        if (id == null) {
            return null;
        }
        Group group = new Group();
        group.setId(id);
        return group;
    }
}
