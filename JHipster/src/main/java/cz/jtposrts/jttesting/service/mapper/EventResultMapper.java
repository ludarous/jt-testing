package cz.jtposrts.jttesting.service.mapper;

import cz.jtposrts.jttesting.domain.*;
import cz.jtposrts.jttesting.service.dto.EventResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity EventResult and its DTO EventResultDTO.
 */
@Mapper(componentModel = "spring", uses = {EventMapper.class, PersonMapper.class})
public interface EventResultMapper extends EntityMapper<EventResultDTO, EventResult> {

    @Mapping(source = "event.id", target = "eventId")
    @Mapping(source = "person.id", target = "personId")
    EventResultDTO toDto(EventResult eventResult);

    @Mapping(source = "eventId", target = "event")
    @Mapping(target = "testResults", ignore = true)
    @Mapping(source = "personId", target = "person")
    EventResult toEntity(EventResultDTO eventResultDTO);

    default EventResult fromId(Long id) {
        if (id == null) {
            return null;
        }
        EventResult eventResult = new EventResult();
        eventResult.setId(id);
        return eventResult;
    }
}
