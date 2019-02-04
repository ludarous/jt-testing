package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.Workout;
import com.jtsports.jttesting.repository.WorkoutRepository;
import com.jtsports.jttesting.repository.search.WorkoutSearchRepository;
import com.jtsports.jttesting.service.WorkoutService;
import com.jtsports.jttesting.service.dto.WorkoutDTO;
import com.jtsports.jttesting.service.mapper.WorkoutMapper;
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

/**
 * Test class for the WorkoutResource REST controller.
 *
 * @see WorkoutResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class WorkoutResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final Integer DEFAULT_MIN_AGE = 1;
    private static final Integer UPDATED_MIN_AGE = 2;

    private static final Integer DEFAULT_MAX_AGE = 1;
    private static final Integer UPDATED_MAX_AGE = 2;

    @Autowired
    private WorkoutRepository workoutRepository;
    @Mock
    private WorkoutRepository workoutRepositoryMock;

    @Autowired
    private WorkoutMapper workoutMapper;
    
    @Mock
    private WorkoutService workoutServiceMock;

    @Autowired
    private WorkoutService workoutService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.WorkoutSearchRepositoryMockConfiguration
     */
    @Autowired
    private WorkoutSearchRepository mockWorkoutSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restWorkoutMockMvc;

    private Workout workout;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final WorkoutResource workoutResource = new WorkoutResource(workoutService);
        this.restWorkoutMockMvc = MockMvcBuilders.standaloneSetup(workoutResource)
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
    public static Workout createEntity(EntityManager em) {
        Workout workout = new Workout()
            .name(DEFAULT_NAME)
            .description(DEFAULT_DESCRIPTION)
            .minAge(DEFAULT_MIN_AGE)
            .maxAge(DEFAULT_MAX_AGE);
        return workout;
    }

    @Before
    public void initTest() {
        workout = createEntity(em);
    }

    @Test
    @Transactional
    public void createWorkout() throws Exception {
        int databaseSizeBeforeCreate = workoutRepository.findAll().size();

        // Create the Workout
        WorkoutDTO workoutDTO = workoutMapper.toDto(workout);
        restWorkoutMockMvc.perform(post("/api/workouts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutDTO)))
            .andExpect(status().isCreated());

        // Validate the Workout in the database
        List<Workout> workoutList = workoutRepository.findAll();
        assertThat(workoutList).hasSize(databaseSizeBeforeCreate + 1);
        Workout testWorkout = workoutList.get(workoutList.size() - 1);
        assertThat(testWorkout.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testWorkout.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
        assertThat(testWorkout.getMinAge()).isEqualTo(DEFAULT_MIN_AGE);
        assertThat(testWorkout.getMaxAge()).isEqualTo(DEFAULT_MAX_AGE);

        // Validate the Workout in Elasticsearch
        verify(mockWorkoutSearchRepository, times(1)).save(testWorkout);
    }

    @Test
    @Transactional
    public void createWorkoutWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = workoutRepository.findAll().size();

        // Create the Workout with an existing ID
        workout.setId(1L);
        WorkoutDTO workoutDTO = workoutMapper.toDto(workout);

        // An entity with an existing ID cannot be created, so this API call must fail
        restWorkoutMockMvc.perform(post("/api/workouts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Workout in the database
        List<Workout> workoutList = workoutRepository.findAll();
        assertThat(workoutList).hasSize(databaseSizeBeforeCreate);

        // Validate the Workout in Elasticsearch
        verify(mockWorkoutSearchRepository, times(0)).save(workout);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = workoutRepository.findAll().size();
        // set the field null
        workout.setName(null);

        // Create the Workout, which fails.
        WorkoutDTO workoutDTO = workoutMapper.toDto(workout);

        restWorkoutMockMvc.perform(post("/api/workouts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutDTO)))
            .andExpect(status().isBadRequest());

        List<Workout> workoutList = workoutRepository.findAll();
        assertThat(workoutList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllWorkouts() throws Exception {
        // Initialize the database
        workoutRepository.saveAndFlush(workout);

        // Get all the workoutList
        restWorkoutMockMvc.perform(get("/api/workouts?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(workout.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)));
    }
    
    public void getAllWorkoutsWithEagerRelationshipsIsEnabled() throws Exception {
        WorkoutResource workoutResource = new WorkoutResource(workoutServiceMock);
        when(workoutServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        MockMvc restWorkoutMockMvc = MockMvcBuilders.standaloneSetup(workoutResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restWorkoutMockMvc.perform(get("/api/workouts?eagerload=true"))
        .andExpect(status().isOk());

        verify(workoutServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    public void getAllWorkoutsWithEagerRelationshipsIsNotEnabled() throws Exception {
        WorkoutResource workoutResource = new WorkoutResource(workoutServiceMock);
            when(workoutServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));
            MockMvc restWorkoutMockMvc = MockMvcBuilders.standaloneSetup(workoutResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restWorkoutMockMvc.perform(get("/api/workouts?eagerload=true"))
        .andExpect(status().isOk());

            verify(workoutServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    @Test
    @Transactional
    public void getWorkout() throws Exception {
        // Initialize the database
        workoutRepository.saveAndFlush(workout);

        // Get the workout
        restWorkoutMockMvc.perform(get("/api/workouts/{id}", workout.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(workout.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()))
            .andExpect(jsonPath("$.minAge").value(DEFAULT_MIN_AGE))
            .andExpect(jsonPath("$.maxAge").value(DEFAULT_MAX_AGE));
    }
    @Test
    @Transactional
    public void getNonExistingWorkout() throws Exception {
        // Get the workout
        restWorkoutMockMvc.perform(get("/api/workouts/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateWorkout() throws Exception {
        // Initialize the database
        workoutRepository.saveAndFlush(workout);

        int databaseSizeBeforeUpdate = workoutRepository.findAll().size();

        // Update the workout
        Workout updatedWorkout = workoutRepository.findById(workout.getId()).get();
        // Disconnect from session so that the updates on updatedWorkout are not directly saved in db
        em.detach(updatedWorkout);
        updatedWorkout
            .name(UPDATED_NAME)
            .description(UPDATED_DESCRIPTION)
            .minAge(UPDATED_MIN_AGE)
            .maxAge(UPDATED_MAX_AGE);
        WorkoutDTO workoutDTO = workoutMapper.toDto(updatedWorkout);

        restWorkoutMockMvc.perform(put("/api/workouts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutDTO)))
            .andExpect(status().isOk());

        // Validate the Workout in the database
        List<Workout> workoutList = workoutRepository.findAll();
        assertThat(workoutList).hasSize(databaseSizeBeforeUpdate);
        Workout testWorkout = workoutList.get(workoutList.size() - 1);
        assertThat(testWorkout.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testWorkout.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
        assertThat(testWorkout.getMinAge()).isEqualTo(UPDATED_MIN_AGE);
        assertThat(testWorkout.getMaxAge()).isEqualTo(UPDATED_MAX_AGE);

        // Validate the Workout in Elasticsearch
        verify(mockWorkoutSearchRepository, times(1)).save(testWorkout);
    }

    @Test
    @Transactional
    public void updateNonExistingWorkout() throws Exception {
        int databaseSizeBeforeUpdate = workoutRepository.findAll().size();

        // Create the Workout
        WorkoutDTO workoutDTO = workoutMapper.toDto(workout);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restWorkoutMockMvc.perform(put("/api/workouts")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Workout in the database
        List<Workout> workoutList = workoutRepository.findAll();
        assertThat(workoutList).hasSize(databaseSizeBeforeUpdate);

        // Validate the Workout in Elasticsearch
        verify(mockWorkoutSearchRepository, times(0)).save(workout);
    }

    @Test
    @Transactional
    public void deleteWorkout() throws Exception {
        // Initialize the database
        workoutRepository.saveAndFlush(workout);

        int databaseSizeBeforeDelete = workoutRepository.findAll().size();

        // Get the workout
        restWorkoutMockMvc.perform(delete("/api/workouts/{id}", workout.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<Workout> workoutList = workoutRepository.findAll();
        assertThat(workoutList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the Workout in Elasticsearch
        verify(mockWorkoutSearchRepository, times(1)).deleteById(workout.getId());
    }

    @Test
    @Transactional
    public void searchWorkout() throws Exception {
        // Initialize the database
        workoutRepository.saveAndFlush(workout);
        when(mockWorkoutSearchRepository.search(queryStringQuery("id:" + workout.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(workout), PageRequest.of(0, 1), 1));
        // Search the workout
        restWorkoutMockMvc.perform(get("/api/_search/workouts?query=id:" + workout.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(workout.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Workout.class);
        Workout workout1 = new Workout();
        workout1.setId(1L);
        Workout workout2 = new Workout();
        workout2.setId(workout1.getId());
        assertThat(workout1).isEqualTo(workout2);
        workout2.setId(2L);
        assertThat(workout1).isNotEqualTo(workout2);
        workout1.setId(null);
        assertThat(workout1).isNotEqualTo(workout2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(WorkoutDTO.class);
        WorkoutDTO workoutDTO1 = new WorkoutDTO();
        workoutDTO1.setId(1L);
        WorkoutDTO workoutDTO2 = new WorkoutDTO();
        assertThat(workoutDTO1).isNotEqualTo(workoutDTO2);
        workoutDTO2.setId(workoutDTO1.getId());
        assertThat(workoutDTO1).isEqualTo(workoutDTO2);
        workoutDTO2.setId(2L);
        assertThat(workoutDTO1).isNotEqualTo(workoutDTO2);
        workoutDTO1.setId(null);
        assertThat(workoutDTO1).isNotEqualTo(workoutDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(workoutMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(workoutMapper.fromId(null)).isNull();
    }
}
