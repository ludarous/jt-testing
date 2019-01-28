package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.PersonGroupDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity PersonGroup and its DTO PersonGroupDTO.
 */
@Mapper(componentModel = "spring", uses = {PersonMapper.class, GroupMapper.class})
public interface PersonGroupMapper extends EntityMapper<PersonGroupDTO, PersonGroup> {

    @Mapping(source = "person.id", target = "personId")
    @Mapping(source = "person.email", target = "personEmail")
    @Mapping(source = "group.id", target = "groupId")
    @Mapping(source = "group.name", target = "groupName")
    PersonGroupDTO toDto(PersonGroup personGroup);

    @Mapping(source = "personId", target = "person")
    @Mapping(source = "groupId", target = "group")
    PersonGroup toEntity(PersonGroupDTO personGroupDTO);

    default PersonGroup fromId(Long id) {
        if (id == null) {
            return null;
        }
        PersonGroup personGroup = new PersonGroup();
        personGroup.setId(id);
        return personGroup;
    }
}
