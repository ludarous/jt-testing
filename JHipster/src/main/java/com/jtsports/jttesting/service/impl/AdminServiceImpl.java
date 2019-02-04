package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.domain.ActivityCategory;
import com.jtsports.jttesting.domain.Person;
import com.jtsports.jttesting.domain.enumeration.ActivityResultUnits;
import com.jtsports.jttesting.domain.enumeration.ResultType;
import com.jtsports.jttesting.repository.ActivityCategoryRepository;
import com.jtsports.jttesting.repository.WorkoutRepository;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.search.ActivityCategorySearchRepository;
import com.jtsports.jttesting.service.ActivityService;
import com.jtsports.jttesting.service.AdminService;
import com.jtsports.jttesting.service.PersonService;
import com.jtsports.jttesting.service.mapper.ActivityCategoryMapper;
import org.apache.commons.io.IOUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.*;
import java.net.URL;
import java.time.ZonedDateTime;
import java.util.HashSet;
import java.util.Optional;
import java.util.Set;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

    private final ActivityCategoryRepository activityCategoryRepository;

    private final ActivityCategoryMapper activityCategoryMapper;

    private final ActivityCategorySearchRepository activityCategorySearchRepository;

    private final ActivityService activityService;

    private final ActivityRepository activityRepository;

    private final WorkoutRepository workoutRepository;

    private final PersonService personService;

    private final static String DEFAULT_ENTITIES_PATH = "default-entities.json";

    public AdminServiceImpl(ActivityCategoryRepository activityCategoryRepository,
                            ActivityCategoryMapper activityCategoryMapper,
                            ActivityCategorySearchRepository activityCategorySearchRepository,
                            ActivityService activityService,
                            ActivityRepository activityRepository,
                            WorkoutRepository workoutRepository, PersonService personService)
    {
        this.activityCategoryRepository = activityCategoryRepository;
        this.activityCategoryMapper = activityCategoryMapper;
        this.activityCategorySearchRepository = activityCategorySearchRepository;
        this.activityService = activityService;
        this.activityRepository = activityRepository;
        this.workoutRepository = workoutRepository;
        this.personService = personService;
    }

    @Override
    public void generateDefaultEntities() throws IOException {
        ClassLoader classloader = Thread.currentThread().getContextClassLoader();
        URL templateUrl = classloader.getResource(DEFAULT_ENTITIES_PATH);

        InputStream fis = templateUrl.openStream();
        StringWriter writer = new StringWriter();
        IOUtils.copy(fis, writer, "UTF-8");
        String json = writer.toString();


        Person currentPerson = this.personService.findCurrentPerson();

        JSONObject jsonObject = new JSONObject(json);
        JSONArray activityCategoriesJson  = jsonObject.getJSONArray("activityCategories");
        for (int i = 0; i < activityCategoriesJson.length(); i++)
        {
            this.parseAndSaveActivityCategory(activityCategoriesJson.getJSONObject(i));
        }

        JSONArray activitiesJson  = jsonObject.getJSONArray("activities");
        for (int i = 0; i < activitiesJson.length(); i++)
        {
            this.parseAndSaveActivity(activitiesJson.getJSONObject(i), currentPerson);
        }
    }

    private ActivityCategory parseAndSaveActivityCategory(JSONObject activityCategoryJson) {
        return parseAndSaveActivityCategory(activityCategoryJson, null);
    }

    private ActivityCategory parseAndSaveActivityCategory(JSONObject activityCategoryJson, ActivityCategory parent) {

        ActivityCategory activityCategory = new ActivityCategory();
        if(parent != null) activityCategory.setParent(parent);

        String key = activityCategoryJson.getString("key");
        if(key != null || key.length() > 0) {
            Optional<ActivityCategory> activityOptional = this.activityCategoryRepository.findOneByKey(key);
            if(activityOptional.isPresent()) {
                activityCategory = activityOptional.get();
            }
        }

        activityCategory.setName(activityCategoryJson.getString("name"));
        activityCategory.setDescription(activityCategoryJson.getString("description"));
        activityCategory.setKey(activityCategoryJson.getString("key"));

        activityCategory = activityCategoryRepository.saveAndFlush(activityCategory);

        if(!activityCategoryJson.isNull("children")) {
            JSONArray activityCategoriesChildrenJson = activityCategoryJson.getJSONArray("children");

            Set<ActivityCategory> activityCategorySet = new HashSet<>();
            for (int i = 0; i < activityCategoriesChildrenJson.length(); i++) {
                JSONObject activityCategoryChildJson = activityCategoriesChildrenJson.getJSONObject(i);
                activityCategorySet.add(this.parseAndSaveActivityCategory(activityCategoryChildJson, activityCategory));
            }
            activityCategory.setChildren(activityCategorySet);
        }

        activityCategory = activityCategoryRepository.saveAndFlush(activityCategory);

        return activityCategory;
    }

    private Activity parseAndSaveActivity(JSONObject activityJson, Person currentPerson) {
        Activity activity = new Activity();
        String key = activityJson.getString("key");
        if(key != null || key.length() > 0) {
            Optional<Activity> activityOptional = this.activityRepository.findOneByKey(key);
            if(activityOptional.isPresent()) {
                activity = activityOptional.get();
            }
        }

        activity.setCreationTime(ZonedDateTime.now());
        activity.setAuthor(currentPerson);

        activity.setName(activityJson.getString("name"));
        activity.setDescription(activityJson.getString("description"));
        activity.setHelp(activityJson.getString("help"));
        activity.setKey(activityJson.getString("key"));

        String primaryResultType = activityJson.getString("primaryResultType");
        if(primaryResultType.length() > 0) activity.setPrimaryResultType(ResultType.valueOf(primaryResultType));

        String secondaryResultType = activityJson.getString("secondaryResultType");
        if(secondaryResultType.length() > 0) activity.setSecondaryResultType(ResultType.valueOf(secondaryResultType));

        String primaryResultValueUnit = activityJson.getString("primaryResultValueUnit");
        if(primaryResultValueUnit.length() > 0) activity.setPrimaryResultValueUnit(ActivityResultUnits.valueOf(primaryResultValueUnit));

        String secondaryResultValueUnit = activityJson.getString("secondaryResultValueUnit");
        if(secondaryResultValueUnit.length() > 0) activity.setSecondaryResultValueUnit(ActivityResultUnits.valueOf(secondaryResultValueUnit));

        activity.setMaxAge(activityJson.getInt("maxAge"));
        activity.setMinAge(activityJson.getInt("minAge"));

        JSONArray activityCategoriesKeys = activityJson.getJSONArray("activityCategoriesKeys");

        Set<ActivityCategory> activityCategories = new HashSet<>();
        for (int i = 0; i < activityCategoriesKeys.length(); i++) {
            String activityCategoriesKey = activityCategoriesKeys.getString(i);
            Optional<ActivityCategory> activityCategoryOptional = activityCategoryRepository.findOneByKey(activityCategoriesKey);
            if(activityCategoryOptional.isPresent()) {
                activityCategories.add(activityCategoryOptional.get());
            }
        }
        activity.setCategories(activityCategories);


        activity = activityRepository.saveAndFlush(activity);
        return activity;
    }
}
