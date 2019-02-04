package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.WorkoutResultService;
import com.jtsports.jttesting.domain.WorkoutResult;
import com.jtsports.jttesting.repository.WorkoutResultRepository;
import com.jtsports.jttesting.repository.search.WorkoutResultSearchRepository;
import com.jtsports.jttesting.service.dto.WorkoutResultDTO;
import com.jtsports.jttesting.service.mapper.WorkoutResultMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing WorkoutResult.
 */
@Service
@Transactional
public class WorkoutResultServiceImpl implements WorkoutResultService {

    private final Logger log = LoggerFactory.getLogger(WorkoutResultServiceImpl.class);

    private final WorkoutResultRepository workoutResultRepository;

    private final WorkoutResultMapper workoutResultMapper;

    private final WorkoutResultSearchRepository workoutResultSearchRepository;

    public WorkoutResultServiceImpl(WorkoutResultRepository workoutResultRepository, WorkoutResultMapper workoutResultMapper, WorkoutResultSearchRepository workoutResultSearchRepository) {
        this.workoutResultRepository = workoutResultRepository;
        this.workoutResultMapper = workoutResultMapper;
        this.workoutResultSearchRepository = workoutResultSearchRepository;
    }

    /**
     * Save a workoutResult.
     *
     * @param workoutResultDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public WorkoutResultDTO save(WorkoutResultDTO workoutResultDTO) {
        log.debug("Request to save WorkoutResult : {}", workoutResultDTO);
        WorkoutResult workoutResult = workoutResultMapper.toEntity(workoutResultDTO);
        workoutResult = workoutResultRepository.save(workoutResult);
        WorkoutResultDTO result = workoutResultMapper.toDto(workoutResult);
        workoutResultSearchRepository.save(workoutResult);
        return result;
    }

    /**
     * Get all the workoutResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<WorkoutResultDTO> findAll(Pageable pageable) {
        log.debug("Request to get all WorkoutResults");
        return workoutResultRepository.findAll(pageable)
            .map(workoutResultMapper::toDto);
    }


    /**
     * Get one workoutResult by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<WorkoutResultDTO> findOne(Long id) {
        log.debug("Request to get WorkoutResult : {}", id);
        return workoutResultRepository.findById(id)
            .map(workoutResultMapper::toDto);
    }

    /**
     * Delete the workoutResult by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete WorkoutResult : {}", id);
        workoutResultRepository.deleteById(id);
        workoutResultSearchRepository.deleteById(id);
    }

    /**
     * Search for the workoutResult corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<WorkoutResultDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of WorkoutResults for query {}", query);
        return workoutResultSearchRepository.search(queryStringQuery(query), pageable)
            .map(workoutResultMapper::toDto);
    }
}
