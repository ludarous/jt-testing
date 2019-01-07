package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.service.ActivityCategoryService;
import com.jtsports.jttesting.service.ActivityService;
import com.jtsports.jttesting.service.JTTestService;
import com.jtsports.jttesting.domain.JTTest;
import com.jtsports.jttesting.repository.JTTestRepository;
import com.jtsports.jttesting.repository.search.JTTestSearchRepository;
import com.jtsports.jttesting.service.dto.Activity.PersonalActivityStatsDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import com.jtsports.jttesting.service.dto.JTTestDTO;
import com.jtsports.jttesting.service.dto.Test.PersonalTestsStatsDTO;
import com.jtsports.jttesting.service.mapper.JTTestMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing JTTest.
 */
@Service
@Transactional
public class JTTestServiceImpl implements JTTestService {

    private final Logger log = LoggerFactory.getLogger(JTTestServiceImpl.class);

    private final JTTestRepository jTTestRepository;

    private final JTTestMapper jTTestMapper;

    private final JTTestSearchRepository jTTestSearchRepository;

    private final ActivityService activityService;

    private final ActivityCategoryService activityCategoryService;

    public JTTestServiceImpl(JTTestRepository jTTestRepository, JTTestMapper jTTestMapper, JTTestSearchRepository jTTestSearchRepository, ActivityService activityService, ActivityCategoryService activityCategoryService) {
        this.jTTestRepository = jTTestRepository;
        this.jTTestMapper = jTTestMapper;
        this.jTTestSearchRepository = jTTestSearchRepository;
        this.activityService = activityService;
        this.activityCategoryService = activityCategoryService;
    }

    /**
     * Save a jTTest.
     *
     * @param jTTestDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public JTTestDTO save(JTTestDTO jTTestDTO) {
        log.debug("Request to save JTTest : {}", jTTestDTO);
        JTTest jTTest = jTTestMapper.toEntity(jTTestDTO);
        jTTest = jTTestRepository.save(jTTest);
        JTTestDTO result = jTTestMapper.toDto(jTTest);
        jTTestSearchRepository.save(jTTest);
        return result;
    }

    /**
     * Get all the jTTests.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<JTTestDTO> findAll(Pageable pageable) {
        log.debug("Request to get all JTTests");
        return jTTestRepository.findAll(pageable)
            .map(jTTestMapper::toDto);
    }

    /**
     * Get all the JTTest with eager load of many-to-many relationships.
     *
     * @return the list of entities
     */
    public Page<JTTestDTO> findAllWithEagerRelationships(Pageable pageable) {
        return jTTestRepository.findAllWithEagerRelationships(pageable).map(jTTestMapper::toDto);
    }


    /**
     * Get one jTTest by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<JTTestDTO> findOne(Long id) {
        log.debug("Request to get JTTest : {}", id);
        return jTTestRepository.findOneWithEagerRelationships(id)
            .map(jTTestMapper::toDto);
    }

    /**
     * Delete the jTTest by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete JTTest : {}", id);
        jTTestRepository.deleteById(id);
        jTTestSearchRepository.deleteById(id);
    }

    /**
     * Search for the jTTest corresponding to the query.
     *
     * @param query    the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<JTTestDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of JTTests for query {}", query);
        return jTTestSearchRepository.search(queryStringQuery(query), pageable)
            .map(jTTestMapper::toDto);
    }

}
