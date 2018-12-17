package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.repository.ActivityResultRepository;
import com.jtsports.jttesting.repository.search.ActivityResultSearchRepository;
import com.jtsports.jttesting.service.ActivityResultService;
import com.jtsports.jttesting.service.dto.ActivityResultDTO;
import com.jtsports.jttesting.service.mapper.ActivityResultMapper;
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
import java.time.Instant;
import java.time.ZonedDateTime;
import java.time.ZoneOffset;
import java.time.ZoneId;
import java.util.Collections;
import java.util.List;


import static com.jtsports.jttesting.web.rest.TestUtil.sameInstant;
import static com.jtsports.jttesting.web.rest.TestUtil.createFormattingConversionService;
import static org.assertj.core.api.Assertions.assertThat;
import static org.elasticsearch.index.query.QueryBuilders.queryStringQuery;
import static org.hamcrest.Matchers.hasItem;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Test class for the ActivityResultResource REST controller.
 *
 * @see ActivityResultResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class ActivityResultResourceIntTest {

    private static final Float DEFAULT_PRIMARY_RESULT_VALUE = 1F;
    private static final Float UPDATED_PRIMARY_RESULT_VALUE = 2F;

    private static final Float DEFAULT_SECONDARY_RESULT_VALUE = 1F;
    private static final Float UPDATED_SECONDARY_RESULT_VALUE = 2F;

    private static final String DEFAULT_NOTE = "AAAAAAAAAA";
    private static final String UPDATED_NOTE = "BBBBBBBBBB";

    private static final ZonedDateTime DEFAULT_EVENT_DATE = ZonedDateTime.ofInstant(Instant.ofEpochMilli(0L), ZoneOffset.UTC);
    private static final ZonedDateTime UPDATED_EVENT_DATE = ZonedDateTime.now(ZoneId.systemDefault()).withNano(0);

    @Autowired
    private ActivityResultRepository activityResultRepository;


    @Autowired
    private ActivityResultMapper activityResultMapper;
    

    @Autowired
    private ActivityResultService activityResultService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.ActivityResultSearchRepositoryMockConfiguration
     */
    @Autowired
    private ActivityResultSearchRepository mockActivityResultSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restActivityResultMockMvc;

    private ActivityResult activityResult;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final ActivityResultResource activityResultResource = new ActivityResultResource(activityResultService);
        this.restActivityResultMockMvc = MockMvcBuilders.standaloneSetup(activityResultResource)
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
    public static ActivityResult createEntity(EntityManager em) {
        ActivityResult activityResult = new ActivityResult()
            .primaryResultValue(DEFAULT_PRIMARY_RESULT_VALUE)
            .secondaryResultValue(DEFAULT_SECONDARY_RESULT_VALUE)
            .note(DEFAULT_NOTE)
            .eventDate(DEFAULT_EVENT_DATE);
        // Add required entity
        Activity activity = ActivityResourceIntTest.createEntity(em);
        em.persist(activity);
        em.flush();
        activityResult.setActivity(activity);
        return activityResult;
    }

    @Before
    public void initTest() {
        activityResult = createEntity(em);
    }

    @Test
    @Transactional
    public void createActivityResult() throws Exception {
        int databaseSizeBeforeCreate = activityResultRepository.findAll().size();

        // Create the ActivityResult
        ActivityResultDTO activityResultDTO = activityResultMapper.toDto(activityResult);
        restActivityResultMockMvc.perform(post("/api/activity-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityResultDTO)))
            .andExpect(status().isCreated());

        // Validate the ActivityResult in the database
        List<ActivityResult> activityResultList = activityResultRepository.findAll();
        assertThat(activityResultList).hasSize(databaseSizeBeforeCreate + 1);
        ActivityResult testActivityResult = activityResultList.get(activityResultList.size() - 1);
        assertThat(testActivityResult.getPrimaryResultValue()).isEqualTo(DEFAULT_PRIMARY_RESULT_VALUE);
        assertThat(testActivityResult.getSecondaryResultValue()).isEqualTo(DEFAULT_SECONDARY_RESULT_VALUE);
        assertThat(testActivityResult.getNote()).isEqualTo(DEFAULT_NOTE);
        assertThat(testActivityResult.getEventDate()).isEqualTo(DEFAULT_EVENT_DATE);

        // Validate the ActivityResult in Elasticsearch
        verify(mockActivityResultSearchRepository, times(1)).save(testActivityResult);
    }

    @Test
    @Transactional
    public void createActivityResultWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = activityResultRepository.findAll().size();

        // Create the ActivityResult with an existing ID
        activityResult.setId(1L);
        ActivityResultDTO activityResultDTO = activityResultMapper.toDto(activityResult);

        // An entity with an existing ID cannot be created, so this API call must fail
        restActivityResultMockMvc.perform(post("/api/activity-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityResult in the database
        List<ActivityResult> activityResultList = activityResultRepository.findAll();
        assertThat(activityResultList).hasSize(databaseSizeBeforeCreate);

        // Validate the ActivityResult in Elasticsearch
        verify(mockActivityResultSearchRepository, times(0)).save(activityResult);
    }

    @Test
    @Transactional
    public void checkEventDateIsRequired() throws Exception {
        int databaseSizeBeforeTest = activityResultRepository.findAll().size();
        // set the field null
        activityResult.setEventDate(null);

        // Create the ActivityResult, which fails.
        ActivityResultDTO activityResultDTO = activityResultMapper.toDto(activityResult);

        restActivityResultMockMvc.perform(post("/api/activity-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityResultDTO)))
            .andExpect(status().isBadRequest());

        List<ActivityResult> activityResultList = activityResultRepository.findAll();
        assertThat(activityResultList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllActivityResults() throws Exception {
        // Initialize the database
        activityResultRepository.saveAndFlush(activityResult);

        // Get all the activityResultList
        restActivityResultMockMvc.perform(get("/api/activity-results?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].primaryResultValue").value(hasItem(DEFAULT_PRIMARY_RESULT_VALUE.doubleValue())))
            .andExpect(jsonPath("$.[*].secondaryResultValue").value(hasItem(DEFAULT_SECONDARY_RESULT_VALUE.doubleValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())))
            .andExpect(jsonPath("$.[*].eventDate").value(hasItem(sameInstant(DEFAULT_EVENT_DATE))));
    }
    

    @Test
    @Transactional
    public void getActivityResult() throws Exception {
        // Initialize the database
        activityResultRepository.saveAndFlush(activityResult);

        // Get the activityResult
        restActivityResultMockMvc.perform(get("/api/activity-results/{id}", activityResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(activityResult.getId().intValue()))
            .andExpect(jsonPath("$.primaryResultValue").value(DEFAULT_PRIMARY_RESULT_VALUE.doubleValue()))
            .andExpect(jsonPath("$.secondaryResultValue").value(DEFAULT_SECONDARY_RESULT_VALUE.doubleValue()))
            .andExpect(jsonPath("$.note").value(DEFAULT_NOTE.toString()))
            .andExpect(jsonPath("$.eventDate").value(sameInstant(DEFAULT_EVENT_DATE)));
    }
    @Test
    @Transactional
    public void getNonExistingActivityResult() throws Exception {
        // Get the activityResult
        restActivityResultMockMvc.perform(get("/api/activity-results/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateActivityResult() throws Exception {
        // Initialize the database
        activityResultRepository.saveAndFlush(activityResult);

        int databaseSizeBeforeUpdate = activityResultRepository.findAll().size();

        // Update the activityResult
        ActivityResult updatedActivityResult = activityResultRepository.findById(activityResult.getId()).get();
        // Disconnect from session so that the updates on updatedActivityResult are not directly saved in db
        em.detach(updatedActivityResult);
        updatedActivityResult
            .primaryResultValue(UPDATED_PRIMARY_RESULT_VALUE)
            .secondaryResultValue(UPDATED_SECONDARY_RESULT_VALUE)
            .note(UPDATED_NOTE)
            .eventDate(UPDATED_EVENT_DATE);
        ActivityResultDTO activityResultDTO = activityResultMapper.toDto(updatedActivityResult);

        restActivityResultMockMvc.perform(put("/api/activity-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityResultDTO)))
            .andExpect(status().isOk());

        // Validate the ActivityResult in the database
        List<ActivityResult> activityResultList = activityResultRepository.findAll();
        assertThat(activityResultList).hasSize(databaseSizeBeforeUpdate);
        ActivityResult testActivityResult = activityResultList.get(activityResultList.size() - 1);
        assertThat(testActivityResult.getPrimaryResultValue()).isEqualTo(UPDATED_PRIMARY_RESULT_VALUE);
        assertThat(testActivityResult.getSecondaryResultValue()).isEqualTo(UPDATED_SECONDARY_RESULT_VALUE);
        assertThat(testActivityResult.getNote()).isEqualTo(UPDATED_NOTE);
        assertThat(testActivityResult.getEventDate()).isEqualTo(UPDATED_EVENT_DATE);

        // Validate the ActivityResult in Elasticsearch
        verify(mockActivityResultSearchRepository, times(1)).save(testActivityResult);
    }

    @Test
    @Transactional
    public void updateNonExistingActivityResult() throws Exception {
        int databaseSizeBeforeUpdate = activityResultRepository.findAll().size();

        // Create the ActivityResult
        ActivityResultDTO activityResultDTO = activityResultMapper.toDto(activityResult);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restActivityResultMockMvc.perform(put("/api/activity-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityResult in the database
        List<ActivityResult> activityResultList = activityResultRepository.findAll();
        assertThat(activityResultList).hasSize(databaseSizeBeforeUpdate);

        // Validate the ActivityResult in Elasticsearch
        verify(mockActivityResultSearchRepository, times(0)).save(activityResult);
    }

    @Test
    @Transactional
    public void deleteActivityResult() throws Exception {
        // Initialize the database
        activityResultRepository.saveAndFlush(activityResult);

        int databaseSizeBeforeDelete = activityResultRepository.findAll().size();

        // Get the activityResult
        restActivityResultMockMvc.perform(delete("/api/activity-results/{id}", activityResult.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<ActivityResult> activityResultList = activityResultRepository.findAll();
        assertThat(activityResultList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the ActivityResult in Elasticsearch
        verify(mockActivityResultSearchRepository, times(1)).deleteById(activityResult.getId());
    }

    @Test
    @Transactional
    public void searchActivityResult() throws Exception {
        // Initialize the database
        activityResultRepository.saveAndFlush(activityResult);
        when(mockActivityResultSearchRepository.search(queryStringQuery("id:" + activityResult.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(activityResult), PageRequest.of(0, 1), 1));
        // Search the activityResult
        restActivityResultMockMvc.perform(get("/api/_search/activity-results?query=id:" + activityResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].primaryResultValue").value(hasItem(DEFAULT_PRIMARY_RESULT_VALUE.doubleValue())))
            .andExpect(jsonPath("$.[*].secondaryResultValue").value(hasItem(DEFAULT_SECONDARY_RESULT_VALUE.doubleValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())))
            .andExpect(jsonPath("$.[*].eventDate").value(hasItem(sameInstant(DEFAULT_EVENT_DATE))));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityResult.class);
        ActivityResult activityResult1 = new ActivityResult();
        activityResult1.setId(1L);
        ActivityResult activityResult2 = new ActivityResult();
        activityResult2.setId(activityResult1.getId());
        assertThat(activityResult1).isEqualTo(activityResult2);
        activityResult2.setId(2L);
        assertThat(activityResult1).isNotEqualTo(activityResult2);
        activityResult1.setId(null);
        assertThat(activityResult1).isNotEqualTo(activityResult2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityResultDTO.class);
        ActivityResultDTO activityResultDTO1 = new ActivityResultDTO();
        activityResultDTO1.setId(1L);
        ActivityResultDTO activityResultDTO2 = new ActivityResultDTO();
        assertThat(activityResultDTO1).isNotEqualTo(activityResultDTO2);
        activityResultDTO2.setId(activityResultDTO1.getId());
        assertThat(activityResultDTO1).isEqualTo(activityResultDTO2);
        activityResultDTO2.setId(2L);
        assertThat(activityResultDTO1).isNotEqualTo(activityResultDTO2);
        activityResultDTO1.setId(null);
        assertThat(activityResultDTO1).isNotEqualTo(activityResultDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(activityResultMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(activityResultMapper.fromId(null)).isNull();
    }
}
