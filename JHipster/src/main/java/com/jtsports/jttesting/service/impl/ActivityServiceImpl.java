package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.service.ActivityService;
import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.search.ActivitySearchRepository;
import com.jtsports.jttesting.service.dto.Activity.ActivityResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Activity.ActivityStatsDTO;
import com.jtsports.jttesting.service.dto.ActivityDTO;
import com.jtsports.jttesting.service.mapper.ActivityMapper;
import com.jtsports.jttesting.service.util.StatsUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing Activity.
 */
@Service
@Transactional
public class ActivityServiceImpl implements ActivityService {

    private final Logger log = LoggerFactory.getLogger(ActivityServiceImpl.class);

    private final ActivityRepository activityRepository;

    private final ActivityMapper activityMapper;

    private final ActivitySearchRepository activitySearchRepository;

    public ActivityServiceImpl(ActivityRepository activityRepository, ActivityMapper activityMapper, ActivitySearchRepository activitySearchRepository) {
        this.activityRepository = activityRepository;
        this.activityMapper = activityMapper;
        this.activitySearchRepository = activitySearchRepository;
    }

    /**
     * Save a activity.
     *
     * @param activityDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public ActivityDTO save(ActivityDTO activityDTO) {
        log.debug("Request to save Activity : {}", activityDTO);
        Activity activity = activityMapper.toEntity(activityDTO);
        activity = activityRepository.save(activity);
        ActivityDTO result = activityMapper.toDto(activity);
        activitySearchRepository.save(activity);
        return result;
    }

    /**
     * Get all the activities.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityDTO> findAll(Pageable pageable) {
        log.debug("Request to get all Activities");
        return activityRepository.findAll(pageable)
            .map(activityMapper::toDto);
    }

    /**
     * Get all the Activity with eager load of many-to-many relationships.
     *
     * @return the list of entities
     */
    public Page<ActivityDTO> findAllWithEagerRelationships(Pageable pageable) {
        return activityRepository.findAllWithEagerRelationships(pageable).map(activityMapper::toDto);
    }
    

    /**
     * Get one activity by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<ActivityDTO> findOne(Long id) {
        log.debug("Request to get Activity : {}", id);
        return activityRepository.findOneWithEagerRelationships(id)
            .map(activityMapper::toDto);
    }

    /**
     * Delete the activity by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete Activity : {}", id);
        activityRepository.deleteById(id);
        activitySearchRepository.deleteById(id);
    }

    /**
     * Search for the activity corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<ActivityDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of Activities for query {}", query);
        return activitySearchRepository.search(queryStringQuery(query), pageable)
            .map(activityMapper::toDto);
    }

    @Override
    public ActivityStatsDTO findStats(Long id) {
        Optional<Activity> activity = activityRepository.findOneWithEagerRelationships(id);
        ActivityStatsDTO activityStatsDTO = new ActivityStatsDTO();

        if(activity.isPresent()) {

            activityStatsDTO.setActivity(activityMapper.toDto(activity.get()));

            List<ActivityResult> virtualResults = activityRepository.findActivityStats(id, true);
            List<ActivityResult> realResults = activityRepository.findActivityStats(id, false);

            //Stats of virtual users
            List<Float> primaryVirtualResults = virtualResults.stream().filter(r -> r.getPrimaryResultValue() != null).map(r -> r.getPrimaryResultValue()).collect(Collectors.toList());
            List<Float> secondaryVirtualResults = virtualResults.stream().filter(r -> r.getSecondaryResultValue() != null).map(r -> r.getSecondaryResultValue()).collect(Collectors.toList());


            ActivityResultsStatsDTO virtualResultsStatsDTO = this.getActivityResultStats(primaryVirtualResults, secondaryVirtualResults);
            activityStatsDTO.setVirtualStats(virtualResultsStatsDTO);


            //Stats of real users
            List<Float> primaryRealResults = realResults.stream().filter(r -> r.getPrimaryResultValue() != null).map(r -> r.getPrimaryResultValue()).collect(Collectors.toList());
            List<Float> secondaryRealResults = realResults.stream().filter(r -> r.getSecondaryResultValue() != null).map(r -> r.getSecondaryResultValue()).collect(Collectors.toList());

            ActivityResultsStatsDTO realResultsStatsDTO = this.getActivityResultStats(primaryRealResults, secondaryRealResults);
            activityStatsDTO.setRealStats(realResultsStatsDTO);

            return activityStatsDTO;
        }
        return null;
    }

    private ActivityResultsStatsDTO getActivityResultStats(List<Float> primaryResults, List<Float> secondaryResults) {
        ActivityResultsStatsDTO resultsStatsDTO = new ActivityResultsStatsDTO();

        if(primaryResults != null && primaryResults.size() > 0) {
            resultsStatsDTO.setPrimaryAverage(StatsUtil.average(primaryResults));
            resultsStatsDTO.setPrimaryMedian(StatsUtil.median(primaryResults));
            resultsStatsDTO.setPrimaryMin(StatsUtil.min(primaryResults));
            resultsStatsDTO.setPrimaryMax(StatsUtil.max(primaryResults));
        }

        if(secondaryResults != null && secondaryResults.size() > 0) {
            resultsStatsDTO.setSecondaryAverage(StatsUtil.average(secondaryResults));
            resultsStatsDTO.setSecondaryMedian(StatsUtil.median(secondaryResults));
            resultsStatsDTO.setSecondaryMin(StatsUtil.min(secondaryResults));
            resultsStatsDTO.setSecondaryMax(StatsUtil.max(secondaryResults));
        }

        return resultsStatsDTO;
    }
}
