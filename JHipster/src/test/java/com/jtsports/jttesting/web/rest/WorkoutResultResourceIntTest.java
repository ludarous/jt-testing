package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.WorkoutResult;
import com.jtsports.jttesting.domain.Workout;
import com.jtsports.jttesting.repository.WorkoutResultRepository;
import com.jtsports.jttesting.repository.search.WorkoutResultSearchRepository;
import com.jtsports.jttesting.service.WorkoutResultService;
import com.jtsports.jttesting.service.dto.WorkoutResultDTO;
import com.jtsports.jttesting.service.mapper.WorkoutResultMapper;
import com.jtsports.jttesting.web.rest.errors.ExceptionTranslator;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
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
 * Test class for the WorkoutResultResource REST controller.
 *
 * @see WorkoutResultResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class WorkoutResultResourceIntTest {

    private static final String DEFAULT_NOTE = "AAAAAAAAAA";
    private static final String UPDATED_NOTE = "BBBBBBBBBB";

    @Autowired
    private WorkoutResultRepository workoutResultRepository;


    @Autowired
    private WorkoutResultMapper workoutResultMapper;
    

    @Autowired
    private WorkoutResultService workoutResultService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.WorkoutResultSearchRepositoryMockConfiguration
     */
    @Autowired
    private WorkoutResultSearchRepository mockWorkoutResultSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restWorkoutResultMockMvc;

    private WorkoutResult workoutResult;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final WorkoutResultResource workoutResultResource = new WorkoutResultResource(workoutResultService);
        this.restWorkoutResultMockMvc = MockMvcBuilders.standaloneSetup(workoutResultResource)
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
    public static WorkoutResult createEntity(EntityManager em) {
        WorkoutResult workoutResult = new WorkoutResult()
            .note(DEFAULT_NOTE);
        // Add required entity
        Workout workout = WorkoutResourceIntTest.createEntity(em);
        em.persist(workout);
        em.flush();
        workoutResult.setWorkout(workout);
        return workoutResult;
    }

    @Before
    public void initTest() {
        workoutResult = createEntity(em);
    }

    @Test
    @Transactional
    public void createWorkoutResult() throws Exception {
        int databaseSizeBeforeCreate = workoutResultRepository.findAll().size();

        // Create the WorkoutResult
        WorkoutResultDTO workoutResultDTO = workoutResultMapper.toDto(workoutResult);
        restWorkoutResultMockMvc.perform(post("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutResultDTO)))
            .andExpect(status().isCreated());

        // Validate the WorkoutResult in the database
        List<WorkoutResult> workoutResultList = workoutResultRepository.findAll();
        assertThat(workoutResultList).hasSize(databaseSizeBeforeCreate + 1);
        WorkoutResult testWorkoutResult = workoutResultList.get(workoutResultList.size() - 1);
        assertThat(testWorkoutResult.getNote()).isEqualTo(DEFAULT_NOTE);

        // Validate the WorkoutResult in Elasticsearch
        verify(mockWorkoutResultSearchRepository, times(1)).save(testWorkoutResult);
    }

    @Test
    @Transactional
    public void createWorkoutResultWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = workoutResultRepository.findAll().size();

        // Create the WorkoutResult with an existing ID
        workoutResult.setId(1L);
        WorkoutResultDTO workoutResultDTO = workoutResultMapper.toDto(workoutResult);

        // An entity with an existing ID cannot be created, so this API call must fail
        restWorkoutResultMockMvc.perform(post("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the WorkoutResult in the database
        List<WorkoutResult> workoutResultList = workoutResultRepository.findAll();
        assertThat(workoutResultList).hasSize(databaseSizeBeforeCreate);

        // Validate the WorkoutResult in Elasticsearch
        verify(mockWorkoutResultSearchRepository, times(0)).save(workoutResult);
    }

    @Test
    @Transactional
    public void getAllWorkoutResults() throws Exception {
        // Initialize the database
        workoutResultRepository.saveAndFlush(workoutResult);

        // Get all the workoutResultList
        restWorkoutResultMockMvc.perform(get("/api/activity-group-results?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(workoutResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())));
    }
    

    @Test
    @Transactional
    public void getWorkoutResult() throws Exception {
        // Initialize the database
        workoutResultRepository.saveAndFlush(workoutResult);

        // Get the workoutResult
        restWorkoutResultMockMvc.perform(get("/api/activity-group-results/{id}", workoutResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(workoutResult.getId().intValue()))
            .andExpect(jsonPath("$.note").value(DEFAULT_NOTE.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingWorkoutResult() throws Exception {
        // Get the workoutResult
        restWorkoutResultMockMvc.perform(get("/api/activity-group-results/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateWorkoutResult() throws Exception {
        // Initialize the database
        workoutResultRepository.saveAndFlush(workoutResult);

        int databaseSizeBeforeUpdate = workoutResultRepository.findAll().size();

        // Update the workoutResult
        WorkoutResult updatedWorkoutResult = workoutResultRepository.findById(workoutResult.getId()).get();
        // Disconnect from session so that the updates on updatedWorkoutResult are not directly saved in db
        em.detach(updatedWorkoutResult);
        updatedWorkoutResult
            .note(UPDATED_NOTE);
        WorkoutResultDTO workoutResultDTO = workoutResultMapper.toDto(updatedWorkoutResult);

        restWorkoutResultMockMvc.perform(put("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutResultDTO)))
            .andExpect(status().isOk());

        // Validate the WorkoutResult in the database
        List<WorkoutResult> workoutResultList = workoutResultRepository.findAll();
        assertThat(workoutResultList).hasSize(databaseSizeBeforeUpdate);
        WorkoutResult testWorkoutResult = workoutResultList.get(workoutResultList.size() - 1);
        assertThat(testWorkoutResult.getNote()).isEqualTo(UPDATED_NOTE);

        // Validate the WorkoutResult in Elasticsearch
        verify(mockWorkoutResultSearchRepository, times(1)).save(testWorkoutResult);
    }

    @Test
    @Transactional
    public void updateNonExistingWorkoutResult() throws Exception {
        int databaseSizeBeforeUpdate = workoutResultRepository.findAll().size();

        // Create the WorkoutResult
        WorkoutResultDTO workoutResultDTO = workoutResultMapper.toDto(workoutResult);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restWorkoutResultMockMvc.perform(put("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the WorkoutResult in the database
        List<WorkoutResult> workoutResultList = workoutResultRepository.findAll();
        assertThat(workoutResultList).hasSize(databaseSizeBeforeUpdate);

        // Validate the WorkoutResult in Elasticsearch
        verify(mockWorkoutResultSearchRepository, times(0)).save(workoutResult);
    }

    @Test
    @Transactional
    public void deleteWorkoutResult() throws Exception {
        // Initialize the database
        workoutResultRepository.saveAndFlush(workoutResult);

        int databaseSizeBeforeDelete = workoutResultRepository.findAll().size();

        // Get the workoutResult
        restWorkoutResultMockMvc.perform(delete("/api/activity-group-results/{id}", workoutResult.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<WorkoutResult> workoutResultList = workoutResultRepository.findAll();
        assertThat(workoutResultList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the WorkoutResult in Elasticsearch
        verify(mockWorkoutResultSearchRepository, times(1)).deleteById(workoutResult.getId());
    }

    @Test
    @Transactional
    public void searchWorkoutResult() throws Exception {
        // Initialize the database
        workoutResultRepository.saveAndFlush(workoutResult);
        when(mockWorkoutResultSearchRepository.search(queryStringQuery("id:" + workoutResult.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(workoutResult), PageRequest.of(0, 1), 1));
        // Search the workoutResult
        restWorkoutResultMockMvc.perform(get("/api/_search/activity-group-results?query=id:" + workoutResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(workoutResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(WorkoutResult.class);
        WorkoutResult workoutResult1 = new WorkoutResult();
        workoutResult1.setId(1L);
        WorkoutResult workoutResult2 = new WorkoutResult();
        workoutResult2.setId(workoutResult1.getId());
        assertThat(workoutResult1).isEqualTo(workoutResult2);
        workoutResult2.setId(2L);
        assertThat(workoutResult1).isNotEqualTo(workoutResult2);
        workoutResult1.setId(null);
        assertThat(workoutResult1).isNotEqualTo(workoutResult2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(WorkoutResultDTO.class);
        WorkoutResultDTO workoutResultDTO1 = new WorkoutResultDTO();
        workoutResultDTO1.setId(1L);
        WorkoutResultDTO workoutResultDTO2 = new WorkoutResultDTO();
        assertThat(workoutResultDTO1).isNotEqualTo(workoutResultDTO2);
        workoutResultDTO2.setId(workoutResultDTO1.getId());
        assertThat(workoutResultDTO1).isEqualTo(workoutResultDTO2);
        workoutResultDTO2.setId(2L);
        assertThat(workoutResultDTO1).isNotEqualTo(workoutResultDTO2);
        workoutResultDTO1.setId(null);
        assertThat(workoutResultDTO1).isNotEqualTo(workoutResultDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(workoutResultMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(workoutResultMapper.fromId(null)).isNull();
    }
}
