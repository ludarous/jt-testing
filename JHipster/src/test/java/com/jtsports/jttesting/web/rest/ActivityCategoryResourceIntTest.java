package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.ActivityCategory;
import com.jtsports.jttesting.repository.ActivityCategoryRepository;
import com.jtsports.jttesting.repository.search.ActivityCategorySearchRepository;
import com.jtsports.jttesting.service.ActivityCategoryService;
import com.jtsports.jttesting.service.dto.ActivityCategoryDTO;
import com.jtsports.jttesting.service.mapper.ActivityCategoryMapper;
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
 * Test class for the ActivityCategoryResource REST controller.
 *
 * @see ActivityCategoryResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class ActivityCategoryResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_KEY = "AAAAAAAAAA";
    private static final String UPDATED_KEY = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    @Autowired
    private ActivityCategoryRepository activityCategoryRepository;


    @Autowired
    private ActivityCategoryMapper activityCategoryMapper;
    

    @Autowired
    private ActivityCategoryService activityCategoryService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.ActivityCategorySearchRepositoryMockConfiguration
     */
    @Autowired
    private ActivityCategorySearchRepository mockActivityCategorySearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restActivityCategoryMockMvc;

    private ActivityCategory activityCategory;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final ActivityCategoryResource activityCategoryResource = new ActivityCategoryResource(activityCategoryService);
        this.restActivityCategoryMockMvc = MockMvcBuilders.standaloneSetup(activityCategoryResource)
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
    public static ActivityCategory createEntity(EntityManager em) {
        ActivityCategory activityCategory = new ActivityCategory()
            .name(DEFAULT_NAME)
            .key(DEFAULT_KEY)
            .description(DEFAULT_DESCRIPTION);
        return activityCategory;
    }

    @Before
    public void initTest() {
        activityCategory = createEntity(em);
    }

    @Test
    @Transactional
    public void createActivityCategory() throws Exception {
        int databaseSizeBeforeCreate = activityCategoryRepository.findAll().size();

        // Create the ActivityCategory
        ActivityCategoryDTO activityCategoryDTO = activityCategoryMapper.toDto(activityCategory);
        restActivityCategoryMockMvc.perform(post("/api/activity-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityCategoryDTO)))
            .andExpect(status().isCreated());

        // Validate the ActivityCategory in the database
        List<ActivityCategory> activityCategoryList = activityCategoryRepository.findAll();
        assertThat(activityCategoryList).hasSize(databaseSizeBeforeCreate + 1);
        ActivityCategory testActivityCategory = activityCategoryList.get(activityCategoryList.size() - 1);
        assertThat(testActivityCategory.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testActivityCategory.getKey()).isEqualTo(DEFAULT_KEY);
        assertThat(testActivityCategory.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);

        // Validate the ActivityCategory in Elasticsearch
        verify(mockActivityCategorySearchRepository, times(1)).save(testActivityCategory);
    }

    @Test
    @Transactional
    public void createActivityCategoryWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = activityCategoryRepository.findAll().size();

        // Create the ActivityCategory with an existing ID
        activityCategory.setId(1L);
        ActivityCategoryDTO activityCategoryDTO = activityCategoryMapper.toDto(activityCategory);

        // An entity with an existing ID cannot be created, so this API call must fail
        restActivityCategoryMockMvc.perform(post("/api/activity-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityCategory in the database
        List<ActivityCategory> activityCategoryList = activityCategoryRepository.findAll();
        assertThat(activityCategoryList).hasSize(databaseSizeBeforeCreate);

        // Validate the ActivityCategory in Elasticsearch
        verify(mockActivityCategorySearchRepository, times(0)).save(activityCategory);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = activityCategoryRepository.findAll().size();
        // set the field null
        activityCategory.setName(null);

        // Create the ActivityCategory, which fails.
        ActivityCategoryDTO activityCategoryDTO = activityCategoryMapper.toDto(activityCategory);

        restActivityCategoryMockMvc.perform(post("/api/activity-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityCategoryDTO)))
            .andExpect(status().isBadRequest());

        List<ActivityCategory> activityCategoryList = activityCategoryRepository.findAll();
        assertThat(activityCategoryList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllActivityCategories() throws Exception {
        // Initialize the database
        activityCategoryRepository.saveAndFlush(activityCategory);

        // Get all the activityCategoryList
        restActivityCategoryMockMvc.perform(get("/api/activity-categories?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }
    

    @Test
    @Transactional
    public void getActivityCategory() throws Exception {
        // Initialize the database
        activityCategoryRepository.saveAndFlush(activityCategory);

        // Get the activityCategory
        restActivityCategoryMockMvc.perform(get("/api/activity-categories/{id}", activityCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(activityCategory.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.key").value(DEFAULT_KEY.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingActivityCategory() throws Exception {
        // Get the activityCategory
        restActivityCategoryMockMvc.perform(get("/api/activity-categories/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateActivityCategory() throws Exception {
        // Initialize the database
        activityCategoryRepository.saveAndFlush(activityCategory);

        int databaseSizeBeforeUpdate = activityCategoryRepository.findAll().size();

        // Update the activityCategory
        ActivityCategory updatedActivityCategory = activityCategoryRepository.findById(activityCategory.getId()).get();
        // Disconnect from session so that the updates on updatedActivityCategory are not directly saved in db
        em.detach(updatedActivityCategory);
        updatedActivityCategory
            .name(UPDATED_NAME)
            .key(UPDATED_KEY)
            .description(UPDATED_DESCRIPTION);
        ActivityCategoryDTO activityCategoryDTO = activityCategoryMapper.toDto(updatedActivityCategory);

        restActivityCategoryMockMvc.perform(put("/api/activity-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityCategoryDTO)))
            .andExpect(status().isOk());

        // Validate the ActivityCategory in the database
        List<ActivityCategory> activityCategoryList = activityCategoryRepository.findAll();
        assertThat(activityCategoryList).hasSize(databaseSizeBeforeUpdate);
        ActivityCategory testActivityCategory = activityCategoryList.get(activityCategoryList.size() - 1);
        assertThat(testActivityCategory.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testActivityCategory.getKey()).isEqualTo(UPDATED_KEY);
        assertThat(testActivityCategory.getDescription()).isEqualTo(UPDATED_DESCRIPTION);

        // Validate the ActivityCategory in Elasticsearch
        verify(mockActivityCategorySearchRepository, times(1)).save(testActivityCategory);
    }

    @Test
    @Transactional
    public void updateNonExistingActivityCategory() throws Exception {
        int databaseSizeBeforeUpdate = activityCategoryRepository.findAll().size();

        // Create the ActivityCategory
        ActivityCategoryDTO activityCategoryDTO = activityCategoryMapper.toDto(activityCategory);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restActivityCategoryMockMvc.perform(put("/api/activity-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityCategory in the database
        List<ActivityCategory> activityCategoryList = activityCategoryRepository.findAll();
        assertThat(activityCategoryList).hasSize(databaseSizeBeforeUpdate);

        // Validate the ActivityCategory in Elasticsearch
        verify(mockActivityCategorySearchRepository, times(0)).save(activityCategory);
    }

    @Test
    @Transactional
    public void deleteActivityCategory() throws Exception {
        // Initialize the database
        activityCategoryRepository.saveAndFlush(activityCategory);

        int databaseSizeBeforeDelete = activityCategoryRepository.findAll().size();

        // Get the activityCategory
        restActivityCategoryMockMvc.perform(delete("/api/activity-categories/{id}", activityCategory.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<ActivityCategory> activityCategoryList = activityCategoryRepository.findAll();
        assertThat(activityCategoryList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the ActivityCategory in Elasticsearch
        verify(mockActivityCategorySearchRepository, times(1)).deleteById(activityCategory.getId());
    }

    @Test
    @Transactional
    public void searchActivityCategory() throws Exception {
        // Initialize the database
        activityCategoryRepository.saveAndFlush(activityCategory);
        when(mockActivityCategorySearchRepository.search(queryStringQuery("id:" + activityCategory.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(activityCategory), PageRequest.of(0, 1), 1));
        // Search the activityCategory
        restActivityCategoryMockMvc.perform(get("/api/_search/activity-categories?query=id:" + activityCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityCategory.class);
        ActivityCategory activityCategory1 = new ActivityCategory();
        activityCategory1.setId(1L);
        ActivityCategory activityCategory2 = new ActivityCategory();
        activityCategory2.setId(activityCategory1.getId());
        assertThat(activityCategory1).isEqualTo(activityCategory2);
        activityCategory2.setId(2L);
        assertThat(activityCategory1).isNotEqualTo(activityCategory2);
        activityCategory1.setId(null);
        assertThat(activityCategory1).isNotEqualTo(activityCategory2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityCategoryDTO.class);
        ActivityCategoryDTO activityCategoryDTO1 = new ActivityCategoryDTO();
        activityCategoryDTO1.setId(1L);
        ActivityCategoryDTO activityCategoryDTO2 = new ActivityCategoryDTO();
        assertThat(activityCategoryDTO1).isNotEqualTo(activityCategoryDTO2);
        activityCategoryDTO2.setId(activityCategoryDTO1.getId());
        assertThat(activityCategoryDTO1).isEqualTo(activityCategoryDTO2);
        activityCategoryDTO2.setId(2L);
        assertThat(activityCategoryDTO1).isNotEqualTo(activityCategoryDTO2);
        activityCategoryDTO1.setId(null);
        assertThat(activityCategoryDTO1).isNotEqualTo(activityCategoryDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(activityCategoryMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(activityCategoryMapper.fromId(null)).isNull();
    }
}
