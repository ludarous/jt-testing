package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.domain.ActivityCategory;
import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.domain.JTTest;
import com.jtsports.jttesting.domain.enumeration.ResultType;
import com.jtsports.jttesting.repository.ActivityCategoryRepository;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.ActivityResultRepository;
import com.jtsports.jttesting.repository.JTTestRepository;
import com.jtsports.jttesting.service.*;
import com.jtsports.jttesting.service.dto.Activity.ActivityResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Activity.ActivityStatsDTO;
import com.jtsports.jttesting.service.dto.Activity.PersonalActivityResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Activity.PersonalActivityStatsDTO;
import com.jtsports.jttesting.service.dto.ActivityResultDTO;
import com.jtsports.jttesting.service.dto.Category.PersonalCategoryResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Category.PersonalCategoryStatsDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import com.jtsports.jttesting.service.dto.Test.PersonalTestsStatsDTO;
import com.jtsports.jttesting.service.mapper.ActivityCategoryMapper;
import com.jtsports.jttesting.service.mapper.ActivityMapper;
import com.jtsports.jttesting.service.mapper.ActivityResultMapper;
import com.jtsports.jttesting.service.mapper.JTTestMapper;
import com.jtsports.jttesting.service.util.StatsUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

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


    private final JTTestService testService;

    private final JTTestRepository testRepository;

    private final JTTestMapper testMapper;

    public StatsServiceImpl(
        ActivityService activityService,
        ActivityRepository activityRepository,
        ActivityCategoryService activityCategoryService,
        ActivityCategoryRepository activityCategoryRepository,
        ActivityCategoryMapper activityCategoryMapper,
        ActivityMapper activityMapper,
        ActivityResultService activityResultService,
        ActivityResultRepository activityResultRepository,
        ActivityResultMapper activityResultMapper, JTTestService testService, JTTestRepository testRepository, JTTestMapper testMapper)
    {
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
    public ActivityStatsDTO findStats(Long activityId, StatsRequestDTO statsRequest) {
        Optional<Activity> activity = activityRepository.findOneWithEagerRelationships(activityId);
        ActivityStatsDTO activityStatsDTO = new ActivityStatsDTO();

        if(activity.isPresent()) {
            statsRequest.setActivityId(activityId); //TODO: refactor to stats request
            List<ActivityResult> filteredResults = this.getFilterActivitiesResults(statsRequest);

            activityStatsDTO.setActivity(activityMapper.toDto(activity.get()));
            ActivityResultsStatsDTO resultsStatsDTO = this.getActivityResultStats(filteredResults);
            activityStatsDTO.setActivityResultsStats(resultsStatsDTO);

            return activityStatsDTO;
        }
        return null;
    }

    @Override
    public PersonalActivityStatsDTO getPersonalActivityStats(Long personId, Activity activity, List<ActivityResult> activityResults) {

        PersonalActivityStatsDTO personalActivityStatsDTO = new PersonalActivityStatsDTO();

        if(activity != null) {

            List<ActivityResult> personalResults = activityResults
                .stream()
                .filter(ar -> ar.getPerson().getId().longValue() == personId.longValue())
                .collect(Collectors.toList());

            personalActivityStatsDTO.setActivity(activityMapper.toDto(activity));

            this.setStats(personalActivityStatsDTO, personId, activityResults, activity);
            personalActivityStatsDTO.setPersonalActivityResults(personalResults.stream().map(activityResultMapper::toDto).collect(Collectors.toList()));


            return personalActivityStatsDTO;
        }
        return null;
    }

    @Override
    public List<PersonalActivityStatsDTO> getPersonalActivitiesStats(Long personId, List<ActivityResult> filteredActivityResults) {
        long calculateStartTime = System.currentTimeMillis();

        List<PersonalActivityStatsDTO> personalActivityStatsDTOList = new ArrayList<>();
        log.info("Get filtered results duration: " + (System.currentTimeMillis() - calculateStartTime) + " ms, activities results count: " + filteredActivityResults.size());
        List<Activity> activities = filteredActivityResults.stream().map(r -> r.getActivity()).distinct().collect(Collectors.toList());
        for(Activity activity : activities) {

            PersonalActivityStatsDTO personalActivityStatsDTO = new PersonalActivityStatsDTO();
            personalActivityStatsDTO.setActivity(activityMapper.toDto(activity));

            List<ActivityResult> activityFilteredResults = filteredActivityResults.stream()
                .filter(ar -> ar.getActivity().getId().longValue() == activity.getId().longValue())
                .collect(Collectors.toList());

            List<ActivityResult> personalResults = activityFilteredResults
                .stream()
                .filter(ar -> ar.getTestResult().getEventResult().getPerson().getId().longValue() == personId.longValue())
                .collect(Collectors.toList());

            this.setStats(personalActivityStatsDTO, personId, activityFilteredResults, activity);

            personalActivityStatsDTOList.add(personalActivityStatsDTO);
            personalActivityStatsDTO.setPersonalActivityResults(personalResults.stream().map(activityResultMapper::toDto).collect(Collectors.toList()));

        }
        log.info("Get all activities stats: " + (System.currentTimeMillis() - calculateStartTime) + " ms, activities count: " + activities.size());
        return personalActivityStatsDTOList;

    }

    @Override
    public PersonalCategoryStatsDTO getPersonalCategoryStats(Long personId, Long parentCategoryId, List<ActivityResult> filteredActivityResults) {
        PersonalCategoryStatsDTO personalCategoryStatsDTO = new PersonalCategoryStatsDTO();

        if(parentCategoryId != null) {
            personalCategoryStatsDTO.setParentCategory(this.activityCategoryMapper.toDto(this.activityCategoryRepository.getOne(parentCategoryId)));
        }

        List<ActivityCategory> categories = this.activityCategoryRepository.findAllByParentId(parentCategoryId);

        List<PersonalCategoryResultsStatsDTO> personalCategoryResultsStatsDTOList = new ArrayList<>();
        for(ActivityCategory category : categories) {
            PersonalCategoryResultsStatsDTO personalCategoryResultsStatsDTO = this.getPersonalCategoryResultStats(personId, category, filteredActivityResults);
            if(personalCategoryResultsStatsDTO != null) {
                personalCategoryResultsStatsDTOList.add(personalCategoryResultsStatsDTO);
            }
        }
        personalCategoryStatsDTO.setPersonalCategoriesResultsStats(personalCategoryResultsStatsDTOList);

        return  personalCategoryStatsDTO;
    }

    @Override
    public PersonalTestsStatsDTO getPersonalTestStats(Long personId, Long parentCategoryId, List<ActivityResult> allActivitiesResults) {
        long calculateStartTime = System.currentTimeMillis();

        PersonalTestsStatsDTO personalTestsStats = new PersonalTestsStatsDTO();
        personalTestsStats.setPersonalCategoryStats(this.getPersonalCategoryStats(personId, parentCategoryId, allActivitiesResults));

        List<PersonalActivityStatsDTO> personalActivitiesStats = new ArrayList<>();
        List<Activity> activities = allActivitiesResults
            .stream()
            .map(r -> r.getActivity()).distinct()
            .collect(Collectors.toList());

        for (Activity activity : activities) {
            List<ActivityResult> activityActivityResults = allActivitiesResults
                .stream()
                .filter(cr -> cr.getActivity().getId().longValue() == activity.getId().longValue())
                .collect(Collectors.toList());

            personalActivitiesStats.add(this.getPersonalActivityStats(personId, activity, activityActivityResults));
        }
        personalTestsStats.setPersonalActivitiesStats(personalActivitiesStats);

        return personalTestsStats;
    }

    @Override
    public PersonalCategoryResultsStatsDTO getPersonalCategoryResultStats(Long personId, ActivityCategory category, List<ActivityResult> filteredResults) {

        List<Long> allSubcategories = this.activityCategoryService.getAllSubcategories(category)
            .stream()
            .map(ac -> ac.getId())
            .collect(Collectors.toList());

        List<ActivityResult> categoryResults = filteredResults
            .stream()
            .filter(ar -> this.activityIsInCategories(ar.getActivity(), allSubcategories))
            .collect(Collectors.toList());

        List<Activity> activities = categoryResults
            .stream()
            .map(ar -> ar.getActivity())
            .distinct()
            .collect(Collectors.toList());

        if(activities.size() > 0) {
            PersonalCategoryResultsStatsDTO personalCategoryResultsStatsDTO = new PersonalCategoryResultsStatsDTO();
            List<PersonalActivityStatsDTO> personalActivityStatsDTOList = new ArrayList<>();
            for (Activity activity : activities) {
                List<ActivityResult> activityActivityResults = categoryResults
                    .stream()
                    .filter(cr -> cr.getActivity().getId().longValue() == activity.getId().longValue())
                    .collect(Collectors.toList());

                PersonalActivityStatsDTO personalActivityStatsDTO = this.getPersonalActivityStats(personId, activity, activityActivityResults);
                personalActivityStatsDTOList.add(personalActivityStatsDTO);
            }


            Float primaryPlacementInPercents = 0F;
            Float secondaryPlacementInPercents = 0F;

            int primaryDelimiter = 0;
            int secondaryDelimiter = 0;

            for (PersonalActivityStatsDTO personalActivityStats : personalActivityStatsDTOList) {
                if (personalActivityStats.returnAveragePrimaryPlacementInPercents() != null) {
                    primaryDelimiter++;
                    primaryPlacementInPercents += personalActivityStats.returnAveragePrimaryPlacementInPercents();
                }

                if (personalActivityStats.returnAverageSecondaryPlacementInPercents() != null) {
                    secondaryDelimiter++;
                    secondaryPlacementInPercents += personalActivityStats.returnAverageSecondaryPlacementInPercents();
                }
            }

            primaryPlacementInPercents = primaryPlacementInPercents / primaryDelimiter;
            secondaryPlacementInPercents = secondaryPlacementInPercents / secondaryDelimiter;

            personalCategoryResultsStatsDTO.setPrimaryPlacement(primaryPlacementInPercents);
            personalCategoryResultsStatsDTO.setSecondaryPlacement(secondaryPlacementInPercents);
            personalCategoryResultsStatsDTO.setCategory(this.activityCategoryMapper.toDto(category));
            return personalCategoryResultsStatsDTO;
        }
        return null;
    }

    @Override
    public List<ActivityResult> getFilterActivitiesResults(StatsRequestDTO statsRequest) {
        long calculateStartTime = System.currentTimeMillis();
        log.info("Get filtered results duration: " + (System.currentTimeMillis() - calculateStartTime) + " ms");
        List<ActivityResult> allActivityResults = activityRepository.findAllActivitiesResultsWithRequest(
            statsRequest.getPersonId(),
            statsRequest.getActivityId(),
            statsRequest.getTestId(),
            statsRequest.getEventId(),
            statsRequest.getDateFrom(),
            statsRequest.getDateTo(),
            statsRequest.getUsersBirthdayFrom(),
            statsRequest.getUsersBirthDayTo());
        //List<ActivityResult> filteredResults = new ArrayList<>();
        log.info("Get all activities results: " + (System.currentTimeMillis() - calculateStartTime) + " ms, activities results count: " + allActivityResults.size());

        return allActivityResults;
    }

    private List<PersonalActivityResultsStatsDTO> getPersonalActivityResultStats(Long personId, List<ActivityResult> filteredResults, Activity activity) {

        List<PersonalActivityResultsStatsDTO> personalActivityResultsStatsDTOList = new ArrayList<>();

        List<Float> primaryResults = filteredResults.stream().filter(r -> r.getPrimaryResultValue() != null).map(r -> r.getPrimaryResultValue()).collect(Collectors.toList());
        List<Float> secondaryResults = filteredResults.stream().filter(r -> r.getSecondaryResultValue() != null).map(r -> r.getSecondaryResultValue()).collect(Collectors.toList());

        Comparator<ActivityResult> resultPrimaryComparator = Comparator.comparing(ActivityResult::getPrimaryResultValue, Comparator.nullsLast(Float::compareTo));
        Comparator<ActivityResult> resultSecondaryComparator = Comparator.comparing(ActivityResult::getSecondaryResultValue, Comparator.nullsLast(Float::compareTo));

        List<ActivityResult> personalResults = this.filterPersonResults(filteredResults, personId);

        for (ActivityResult personalActivityResult : personalResults) {

            PersonalActivityResultsStatsDTO personalActivityResultsStatsDTO = new PersonalActivityResultsStatsDTO();
            personalActivityResultsStatsDTO.setTotalPrimaryResults(primaryResults.size());
            personalActivityResultsStatsDTO.setTotalSecondaryResults(secondaryResults.size());

            this.sortActivityResults(filteredResults, activity.getPrimaryResultType(), resultPrimaryComparator);

            int primaryPlacement = filteredResults.indexOf(personalActivityResult);
            personalActivityResultsStatsDTO.setPrimaryPlacement(primaryPlacement);

            if (personalActivityResult.getSecondaryResultValue() != null) {

                this.sortActivityResults(filteredResults, activity.getSecondaryResultType(), resultSecondaryComparator);

                int secondaryPlacement = filteredResults.indexOf(personalActivityResult);
                personalActivityResultsStatsDTO.setSecondaryPlacement(secondaryPlacement);
            }

            personalActivityResultsStatsDTOList.add(personalActivityResultsStatsDTO);
        }


        return personalActivityResultsStatsDTOList;

    }

    private List<ActivityResult> filterPersonResults(List<ActivityResult> results, Long personId) {
        List<ActivityResult> filteredResults = results;


        if(personId != null) {
            filteredResults = filteredResults.stream().filter(r -> r.getTestResult().getEventResult().getPerson().getId().longValue() == personId.longValue()).collect(Collectors.toList());
        }

        return filteredResults;
    }

    private ActivityResultsStatsDTO getActivityResultStats(List<ActivityResult> filteredResults) {

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

    private void sortActivityResults(List<ActivityResult> results, ResultType resultType, Comparator<ActivityResult> comparator) {
        if(ResultType.MORE_IS_BETTER.equals(resultType)) {
            Collections.sort(results, comparator.reversed());
        } else if (ResultType.LESS_IS_BETTER.equals(resultType)) {
            Collections.sort(results, comparator);
        } else {
            Collections.sort(results, comparator);
        }
    }

    private void setStats(PersonalActivityStatsDTO personalActivityStatsDTO, Long personId, List<ActivityResult> results, Activity activity ) {

        ActivityResultsStatsDTO resultsStatsDTO = this.getActivityResultStats(results);
        personalActivityStatsDTO.setActivityResultsStats(resultsStatsDTO);

        List<PersonalActivityResultsStatsDTO> personalActivityResultsStatsDTOs = this.getPersonalActivityResultStats(personId, results, activity);
        personalActivityStatsDTO.setPersonalActivityResultsStats(personalActivityResultsStatsDTOs);
    }

    private boolean activityIsInCategories(Activity activity, List<Long> categoryIds) {
        if(activity != null && activity.getCategories() != null) {
            return activity.getCategories().stream().map(c -> c.getId()).anyMatch(id -> categoryIds.contains(id));
        }
        return false;
    }
}
