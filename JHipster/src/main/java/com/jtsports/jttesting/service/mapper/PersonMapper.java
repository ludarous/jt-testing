package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.PersonDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity Person and its DTO PersonDTO.
 */
@Mapper(componentModel = "spring", uses = {PersonalDataMapper.class, AddressMapper.class, UserMapper.class})
public interface PersonMapper extends EntityMapper<PersonDTO, Person> {

    @Mapping(source = "personalData.id", target = "personalDataId")
    @Mapping(source = "address.id", target = "addressId")
    @Mapping(source = "user.id", target = "userId")
    PersonDTO toDto(Person person);

    @Mapping(source = "personalDataId", target = "personalData")
    @Mapping(source = "addressId", target = "address")
    @Mapping(source = "userId", target = "user")
    Person toEntity(PersonDTO personDTO);

    default Person fromId(Long id) {
        if (id == null) {
            return null;
        }
        Person person = new Person();
        person.setId(id);
        return person;
    }
}
