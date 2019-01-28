package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.ActivityGroupCategory;
import com.jtsports.jttesting.repository.ActivityGroupCategoryRepository;
import com.jtsports.jttesting.repository.search.ActivityGroupCategorySearchRepository;
import com.jtsports.jttesting.service.ActivityGroupCategoryService;
import com.jtsports.jttesting.service.dto.ActivityGroupCategoryDTO;
import com.jtsports.jttesting.service.mapper.ActivityGroupCategoryMapper;
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
 * Test class for the ActivityGroupCategoryResource REST controller.
 *
 * @see ActivityGroupCategoryResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class ActivityGroupCategoryResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_KEY = "AAAAAAAAAA";
    private static final String UPDATED_KEY = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    @Autowired
    private ActivityGroupCategoryRepository activityGroupCategoryRepository;


    @Autowired
    private ActivityGroupCategoryMapper activityGroupCategoryMapper;
    

    @Autowired
    private ActivityGroupCategoryService activityGroupCategoryService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.ActivityGroupCategorySearchRepositoryMockConfiguration
     */
    @Autowired
    private ActivityGroupCategorySearchRepository mockActivityGroupCategorySearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restActivityGroupCategoryMockMvc;

    private ActivityGroupCategory activityGroupCategory;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final ActivityGroupCategoryResource activityGroupCategoryResource = new ActivityGroupCategoryResource(activityGroupCategoryService);
        this.restActivityGroupCategoryMockMvc = MockMvcBuilders.standaloneSetup(activityGroupCategoryResource)
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
    public static ActivityGroupCategory createEntity(EntityManager em) {
        ActivityGroupCategory activityGroupCategory = new ActivityGroupCategory()
            .name(DEFAULT_NAME)
            .key(DEFAULT_KEY)
            .description(DEFAULT_DESCRIPTION);
        return activityGroupCategory;
    }

    @Before
    public void initTest() {
        activityGroupCategory = createEntity(em);
    }

    @Test
    @Transactional
    public void createActivityGroupCategory() throws Exception {
        int databaseSizeBeforeCreate = activityGroupCategoryRepository.findAll().size();

        // Create the ActivityGroupCategory
        ActivityGroupCategoryDTO activityGroupCategoryDTO = activityGroupCategoryMapper.toDto(activityGroupCategory);
        restActivityGroupCategoryMockMvc.perform(post("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupCategoryDTO)))
            .andExpect(status().isCreated());

        // Validate the ActivityGroupCategory in the database
        List<ActivityGroupCategory> activityGroupCategoryList = activityGroupCategoryRepository.findAll();
        assertThat(activityGroupCategoryList).hasSize(databaseSizeBeforeCreate + 1);
        ActivityGroupCategory testActivityGroupCategory = activityGroupCategoryList.get(activityGroupCategoryList.size() - 1);
        assertThat(testActivityGroupCategory.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testActivityGroupCategory.getKey()).isEqualTo(DEFAULT_KEY);
        assertThat(testActivityGroupCategory.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);

        // Validate the ActivityGroupCategory in Elasticsearch
        verify(mockActivityGroupCategorySearchRepository, times(1)).save(testActivityGroupCategory);
    }

    @Test
    @Transactional
    public void createActivityGroupCategoryWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = activityGroupCategoryRepository.findAll().size();

        // Create the ActivityGroupCategory with an existing ID
        activityGroupCategory.setId(1L);
        ActivityGroupCategoryDTO activityGroupCategoryDTO = activityGroupCategoryMapper.toDto(activityGroupCategory);

        // An entity with an existing ID cannot be created, so this API call must fail
        restActivityGroupCategoryMockMvc.perform(post("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityGroupCategory in the database
        List<ActivityGroupCategory> activityGroupCategoryList = activityGroupCategoryRepository.findAll();
        assertThat(activityGroupCategoryList).hasSize(databaseSizeBeforeCreate);

        // Validate the ActivityGroupCategory in Elasticsearch
        verify(mockActivityGroupCategorySearchRepository, times(0)).save(activityGroupCategory);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = activityGroupCategoryRepository.findAll().size();
        // set the field null
        activityGroupCategory.setName(null);

        // Create the ActivityGroupCategory, which fails.
        ActivityGroupCategoryDTO activityGroupCategoryDTO = activityGroupCategoryMapper.toDto(activityGroupCategory);

        restActivityGroupCategoryMockMvc.perform(post("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupCategoryDTO)))
            .andExpect(status().isBadRequest());

        List<ActivityGroupCategory> activityGroupCategoryList = activityGroupCategoryRepository.findAll();
        assertThat(activityGroupCategoryList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllActivityGroupCategories() throws Exception {
        // Initialize the database
        activityGroupCategoryRepository.saveAndFlush(activityGroupCategory);

        // Get all the activityGroupCategoryList
        restActivityGroupCategoryMockMvc.perform(get("/api/activity-group-categories?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityGroupCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }
    

    @Test
    @Transactional
    public void getActivityGroupCategory() throws Exception {
        // Initialize the database
        activityGroupCategoryRepository.saveAndFlush(activityGroupCategory);

        // Get the activityGroupCategory
        restActivityGroupCategoryMockMvc.perform(get("/api/activity-group-categories/{id}", activityGroupCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(activityGroupCategory.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.key").value(DEFAULT_KEY.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingActivityGroupCategory() throws Exception {
        // Get the activityGroupCategory
        restActivityGroupCategoryMockMvc.perform(get("/api/activity-group-categories/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateActivityGroupCategory() throws Exception {
        // Initialize the database
        activityGroupCategoryRepository.saveAndFlush(activityGroupCategory);

        int databaseSizeBeforeUpdate = activityGroupCategoryRepository.findAll().size();

        // Update the activityGroupCategory
        ActivityGroupCategory updatedActivityGroupCategory = activityGroupCategoryRepository.findById(activityGroupCategory.getId()).get();
        // Disconnect from session so that the updates on updatedActivityGroupCategory are not directly saved in db
        em.detach(updatedActivityGroupCategory);
        updatedActivityGroupCategory
            .name(UPDATED_NAME)
            .key(UPDATED_KEY)
            .description(UPDATED_DESCRIPTION);
        ActivityGroupCategoryDTO activityGroupCategoryDTO = activityGroupCategoryMapper.toDto(updatedActivityGroupCategory);

        restActivityGroupCategoryMockMvc.perform(put("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupCategoryDTO)))
            .andExpect(status().isOk());

        // Validate the ActivityGroupCategory in the database
        List<ActivityGroupCategory> activityGroupCategoryList = activityGroupCategoryRepository.findAll();
        assertThat(activityGroupCategoryList).hasSize(databaseSizeBeforeUpdate);
        ActivityGroupCategory testActivityGroupCategory = activityGroupCategoryList.get(activityGroupCategoryList.size() - 1);
        assertThat(testActivityGroupCategory.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testActivityGroupCategory.getKey()).isEqualTo(UPDATED_KEY);
        assertThat(testActivityGroupCategory.getDescription()).isEqualTo(UPDATED_DESCRIPTION);

        // Validate the ActivityGroupCategory in Elasticsearch
        verify(mockActivityGroupCategorySearchRepository, times(1)).save(testActivityGroupCategory);
    }

    @Test
    @Transactional
    public void updateNonExistingActivityGroupCategory() throws Exception {
        int databaseSizeBeforeUpdate = activityGroupCategoryRepository.findAll().size();

        // Create the ActivityGroupCategory
        ActivityGroupCategoryDTO activityGroupCategoryDTO = activityGroupCategoryMapper.toDto(activityGroupCategory);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restActivityGroupCategoryMockMvc.perform(put("/api/activity-group-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityGroupCategory in the database
        List<ActivityGroupCategory> activityGroupCategoryList = activityGroupCategoryRepository.findAll();
        assertThat(activityGroupCategoryList).hasSize(databaseSizeBeforeUpdate);

        // Validate the ActivityGroupCategory in Elasticsearch
        verify(mockActivityGroupCategorySearchRepository, times(0)).save(activityGroupCategory);
    }

    @Test
    @Transactional
    public void deleteActivityGroupCategory() throws Exception {
        // Initialize the database
        activityGroupCategoryRepository.saveAndFlush(activityGroupCategory);

        int databaseSizeBeforeDelete = activityGroupCategoryRepository.findAll().size();

        // Get the activityGroupCategory
        restActivityGroupCategoryMockMvc.perform(delete("/api/activity-group-categories/{id}", activityGroupCategory.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<ActivityGroupCategory> activityGroupCategoryList = activityGroupCategoryRepository.findAll();
        assertThat(activityGroupCategoryList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the ActivityGroupCategory in Elasticsearch
        verify(mockActivityGroupCategorySearchRepository, times(1)).deleteById(activityGroupCategory.getId());
    }

    @Test
    @Transactional
    public void searchActivityGroupCategory() throws Exception {
        // Initialize the database
        activityGroupCategoryRepository.saveAndFlush(activityGroupCategory);
        when(mockActivityGroupCategorySearchRepository.search(queryStringQuery("id:" + activityGroupCategory.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(activityGroupCategory), PageRequest.of(0, 1), 1));
        // Search the activityGroupCategory
        restActivityGroupCategoryMockMvc.perform(get("/api/_search/activity-group-categories?query=id:" + activityGroupCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityGroupCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityGroupCategory.class);
        ActivityGroupCategory activityGroupCategory1 = new ActivityGroupCategory();
        activityGroupCategory1.setId(1L);
        ActivityGroupCategory activityGroupCategory2 = new ActivityGroupCategory();
        activityGroupCategory2.setId(activityGroupCategory1.getId());
        assertThat(activityGroupCategory1).isEqualTo(activityGroupCategory2);
        activityGroupCategory2.setId(2L);
        assertThat(activityGroupCategory1).isNotEqualTo(activityGroupCategory2);
        activityGroupCategory1.setId(null);
        assertThat(activityGroupCategory1).isNotEqualTo(activityGroupCategory2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityGroupCategoryDTO.class);
        ActivityGroupCategoryDTO activityGroupCategoryDTO1 = new ActivityGroupCategoryDTO();
        activityGroupCategoryDTO1.setId(1L);
        ActivityGroupCategoryDTO activityGroupCategoryDTO2 = new ActivityGroupCategoryDTO();
        assertThat(activityGroupCategoryDTO1).isNotEqualTo(activityGroupCategoryDTO2);
        activityGroupCategoryDTO2.setId(activityGroupCategoryDTO1.getId());
        assertThat(activityGroupCategoryDTO1).isEqualTo(activityGroupCategoryDTO2);
        activityGroupCategoryDTO2.setId(2L);
        assertThat(activityGroupCategoryDTO1).isNotEqualTo(activityGroupCategoryDTO2);
        activityGroupCategoryDTO1.setId(null);
        assertThat(activityGroupCategoryDTO1).isNotEqualTo(activityGroupCategoryDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(activityGroupCategoryMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(activityGroupCategoryMapper.fromId(null)).isNull();
    }
}
