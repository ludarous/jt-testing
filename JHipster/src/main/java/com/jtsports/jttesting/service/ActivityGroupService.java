package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.ActivityGroupDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing ActivityGroup.
 */
public interface ActivityGroupService {

    /**
     * Save a activityGroup.
     *
     * @param activityGroupDTO the entity to save
     * @return the persisted entity
     */
    ActivityGroupDTO save(ActivityGroupDTO activityGroupDTO);

    /**
     * Get all the activityGroups.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<ActivityGroupDTO> findAll(Pageable pageable);

    /**
     * Get all the ActivityGroup with eager load of many-to-many relationships.
     *
     * @return the list of entities
     */
    Page<ActivityGroupDTO> findAllWithEagerRelationships(Pageable pageable);
    
    /**
     * Get the "id" activityGroup.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<ActivityGroupDTO> findOne(Long id);

    /**
     * Delete the "id" activityGroup.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the activityGroup corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<ActivityGroupDTO> search(String query, Pageable pageable);
}
