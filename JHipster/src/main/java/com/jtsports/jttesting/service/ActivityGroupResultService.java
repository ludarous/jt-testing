package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.ActivityGroupResultDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing ActivityGroupResult.
 */
public interface ActivityGroupResultService {

    /**
     * Save a activityGroupResult.
     *
     * @param activityGroupResultDTO the entity to save
     * @return the persisted entity
     */
    ActivityGroupResultDTO save(ActivityGroupResultDTO activityGroupResultDTO);

    /**
     * Get all the activityGroupResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<ActivityGroupResultDTO> findAll(Pageable pageable);


    /**
     * Get the "id" activityGroupResult.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<ActivityGroupResultDTO> findOne(Long id);

    /**
     * Delete the "id" activityGroupResult.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the activityGroupResult corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<ActivityGroupResultDTO> search(String query, Pageable pageable);
}
