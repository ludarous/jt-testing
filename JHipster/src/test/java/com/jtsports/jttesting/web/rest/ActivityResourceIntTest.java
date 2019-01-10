package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.repository.ActivityRepository;
import com.jtsports.jttesting.repository.search.ActivitySearchRepository;
import com.jtsports.jttesting.service.ActivityService;
import com.jtsports.jttesting.service.PersonService;
import com.jtsports.jttesting.service.StatsService;
import com.jtsports.jttesting.service.UserService;
import com.jtsports.jttesting.service.dto.ActivityDTO;
import com.jtsports.jttesting.service.mapper.ActivityMapper;
import com.jtsports.jttesting.web.rest.errors.ExceptionTranslator;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.web.PageableHandlerMethodArgumentResolver;
import org.springframework.http.MediaType;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


import static com.jtsports.jttesting.web.rest.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.elasticsearch.index.query.QueryBuilders.queryStringQuery;
import static org.hamcrest.Matchers.hasItem;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import com.jtsports.jttesting.domain.enumeration.ActivityResultUnits;
import com.jtsports.jttesting.domain.enumeration.ActivityResultUnits;
import com.jtsports.jttesting.domain.enumeration.ResultType;
import com.jtsports.jttesting.domain.enumeration.ResultType;
/**
 * Test class for the ActivityResource REST controller.
 *
 * @see ActivityResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class ActivityResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final String DEFAULT_HELP = "AAAAAAAAAA";
    private static final String UPDATED_HELP = "BBBBBBBBBB";

    private static final String DEFAULT_KEY = "AAAAAAAAAA";
    private static final String UPDATED_KEY = "BBBBBBBBBB";

    private static final ActivityResultUnits DEFAULT_PRIMARY_RESULT_VALUE_UNIT = ActivityResultUnits.SECONDS;
    private static final ActivityResultUnits UPDATED_PRIMARY_RESULT_VALUE_UNIT = ActivityResultUnits.MINUTES;

    private static final ActivityResultUnits DEFAULT_SECONDARY_RESULT_VALUE_UNIT = ActivityResultUnits.SECONDS;
    private static final ActivityResultUnits UPDATED_SECONDARY_RESULT_VALUE_UNIT = ActivityResultUnits.MINUTES;

    private static final Integer DEFAULT_MIN_AGE = 1;
    private static final Integer UPDATED_MIN_AGE = 2;

    private static final Integer DEFAULT_MAX_AGE = 1;
    private static final Integer UPDATED_MAX_AGE = 2;

    private static final ResultType DEFAULT_PRIMARY_RESULT_TYPE = ResultType.LESS_IS_BETTER;
    private static final ResultType UPDATED_PRIMARY_RESULT_TYPE = ResultType.MORE_IS_BETTER;

    private static final ResultType DEFAULT_SECONDARY_RESULT_TYPE = ResultType.LESS_IS_BETTER;
    private static final ResultType UPDATED_SECONDARY_RESULT_TYPE = ResultType.MORE_IS_BETTER;

    @Autowired
    private ActivityRepository activityRepository;
    @Mock
    private ActivityRepository activityRepositoryMock;

    @Autowired
    private ActivityMapper activityMapper;
    
    @Mock
    private ActivityService activityServiceMock;

    @Autowired
    private ActivityService activityService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.ActivitySearchRepositoryMockConfiguration
     */
    @Autowired
    private ActivitySearchRepository mockActivitySearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private UserService userService;

    @Autowired
    private PersonService personService;

    @Autowired
    private StatsService statsService;

    @Autowired
    private EntityManager em;

    private MockMvc restActivityMockMvc;

    private Activity activity;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final ActivityResource activityResource = new ActivityResource(activityService, activityRepository, userService, personService, statsService);
        this.restActivityMockMvc = MockMvcBuilders.standaloneSetup(activityResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();
    }

    /**
     * Create an entity for this test.
     *
     * This is a static method, as tests for other entities might also need it,
     * if they test an entity which requires the current entity.
     */
    public static Activity createEntity(EntityManager em) {
        Activity activity = new Activity()
            .name(DEFAULT_NAME)
            .description(DEFAULT_DESCRIPTION)
            .help(DEFAULT_HELP)
            .key(DEFAULT_KEY)
            .primaryResultValueUnit(DEFAULT_PRIMARY_RESULT_VALUE_UNIT)
            .secondaryResultValueUnit(DEFAULT_SECONDARY_RESULT_VALUE_UNIT)
            .minAge(DEFAULT_MIN_AGE)
            .maxAge(DEFAULT_MAX_AGE)
            .primaryResultType(DEFAULT_PRIMARY_RESULT_TYPE)
            .secondaryResultType(DEFAULT_SECONDARY_RESULT_TYPE);
        return activity;
    }

    @Before
    public void initTest() {
        activity = createEntity(em);
    }

    @Test
    @Transactional
    public void createActivity() throws Exception {
        int databaseSizeBeforeCreate = activityRepository.findAll().size();

        // Create the Activity
        ActivityDTO activityDTO = activityMapper.toDto(activity);
        restActivityMockMvc.perform(post("/api/activities")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityDTO)))
            .andExpect(status().isCreated());

        // Validate the Activity in the database
        List<Activity> activityList = activityRepository.findAll();
        assertThat(activityList).hasSize(databaseSizeBeforeCreate + 1);
        Activity testActivity = activityList.get(activityList.size() - 1);
        assertThat(testActivity.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testActivity.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
        assertThat(testActivity.getHelp()).isEqualTo(DEFAULT_HELP);
        assertThat(testActivity.getKey()).isEqualTo(DEFAULT_KEY);
        assertThat(testActivity.getPrimaryResultValueUnit()).isEqualTo(DEFAULT_PRIMARY_RESULT_VALUE_UNIT);
        assertThat(testActivity.getSecondaryResultValueUnit()).isEqualTo(DEFAULT_SECONDARY_RESULT_VALUE_UNIT);
        assertThat(testActivity.getMinAge()).isEqualTo(DEFAULT_MIN_AGE);
        assertThat(testActivity.getMaxAge()).isEqualTo(DEFAULT_MAX_AGE);
        assertThat(testActivity.getPrimaryResultType()).isEqualTo(DEFAULT_PRIMARY_RESULT_TYPE);
        assertThat(testActivity.getSecondaryResultType()).isEqualTo(DEFAULT_SECONDARY_RESULT_TYPE);

        // Validate the Activity in Elasticsearch
        verify(mockActivitySearchRepository, times(1)).save(testActivity);
    }

    @Test
    @Transactional
    public void createActivityWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = activityRepository.findAll().size();

        // Create the Activity with an existing ID
        activity.setId(1L);
        ActivityDTO activityDTO = activityMapper.toDto(activity);

        // An entity with an existing ID cannot be created, so this API call must fail
        restActivityMockMvc.perform(post("/api/activities")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Activity in the database
        List<Activity> activityList = activityRepository.findAll();
        assertThat(activityList).hasSize(databaseSizeBeforeCreate);

        // Validate the Activity in Elasticsearch
        verify(mockActivitySearchRepository, times(0)).save(activity);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = activityRepository.findAll().size();
        // set the field null
        activity.setName(null);

        // Create the Activity, which fails.
        ActivityDTO activityDTO = activityMapper.toDto(activity);

        restActivityMockMvc.perform(post("/api/activities")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityDTO)))
            .andExpect(status().isBadRequest());

        List<Activity> activityList = activityRepository.findAll();
        assertThat(activityList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void checkPrimaryResultValueUnitIsRequired() throws Exception {
        int databaseSizeBeforeTest = activityRepository.findAll().size();
        // set the field null
        activity.setPrimaryResultValueUnit(null);

        // Create the Activity, which fails.
        ActivityDTO activityDTO = activityMapper.toDto(activity);

        restActivityMockMvc.perform(post("/api/activities")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityDTO)))
            .andExpect(status().isBadRequest());

        List<Activity> activityList = activityRepository.findAll();
        assertThat(activityList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllActivities() throws Exception {
        // Initialize the database
        activityRepository.saveAndFlush(activity);

        // Get all the activityList
        restActivityMockMvc.perform(get("/api/activities?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activity.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].help").value(hasItem(DEFAULT_HELP.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].primaryResultValueUnit").value(hasItem(DEFAULT_PRIMARY_RESULT_VALUE_UNIT.toString())))
            .andExpect(jsonPath("$.[*].secondaryResultValueUnit").value(hasItem(DEFAULT_SECONDARY_RESULT_VALUE_UNIT.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)))
            .andExpect(jsonPath("$.[*].primaryResultType").value(hasItem(DEFAULT_PRIMARY_RESULT_TYPE.toString())))
            .andExpect(jsonPath("$.[*].secondaryResultType").value(hasItem(DEFAULT_SECONDARY_RESULT_TYPE.toString())));
    }
    
    public void getAllActivitiesWithEagerRelationshipsIsEnabled() throws Exception {
        ActivityResource activityResource = new ActivityResource(activityServiceMock, activityRepository, userService, personService, statsService);
        when(activityServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        MockMvc restActivityMockMvc = MockMvcBuilders.standaloneSetup(activityResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restActivityMockMvc.perform(get("/api/activities?eagerload=true"))
        .andExpect(status().isOk());

        verify(activityServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    public void getAllActivitiesWithEagerRelationshipsIsNotEnabled() throws Exception {
        ActivityResource activityResource = new ActivityResource(activityServiceMock, activityRepository, userService, personService, statsService);
            when(activityServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));
            MockMvc restActivityMockMvc = MockMvcBuilders.standaloneSetup(activityResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restActivityMockMvc.perform(get("/api/activities?eagerload=true"))
        .andExpect(status().isOk());

            verify(activityServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    @Test
    @Transactional
    public void getActivity() throws Exception {
        // Initialize the database
        activityRepository.saveAndFlush(activity);

        // Get the activity
        restActivityMockMvc.perform(get("/api/activities/{id}", activity.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(activity.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()))
            .andExpect(jsonPath("$.help").value(DEFAULT_HELP.toString()))
            .andExpect(jsonPath("$.key").value(DEFAULT_KEY.toString()))
            .andExpect(jsonPath("$.primaryResultValueUnit").value(DEFAULT_PRIMARY_RESULT_VALUE_UNIT.toString()))
            .andExpect(jsonPath("$.secondaryResultValueUnit").value(DEFAULT_SECONDARY_RESULT_VALUE_UNIT.toString()))
            .andExpect(jsonPath("$.minAge").value(DEFAULT_MIN_AGE))
            .andExpect(jsonPath("$.maxAge").value(DEFAULT_MAX_AGE))
            .andExpect(jsonPath("$.primaryResultType").value(DEFAULT_PRIMARY_RESULT_TYPE.toString()))
            .andExpect(jsonPath("$.secondaryResultType").value(DEFAULT_SECONDARY_RESULT_TYPE.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingActivity() throws Exception {
        // Get the activity
        restActivityMockMvc.perform(get("/api/activities/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateActivity() throws Exception {
        // Initialize the database
        activityRepository.saveAndFlush(activity);

        int databaseSizeBeforeUpdate = activityRepository.findAll().size();

        // Update the activity
        Activity updatedActivity = activityRepository.findById(activity.getId()).get();
        // Disconnect from session so that the updates on updatedActivity are not directly saved in db
        em.detach(updatedActivity);
        updatedActivity
            .name(UPDATED_NAME)
            .description(UPDATED_DESCRIPTION)
            .help(UPDATED_HELP)
            .key(UPDATED_KEY)
            .primaryResultValueUnit(UPDATED_PRIMARY_RESULT_VALUE_UNIT)
            .secondaryResultValueUnit(UPDATED_SECONDARY_RESULT_VALUE_UNIT)
            .minAge(UPDATED_MIN_AGE)
            .maxAge(UPDATED_MAX_AGE)
            .primaryResultType(UPDATED_PRIMARY_RESULT_TYPE)
            .secondaryResultType(UPDATED_SECONDARY_RESULT_TYPE);
        ActivityDTO activityDTO = activityMapper.toDto(updatedActivity);

        restActivityMockMvc.perform(put("/api/activities")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityDTO)))
            .andExpect(status().isOk());

        // Validate the Activity in the database
        List<Activity> activityList = activityRepository.findAll();
        assertThat(activityList).hasSize(databaseSizeBeforeUpdate);
        Activity testActivity = activityList.get(activityList.size() - 1);
        assertThat(testActivity.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testActivity.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
        assertThat(testActivity.getHelp()).isEqualTo(UPDATED_HELP);
        assertThat(testActivity.getKey()).isEqualTo(UPDATED_KEY);
        assertThat(testActivity.getPrimaryResultValueUnit()).isEqualTo(UPDATED_PRIMARY_RESULT_VALUE_UNIT);
        assertThat(testActivity.getSecondaryResultValueUnit()).isEqualTo(UPDATED_SECONDARY_RESULT_VALUE_UNIT);
        assertThat(testActivity.getMinAge()).isEqualTo(UPDATED_MIN_AGE);
        assertThat(testActivity.getMaxAge()).isEqualTo(UPDATED_MAX_AGE);
        assertThat(testActivity.getPrimaryResultType()).isEqualTo(UPDATED_PRIMARY_RESULT_TYPE);
        assertThat(testActivity.getSecondaryResultType()).isEqualTo(UPDATED_SECONDARY_RESULT_TYPE);

        // Validate the Activity in Elasticsearch
        verify(mockActivitySearchRepository, times(1)).save(testActivity);
    }

    @Test
    @Transactional
    public void updateNonExistingActivity() throws Exception {
        int databaseSizeBeforeUpdate = activityRepository.findAll().size();

        // Create the Activity
        ActivityDTO activityDTO = activityMapper.toDto(activity);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restActivityMockMvc.perform(put("/api/activities")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Activity in the database
        List<Activity> activityList = activityRepository.findAll();
        assertThat(activityList).hasSize(databaseSizeBeforeUpdate);

        // Validate the Activity in Elasticsearch
        verify(mockActivitySearchRepository, times(0)).save(activity);
    }

    @Test
    @Transactional
    public void deleteActivity() throws Exception {
        // Initialize the database
        activityRepository.saveAndFlush(activity);

        int databaseSizeBeforeDelete = activityRepository.findAll().size();

        // Get the activity
        restActivityMockMvc.perform(delete("/api/activities/{id}", activity.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<Activity> activityList = activityRepository.findAll();
        assertThat(activityList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the Activity in Elasticsearch
        verify(mockActivitySearchRepository, times(1)).deleteById(activity.getId());
    }

    @Test
    @Transactional
    public void searchActivity() throws Exception {
        // Initialize the database
        activityRepository.saveAndFlush(activity);
        when(mockActivitySearchRepository.search(queryStringQuery("id:" + activity.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(activity), PageRequest.of(0, 1), 1));
        // Search the activity
        restActivityMockMvc.perform(get("/api/_search/activities?query=id:" + activity.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activity.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].help").value(hasItem(DEFAULT_HELP.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].primaryResultValueUnit").value(hasItem(DEFAULT_PRIMARY_RESULT_VALUE_UNIT.toString())))
            .andExpect(jsonPath("$.[*].secondaryResultValueUnit").value(hasItem(DEFAULT_SECONDARY_RESULT_VALUE_UNIT.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)))
            .andExpect(jsonPath("$.[*].primaryResultType").value(hasItem(DEFAULT_PRIMARY_RESULT_TYPE.toString())))
            .andExpect(jsonPath("$.[*].secondaryResultType").value(hasItem(DEFAULT_SECONDARY_RESULT_TYPE.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Activity.class);
        Activity activity1 = new Activity();
        activity1.setId(1L);
        Activity activity2 = new Activity();
        activity2.setId(activity1.getId());
        assertThat(activity1).isEqualTo(activity2);
        activity2.setId(2L);
        assertThat(activity1).isNotEqualTo(activity2);
        activity1.setId(null);
        assertThat(activity1).isNotEqualTo(activity2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityDTO.class);
        ActivityDTO activityDTO1 = new ActivityDTO();
        activityDTO1.setId(1L);
        ActivityDTO activityDTO2 = new ActivityDTO();
        assertThat(activityDTO1).isNotEqualTo(activityDTO2);
        activityDTO2.setId(activityDTO1.getId());
        assertThat(activityDTO1).isEqualTo(activityDTO2);
        activityDTO2.setId(2L);
        assertThat(activityDTO1).isNotEqualTo(activityDTO2);
        activityDTO1.setId(null);
        assertThat(activityDTO1).isNotEqualTo(activityDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(activityMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(activityMapper.fromId(null)).isNull();
    }
}
