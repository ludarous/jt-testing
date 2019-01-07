package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.JTTestRepository;
import com.jtsports.jttesting.service.ActivityCategoryService;
import com.jtsports.jttesting.domain.ActivityCategory;
import com.jtsports.jttesting.repository.ActivityCategoryRepository;
import com.jtsports.jttesting.repository.search.ActivityCategorySearchRepository;
import com.jtsports.jttesting.service.ActivityService;
import com.jtsports.jttesting.service.dto.Activity.PersonalActivityStatsDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import com.jtsports.jttesting.service.dto.ActivityCategoryDTO;
import com.jtsports.jttesting.service.dto.Category.PersonalCategoryResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Category.PersonalCategoryStatsDTO;
import com.jtsports.jttesting.service.mapper.ActivityCategoryMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing ActivityCategory.
 */
@Service
@Transactional
public class ActivityCategoryServiceImpl implements ActivityCategoryService {

    private final Logger log = LoggerFactory.getLogger(ActivityCategoryServiceImpl.class);

    private final ActivityCategoryRepository activityCategoryRepository;

    private final ActivityCategoryMapper activityCategoryMapper;

    private final ActivityCategorySearchRepository activityCategorySearchRepository;

    private final ActivityService activityService;

    private final ActivityRepository activityRepository;

    private final JTTestRepository testRepository;

    public ActivityCategoryServiceImpl(ActivityCategoryRepository activityCategoryRepository, ActivityCategoryMapper activityCategoryMapper, ActivityCategorySearchRepository activityCategorySearchRepository, ActivityService activityService, ActivityRepository activityRepository, JTTestRepository testRepository) {
        this.activityCategoryRepository = activityCategoryRepository;
        this.activityCategoryMapper = activityCategoryMapper;
        this.activityCategorySearchRepository = activityCategorySearchRepository;
        this.activityService = activityService;
        this.activityRepository = activityRepository;
        this.testRepository = testRepository;
    }

    /**
     * Save a activityCategory.
     *
     * @param activityCategoryDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public ActivityCategoryDTO save(ActivityCategoryDTO activityCategoryDTO) {
        log.debug("Request to save ActivityCategory : {}", activityCategoryDTO);
        ActivityCategory activityCategory = activityCategoryMapper.toEntity(activityCategoryDTO);
        activityCategory = activityCategoryRepository.save(activityCategory);
        ActivityCategoryDTO result = activityCategoryMapper.toDto(activityCategory);
        activityCategorySearchRepository.save(activityCategory);
        return result;
    }

    /**
     * Get all the activityCategories.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityCategoryDTO> findAll(Pageable pageable) {
        log.debug("Request to get all ActivityCategories");
        return activityCategoryRepository.findAll(pageable)
            .map(activityCategoryMapper::toDto);
    }


    /**
     * Get one activityCategory by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<ActivityCategoryDTO> findOne(Long id) {
        log.debug("Request to get ActivityCategory : {}", id);
        return activityCategoryRepository.findById(id)
            .map(activityCategoryMapper::toDto);
    }

    /**
     * Delete the activityCategory by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete ActivityCategory : {}", id);
        activityCategoryRepository.deleteById(id);
        activityCategorySearchRepository.deleteById(id);
    }

    /**
     * Search for the activityCategory corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityCategoryDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of ActivityCategories for query {}", query);
        return activityCategorySearchRepository.search(queryStringQuery(query), pageable)
            .map(activityCategoryMapper::toDto);
    }


    @Override
    public List<ActivityCategory> findOneWithSubcategories(Long categoryId) {
        List<ActivityCategory> allCategories = new ArrayList<>();

        if(categoryId != null) {
            allCategories.add(this.activityCategoryRepository.getOne(categoryId));
        }

        List<ActivityCategory> subCategories = this.activityCategoryRepository.findAllByParentId(categoryId);

        for(ActivityCategory activitySubCategory : subCategories) {
            allCategories.addAll(this.findOneWithSubcategories(activitySubCategory.getId()));
        }

        return allCategories;
    }

    @Override
    public List<Activity> findByCategoryId(Long categoryId, Long eventId, Long testId) {

        List<ActivityCategory> categories = this.findOneWithSubcategories(categoryId);
        List<Long> categoriesIds = categories.stream().map(c -> c.getId()).collect(Collectors.toList());
        List<Activity> activities = new ArrayList<>();

        if(eventId != null && testId != null) {
            activities = this.activityRepository.findActivityByCategoriesAndEventIdAndTestId(categoriesIds, eventId, testId);
        } else if(eventId != null) {
            activities = this.activityRepository.findActivityByCategoriesAndEventId(categoriesIds, eventId);
        } else {
            activities = this.activityRepository.findActivityByCategories(categoriesIds);
        }

        return activities;

    }

    @Override
    public List<ActivityCategory> getAllSubcategories(ActivityCategory activityCategory) {
        List<ActivityCategory> allSubcategories = new ArrayList<>();
        allSubcategories.add(activityCategory);
        for(ActivityCategory ac : activityCategory.getChildren()) {
            allSubcategories.addAll(getAllSubcategories(ac));
        }
        return allSubcategories;
    }

}
