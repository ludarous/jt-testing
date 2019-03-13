package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.Person;
import com.jtsports.jttesting.service.dto.PersonFullDTO;
import org.mapstruct.*;

/**
 * Mapper for the entity Person and its DTO PersonDTO.
 */
@Mapper(componentModel = "spring", uses = {PersonalDataMapper.class, AddressMapper.class, UserMapper.class})
public interface PersonFullMapper extends EntityMapper<PersonFullDTO, Person> {

    @Mapping(source = "personalData", target = "personalData")
    @Mapping(source = "address", target = "address")
    @Mapping(source = "user", target = "user")
    @Mapping(source = "email", target = "email")
    @Mapping(source = "virtual", target = "virtual")
    PersonFullDTO toDto(Person person);

    @Mapping(source = "personalData", target = "personalData")
    @Mapping(source = "address", target = "address")
    @Mapping(source = "user", target = "user")
    @Mapping(source = "email", target = "email")
    @Mapping(source = "virtual", target = "virtual")
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
