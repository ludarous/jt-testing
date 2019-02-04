package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.WorkoutService;
import com.jtsports.jttesting.domain.Workout;
import com.jtsports.jttesting.repository.WorkoutRepository;
import com.jtsports.jttesting.repository.search.WorkoutSearchRepository;
import com.jtsports.jttesting.service.dto.WorkoutDTO;
import com.jtsports.jttesting.service.mapper.WorkoutMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing Workout.
 */
@Service
@Transactional
public class WorkoutServiceImpl implements WorkoutService {

    private final Logger log = LoggerFactory.getLogger(WorkoutServiceImpl.class);

    private final WorkoutRepository workoutRepository;

    private final WorkoutMapper workoutMapper;

    private final WorkoutSearchRepository workoutSearchRepository;

    public WorkoutServiceImpl(WorkoutRepository workoutRepository, WorkoutMapper workoutMapper, WorkoutSearchRepository workoutSearchRepository) {
        this.workoutRepository = workoutRepository;
        this.workoutMapper = workoutMapper;
        this.workoutSearchRepository = workoutSearchRepository;
    }

    /**
     * Save a workout.
     *
     * @param workoutDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public WorkoutDTO save(WorkoutDTO workoutDTO) {
        log.debug("Request to save Workout : {}", workoutDTO);
        Workout workout = workoutMapper.toEntity(workoutDTO);
        workout = workoutRepository.save(workout);
        WorkoutDTO result = workoutMapper.toDto(workout);
        workoutSearchRepository.save(workout);
        return result;
    }

    /**
     * Get all the workouts.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<WorkoutDTO> findAll(Pageable pageable) {
        log.debug("Request to get all Workouts");
        return workoutRepository.findAll(pageable)
            .map(workoutMapper::toDto);
    }

    /**
     * Get all the Workout with eager load of many-to-many relationships.
     *
     * @return the list of entities
     */
    public Page<WorkoutDTO> findAllWithEagerRelationships(Pageable pageable) {
        return workoutRepository.findAllWithEagerRelationships(pageable).map(workoutMapper::toDto);
    }
    

    /**
     * Get one workout by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<WorkoutDTO> findOne(Long id) {
        log.debug("Request to get Workout : {}", id);
        return workoutRepository.findOneWithEagerRelationships(id)
            .map(workoutMapper::toDto);
    }

    /**
     * Delete the workout by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete Workout : {}", id);
        workoutRepository.deleteById(id);
        workoutSearchRepository.deleteById(id);
    }

    /**
     * Search for the workout corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<WorkoutDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of Workouts for query {}", query);
        return workoutSearchRepository.search(queryStringQuery(query), pageable)
            .map(workoutMapper::toDto);
    }
}
