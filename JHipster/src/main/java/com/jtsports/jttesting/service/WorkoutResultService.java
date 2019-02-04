package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.WorkoutResultDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing WorkoutResult.
 */
public interface WorkoutResultService {

    /**
     * Save a workoutResult.
     *
     * @param workoutResultDTO the entity to save
     * @return the persisted entity
     */
    WorkoutResultDTO save(WorkoutResultDTO workoutResultDTO);

    /**
     * Get all the workoutResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<WorkoutResultDTO> findAll(Pageable pageable);


    /**
     * Get the "id" workoutResult.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<WorkoutResultDTO> findOne(Long id);

    /**
     * Delete the "id" workoutResult.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the workoutResult corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<WorkoutResultDTO> search(String query, Pageable pageable);
}
