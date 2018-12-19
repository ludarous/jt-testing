package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.repository.ActivityCategoryRepository;
import com.jtsports.jttesting.repository.DAO.ActivityResultDAO;
import com.jtsports.jttesting.service.ActivityService;
import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.search.ActivitySearchRepository;
import com.jtsports.jttesting.service.dto.Activity.*;
import com.jtsports.jttesting.service.dto.ActivityDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import com.jtsports.jttesting.service.mapper.ActivityMapper;
import com.jtsports.jttesting.service.mapper.ActivityResultMapper;
import com.jtsports.jttesting.service.util.StatsUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.util.*;
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

    private final ActivityResultMapper activityResultMapper;

    private final ActivityCategoryRepository activityCategoryRepository;

    private final ActivitySearchRepository activitySearchRepository;

    public ActivityServiceImpl(ActivityRepository activityRepository, ActivityMapper activityMapper, ActivityResultMapper activityResultMapper, ActivityCategoryRepository activityCategoryRepository, ActivitySearchRepository activitySearchRepository) {
        this.activityRepository = activityRepository;
        this.activityMapper = activityMapper;
        this.activityResultMapper = activityResultMapper;
        this.activityCategoryRepository = activityCategoryRepository;
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
    public ActivityStatsDTO findStats(Long activityId, StatsRequestDTO statsRequest) {
        Optional<Activity> activity = activityRepository.findOneWithEagerRelationships(activityId);
        ActivityStatsDTO activityStatsDTO = new ActivityStatsDTO();

        if(activity.isPresent()) {

            List<ActivityResult> filteredResults = this.getFilterActivityResults(activityId, statsRequest);

            activityStatsDTO.setActivity(activityMapper.toDto(activity.get()));
            ActivityResultsStatsDTO resultsStatsDTO = this.getActivityResultStats(filteredResults, statsRequest);
            activityStatsDTO.setActivityResultsStats(resultsStatsDTO);

            return activityStatsDTO;
        }
        return null;
    }

    @Override
    public PersonalActivityStatsDTO findPersonalActivityStats(Long personId, Long activityId, StatsRequestDTO statsRequest) {
        Optional<Activity> activity = activityRepository.findOneWithEagerRelationships(activityId);
        PersonalActivityStatsDTO personalActivityStatsDTO = new PersonalActivityStatsDTO();

        if(activity.isPresent()) {

            List<ActivityResult> filteredResults = this.getFilterActivityResults(activityId, statsRequest);
            List<ActivityResult> personalResults = filteredResults
                .stream()
                .filter(ar -> ar.getTestResult().getEventResult().getPerson().getId().longValue() == personId.longValue())
                .collect(Collectors.toList());

            personalActivityStatsDTO.setActivity(activityMapper.toDto(activity.get()));

            ActivityResultsStatsDTO resultsStatsDTO = this.getActivityResultStats(filteredResults, statsRequest);
            personalActivityStatsDTO.setActivityResultsStats(resultsStatsDTO);

            List<PersonalActivityResultsStatsDTO> personalActivityResultsStatsDTOs = this.getPersonalActivityResultStats(filteredResults, personId);
            personalActivityStatsDTO.setPersonalActivityResultsStats(personalActivityResultsStatsDTOs);
            personalActivityStatsDTO.setPersonalActivityResults(personalResults.stream().map(activityResultMapper::toDto).collect(Collectors.toList()));


            return personalActivityStatsDTO;
        }
        return null;
    }

    @Override
    public List<PersonalActivityStatsDTO> findPersonalActivitiesStats(Long personId, StatsRequestDTO statsRequest) {
        long calculateStartTime = System.currentTimeMillis();

        List<PersonalActivityStatsDTO> personalActivityStatsDTOList = new ArrayList<>();

        List<ActivityResult> filteredResults = this.getFilterAllActivitieResults(statsRequest);

        log.info("Get filtered results duration: " + (System.currentTimeMillis() - calculateStartTime) + " ms, activities results count: " + filteredResults.size());
        List<Activity> activities = filteredResults.stream().map(r -> r.getActivity()).distinct().collect(Collectors.toList());
        for(Activity activity : activities) {

            PersonalActivityStatsDTO personalActivityStatsDTO = new PersonalActivityStatsDTO();
            personalActivityStatsDTO.setActivity(activityMapper.toDto(activity));

            List<ActivityResult> activityFilteredResults = filteredResults.stream()
                .filter(ar -> ar.getActivity().getId().longValue() == activity.getId().longValue())
                .collect(Collectors.toList());
            List<ActivityResult> personalResults = activityFilteredResults
                .stream()
                .filter(ar -> ar.getTestResult().getEventResult().getPerson().getId().longValue() == personId.longValue())
                .collect(Collectors.toList());

            ActivityResultsStatsDTO resultsStatsDTO = this.getActivityResultStats(activityFilteredResults, statsRequest);
            personalActivityStatsDTO.setActivityResultsStats(resultsStatsDTO);

            List<PersonalActivityResultsStatsDTO> personalActivityResultsStatsDTOs = this.getPersonalActivityResultStats(activityFilteredResults, personId);
            personalActivityStatsDTO.setPersonalActivityResultsStats(personalActivityResultsStatsDTOs);

            personalActivityStatsDTOList.add(personalActivityStatsDTO);
            personalActivityStatsDTO.setPersonalActivityResults(personalResults.stream().map(activityResultMapper::toDto).collect(Collectors.toList()));

        }
        log.info("Get all activities stats: " + (System.currentTimeMillis() - calculateStartTime) + " ms, activities count: " + activities.size());
        return personalActivityStatsDTOList;

    }

    private List<PersonalActivityResultsStatsDTO> getPersonalActivityResultStats(List<ActivityResult> filteredResults, Long personId) {

        List<PersonalActivityResultsStatsDTO> personalActivityResultsStatsDTOList = new ArrayList<>();

        List<Float> primaryResults = filteredResults.stream().filter(r -> r.getPrimaryResultValue() != null).map(r -> r.getPrimaryResultValue()).collect(Collectors.toList());
        List<Float> secondaryResults = filteredResults.stream().filter(r -> r.getSecondaryResultValue() != null).map(r -> r.getSecondaryResultValue()).collect(Collectors.toList());

        List<ActivityResult> personalResults = this.filterPersonResults(filteredResults, personId);

        for (ActivityResult personalActivityResult : personalResults) {

            PersonalActivityResultsStatsDTO personalActivityResultsStatsDTO = new PersonalActivityResultsStatsDTO();
            personalActivityResultsStatsDTO.setTotalPrimaryResults(primaryResults.size());
            personalActivityResultsStatsDTO.setTotalSecondaryResults(secondaryResults.size());

            Comparator<ActivityResult> resultPrimaryComparator = Comparator.comparing(ActivityResult::getPrimaryResultValue, Comparator.nullsLast(Float::compareTo));
            Collections.sort(filteredResults, resultPrimaryComparator);

            int primaryPlacement = filteredResults.indexOf(personalActivityResult);
            personalActivityResultsStatsDTO.setPrimaryPlacement(primaryPlacement);

            if (personalActivityResult.getSecondaryResultValue() != null) {

                Comparator<ActivityResult> resultSecondaryComparator = Comparator.comparing(ActivityResult::getSecondaryResultValue, Comparator.nullsLast(Float::compareTo));
                Collections.sort(filteredResults, resultSecondaryComparator);

                int secondaryPlacement = filteredResults.indexOf(personalActivityResult);
                personalActivityResultsStatsDTO.setSecondaryPlacement(secondaryPlacement);
            }

            personalActivityResultsStatsDTOList.add(personalActivityResultsStatsDTO);
        }


        return personalActivityResultsStatsDTOList;

    }


    private List<ActivityResult> getFilterActivityResults(Long activityId, StatsRequestDTO statsRequest) {

        List<ActivityResult> allActivityResults = activityRepository.findActivityResultsWithRequest(
            activityId,
            statsRequest.getTestId(),
            statsRequest.getEventId(),
            statsRequest.getDateFrom(),
            statsRequest.getDateTo(),
            statsRequest.getUsersBirthdayFrom(),
            statsRequest.getUsersBirthDayTo());
        List<ActivityResult> filteredResults = allActivityResults;

        return filteredResults;
    }

    private List<ActivityResult> getFilterAllActivitieResults(StatsRequestDTO statsRequest) {

        List<ActivityResult> allActivityResults = activityRepository.findAllActivitiesResultsWithRequest(
            statsRequest.getTestId(),
            statsRequest.getEventId(),
            statsRequest.getDateFrom(),
            statsRequest.getDateTo(),
            statsRequest.getUsersBirthdayFrom(),
            statsRequest.getUsersBirthDayTo());
        List<ActivityResult> filteredResults = allActivityResults;

        return filteredResults;
    }

    private List<ActivityResult> filterPersonResults(List<ActivityResult> results, Long personId) {
        List<ActivityResult> filteredResults = results;


        if(personId != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getPerson().getId().longValue() == personId.longValue()).collect(Collectors.toList());
        }

        return filteredResults;
    }

    private ActivityResultsStatsDTO getActivityResultStats(List<ActivityResult> filteredResults, StatsRequestDTO activityStatsRequest) {

        List<Float> primaryResults = filteredResults.stream().filter(r -> r.getPrimaryResultValue() != null).map(r -> r.getPrimaryResultValue()).collect(Collectors.toList());
        List<Float> secondaryResults = filteredResults.stream().filter(r -> r.getSecondaryResultValue() != null).map(r -> r.getSecondaryResultValue()).collect(Collectors.toList());

        ActivityResultsStatsDTO resultsStatsDTO = new ActivityResultsStatsDTO();

        if(primaryResults != null && primaryResults.size() > 0) {
            resultsStatsDTO.setPrimaryAverage(StatsUtil.average(primaryResults));
            resultsStatsDTO.setPrimaryMedian(StatsUtil.median(primaryResults));
            resultsStatsDTO.setPrimaryMin(StatsUtil.min(primaryResults));
            resultsStatsDTO.setPrimaryMax(StatsUtil.max(primaryResults));
            resultsStatsDTO.setPrimaryResultsCount(primaryResults.size());
        }

        if(secondaryResults != null && secondaryResults.size() > 0) {
            resultsStatsDTO.setSecondaryAverage(StatsUtil.average(secondaryResults));
            resultsStatsDTO.setSecondaryMedian(StatsUtil.median(secondaryResults));
            resultsStatsDTO.setSecondaryMin(StatsUtil.min(secondaryResults));
            resultsStatsDTO.setSecondaryMax(StatsUtil.max(secondaryResults));
            resultsStatsDTO.setSecondaryResultsCount(secondaryResults.size());
        }

        return resultsStatsDTO;
    }
}
