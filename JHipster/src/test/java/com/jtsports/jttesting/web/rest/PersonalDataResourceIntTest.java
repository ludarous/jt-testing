package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.PersonalData;
import com.jtsports.jttesting.repository.PersonalDataRepository;
import com.jtsports.jttesting.repository.search.PersonalDataSearchRepository;
import com.jtsports.jttesting.service.PersonalDataService;
import com.jtsports.jttesting.service.dto.PersonalDataDTO;
import com.jtsports.jttesting.service.mapper.PersonalDataMapper;
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
 * Test class for the PersonalDataResource REST controller.
 *
 * @see PersonalDataResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class PersonalDataResourceIntTest {

    private static final String DEFAULT_FIRST_NAME = "AAAAAAAAAA";
    private static final String UPDATED_FIRST_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_LAST_NAME = "AAAAAAAAAA";
    private static final String UPDATED_LAST_NAME = "BBBBBBBBBB";

    private static final ZonedDateTime DEFAULT_BIRTH_DATE = ZonedDateTime.ofInstant(Instant.ofEpochMilli(0L), ZoneOffset.UTC);
    private static final ZonedDateTime UPDATED_BIRTH_DATE = ZonedDateTime.now(ZoneId.systemDefault()).withNano(0);

    private static final String DEFAULT_NATIONALITY = "AAAAAAAAAA";
    private static final String UPDATED_NATIONALITY = "BBBBBBBBBB";

    @Autowired
    private PersonalDataRepository personalDataRepository;


    @Autowired
    private PersonalDataMapper personalDataMapper;
    

    @Autowired
    private PersonalDataService personalDataService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.PersonalDataSearchRepositoryMockConfiguration
     */
    @Autowired
    private PersonalDataSearchRepository mockPersonalDataSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restPersonalDataMockMvc;

    private PersonalData personalData;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final PersonalDataResource personalDataResource = new PersonalDataResource(personalDataService);
        this.restPersonalDataMockMvc = MockMvcBuilders.standaloneSetup(personalDataResource)
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
    public static PersonalData createEntity(EntityManager em) {
        PersonalData personalData = new PersonalData()
            .firstName(DEFAULT_FIRST_NAME)
            .lastName(DEFAULT_LAST_NAME)
            .birthDate(DEFAULT_BIRTH_DATE)
            .nationality(DEFAULT_NATIONALITY);
        return personalData;
    }

    @Before
    public void initTest() {
        personalData = createEntity(em);
    }

    @Test
    @Transactional
    public void createPersonalData() throws Exception {
        int databaseSizeBeforeCreate = personalDataRepository.findAll().size();

        // Create the PersonalData
        PersonalDataDTO personalDataDTO = personalDataMapper.toDto(personalData);
        restPersonalDataMockMvc.perform(post("/api/personal-data")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personalDataDTO)))
            .andExpect(status().isCreated());

        // Validate the PersonalData in the database
        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeCreate + 1);
        PersonalData testPersonalData = personalDataList.get(personalDataList.size() - 1);
        assertThat(testPersonalData.getFirstName()).isEqualTo(DEFAULT_FIRST_NAME);
        assertThat(testPersonalData.getLastName()).isEqualTo(DEFAULT_LAST_NAME);
        assertThat(testPersonalData.getBirthDate()).isEqualTo(DEFAULT_BIRTH_DATE);
        assertThat(testPersonalData.getNationality()).isEqualTo(DEFAULT_NATIONALITY);

        // Validate the PersonalData in Elasticsearch
        verify(mockPersonalDataSearchRepository, times(1)).save(testPersonalData);
    }

    @Test
    @Transactional
    public void createPersonalDataWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = personalDataRepository.findAll().size();

        // Create the PersonalData with an existing ID
        personalData.setId(1L);
        PersonalDataDTO personalDataDTO = personalDataMapper.toDto(personalData);

        // An entity with an existing ID cannot be created, so this API call must fail
        restPersonalDataMockMvc.perform(post("/api/personal-data")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personalDataDTO)))
            .andExpect(status().isBadRequest());

        // Validate the PersonalData in the database
        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeCreate);

        // Validate the PersonalData in Elasticsearch
        verify(mockPersonalDataSearchRepository, times(0)).save(personalData);
    }

    @Test
    @Transactional
    public void checkFirstNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = personalDataRepository.findAll().size();
        // set the field null
        personalData.setFirstName(null);

        // Create the PersonalData, which fails.
        PersonalDataDTO personalDataDTO = personalDataMapper.toDto(personalData);

        restPersonalDataMockMvc.perform(post("/api/personal-data")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personalDataDTO)))
            .andExpect(status().isBadRequest());

        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void checkLastNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = personalDataRepository.findAll().size();
        // set the field null
        personalData.setLastName(null);

        // Create the PersonalData, which fails.
        PersonalDataDTO personalDataDTO = personalDataMapper.toDto(personalData);

        restPersonalDataMockMvc.perform(post("/api/personal-data")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personalDataDTO)))
            .andExpect(status().isBadRequest());

        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void checkBirthDateIsRequired() throws Exception {
        int databaseSizeBeforeTest = personalDataRepository.findAll().size();
        // set the field null
        personalData.setBirthDate(null);

        // Create the PersonalData, which fails.
        PersonalDataDTO personalDataDTO = personalDataMapper.toDto(personalData);

        restPersonalDataMockMvc.perform(post("/api/personal-data")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personalDataDTO)))
            .andExpect(status().isBadRequest());

        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllPersonalData() throws Exception {
        // Initialize the database
        personalDataRepository.saveAndFlush(personalData);

        // Get all the personalDataList
        restPersonalDataMockMvc.perform(get("/api/personal-data?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(personalData.getId().intValue())))
            .andExpect(jsonPath("$.[*].firstName").value(hasItem(DEFAULT_FIRST_NAME.toString())))
            .andExpect(jsonPath("$.[*].lastName").value(hasItem(DEFAULT_LAST_NAME.toString())))
            .andExpect(jsonPath("$.[*].birthDate").value(hasItem(sameInstant(DEFAULT_BIRTH_DATE))))
            .andExpect(jsonPath("$.[*].nationality").value(hasItem(DEFAULT_NATIONALITY.toString())));
    }
    

    @Test
    @Transactional
    public void getPersonalData() throws Exception {
        // Initialize the database
        personalDataRepository.saveAndFlush(personalData);

        // Get the personalData
        restPersonalDataMockMvc.perform(get("/api/personal-data/{id}", personalData.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(personalData.getId().intValue()))
            .andExpect(jsonPath("$.firstName").value(DEFAULT_FIRST_NAME.toString()))
            .andExpect(jsonPath("$.lastName").value(DEFAULT_LAST_NAME.toString()))
            .andExpect(jsonPath("$.birthDate").value(sameInstant(DEFAULT_BIRTH_DATE)))
            .andExpect(jsonPath("$.nationality").value(DEFAULT_NATIONALITY.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingPersonalData() throws Exception {
        // Get the personalData
        restPersonalDataMockMvc.perform(get("/api/personal-data/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updatePersonalData() throws Exception {
        // Initialize the database
        personalDataRepository.saveAndFlush(personalData);

        int databaseSizeBeforeUpdate = personalDataRepository.findAll().size();

        // Update the personalData
        PersonalData updatedPersonalData = personalDataRepository.findById(personalData.getId()).get();
        // Disconnect from session so that the updates on updatedPersonalData are not directly saved in db
        em.detach(updatedPersonalData);
        updatedPersonalData
            .firstName(UPDATED_FIRST_NAME)
            .lastName(UPDATED_LAST_NAME)
            .birthDate(UPDATED_BIRTH_DATE)
            .nationality(UPDATED_NATIONALITY);
        PersonalDataDTO personalDataDTO = personalDataMapper.toDto(updatedPersonalData);

        restPersonalDataMockMvc.perform(put("/api/personal-data")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personalDataDTO)))
            .andExpect(status().isOk());

        // Validate the PersonalData in the database
        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeUpdate);
        PersonalData testPersonalData = personalDataList.get(personalDataList.size() - 1);
        assertThat(testPersonalData.getFirstName()).isEqualTo(UPDATED_FIRST_NAME);
        assertThat(testPersonalData.getLastName()).isEqualTo(UPDATED_LAST_NAME);
        assertThat(testPersonalData.getBirthDate()).isEqualTo(UPDATED_BIRTH_DATE);
        assertThat(testPersonalData.getNationality()).isEqualTo(UPDATED_NATIONALITY);

        // Validate the PersonalData in Elasticsearch
        verify(mockPersonalDataSearchRepository, times(1)).save(testPersonalData);
    }

    @Test
    @Transactional
    public void updateNonExistingPersonalData() throws Exception {
        int databaseSizeBeforeUpdate = personalDataRepository.findAll().size();

        // Create the PersonalData
        PersonalDataDTO personalDataDTO = personalDataMapper.toDto(personalData);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restPersonalDataMockMvc.perform(put("/api/personal-data")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personalDataDTO)))
            .andExpect(status().isBadRequest());

        // Validate the PersonalData in the database
        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeUpdate);

        // Validate the PersonalData in Elasticsearch
        verify(mockPersonalDataSearchRepository, times(0)).save(personalData);
    }

    @Test
    @Transactional
    public void deletePersonalData() throws Exception {
        // Initialize the database
        personalDataRepository.saveAndFlush(personalData);

        int databaseSizeBeforeDelete = personalDataRepository.findAll().size();

        // Get the personalData
        restPersonalDataMockMvc.perform(delete("/api/personal-data/{id}", personalData.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<PersonalData> personalDataList = personalDataRepository.findAll();
        assertThat(personalDataList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the PersonalData in Elasticsearch
        verify(mockPersonalDataSearchRepository, times(1)).deleteById(personalData.getId());
    }

    @Test
    @Transactional
    public void searchPersonalData() throws Exception {
        // Initialize the database
        personalDataRepository.saveAndFlush(personalData);
        when(mockPersonalDataSearchRepository.search(queryStringQuery("id:" + personalData.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(personalData), PageRequest.of(0, 1), 1));
        // Search the personalData
        restPersonalDataMockMvc.perform(get("/api/_search/personal-data?query=id:" + personalData.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(personalData.getId().intValue())))
            .andExpect(jsonPath("$.[*].firstName").value(hasItem(DEFAULT_FIRST_NAME.toString())))
            .andExpect(jsonPath("$.[*].lastName").value(hasItem(DEFAULT_LAST_NAME.toString())))
            .andExpect(jsonPath("$.[*].birthDate").value(hasItem(sameInstant(DEFAULT_BIRTH_DATE))))
            .andExpect(jsonPath("$.[*].nationality").value(hasItem(DEFAULT_NATIONALITY.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(PersonalData.class);
        PersonalData personalData1 = new PersonalData();
        personalData1.setId(1L);
        PersonalData personalData2 = new PersonalData();
        personalData2.setId(personalData1.getId());
        assertThat(personalData1).isEqualTo(personalData2);
        personalData2.setId(2L);
        assertThat(personalData1).isNotEqualTo(personalData2);
        personalData1.setId(null);
        assertThat(personalData1).isNotEqualTo(personalData2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(PersonalDataDTO.class);
        PersonalDataDTO personalDataDTO1 = new PersonalDataDTO();
        personalDataDTO1.setId(1L);
        PersonalDataDTO personalDataDTO2 = new PersonalDataDTO();
        assertThat(personalDataDTO1).isNotEqualTo(personalDataDTO2);
        personalDataDTO2.setId(personalDataDTO1.getId());
        assertThat(personalDataDTO1).isEqualTo(personalDataDTO2);
        personalDataDTO2.setId(2L);
        assertThat(personalDataDTO1).isNotEqualTo(personalDataDTO2);
        personalDataDTO1.setId(null);
        assertThat(personalDataDTO1).isNotEqualTo(personalDataDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(personalDataMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(personalDataMapper.fromId(null)).isNull();
    }
}
