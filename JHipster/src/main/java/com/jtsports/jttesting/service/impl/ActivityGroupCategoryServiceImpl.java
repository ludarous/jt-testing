package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.ActivityGroupCategoryService;
import com.jtsports.jttesting.domain.ActivityGroupCategory;
import com.jtsports.jttesting.repository.ActivityGroupCategoryRepository;
import com.jtsports.jttesting.repository.search.ActivityGroupCategorySearchRepository;
import com.jtsports.jttesting.service.dto.ActivityGroupCategoryDTO;
import com.jtsports.jttesting.service.mapper.ActivityGroupCategoryMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing ActivityGroupCategory.
 */
@Service
@Transactional
public class ActivityGroupCategoryServiceImpl implements ActivityGroupCategoryService {

    private final Logger log = LoggerFactory.getLogger(ActivityGroupCategoryServiceImpl.class);

    private final ActivityGroupCategoryRepository activityGroupCategoryRepository;

    private final ActivityGroupCategoryMapper activityGroupCategoryMapper;

    private final ActivityGroupCategorySearchRepository activityGroupCategorySearchRepository;

    public ActivityGroupCategoryServiceImpl(ActivityGroupCategoryRepository activityGroupCategoryRepository, ActivityGroupCategoryMapper activityGroupCategoryMapper, ActivityGroupCategorySearchRepository activityGroupCategorySearchRepository) {
        this.activityGroupCategoryRepository = activityGroupCategoryRepository;
        this.activityGroupCategoryMapper = activityGroupCategoryMapper;
        this.activityGroupCategorySearchRepository = activityGroupCategorySearchRepository;
    }

    /**
     * Save a activityGroupCategory.
     *
     * @param activityGroupCategoryDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public ActivityGroupCategoryDTO save(ActivityGroupCategoryDTO activityGroupCategoryDTO) {
        log.debug("Request to save ActivityGroupCategory : {}", activityGroupCategoryDTO);
        ActivityGroupCategory activityGroupCategory = activityGroupCategoryMapper.toEntity(activityGroupCategoryDTO);
        activityGroupCategory = activityGroupCategoryRepository.save(activityGroupCategory);
        ActivityGroupCategoryDTO result = activityGroupCategoryMapper.toDto(activityGroupCategory);
        activityGroupCategorySearchRepository.save(activityGroupCategory);
        return result;
    }

    /**
     * Get all the activityGroupCategories.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityGroupCategoryDTO> findAll(Pageable pageable) {
        log.debug("Request to get all ActivityGroupCategories");
        return activityGroupCategoryRepository.findAll(pageable)
            .map(activityGroupCategoryMapper::toDto);
    }


    /**
     * Get one activityGroupCategory by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<ActivityGroupCategoryDTO> findOne(Long id) {
        log.debug("Request to get ActivityGroupCategory : {}", id);
        return activityGroupCategoryRepository.findById(id)
            .map(activityGroupCategoryMapper::toDto);
    }

    /**
     * Delete the activityGroupCategory by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete ActivityGroupCategory : {}", id);
        activityGroupCategoryRepository.deleteById(id);
        activityGroupCategorySearchRepository.deleteById(id);
    }

    /**
     * Search for the activityGroupCategory corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityGroupCategoryDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of ActivityGroupCategories for query {}", query);
        return activityGroupCategorySearchRepository.search(queryStringQuery(query), pageable)
            .map(activityGroupCategoryMapper::toDto);
    }
}
