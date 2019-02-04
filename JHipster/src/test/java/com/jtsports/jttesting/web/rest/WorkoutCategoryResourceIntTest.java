package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.WorkoutCategory;
import com.jtsports.jttesting.repository.WorkoutCategoryRepository;
import com.jtsports.jttesting.repository.search.WorkoutCategorySearchRepository;
import com.jtsports.jttesting.service.WorkoutCategoryService;
import com.jtsports.jttesting.service.dto.WorkoutCategoryDTO;
import com.jtsports.jttesting.service.mapper.WorkoutCategoryMapper;
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
 * Test class for the WorkoutCategoryResource REST controller.
 *
 * @see WorkoutCategoryResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class WorkoutCategoryResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_KEY = "AAAAAAAAAA";
    private static final String UPDATED_KEY = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    @Autowired
    private WorkoutCategoryRepository workoutCategoryRepository;


    @Autowired
    private WorkoutCategoryMapper workoutCategoryMapper;
    

    @Autowired
    private WorkoutCategoryService workoutCategoryService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.WorkoutCategorySearchRepositoryMockConfiguration
     */
    @Autowired
    private WorkoutCategorySearchRepository mockWorkoutCategorySearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restWorkoutCategoryMockMvc;

    private WorkoutCategory workoutCategory;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final WorkoutCategoryResource workoutCategoryResource = new WorkoutCategoryResource(workoutCategoryService);
        this.restWorkoutCategoryMockMvc = MockMvcBuilders.standaloneSetup(workoutCategoryResource)
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
    public static WorkoutCategory createEntity(EntityManager em) {
        WorkoutCategory workoutCategory = new WorkoutCategory()
            .name(DEFAULT_NAME)
            .key(DEFAULT_KEY)
            .description(DEFAULT_DESCRIPTION);
        return workoutCategory;
    }

    @Before
    public void initTest() {
        workoutCategory = createEntity(em);
    }

    @Test
    @Transactional
    public void createWorkoutCategory() throws Exception {
        int databaseSizeBeforeCreate = workoutCategoryRepository.findAll().size();

        // Create the WorkoutCategory
        WorkoutCategoryDTO workoutCategoryDTO = workoutCategoryMapper.toDto(workoutCategory);
        restWorkoutCategoryMockMvc.perform(post("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutCategoryDTO)))
            .andExpect(status().isCreated());

        // Validate the WorkoutCategory in the database
        List<WorkoutCategory> workoutCategoryList = workoutCategoryRepository.findAll();
        assertThat(workoutCategoryList).hasSize(databaseSizeBeforeCreate + 1);
        WorkoutCategory testWorkoutCategory = workoutCategoryList.get(workoutCategoryList.size() - 1);
        assertThat(testWorkoutCategory.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testWorkoutCategory.getKey()).isEqualTo(DEFAULT_KEY);
        assertThat(testWorkoutCategory.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);

        // Validate the WorkoutCategory in Elasticsearch
        verify(mockWorkoutCategorySearchRepository, times(1)).save(testWorkoutCategory);
    }

    @Test
    @Transactional
    public void createWorkoutCategoryWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = workoutCategoryRepository.findAll().size();

        // Create the WorkoutCategory with an existing ID
        workoutCategory.setId(1L);
        WorkoutCategoryDTO workoutCategoryDTO = workoutCategoryMapper.toDto(workoutCategory);

        // An entity with an existing ID cannot be created, so this API call must fail
        restWorkoutCategoryMockMvc.perform(post("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the WorkoutCategory in the database
        List<WorkoutCategory> workoutCategoryList = workoutCategoryRepository.findAll();
        assertThat(workoutCategoryList).hasSize(databaseSizeBeforeCreate);

        // Validate the WorkoutCategory in Elasticsearch
        verify(mockWorkoutCategorySearchRepository, times(0)).save(workoutCategory);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = workoutCategoryRepository.findAll().size();
        // set the field null
        workoutCategory.setName(null);

        // Create the WorkoutCategory, which fails.
        WorkoutCategoryDTO workoutCategoryDTO = workoutCategoryMapper.toDto(workoutCategory);

        restWorkoutCategoryMockMvc.perform(post("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutCategoryDTO)))
            .andExpect(status().isBadRequest());

        List<WorkoutCategory> workoutCategoryList = workoutCategoryRepository.findAll();
        assertThat(workoutCategoryList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllWorkoutCategories() throws Exception {
        // Initialize the database
        workoutCategoryRepository.saveAndFlush(workoutCategory);

        // Get all the workoutCategoryList
        restWorkoutCategoryMockMvc.perform(get("/api/activity-group-categories?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(workoutCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }
    

    @Test
    @Transactional
    public void getWorkoutCategory() throws Exception {
        // Initialize the database
        workoutCategoryRepository.saveAndFlush(workoutCategory);

        // Get the workoutCategory
        restWorkoutCategoryMockMvc.perform(get("/api/activity-group-categories/{id}", workoutCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(workoutCategory.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.key").value(DEFAULT_KEY.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingWorkoutCategory() throws Exception {
        // Get the workoutCategory
        restWorkoutCategoryMockMvc.perform(get("/api/activity-group-categories/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateWorkoutCategory() throws Exception {
        // Initialize the database
        workoutCategoryRepository.saveAndFlush(workoutCategory);

        int databaseSizeBeforeUpdate = workoutCategoryRepository.findAll().size();

        // Update the workoutCategory
        WorkoutCategory updatedWorkoutCategory = workoutCategoryRepository.findById(workoutCategory.getId()).get();
        // Disconnect from session so that the updates on updatedWorkoutCategory are not directly saved in db
        em.detach(updatedWorkoutCategory);
        updatedWorkoutCategory
            .name(UPDATED_NAME)
            .key(UPDATED_KEY)
            .description(UPDATED_DESCRIPTION);
        WorkoutCategoryDTO workoutCategoryDTO = workoutCategoryMapper.toDto(updatedWorkoutCategory);

        restWorkoutCategoryMockMvc.perform(put("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutCategoryDTO)))
            .andExpect(status().isOk());

        // Validate the WorkoutCategory in the database
        List<WorkoutCategory> workoutCategoryList = workoutCategoryRepository.findAll();
        assertThat(workoutCategoryList).hasSize(databaseSizeBeforeUpdate);
        WorkoutCategory testWorkoutCategory = workoutCategoryList.get(workoutCategoryList.size() - 1);
        assertThat(testWorkoutCategory.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testWorkoutCategory.getKey()).isEqualTo(UPDATED_KEY);
        assertThat(testWorkoutCategory.getDescription()).isEqualTo(UPDATED_DESCRIPTION);

        // Validate the WorkoutCategory in Elasticsearch
        verify(mockWorkoutCategorySearchRepository, times(1)).save(testWorkoutCategory);
    }

    @Test
    @Transactional
    public void updateNonExistingWorkoutCategory() throws Exception {
        int databaseSizeBeforeUpdate = workoutCategoryRepository.findAll().size();

        // Create the WorkoutCategory
        WorkoutCategoryDTO workoutCategoryDTO = workoutCategoryMapper.toDto(workoutCategory);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restWorkoutCategoryMockMvc.perform(put("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(workoutCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the WorkoutCategory in the database
        List<WorkoutCategory> workoutCategoryList = workoutCategoryRepository.findAll();
        assertThat(workoutCategoryList).hasSize(databaseSizeBeforeUpdate);

        // Validate the WorkoutCategory in Elasticsearch
        verify(mockWorkoutCategorySearchRepository, times(0)).save(workoutCategory);
    }

    @Test
    @Transactional
    public void deleteWorkoutCategory() throws Exception {
        // Initialize the database
        workoutCategoryRepository.saveAndFlush(workoutCategory);

        int databaseSizeBeforeDelete = workoutCategoryRepository.findAll().size();

        // Get the workoutCategory
        restWorkoutCategoryMockMvc.perform(delete("/api/activity-group-categories/{id}", workoutCategory.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<WorkoutCategory> workoutCategoryList = workoutCategoryRepository.findAll();
        assertThat(workoutCategoryList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the WorkoutCategory in Elasticsearch
        verify(mockWorkoutCategorySearchRepository, times(1)).deleteById(workoutCategory.getId());
    }

    @Test
    @Transactional
    public void searchWorkoutCategory() throws Exception {
        // Initialize the database
        workoutCategoryRepository.saveAndFlush(workoutCategory);
        when(mockWorkoutCategorySearchRepository.search(queryStringQuery("id:" + workoutCategory.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(workoutCategory), PageRequest.of(0, 1), 1));
        // Search the workoutCategory
        restWorkoutCategoryMockMvc.perform(get("/api/_search/activity-group-categories?query=id:" + workoutCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(workoutCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(WorkoutCategory.class);
        WorkoutCategory workoutCategory1 = new WorkoutCategory();
        workoutCategory1.setId(1L);
        WorkoutCategory workoutCategory2 = new WorkoutCategory();
        workoutCategory2.setId(workoutCategory1.getId());
        assertThat(workoutCategory1).isEqualTo(workoutCategory2);
        workoutCategory2.setId(2L);
        assertThat(workoutCategory1).isNotEqualTo(workoutCategory2);
        workoutCategory1.setId(null);
        assertThat(workoutCategory1).isNotEqualTo(workoutCategory2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(WorkoutCategoryDTO.class);
        WorkoutCategoryDTO workoutCategoryDTO1 = new WorkoutCategoryDTO();
        workoutCategoryDTO1.setId(1L);
        WorkoutCategoryDTO workoutCategoryDTO2 = new WorkoutCategoryDTO();
        assertThat(workoutCategoryDTO1).isNotEqualTo(workoutCategoryDTO2);
        workoutCategoryDTO2.setId(workoutCategoryDTO1.getId());
        assertThat(workoutCategoryDTO1).isEqualTo(workoutCategoryDTO2);
        workoutCategoryDTO2.setId(2L);
        assertThat(workoutCategoryDTO1).isNotEqualTo(workoutCategoryDTO2);
        workoutCategoryDTO1.setId(null);
        assertThat(workoutCategoryDTO1).isNotEqualTo(workoutCategoryDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(workoutCategoryMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(workoutCategoryMapper.fromId(null)).isNull();
    }
}
