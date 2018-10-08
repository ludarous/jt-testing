package cz.jtposrts.jttesting.service.mapper;

import cz.jtposrts.jttesting.domain.*;
import cz.jtposrts.jttesting.service.dto.PersonDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity Person and its DTO PersonDTO.
 */
@Mapper(componentModel = "spring", uses = {PersonalDataMapper.class, AddressMapper.class})
public interface PersonMapper extends EntityMapper<PersonDTO, Person> {

    @Mapping(source = "personalData.id", target = "personalDataId")
    @Mapping(source = "address.id", target = "addressId")
    PersonDTO toDto(Person person);

    @Mapping(source = "personalDataId", target = "personalData")
    @Mapping(source = "addressId", target = "address")
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
