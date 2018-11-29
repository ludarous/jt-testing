package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.EventResultDTO;

import com.jtsports.jttesting.service.dto.TestResultDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing EventResult.
 */
public interface EventResultService {

    /**
     * Save a eventResult.
     *
     * @param eventResultDTO the entity to save
     * @return the persisted entity
     */
    EventResultDTO save(EventResultDTO eventResultDTO);

    /**
     * Get all the eventResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<EventResultDTO> findAll(Pageable pageable);


    /**
     * Get the "id" eventResult.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<EventResultDTO> findOne(Long id);

    /**
     * Delete the "id" eventResult.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the eventResult corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<EventResultDTO> search(String query, Pageable pageable);


    /**
     * Get all the eventResults by eventId.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<EventResultDTO> findAllByEventId(Pageable pageable, Long eventId);

    Page<EventResultDTO> findAllByPersonId(Pageable pageable, Long id);
}
