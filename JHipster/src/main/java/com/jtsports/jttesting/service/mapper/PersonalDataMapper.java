package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.PersonalDataDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity PersonalData and its DTO PersonalDataDTO.
 */
@Mapper(componentModel = "spring", uses = {})
public interface PersonalDataMapper extends EntityMapper<PersonalDataDTO, PersonalData> {



    default PersonalData fromId(Long id) {
        if (id == null) {
            return null;
        }
        PersonalData personalData = new PersonalData();
        personalData.setId(id);
        return personalData;
    }
}
