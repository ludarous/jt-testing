package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.Person;
import com.jtsports.jttesting.domain.User;
import com.jtsports.jttesting.service.dto.PersonDTO;
import com.jtsports.jttesting.service.dto.PersonFullDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity Person and its DTO PersonDTO.
 */
@Mapper(componentModel = "spring", uses = {PersonalDataMapper.class, AddressMapper.class, UserMapper.class})
public interface PersonFullMapper extends EntityMapper<PersonFullDTO, Person> {

    @Mapping(source = "personalData", target = "personalData", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL)
    @Mapping(source = "address", target = "address", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL)
    @Mapping(source = "user", target = "user", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL)
    PersonFullDTO toDto(Person person);

    @Mapping(source = "personalData", target = "personalData", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL)
    @Mapping(source = "address", target = "address", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL)
    @Mapping(source = "user", target = "user", nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.SET_TO_NULL)
    Person toEntity(PersonFullDTO personFullDTO);

    default Person fromId(Long id) {
        if (id == null) {
            return null;
        }
        Person person = new Person();
        person.setId(id);
        return person;
    }
}
