package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.ActivityGroupCategoryDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing ActivityGroupCategory.
 */
public interface ActivityGroupCategoryService {

    /**
     * Save a activityGroupCategory.
     *
     * @param activityGroupCategoryDTO the entity to save
     * @return the persisted entity
     */
    ActivityGroupCategoryDTO save(ActivityGroupCategoryDTO activityGroupCategoryDTO);

    /**
     * Get all the activityGroupCategories.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<ActivityGroupCategoryDTO> findAll(Pageable pageable);


    /**
     * Get the "id" activityGroupCategory.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<ActivityGroupCategoryDTO> findOne(Long id);

    /**
     * Delete the "id" activityGroupCategory.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the activityGroupCategory corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<ActivityGroupCategoryDTO> search(String query, Pageable pageable);
}
