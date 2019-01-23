package com.jtsports.jttesting.service.mapper;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.service.dto.EventResultDTO;

import org.mapstruct.*;

/**
 * Mapper for the entity EventResult and its DTO EventResultDTO.
 */
@Mapper(componentModel = "spring", uses = {EventMapper.class, PersonFullMapper.class, TestResultMapper.class})
public interface EventResultMapper extends EntityMapper<EventResultDTO, EventResult> {

    @Mapping(source = "event.id", target = "eventId")
    @Mapping(source = "person.id", target = "personId")
    @Mapping(source = "testResults", target = "testResults")
    EventResultDTO toDto(EventResult eventResult);

    @Mapping(source = "eventId", target = "event")
    @Mapping(source = "personId", target = "person")
    @Mapping(source = "testResults", target = "testResults")
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
