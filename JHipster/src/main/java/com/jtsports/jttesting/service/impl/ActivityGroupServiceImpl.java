package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.ActivityGroupService;
import com.jtsports.jttesting.domain.ActivityGroup;
import com.jtsports.jttesting.repository.ActivityGroupRepository;
import com.jtsports.jttesting.repository.search.ActivityGroupSearchRepository;
import com.jtsports.jttesting.service.dto.ActivityGroupDTO;
import com.jtsports.jttesting.service.mapper.ActivityGroupMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing ActivityGroup.
 */
@Service
@Transactional
public class ActivityGroupServiceImpl implements ActivityGroupService {

    private final Logger log = LoggerFactory.getLogger(ActivityGroupServiceImpl.class);

    private final ActivityGroupRepository activityGroupRepository;

    private final ActivityGroupMapper activityGroupMapper;

    private final ActivityGroupSearchRepository activityGroupSearchRepository;

    public ActivityGroupServiceImpl(ActivityGroupRepository activityGroupRepository, ActivityGroupMapper activityGroupMapper, ActivityGroupSearchRepository activityGroupSearchRepository) {
        this.activityGroupRepository = activityGroupRepository;
        this.activityGroupMapper = activityGroupMapper;
        this.activityGroupSearchRepository = activityGroupSearchRepository;
    }

    /**
     * Save a activityGroup.
     *
     * @param activityGroupDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public ActivityGroupDTO save(ActivityGroupDTO activityGroupDTO) {
        log.debug("Request to save ActivityGroup : {}", activityGroupDTO);
        ActivityGroup activityGroup = activityGroupMapper.toEntity(activityGroupDTO);
        activityGroup = activityGroupRepository.save(activityGroup);
        ActivityGroupDTO result = activityGroupMapper.toDto(activityGroup);
        activityGroupSearchRepository.save(activityGroup);
        return result;
    }

    /**
     * Get all the activityGroups.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityGroupDTO> findAll(Pageable pageable) {
        log.debug("Request to get all ActivityGroups");
        return activityGroupRepository.findAll(pageable)
            .map(activityGroupMapper::toDto);
    }

    /**
     * Get all the ActivityGroup with eager load of many-to-many relationships.
     *
     * @return the list of entities
     */
    public Page<ActivityGroupDTO> findAllWithEagerRelationships(Pageable pageable) {
        return activityGroupRepository.findAllWithEagerRelationships(pageable).map(activityGroupMapper::toDto);
    }
    

    /**
     * Get one activityGroup by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<ActivityGroupDTO> findOne(Long id) {
        log.debug("Request to get ActivityGroup : {}", id);
        return activityGroupRepository.findOneWithEagerRelationships(id)
            .map(activityGroupMapper::toDto);
    }

    /**
     * Delete the activityGroup by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete ActivityGroup : {}", id);
        activityGroupRepository.deleteById(id);
        activityGroupSearchRepository.deleteById(id);
    }

    /**
     * Search for the activityGroup corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityGroupDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of ActivityGroups for query {}", query);
        return activityGroupSearchRepository.search(queryStringQuery(query), pageable)
            .map(activityGroupMapper::toDto);
    }
}
