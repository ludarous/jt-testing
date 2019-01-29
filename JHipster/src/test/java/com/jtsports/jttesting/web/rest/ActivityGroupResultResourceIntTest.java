package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.ActivityGroupResult;
import com.jtsports.jttesting.domain.ActivityGroup;
import com.jtsports.jttesting.repository.ActivityGroupResultRepository;
import com.jtsports.jttesting.repository.search.ActivityGroupResultSearchRepository;
import com.jtsports.jttesting.service.ActivityGroupResultService;
import com.jtsports.jttesting.service.dto.ActivityGroupResultDTO;
import com.jtsports.jttesting.service.mapper.ActivityGroupResultMapper;
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
 * Test class for the ActivityGroupResultResource REST controller.
 *
 * @see ActivityGroupResultResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class ActivityGroupResultResourceIntTest {

    private static final String DEFAULT_NOTE = "AAAAAAAAAA";
    private static final String UPDATED_NOTE = "BBBBBBBBBB";

    @Autowired
    private ActivityGroupResultRepository activityGroupResultRepository;


    @Autowired
    private ActivityGroupResultMapper activityGroupResultMapper;
    

    @Autowired
    private ActivityGroupResultService activityGroupResultService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.ActivityGroupResultSearchRepositoryMockConfiguration
     */
    @Autowired
    private ActivityGroupResultSearchRepository mockActivityGroupResultSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restActivityGroupResultMockMvc;

    private ActivityGroupResult activityGroupResult;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final ActivityGroupResultResource activityGroupResultResource = new ActivityGroupResultResource(activityGroupResultService);
        this.restActivityGroupResultMockMvc = MockMvcBuilders.standaloneSetup(activityGroupResultResource)
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
    public static ActivityGroupResult createEntity(EntityManager em) {
        ActivityGroupResult activityGroupResult = new ActivityGroupResult()
            .note(DEFAULT_NOTE);
        // Add required entity
        ActivityGroup activityGroup = ActivityGroupResourceIntTest.createEntity(em);
        em.persist(activityGroup);
        em.flush();
        activityGroupResult.setActivityGroup(activityGroup);
        return activityGroupResult;
    }

    @Before
    public void initTest() {
        activityGroupResult = createEntity(em);
    }

    @Test
    @Transactional
    public void createActivityGroupResult() throws Exception {
        int databaseSizeBeforeCreate = activityGroupResultRepository.findAll().size();

        // Create the ActivityGroupResult
        ActivityGroupResultDTO activityGroupResultDTO = activityGroupResultMapper.toDto(activityGroupResult);
        restActivityGroupResultMockMvc.perform(post("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupResultDTO)))
            .andExpect(status().isCreated());

        // Validate the ActivityGroupResult in the database
        List<ActivityGroupResult> activityGroupResultList = activityGroupResultRepository.findAll();
        assertThat(activityGroupResultList).hasSize(databaseSizeBeforeCreate + 1);
        ActivityGroupResult testActivityGroupResult = activityGroupResultList.get(activityGroupResultList.size() - 1);
        assertThat(testActivityGroupResult.getNote()).isEqualTo(DEFAULT_NOTE);

        // Validate the ActivityGroupResult in Elasticsearch
        verify(mockActivityGroupResultSearchRepository, times(1)).save(testActivityGroupResult);
    }

    @Test
    @Transactional
    public void createActivityGroupResultWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = activityGroupResultRepository.findAll().size();

        // Create the ActivityGroupResult with an existing ID
        activityGroupResult.setId(1L);
        ActivityGroupResultDTO activityGroupResultDTO = activityGroupResultMapper.toDto(activityGroupResult);

        // An entity with an existing ID cannot be created, so this API call must fail
        restActivityGroupResultMockMvc.perform(post("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityGroupResult in the database
        List<ActivityGroupResult> activityGroupResultList = activityGroupResultRepository.findAll();
        assertThat(activityGroupResultList).hasSize(databaseSizeBeforeCreate);

        // Validate the ActivityGroupResult in Elasticsearch
        verify(mockActivityGroupResultSearchRepository, times(0)).save(activityGroupResult);
    }

    @Test
    @Transactional
    public void getAllActivityGroupResults() throws Exception {
        // Initialize the database
        activityGroupResultRepository.saveAndFlush(activityGroupResult);

        // Get all the activityGroupResultList
        restActivityGroupResultMockMvc.perform(get("/api/activity-group-results?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityGroupResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())));
    }
    

    @Test
    @Transactional
    public void getActivityGroupResult() throws Exception {
        // Initialize the database
        activityGroupResultRepository.saveAndFlush(activityGroupResult);

        // Get the activityGroupResult
        restActivityGroupResultMockMvc.perform(get("/api/activity-group-results/{id}", activityGroupResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(activityGroupResult.getId().intValue()))
            .andExpect(jsonPath("$.note").value(DEFAULT_NOTE.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingActivityGroupResult() throws Exception {
        // Get the activityGroupResult
        restActivityGroupResultMockMvc.perform(get("/api/activity-group-results/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateActivityGroupResult() throws Exception {
        // Initialize the database
        activityGroupResultRepository.saveAndFlush(activityGroupResult);

        int databaseSizeBeforeUpdate = activityGroupResultRepository.findAll().size();

        // Update the activityGroupResult
        ActivityGroupResult updatedActivityGroupResult = activityGroupResultRepository.findById(activityGroupResult.getId()).get();
        // Disconnect from session so that the updates on updatedActivityGroupResult are not directly saved in db
        em.detach(updatedActivityGroupResult);
        updatedActivityGroupResult
            .note(UPDATED_NOTE);
        ActivityGroupResultDTO activityGroupResultDTO = activityGroupResultMapper.toDto(updatedActivityGroupResult);

        restActivityGroupResultMockMvc.perform(put("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupResultDTO)))
            .andExpect(status().isOk());

        // Validate the ActivityGroupResult in the database
        List<ActivityGroupResult> activityGroupResultList = activityGroupResultRepository.findAll();
        assertThat(activityGroupResultList).hasSize(databaseSizeBeforeUpdate);
        ActivityGroupResult testActivityGroupResult = activityGroupResultList.get(activityGroupResultList.size() - 1);
        assertThat(testActivityGroupResult.getNote()).isEqualTo(UPDATED_NOTE);

        // Validate the ActivityGroupResult in Elasticsearch
        verify(mockActivityGroupResultSearchRepository, times(1)).save(testActivityGroupResult);
    }

    @Test
    @Transactional
    public void updateNonExistingActivityGroupResult() throws Exception {
        int databaseSizeBeforeUpdate = activityGroupResultRepository.findAll().size();

        // Create the ActivityGroupResult
        ActivityGroupResultDTO activityGroupResultDTO = activityGroupResultMapper.toDto(activityGroupResult);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restActivityGroupResultMockMvc.perform(put("/api/activity-group-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityGroupResult in the database
        List<ActivityGroupResult> activityGroupResultList = activityGroupResultRepository.findAll();
        assertThat(activityGroupResultList).hasSize(databaseSizeBeforeUpdate);

        // Validate the ActivityGroupResult in Elasticsearch
        verify(mockActivityGroupResultSearchRepository, times(0)).save(activityGroupResult);
    }

    @Test
    @Transactional
    public void deleteActivityGroupResult() throws Exception {
        // Initialize the database
        activityGroupResultRepository.saveAndFlush(activityGroupResult);

        int databaseSizeBeforeDelete = activityGroupResultRepository.findAll().size();

        // Get the activityGroupResult
        restActivityGroupResultMockMvc.perform(delete("/api/activity-group-results/{id}", activityGroupResult.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<ActivityGroupResult> activityGroupResultList = activityGroupResultRepository.findAll();
        assertThat(activityGroupResultList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the ActivityGroupResult in Elasticsearch
        verify(mockActivityGroupResultSearchRepository, times(1)).deleteById(activityGroupResult.getId());
    }

    @Test
    @Transactional
    public void searchActivityGroupResult() throws Exception {
        // Initialize the database
        activityGroupResultRepository.saveAndFlush(activityGroupResult);
        when(mockActivityGroupResultSearchRepository.search(queryStringQuery("id:" + activityGroupResult.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(activityGroupResult), PageRequest.of(0, 1), 1));
        // Search the activityGroupResult
        restActivityGroupResultMockMvc.perform(get("/api/_search/activity-group-results?query=id:" + activityGroupResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityGroupResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityGroupResult.class);
        ActivityGroupResult activityGroupResult1 = new ActivityGroupResult();
        activityGroupResult1.setId(1L);
        ActivityGroupResult activityGroupResult2 = new ActivityGroupResult();
        activityGroupResult2.setId(activityGroupResult1.getId());
        assertThat(activityGroupResult1).isEqualTo(activityGroupResult2);
        activityGroupResult2.setId(2L);
        assertThat(activityGroupResult1).isNotEqualTo(activityGroupResult2);
        activityGroupResult1.setId(null);
        assertThat(activityGroupResult1).isNotEqualTo(activityGroupResult2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityGroupResultDTO.class);
        ActivityGroupResultDTO activityGroupResultDTO1 = new ActivityGroupResultDTO();
        activityGroupResultDTO1.setId(1L);
        ActivityGroupResultDTO activityGroupResultDTO2 = new ActivityGroupResultDTO();
        assertThat(activityGroupResultDTO1).isNotEqualTo(activityGroupResultDTO2);
        activityGroupResultDTO2.setId(activityGroupResultDTO1.getId());
        assertThat(activityGroupResultDTO1).isEqualTo(activityGroupResultDTO2);
        activityGroupResultDTO2.setId(2L);
        assertThat(activityGroupResultDTO1).isNotEqualTo(activityGroupResultDTO2);
        activityGroupResultDTO1.setId(null);
        assertThat(activityGroupResultDTO1).isNotEqualTo(activityGroupResultDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(activityGroupResultMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(activityGroupResultMapper.fromId(null)).isNull();
    }
}
