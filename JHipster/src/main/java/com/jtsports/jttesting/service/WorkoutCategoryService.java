package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.WorkoutCategoryDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing WorkoutCategory.
 */
public interface WorkoutCategoryService {

    /**
     * Save a workoutCategory.
     *
     * @param workoutCategoryDTO the entity to save
     * @return the persisted entity
     */
    WorkoutCategoryDTO save(WorkoutCategoryDTO workoutCategoryDTO);

    /**
     * Get all the workoutCategories.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<WorkoutCategoryDTO> findAll(Pageable pageable);


    /**
     * Get the "id" workoutCategory.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<WorkoutCategoryDTO> findOne(Long id);

    /**
     * Delete the "id" workoutCategory.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the workoutCategory corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<WorkoutCategoryDTO> search(String query, Pageable pageable);
}