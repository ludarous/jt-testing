package com.jtsports.jttesting.service;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.domain.ActivityCategory;
import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.service.dto.Activity.ActivityStatsDTO;
import com.jtsports.jttesting.service.dto.Activity.PersonalActivityStatsDTO;
import com.jtsports.jttesting.service.dto.Category.PersonalCategoryResultsStatsDTO;
import com.jtsports.jttesting.service.dto.Category.PersonalCategoryStatsDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import com.jtsports.jttesting.service.dto.Test.PersonalTestsStatsDTO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public interface StatsService {

    ActivityStatsDTO findStats(Long activityId, StatsRequestDTO statsRequest);

    PersonalActivityStatsDTO getPersonalActivityStats(Long personId, Activity activity, List<ActivityResult> activityResults);

    List<PersonalActivityStatsDTO> getPersonalActivitiesStats(Long personId, List<ActivityResult> activityResults);

    PersonalCategoryStatsDTO getPersonalCategoryStats(Long personId, Long parentCategoryId, List<ActivityResult> filteredActivityResults);

    PersonalCategoryResultsStatsDTO getPersonalCategoryResultStats(Long personId, ActivityCategory category, List<ActivityResult> filteredResults);

    PersonalTestsStatsDTO getPersonalTestStats(Long personId, Long parentCategoryId, List<ActivityResult> activityResults);

    List<ActivityResult> getFilterActivitiesResults(StatsRequestDTO statsRequest);


}
