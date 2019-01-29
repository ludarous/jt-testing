package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.ActivityGroupResultService;
import com.jtsports.jttesting.domain.ActivityGroupResult;
import com.jtsports.jttesting.repository.ActivityGroupResultRepository;
import com.jtsports.jttesting.repository.search.ActivityGroupResultSearchRepository;
import com.jtsports.jttesting.service.dto.ActivityGroupResultDTO;
import com.jtsports.jttesting.service.mapper.ActivityGroupResultMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing ActivityGroupResult.
 */
@Service
@Transactional
public class ActivityGroupResultServiceImpl implements ActivityGroupResultService {

    private final Logger log = LoggerFactory.getLogger(ActivityGroupResultServiceImpl.class);

    private final ActivityGroupResultRepository activityGroupResultRepository;

    private final ActivityGroupResultMapper activityGroupResultMapper;

    private final ActivityGroupResultSearchRepository activityGroupResultSearchRepository;

    public ActivityGroupResultServiceImpl(ActivityGroupResultRepository activityGroupResultRepository, ActivityGroupResultMapper activityGroupResultMapper, ActivityGroupResultSearchRepository activityGroupResultSearchRepository) {
        this.activityGroupResultRepository = activityGroupResultRepository;
        this.activityGroupResultMapper = activityGroupResultMapper;
        this.activityGroupResultSearchRepository = activityGroupResultSearchRepository;
    }

    /**
     * Save a activityGroupResult.
     *
     * @param activityGroupResultDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public ActivityGroupResultDTO save(ActivityGroupResultDTO activityGroupResultDTO) {
        log.debug("Request to save ActivityGroupResult : {}", activityGroupResultDTO);
        ActivityGroupResult activityGroupResult = activityGroupResultMapper.toEntity(activityGroupResultDTO);
        activityGroupResult = activityGroupResultRepository.save(activityGroupResult);
        ActivityGroupResultDTO result = activityGroupResultMapper.toDto(activityGroupResult);
        activityGroupResultSearchRepository.save(activityGroupResult);
        return result;
    }

    /**
     * Get all the activityGroupResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityGroupResultDTO> findAll(Pageable pageable) {
        log.debug("Request to get all ActivityGroupResults");
        return activityGroupResultRepository.findAll(pageable)
            .map(activityGroupResultMapper::toDto);
    }


    /**
     * Get one activityGroupResult by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<ActivityGroupResultDTO> findOne(Long id) {
        log.debug("Request to get ActivityGroupResult : {}", id);
        return activityGroupResultRepository.findById(id)
            .map(activityGroupResultMapper::toDto);
    }

    /**
     * Delete the activityGroupResult by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete ActivityGroupResult : {}", id);
        activityGroupResultRepository.deleteById(id);
        activityGroupResultSearchRepository.deleteById(id);
    }

    /**
     * Search for the activityGroupResult corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityGroupResultDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of ActivityGroupResults for query {}", query);
        return activityGroupResultSearchRepository.search(queryStringQuery(query), pageable)
            .map(activityGroupResultMapper::toDto);
    }
}
