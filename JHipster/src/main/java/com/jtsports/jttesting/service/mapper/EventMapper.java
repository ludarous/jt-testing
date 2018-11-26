package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.EventDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity Event and its DTO EventDTO.
 */
@Mapper(componentModel = "spring", uses = {AddressMapper.class, JTTestMapper.class, PersonFullMapper.class})
public interface EventMapper extends EntityMapper<EventDTO, Event> {

    @Mapping(source = "address.id", target = "addressId")
    @Mapping(source = "address.street", target = "addressStreet")
    EventDTO toDto(Event event);

    @Mapping(target = "eventResults", ignore = true)
    @Mapping(source = "addressId", target = "address")
    Event toEntity(EventDTO eventDTO);

    default Event fromId(Long id) {
        if (id == null) {
            return null;
        }
        Event event = new Event();
        event.setId(id);
        return event;
    }
}
