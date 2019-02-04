package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.domain.ActivityCategory;
import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.domain.enumeration.ResultCategory;
import com.jtsports.jttesting.domain.enumeration.ResultType;
import com.jtsports.jttesting.repository.ActivityCategoryRepository;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.ActivityResultRepository;
import com.jtsports.jttesting.repository.WorkoutRepository;
import com.jtsports.jttesting.service.*;
import com.jtsports.jttesting.service.dto.Stats.Activity.ActivityResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Stats.Activity.ActivityStatsDTO;
import com.jtsports.jttesting.service.dto.Stats.Activity.PersonalActivityResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Stats.Activity.PersonalActivityStatsDTO;
import com.jtsports.jttesting.service.dto.Stats.Category.PersonalCategoryResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Stats.Category.PersonalCategoryStatsDTO;
import com.jtsports.jttesting.service.dto.Stats.PersonalStatsDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import com.jtsports.jttesting.service.mapper.ActivityCategoryMapper;
import com.jtsports.jttesting.service.mapper.ActivityMapper;
import com.jtsports.jttesting.service.mapper.ActivityResultMapper;
import com.jtsports.jttesting.service.mapper.WorkoutMapper;
import com.jtsports.jttesting.service.util.StatsUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@Transactional
public class StatsServiceImpl implements StatsService {

    private final Logger log = LoggerFactory.getLogger(ActivityServiceImpl.class);

    private final ActivityService activityService;

    private final ActivityRepository activityRepository;

    private final ActivityMapper activityMapper;


    private final ActivityCategoryService activityCategoryService;

    private final ActivityCategoryRepository activityCategoryRepository;

    private final ActivityCategoryMapper activityCategoryMapper;


    private final ActivityResultService activityResultService;

    private final ActivityResultRepository activityResultRepository;

    private final ActivityResultMapper activityResultMapper;


    private final WorkoutService testService;

    private final WorkoutRepository testRepository;

    private final WorkoutMapper testMapper;

    public StatsServiceImpl(
        ActivityService activityService,
        ActivityRepository activityRepository,
        ActivityCategoryService activityCategoryService,
        ActivityCategoryRepository activityCategoryRepository,
        ActivityCategoryMapper activityCategoryMapper,
        ActivityMapper activityMapper,
        ActivityResultService activityResultService,
        ActivityResultRepository activityResultRepository,
        ActivityResultMapper activityResultMapper, WorkoutService testService, WorkoutRepository testRepository, WorkoutMapper testMapper) {
        this.activityService = activityService;
        this.activityCategoryService = activityCategoryService;
        this.activityCategoryRepository = activityCategoryRepository;
        this.activityCategoryMapper = activityCategoryMapper;
        this.activityMapper = activityMapper;
        this.activityRepository = activityRepository;
        this.activityResultService = activityResultService;
        this.activityResultRepository = activityResultRepository;
        this.activityResultMapper = activityResultMapper;
        this.testService = testService;
        this.testRepository = testRepository;
        this.testMapper = testMapper;
    }

    @Override
    public PersonalStatsDTO getPersonalStats(Long personId, StatsRequestDTO statsRequest) {
        //statsRequest.setPersonId(personId);
        List<ActivityResult> filteredResult = this.filterActivitiesResults(statsRequest);

        List<Activity> resultsActivities = this.getAllResultsActivities(filteredResult);
        List<ActivityCategory> resultsCategories = new ArrayList<>();

        List<PersonalActivityStatsDTO> personalActivitiesStats = new ArrayList<>();
        for (Activity activity : resultsActivities) {
            resultsCategories.addAll(activity.getCategories());
            personalActivitiesStats.add(getPersonalActivityStats(personId, activity, filteredResult));
        }

        resultsCategories = resultsCategories.stream().distinct().collect(Collectors.toList());
        List<PersonalCategoryStatsDTO> personalCategoriesStats = new ArrayList<>();

        List<ActivityCategory> rootCategories = this.activityCategoryService.getAllRootCategories(resultsCategories);

        for (ActivityCategory category : rootCategories) {
            personalCategoriesStats.add(getPersonalCategoryStats(category, personalActivitiesStats));
        }

        PersonalStatsDTO personalStatsDTO = new PersonalStatsDTO();
        personalStatsDTO.setActivitiesStats(personalActivitiesStats);
        personalStatsDTO.setCategoriesStats(personalCategoriesStats);

        return personalStatsDTO;
    }


    public PersonalActivityStatsDTO getPersonalActivityStats(Long personId, Activity activity, List<ActivityResult> filteredResults) {

        PersonalActivityStatsDTO personalActivityStatsDTO = new PersonalActivityStatsDTO();

        if (activity != null) {

            List<ActivityResult> activityResults = this.filterActivityResults(activity.getId(), filteredResults);
            List<ActivityResult> personalResults = this.filterPersonResults(personId, activityResults);

            personalActivityStatsDTO.setActivity(activityMapper.toDto(activity));
            personalActivityStatsDTO.setPersonalActivityResults(personalResults.stream().map(activityResultMapper::toDto).collect(Collectors.toList()));


            PersonalActivityResultsStatsDTO primaryPersonalActivityResultsStatsDTOs = this.getPersonalActivityResultStats(activity, activityResults, personalResults, ResultCategory.PRIMARY);
            personalActivityStatsDTO.setPrimaryPersonalActivityStats(primaryPersonalActivityResultsStatsDTOs);

            PersonalActivityResultsStatsDTO secondaryPersonalActivityResultsStatsDTOs = this.getPersonalActivityResultStats(activity, activityResults, personalResults, ResultCategory.SECONDARY);
            personalActivityStatsDTO.setSecondaryPersonalActivityStats(secondaryPersonalActivityResultsStatsDTOs);

            ActivityResultsStatsDTO primaryResultsStatsDTO = this.getActivityResultStats(activityResults, ResultCategory.PRIMARY, activity.getPrimaryResultType());
            personalActivityStatsDTO.setPrimaryResultsStats(primaryResultsStatsDTO);

            ActivityResultsStatsDTO secondaryResultsStatsDTO = this.getActivityResultStats(activityResults, ResultCategory.SECONDARY, activity.getSecondaryResultType());
            personalActivityStatsDTO.setSecondaryResultsStats(secondaryResultsStatsDTO);


            return personalActivityStatsDTO;
        }
        return null;
    }

    private PersonalActivityResultsStatsDTO getPersonalActivityResultStats(
        Activity activity,
        List<ActivityResult> activityResults,
        List<ActivityResult> personalActivityResults,
        ResultCategory resultCategory) {

        PersonalActivityResultsStatsDTO personalActivityResultsStatsDTO = new PersonalActivityResultsStatsDTO();

        List<Float> personalActivityResultsValues;
        Comparator<ActivityResult> resultComparator;

        if (ResultCategory.PRIMARY.equals(resultCategory)) {
            resultComparator = Comparator
                .comparing(ActivityResult::getPrimaryResultValue, Comparator.nullsLast(Float::compareTo));

            sortActivityResults(activityResults, activity.getPrimaryResultType(), resultComparator);

            personalActivityResultsValues = personalActivityResults
                .stream()
                .filter(r -> r.getPrimaryResultValue() != null)
                .map(r -> r.getPrimaryResultValue())
                .collect(Collectors.toList());

            this.sortActivityResultsValues(personalActivityResultsValues, activity.getPrimaryResultType());
        } else {
            resultComparator = Comparator
                .comparing(ActivityResult::getSecondaryResultValue, Comparator.nullsLast(Float::compareTo));

            sortActivityResults(activityResults, activity.getPrimaryResultType(), resultComparator);

            personalActivityResultsValues = personalActivityResults
                .stream()
                .filter(r -> r.getSecondaryResultValue() != null)
                .map(r -> r.getSecondaryResultValue())
                .collect(Collectors.toList());

            this.sortActivityResultsValues(personalActivityResultsValues, activity.getSecondaryResultType());
        }

        if(personalActivityResultsValues == null || personalActivityResultsValues.size() == 0) {
            return null;
        }

        List<Integer> allPlacements = new ArrayList<>();


        for (ActivityResult personalActivityResult : personalActivityResults) {
            allPlacements.add(activityResults.indexOf(personalActivityResult) + 1);
        }

        personalActivityResultsStatsDTO.setBestPlacement(StatsUtil.minInt(allPlacements));
        personalActivityResultsStatsDTO.setAveragePlacement(StatsUtil.averageInt(allPlacements));
        personalActivityResultsStatsDTO.setWorstPlacement(StatsUtil.maxInt(allPlacements));

        personalActivityResultsStatsDTO.setBestPlacementInPercents(this.getPlacementInPercents(personalActivityResultsStatsDTO.getBestPlacement().floatValue(), new Float(activityResults.size())));
        personalActivityResultsStatsDTO.setAveragePlacementInPercents(this.getPlacementInPercents(personalActivityResultsStatsDTO.getAveragePlacement(), new Float(activityResults.size())));
        personalActivityResultsStatsDTO.setWorstPlacementInPercents(this.getPlacementInPercents(personalActivityResultsStatsDTO.getWorstPlacement().floatValue(), new Float(activityResults.size())));

        personalActivityResultsStatsDTO.setBestValue(StatsUtil.min(personalActivityResultsValues));
        personalActivityResultsStatsDTO.setAverageValue(StatsUtil.average(personalActivityResultsValues));
        personalActivityResultsStatsDTO.setWorstValue(StatsUtil.max(personalActivityResultsValues));

        return personalActivityResultsStatsDTO;

    }

    private ActivityResultsStatsDTO getActivityResultStats(List<ActivityResult> filteredResults, ResultCategory resultCategory, ResultType resultType) {


        List<Float> resultsValues;

        if (ResultCategory.PRIMARY.equals(resultCategory)) {
            resultsValues = filteredResults.stream().filter(r -> r.getPrimaryResultValue() != null).map(r -> r.getPrimaryResultValue()).collect(Collectors.toList());
        } else {
            resultsValues = filteredResults.stream().filter(r -> r.getSecondaryResultValue() != null).map(r -> r.getSecondaryResultValue()).collect(Collectors.toList());
        }
        if (resultsValues != null && resultsValues.size() > 0) {
        ActivityResultsStatsDTO resultsStatsDTO = new ActivityResultsStatsDTO();


            resultsStatsDTO.setResultsAverageValue(StatsUtil.average(resultsValues));
            resultsStatsDTO.setResultsMedianValue(StatsUtil.median(resultsValues));
            resultsStatsDTO.setResultsMinValue(StatsUtil.min(resultsValues));
            resultsStatsDTO.setResultsMaxValue(StatsUtil.max(resultsValues));
            resultsStatsDTO.setResultsCount(resultsValues.size());

            return resultsStatsDTO;
        }

        return null;
    }

    public PersonalCategoryStatsDTO getPersonalCategoryStats(ActivityCategory category, List<PersonalActivityStatsDTO> personalActivitiesStats) {
        PersonalCategoryStatsDTO personalCategoryStatsDTO = new PersonalCategoryStatsDTO();

        personalCategoryStatsDTO.setCategory(activityCategoryMapper.toDto(category));
        personalCategoryStatsDTO.setPrimaryCategoryResultsStats(getPersonalCategoryResultStats(category, personalActivitiesStats, ResultCategory.PRIMARY));
        personalCategoryStatsDTO.setSecondaryCategoryResultsStats(getPersonalCategoryResultStats(category, personalActivitiesStats, ResultCategory.SECONDARY));

        List<PersonalCategoryStatsDTO> childCategoryPersonalStats = new ArrayList<>();
        for (ActivityCategory childCategory : category.getChildren()) {
            childCategoryPersonalStats.add(getPersonalCategoryStats(childCategory, personalActivitiesStats));
        }
        personalCategoryStatsDTO.setChildCategoryPersonalStats(childCategoryPersonalStats);
        return personalCategoryStatsDTO;
    }

    public PersonalCategoryResultsStatsDTO getPersonalCategoryResultStats(
        ActivityCategory category,
        List<PersonalActivityStatsDTO> personalActivitiesStats,
        ResultCategory resultCategory) {

        List<ActivityCategory> categoryWithSubcategories = this.activityCategoryService.getAllSubcategories(category);
        List<Long> categoryWithSubcategoriesIds = categoryWithSubcategories
            .stream()
            .map(c -> c.getId())
            .collect(Collectors.toList());

        List<PersonalActivityStatsDTO> personalActivitiesStatsForCategory = personalActivitiesStats
            .stream()
            .filter(pas -> this.activityIsInCategories(this.activityRepository.getOne(pas.getActivity().getId()), categoryWithSubcategoriesIds))
            .collect(Collectors.toList());


        if(personalActivitiesStatsForCategory != null && personalActivitiesStatsForCategory.size() > 0) {

            PersonalCategoryResultsStatsDTO personalCategoryResultsStats = new PersonalCategoryResultsStatsDTO();

            Float averagePlacementTotal = 0F;
            Float averagePlacementInPercentsTotal = 0F;
            int delimiter = 0;

            for (PersonalActivityStatsDTO personalActivityStats : personalActivitiesStatsForCategory) {

                if (ResultCategory.PRIMARY.equals(resultCategory) &&
                    personalActivityStats.getPrimaryPersonalActivityStats() != null &&
                    personalActivityStats.getPrimaryResultsStats() != null &&
                    personalActivityStats.getPrimaryPersonalActivityStats().getAveragePlacementInPercents() != null) {


                    delimiter++;
                    averagePlacementTotal += personalActivityStats.getPrimaryPersonalActivityStats().getAveragePlacement();
                    averagePlacementInPercentsTotal += personalActivityStats.getPrimaryPersonalActivityStats().getAveragePlacementInPercents();

                } else if (ResultCategory.SECONDARY.equals(resultCategory) &&
                    personalActivityStats.getSecondaryPersonalActivityStats() != null &&
                    personalActivityStats.getSecondaryResultsStats() != null &&
                    personalActivityStats.getSecondaryPersonalActivityStats().getAveragePlacement() != null) {

                    delimiter++;
                    averagePlacementTotal += personalActivityStats.getSecondaryPersonalActivityStats().getAveragePlacement();
                    averagePlacementInPercentsTotal += personalActivityStats.getSecondaryPersonalActivityStats().getAveragePlacementInPercents();
                }
            }

            if(delimiter > 0) {
                averagePlacementTotal = averagePlacementTotal / delimiter;
                averagePlacementInPercentsTotal = averagePlacementInPercentsTotal / delimiter;

                personalCategoryResultsStats.setAvaregePlacement(averagePlacementTotal);
                personalCategoryResultsStats.setAveragePlacementInPercents(averagePlacementInPercentsTotal);


                return personalCategoryResultsStats;
            }

            return null;
        }

        return null;
    }


    /* Helper methods */
    private List<ActivityResult> filterActivitiesResults(StatsRequestDTO statsRequest) {
        long calculateStartTime = System.currentTimeMillis();
        log.info("Get filtered results duration: " + (System.currentTimeMillis() - calculateStartTime) + " ms");
        List<ActivityResult> allActivityResults = activityRepository.findAllActivitiesResultsWithRequest(
            statsRequest.getPersonId(),
            statsRequest.getActivityId(),
            statsRequest.getWorkoutId(),
            statsRequest.getEventId(),
            statsRequest.getDateFrom(),
            statsRequest.getDateTo(),
            statsRequest.getUsersBirthdayFrom(),
            statsRequest.getUsersBirthDayTo());
        //List<ActivityResult> filteredResults = new ArrayList<>();
        log.info("Get all activities results: " + (System.currentTimeMillis() - calculateStartTime) + " ms, activities results count: " + allActivityResults.size());

        return allActivityResults;
    }

    private List<ActivityResult> filterPersonResults(Long personId, List<ActivityResult> results) {
        List<ActivityResult> filteredPersonResults = results;

        if (personId != null) {
            filteredPersonResults = filteredPersonResults.stream().filter(r -> r.getWorkoutResult().getEventResult().getPerson().getId().longValue() == personId.longValue()).collect(Collectors.toList());
        }

        return filteredPersonResults;
    }

    private List<ActivityResult> filterActivityResults(Long activityId, List<ActivityResult> results) {
        List<ActivityResult> filteredActivityResults = results;

        if (activityId != null) {
            filteredActivityResults = filteredActivityResults.stream().filter(r -> r.getActivity().getId().longValue() == activityId.longValue()).collect(Collectors.toList());
        }

        return filteredActivityResults;
    }


    private void sortActivityResults(List<ActivityResult> results, ResultType resultType, Comparator<ActivityResult> comparator) {
        if (ResultType.MORE_IS_BETTER.equals(resultType)) {
            Collections.sort(results, comparator.reversed());
        } else if (ResultType.LESS_IS_BETTER.equals(resultType)) {
            Collections.sort(results, comparator);
        } else {
            Collections.sort(results, comparator);
        }
    }

    private void sortActivityResultsValues(List<Float> results, ResultType resultType) {
        if (ResultType.MORE_IS_BETTER.equals(resultType)) {
            Collections.sort(results, Collections.reverseOrder());
        } else if (ResultType.LESS_IS_BETTER.equals(resultType)) {
            Collections.sort(results);
        } else {
            Collections.sort(results);
        }
    }

    private List<Activity> getAllResultsActivities(List<ActivityResult> filteredResults) {
        return filteredResults.stream().map(r -> r.getActivity()).distinct().collect(Collectors.toList());
    }

    private boolean activityIsInCategories(Activity activity, List<Long> categoryIds) {
        if (activity != null && activity.getCategories() != null) {
            return activity.getCategories().stream().map(c -> c.getId()).anyMatch(id -> categoryIds.contains(id));
        }
        return false;
    }

    private boolean activityIsInCategory(Activity activity, Long categoryId) {
        if (activity != null && activity.getCategories() != null) {
            return activity.getCategories().stream().map(c -> c.getId()).anyMatch(id -> categoryId.longValue() == id.longValue());
        }
        return false;
    }

    private Float getPlacementInPercents(Float placement,  Float size) {
        if(size > 1) {
            return new Float((size - placement) * (100F / (size - 1F)));
        } else return 100F;
    }

}
