package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.Event;
import com.jtsports.jttesting.service.dto.EventDTO;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

/**
 * Mapper for the entity Event and its DTO EventDTO.
 */
@Mapper(componentModel = "spring", uses = {AddressMapper.class, ActivityGroupMapper.class, PersonFullMapper.class, EventResultMapper.class, ActivityGroupResultMapper.class, ActivityResultMapper.class})
public interface EventMapperCustom extends EntityMapper<EventDTO, Event> {

    @Mapping(source = "address.id", target = "addressId")
    @Mapping(source = "address.street", target = "addressStreet")
    @Mapping(target = "eventResults", ignore = true)
    @Mapping(source = "activityGroups", target = "activityGroups")
    @Mapping(target = "attachedPersons", ignore = true)
    EventDTO toDto(Event event);

    @Mapping(target = "eventResults", ignore = true)
    @Mapping(target = "activityGroups", ignore = true)
    @Mapping(target = "attachedPersons", ignore = true)
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
