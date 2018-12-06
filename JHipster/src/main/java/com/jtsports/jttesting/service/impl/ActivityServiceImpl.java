package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.service.ActivityService;
import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.search.ActivitySearchRepository;
import com.jtsports.jttesting.service.dto.Activity.*;
import com.jtsports.jttesting.service.dto.ActivityDTO;
import com.jtsports.jttesting.service.mapper.ActivityMapper;
import com.jtsports.jttesting.service.util.StatsUtil;
import javafx.collections.transformation.SortedList;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import javax.swing.text.html.Option;
import java.util.Collections;
import java.util.Comparator;
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
    public ActivityStatsDTO findStats(ActivityStatsRequestDTO activityStatsRequest) {
        Optional<Activity> activity = activityRepository.findOneWithEagerRelationships(activityStatsRequest.getActivityId());
        ActivityStatsDTO activityStatsDTO = new ActivityStatsDTO();

        if(activity.isPresent()) {

            List<ActivityResult> allActivityResults = activityRepository.findActivityResults(activityStatsRequest.getActivityId());
            List<ActivityResult> filteredResults = this.filterResults(allActivityResults, activityStatsRequest);

            activityStatsDTO.setActivity(activityMapper.toDto(activity.get()));
            ActivityResultsStatsDTO resultsStatsDTO = this.getActivityResultStats(filteredResults, activityStatsRequest);
            activityStatsDTO.setActivityResultsStats(resultsStatsDTO);

            return activityStatsDTO;
        }
        return null;
    }

    @Override
    public PersonalActivityStatsDTO findPersonalStats(Long personId, ActivityStatsRequestDTO activityStatsRequest) {
        Optional<Activity> activity = activityRepository.findOneWithEagerRelationships(activityStatsRequest.getActivityId());
        PersonalActivityStatsDTO personalActivityStatsDTO = new PersonalActivityStatsDTO();

        if(activity.isPresent()) {

            List<ActivityResult> allActivityResults = activityRepository.findActivityResults(activityStatsRequest.getActivityId());
            List<ActivityResult> filteredResults = this.filterResults(allActivityResults, activityStatsRequest);

            personalActivityStatsDTO.setActivity(activityMapper.toDto(activity.get()));
            ActivityResultsStatsDTO resultsStatsDTO = this.getActivityResultStats(filteredResults, activityStatsRequest);
            personalActivityStatsDTO.setActivityResultsStats(resultsStatsDTO);

            PersonalActivityResultsStatsDTO personalActivityResultsStatsDTO = this.getPersonalActivityResultStats(filteredResults, personId, activityStatsRequest);
            personalActivityStatsDTO.setPersonalActivityResultsStats(personalActivityResultsStatsDTO);


            return personalActivityStatsDTO;
        }
        return null;
    }

    private PersonalActivityResultsStatsDTO getPersonalActivityResultStats(List<ActivityResult> filteredResults, Long personId, ActivityStatsRequestDTO activityStatsRequest) {
        PersonalActivityResultsStatsDTO personalActivityResultsStatsDTO = new PersonalActivityResultsStatsDTO();
        Optional<ActivityResult> personResultOptional = this.filterPersonResults(filteredResults, personId).stream().findFirst();
        if(personResultOptional.isPresent()) {

            Comparator<ActivityResult> resultPrimaryComparator = Comparator.comparing(ActivityResult::getPrimaryResultValue,Comparator.nullsLast(Float::compareTo));
            Collections.sort(filteredResults, resultPrimaryComparator);

            int primaryPlacement = filteredResults.lastIndexOf(personResultOptional.get());
            personalActivityResultsStatsDTO.setPrimaryPlacement(primaryPlacement);

            if(personResultOptional.get().getSecondaryResultValue() != null) {

                Comparator<ActivityResult> resultSecondaryComparator = Comparator.comparing(ActivityResult::getSecondaryResultValue,Comparator.nullsLast(Float::compareTo));
                Collections.sort(filteredResults, resultSecondaryComparator);

                int secondaryPlacement = filteredResults.lastIndexOf(personResultOptional.get());
                personalActivityResultsStatsDTO.setSecondaryPlacement(secondaryPlacement);
            }
        }

        return personalActivityResultsStatsDTO;

    }


    private List<ActivityResult> filterResults(List<ActivityResult> results, ActivityStatsRequestDTO activityStatsRequest) {
        List<ActivityResult> filteredResults = results;

        if(activityStatsRequest.getTestId() != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getTest().getId().longValue() == activityStatsRequest.getTestId().longValue()).collect(Collectors.toList());
        }

        if(activityStatsRequest.getEventId() != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getEvent().getId().longValue() == activityStatsRequest.getEventId().longValue()).collect(Collectors.toList());
        }

        if(activityStatsRequest.getDateFrom() != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getEvent().getDate().isAfter(activityStatsRequest.getDateFrom())).collect(Collectors.toList());
        }

        if(activityStatsRequest.getDateTo() != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getEvent().getDate().isBefore(activityStatsRequest.getDateTo())).collect(Collectors.toList());
        }

        if(activityStatsRequest.getUsersBirthdayFrom() != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getPerson().getPersonalData().getBirthDate().isAfter(activityStatsRequest.getUsersBirthdayFrom())).collect(Collectors.toList());
        }

        if(activityStatsRequest.getUsersBirthDayTo() != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getPerson().getPersonalData().getBirthDate().isBefore(activityStatsRequest.getUsersBirthDayTo())).collect(Collectors.toList());
        }

        if(activityStatsRequest.getVirtual() != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getPerson().isVirtual().booleanValue() == activityStatsRequest.getVirtual().booleanValue()).collect(Collectors.toList());
        }

        return filteredResults;
    }

    private List<ActivityResult> filterPersonResults(List<ActivityResult> results, Long personId) {
        List<ActivityResult> filteredResults = results;


        if(personId != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getPerson().getId().longValue() == personId.longValue()).collect(Collectors.toList());
        }

        return filteredResults;
    }



    private ActivityResultsStatsDTO getActivityResultStats(List<ActivityResult> filteredResults, ActivityStatsRequestDTO activityStatsRequest) {

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
