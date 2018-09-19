package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.EventResult;
import com.jtsports.jttesting.domain.Person;
import com.jtsports.jttesting.repository.EventResultRepository;
import com.jtsports.jttesting.repository.search.EventResultSearchRepository;
import com.jtsports.jttesting.service.EventResultService;
import com.jtsports.jttesting.service.dto.EventResultDTO;
import com.jtsports.jttesting.service.mapper.EventResultMapper;
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
 * Test class for the EventResultResource REST controller.
 *
 * @see EventResultResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class EventResultResourceIntTest {

    private static final String DEFAULT_NOTE = "AAAAAAAAAA";
    private static final String UPDATED_NOTE = "BBBBBBBBBB";

    private static final Float DEFAULT_ACTUAL_HEIGHT_IN_CM = 1F;
    private static final Float UPDATED_ACTUAL_HEIGHT_IN_CM = 2F;

    private static final Float DEFAULT_ACTUAL_WEIGHT_IN_KG = 1F;
    private static final Float UPDATED_ACTUAL_WEIGHT_IN_KG = 2F;

    @Autowired
    private EventResultRepository eventResultRepository;


    @Autowired
    private EventResultMapper eventResultMapper;
    

    @Autowired
    private EventResultService eventResultService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.EventResultSearchRepositoryMockConfiguration
     */
    @Autowired
    private EventResultSearchRepository mockEventResultSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restEventResultMockMvc;

    private EventResult eventResult;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final EventResultResource eventResultResource = new EventResultResource(eventResultService);
        this.restEventResultMockMvc = MockMvcBuilders.standaloneSetup(eventResultResource)
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
    public static EventResult createEntity(EntityManager em) {
        EventResult eventResult = new EventResult()
            .note(DEFAULT_NOTE)
            .actualHeightInCm(DEFAULT_ACTUAL_HEIGHT_IN_CM)
            .actualWeightInKg(DEFAULT_ACTUAL_WEIGHT_IN_KG);
        // Add required entity
        Person person = PersonResourceIntTest.createEntity(em);
        em.persist(person);
        em.flush();
        eventResult.setPerson(person);
        return eventResult;
    }

    @Before
    public void initTest() {
        eventResult = createEntity(em);
    }

    @Test
    @Transactional
    public void createEventResult() throws Exception {
        int databaseSizeBeforeCreate = eventResultRepository.findAll().size();

        // Create the EventResult
        EventResultDTO eventResultDTO = eventResultMapper.toDto(eventResult);
        restEventResultMockMvc.perform(post("/api/event-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(eventResultDTO)))
            .andExpect(status().isCreated());

        // Validate the EventResult in the database
        List<EventResult> eventResultList = eventResultRepository.findAll();
        assertThat(eventResultList).hasSize(databaseSizeBeforeCreate + 1);
        EventResult testEventResult = eventResultList.get(eventResultList.size() - 1);
        assertThat(testEventResult.getNote()).isEqualTo(DEFAULT_NOTE);
        assertThat(testEventResult.getActualHeightInCm()).isEqualTo(DEFAULT_ACTUAL_HEIGHT_IN_CM);
        assertThat(testEventResult.getActualWeightInKg()).isEqualTo(DEFAULT_ACTUAL_WEIGHT_IN_KG);

        // Validate the EventResult in Elasticsearch
        verify(mockEventResultSearchRepository, times(1)).save(testEventResult);
    }

    @Test
    @Transactional
    public void createEventResultWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = eventResultRepository.findAll().size();

        // Create the EventResult with an existing ID
        eventResult.setId(1L);
        EventResultDTO eventResultDTO = eventResultMapper.toDto(eventResult);

        // An entity with an existing ID cannot be created, so this API call must fail
        restEventResultMockMvc.perform(post("/api/event-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(eventResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the EventResult in the database
        List<EventResult> eventResultList = eventResultRepository.findAll();
        assertThat(eventResultList).hasSize(databaseSizeBeforeCreate);

        // Validate the EventResult in Elasticsearch
        verify(mockEventResultSearchRepository, times(0)).save(eventResult);
    }

    @Test
    @Transactional
    public void getAllEventResults() throws Exception {
        // Initialize the database
        eventResultRepository.saveAndFlush(eventResult);

        // Get all the eventResultList
        restEventResultMockMvc.perform(get("/api/event-results?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(eventResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())))
            .andExpect(jsonPath("$.[*].actualHeightInCm").value(hasItem(DEFAULT_ACTUAL_HEIGHT_IN_CM.doubleValue())))
            .andExpect(jsonPath("$.[*].actualWeightInKg").value(hasItem(DEFAULT_ACTUAL_WEIGHT_IN_KG.doubleValue())));
    }
    

    @Test
    @Transactional
    public void getEventResult() throws Exception {
        // Initialize the database
        eventResultRepository.saveAndFlush(eventResult);

        // Get the eventResult
        restEventResultMockMvc.perform(get("/api/event-results/{id}", eventResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(eventResult.getId().intValue()))
            .andExpect(jsonPath("$.note").value(DEFAULT_NOTE.toString()))
            .andExpect(jsonPath("$.actualHeightInCm").value(DEFAULT_ACTUAL_HEIGHT_IN_CM.doubleValue()))
            .andExpect(jsonPath("$.actualWeightInKg").value(DEFAULT_ACTUAL_WEIGHT_IN_KG.doubleValue()));
    }
    @Test
    @Transactional
    public void getNonExistingEventResult() throws Exception {
        // Get the eventResult
        restEventResultMockMvc.perform(get("/api/event-results/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateEventResult() throws Exception {
        // Initialize the database
        eventResultRepository.saveAndFlush(eventResult);

        int databaseSizeBeforeUpdate = eventResultRepository.findAll().size();

        // Update the eventResult
        EventResult updatedEventResult = eventResultRepository.findById(eventResult.getId()).get();
        // Disconnect from session so that the updates on updatedEventResult are not directly saved in db
        em.detach(updatedEventResult);
        updatedEventResult
            .note(UPDATED_NOTE)
            .actualHeightInCm(UPDATED_ACTUAL_HEIGHT_IN_CM)
            .actualWeightInKg(UPDATED_ACTUAL_WEIGHT_IN_KG);
        EventResultDTO eventResultDTO = eventResultMapper.toDto(updatedEventResult);

        restEventResultMockMvc.perform(put("/api/event-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(eventResultDTO)))
            .andExpect(status().isOk());

        // Validate the EventResult in the database
        List<EventResult> eventResultList = eventResultRepository.findAll();
        assertThat(eventResultList).hasSize(databaseSizeBeforeUpdate);
        EventResult testEventResult = eventResultList.get(eventResultList.size() - 1);
        assertThat(testEventResult.getNote()).isEqualTo(UPDATED_NOTE);
        assertThat(testEventResult.getActualHeightInCm()).isEqualTo(UPDATED_ACTUAL_HEIGHT_IN_CM);
        assertThat(testEventResult.getActualWeightInKg()).isEqualTo(UPDATED_ACTUAL_WEIGHT_IN_KG);

        // Validate the EventResult in Elasticsearch
        verify(mockEventResultSearchRepository, times(1)).save(testEventResult);
    }

    @Test
    @Transactional
    public void updateNonExistingEventResult() throws Exception {
        int databaseSizeBeforeUpdate = eventResultRepository.findAll().size();

        // Create the EventResult
        EventResultDTO eventResultDTO = eventResultMapper.toDto(eventResult);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restEventResultMockMvc.perform(put("/api/event-results")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(eventResultDTO)))
            .andExpect(status().isBadRequest());

        // Validate the EventResult in the database
        List<EventResult> eventResultList = eventResultRepository.findAll();
        assertThat(eventResultList).hasSize(databaseSizeBeforeUpdate);

        // Validate the EventResult in Elasticsearch
        verify(mockEventResultSearchRepository, times(0)).save(eventResult);
    }

    @Test
    @Transactional
    public void deleteEventResult() throws Exception {
        // Initialize the database
        eventResultRepository.saveAndFlush(eventResult);

        int databaseSizeBeforeDelete = eventResultRepository.findAll().size();

        // Get the eventResult
        restEventResultMockMvc.perform(delete("/api/event-results/{id}", eventResult.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<EventResult> eventResultList = eventResultRepository.findAll();
        assertThat(eventResultList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the EventResult in Elasticsearch
        verify(mockEventResultSearchRepository, times(1)).deleteById(eventResult.getId());
    }

    @Test
    @Transactional
    public void searchEventResult() throws Exception {
        // Initialize the database
        eventResultRepository.saveAndFlush(eventResult);
        when(mockEventResultSearchRepository.search(queryStringQuery("id:" + eventResult.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(eventResult), PageRequest.of(0, 1), 1));
        // Search the eventResult
        restEventResultMockMvc.perform(get("/api/_search/event-results?query=id:" + eventResult.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(eventResult.getId().intValue())))
            .andExpect(jsonPath("$.[*].note").value(hasItem(DEFAULT_NOTE.toString())))
            .andExpect(jsonPath("$.[*].actualHeightInCm").value(hasItem(DEFAULT_ACTUAL_HEIGHT_IN_CM.doubleValue())))
            .andExpect(jsonPath("$.[*].actualWeightInKg").value(hasItem(DEFAULT_ACTUAL_WEIGHT_IN_KG.doubleValue())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(EventResult.class);
        EventResult eventResult1 = new EventResult();
        eventResult1.setId(1L);
        EventResult eventResult2 = new EventResult();
        eventResult2.setId(eventResult1.getId());
        assertThat(eventResult1).isEqualTo(eventResult2);
        eventResult2.setId(2L);
        assertThat(eventResult1).isNotEqualTo(eventResult2);
        eventResult1.setId(null);
        assertThat(eventResult1).isNotEqualTo(eventResult2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(EventResultDTO.class);
        EventResultDTO eventResultDTO1 = new EventResultDTO();
        eventResultDTO1.setId(1L);
        EventResultDTO eventResultDTO2 = new EventResultDTO();
        assertThat(eventResultDTO1).isNotEqualTo(eventResultDTO2);
        eventResultDTO2.setId(eventResultDTO1.getId());
        assertThat(eventResultDTO1).isEqualTo(eventResultDTO2);
        eventResultDTO2.setId(2L);
        assertThat(eventResultDTO1).isNotEqualTo(eventResultDTO2);
        eventResultDTO1.setId(null);
        assertThat(eventResultDTO1).isNotEqualTo(eventResultDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(eventResultMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(eventResultMapper.fromId(null)).isNull();
    }
}
