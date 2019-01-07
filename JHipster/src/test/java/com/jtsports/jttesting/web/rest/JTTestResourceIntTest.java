package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.JTTest;
import com.jtsports.jttesting.repository.JTTestRepository;
import com.jtsports.jttesting.repository.search.JTTestSearchRepository;
import com.jtsports.jttesting.service.JTTestService;
import com.jtsports.jttesting.service.PersonService;
import com.jtsports.jttesting.service.StatsService;
import com.jtsports.jttesting.service.UserService;
import com.jtsports.jttesting.service.dto.JTTestDTO;
import com.jtsports.jttesting.service.mapper.JTTestMapper;
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
 * Test class for the JTTestResource REST controller.
 *
 * @see JTTestResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class JTTestResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final Integer DEFAULT_MIN_AGE = 1;
    private static final Integer UPDATED_MIN_AGE = 2;

    private static final Integer DEFAULT_MAX_AGE = 1;
    private static final Integer UPDATED_MAX_AGE = 2;

    @Autowired
    private JTTestRepository jTTestRepository;
    @Mock
    private JTTestRepository jTTestRepositoryMock;

    @Autowired
    private JTTestMapper jTTestMapper;
    
    @Mock
    private JTTestService jTTestServiceMock;

    @Autowired
    private JTTestService jTTestService;

    @Autowired
    private UserService userService;

    @Autowired
    private PersonService personService;

    @Autowired
    private StatsService statsService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.JTTestSearchRepositoryMockConfiguration
     */
    @Autowired
    private JTTestSearchRepository mockJTTestSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restJTTestMockMvc;

    private JTTest jTTest;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final JTTestResource jTTestResource = new JTTestResource(jTTestService, userService, personService, statsService);
        this.restJTTestMockMvc = MockMvcBuilders.standaloneSetup(jTTestResource)
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
    public static JTTest createEntity(EntityManager em) {
        JTTest jTTest = new JTTest()
            .name(DEFAULT_NAME)
            .description(DEFAULT_DESCRIPTION)
            .minAge(DEFAULT_MIN_AGE)
            .maxAge(DEFAULT_MAX_AGE);
        return jTTest;
    }

    @Before
    public void initTest() {
        jTTest = createEntity(em);
    }

    @Test
    @Transactional
    public void createJTTest() throws Exception {
        int databaseSizeBeforeCreate = jTTestRepository.findAll().size();

        // Create the JTTest
        JTTestDTO jTTestDTO = jTTestMapper.toDto(jTTest);
        restJTTestMockMvc.perform(post("/api/jt-tests")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(jTTestDTO)))
            .andExpect(status().isCreated());

        // Validate the JTTest in the database
        List<JTTest> jTTestList = jTTestRepository.findAll();
        assertThat(jTTestList).hasSize(databaseSizeBeforeCreate + 1);
        JTTest testJTTest = jTTestList.get(jTTestList.size() - 1);
        assertThat(testJTTest.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testJTTest.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
        assertThat(testJTTest.getMinAge()).isEqualTo(DEFAULT_MIN_AGE);
        assertThat(testJTTest.getMaxAge()).isEqualTo(DEFAULT_MAX_AGE);

        // Validate the JTTest in Elasticsearch
        verify(mockJTTestSearchRepository, times(1)).save(testJTTest);
    }

    @Test
    @Transactional
    public void createJTTestWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = jTTestRepository.findAll().size();

        // Create the JTTest with an existing ID
        jTTest.setId(1L);
        JTTestDTO jTTestDTO = jTTestMapper.toDto(jTTest);

        // An entity with an existing ID cannot be created, so this API call must fail
        restJTTestMockMvc.perform(post("/api/jt-tests")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(jTTestDTO)))
            .andExpect(status().isBadRequest());

        // Validate the JTTest in the database
        List<JTTest> jTTestList = jTTestRepository.findAll();
        assertThat(jTTestList).hasSize(databaseSizeBeforeCreate);

        // Validate the JTTest in Elasticsearch
        verify(mockJTTestSearchRepository, times(0)).save(jTTest);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = jTTestRepository.findAll().size();
        // set the field null
        jTTest.setName(null);

        // Create the JTTest, which fails.
        JTTestDTO jTTestDTO = jTTestMapper.toDto(jTTest);

        restJTTestMockMvc.perform(post("/api/jt-tests")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(jTTestDTO)))
            .andExpect(status().isBadRequest());

        List<JTTest> jTTestList = jTTestRepository.findAll();
        assertThat(jTTestList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllJTTests() throws Exception {
        // Initialize the database
        jTTestRepository.saveAndFlush(jTTest);

        // Get all the jTTestList
        restJTTestMockMvc.perform(get("/api/jt-tests?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(jTTest.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)));
    }
    
    public void getAllJTTestsWithEagerRelationshipsIsEnabled() throws Exception {
        JTTestResource jTTestResource = new JTTestResource(jTTestServiceMock, userService, personService, statsService);
        when(jTTestServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        MockMvc restJTTestMockMvc = MockMvcBuilders.standaloneSetup(jTTestResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restJTTestMockMvc.perform(get("/api/jt-tests?eagerload=true"))
        .andExpect(status().isOk());

        verify(jTTestServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    public void getAllJTTestsWithEagerRelationshipsIsNotEnabled() throws Exception {
        JTTestResource jTTestResource = new JTTestResource(jTTestServiceMock, userService, personService, statsService);
            when(jTTestServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));
            MockMvc restJTTestMockMvc = MockMvcBuilders.standaloneSetup(jTTestResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restJTTestMockMvc.perform(get("/api/jt-tests?eagerload=true"))
        .andExpect(status().isOk());

            verify(jTTestServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    @Test
    @Transactional
    public void getJTTest() throws Exception {
        // Initialize the database
        jTTestRepository.saveAndFlush(jTTest);

        // Get the jTTest
        restJTTestMockMvc.perform(get("/api/jt-tests/{id}", jTTest.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(jTTest.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()))
            .andExpect(jsonPath("$.minAge").value(DEFAULT_MIN_AGE))
            .andExpect(jsonPath("$.maxAge").value(DEFAULT_MAX_AGE));
    }
    @Test
    @Transactional
    public void getNonExistingJTTest() throws Exception {
        // Get the jTTest
        restJTTestMockMvc.perform(get("/api/jt-tests/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateJTTest() throws Exception {
        // Initialize the database
        jTTestRepository.saveAndFlush(jTTest);

        int databaseSizeBeforeUpdate = jTTestRepository.findAll().size();

        // Update the jTTest
        JTTest updatedJTTest = jTTestRepository.findById(jTTest.getId()).get();
        // Disconnect from session so that the updates on updatedJTTest are not directly saved in db
        em.detach(updatedJTTest);
        updatedJTTest
            .name(UPDATED_NAME)
            .description(UPDATED_DESCRIPTION)
            .minAge(UPDATED_MIN_AGE)
            .maxAge(UPDATED_MAX_AGE);
        JTTestDTO jTTestDTO = jTTestMapper.toDto(updatedJTTest);

        restJTTestMockMvc.perform(put("/api/jt-tests")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(jTTestDTO)))
            .andExpect(status().isOk());

        // Validate the JTTest in the database
        List<JTTest> jTTestList = jTTestRepository.findAll();
        assertThat(jTTestList).hasSize(databaseSizeBeforeUpdate);
        JTTest testJTTest = jTTestList.get(jTTestList.size() - 1);
        assertThat(testJTTest.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testJTTest.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
        assertThat(testJTTest.getMinAge()).isEqualTo(UPDATED_MIN_AGE);
        assertThat(testJTTest.getMaxAge()).isEqualTo(UPDATED_MAX_AGE);

        // Validate the JTTest in Elasticsearch
        verify(mockJTTestSearchRepository, times(1)).save(testJTTest);
    }

    @Test
    @Transactional
    public void updateNonExistingJTTest() throws Exception {
        int databaseSizeBeforeUpdate = jTTestRepository.findAll().size();

        // Create the JTTest
        JTTestDTO jTTestDTO = jTTestMapper.toDto(jTTest);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restJTTestMockMvc.perform(put("/api/jt-tests")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(jTTestDTO)))
            .andExpect(status().isBadRequest());

        // Validate the JTTest in the database
        List<JTTest> jTTestList = jTTestRepository.findAll();
        assertThat(jTTestList).hasSize(databaseSizeBeforeUpdate);

        // Validate the JTTest in Elasticsearch
        verify(mockJTTestSearchRepository, times(0)).save(jTTest);
    }

    @Test
    @Transactional
    public void deleteJTTest() throws Exception {
        // Initialize the database
        jTTestRepository.saveAndFlush(jTTest);

        int databaseSizeBeforeDelete = jTTestRepository.findAll().size();

        // Get the jTTest
        restJTTestMockMvc.perform(delete("/api/jt-tests/{id}", jTTest.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<JTTest> jTTestList = jTTestRepository.findAll();
        assertThat(jTTestList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the JTTest in Elasticsearch
        verify(mockJTTestSearchRepository, times(1)).deleteById(jTTest.getId());
    }

    @Test
    @Transactional
    public void searchJTTest() throws Exception {
        // Initialize the database
        jTTestRepository.saveAndFlush(jTTest);
        when(mockJTTestSearchRepository.search(queryStringQuery("id:" + jTTest.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(jTTest), PageRequest.of(0, 1), 1));
        // Search the jTTest
        restJTTestMockMvc.perform(get("/api/_search/jt-tests?query=id:" + jTTest.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(jTTest.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(JTTest.class);
        JTTest jTTest1 = new JTTest();
        jTTest1.setId(1L);
        JTTest jTTest2 = new JTTest();
        jTTest2.setId(jTTest1.getId());
        assertThat(jTTest1).isEqualTo(jTTest2);
        jTTest2.setId(2L);
        assertThat(jTTest1).isNotEqualTo(jTTest2);
        jTTest1.setId(null);
        assertThat(jTTest1).isNotEqualTo(jTTest2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(JTTestDTO.class);
        JTTestDTO jTTestDTO1 = new JTTestDTO();
        jTTestDTO1.setId(1L);
        JTTestDTO jTTestDTO2 = new JTTestDTO();
        assertThat(jTTestDTO1).isNotEqualTo(jTTestDTO2);
        jTTestDTO2.setId(jTTestDTO1.getId());
        assertThat(jTTestDTO1).isEqualTo(jTTestDTO2);
        jTTestDTO2.setId(2L);
        assertThat(jTTestDTO1).isNotEqualTo(jTTestDTO2);
        jTTestDTO1.setId(null);
        assertThat(jTTestDTO1).isNotEqualTo(jTTestDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(jTTestMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(jTTestMapper.fromId(null)).isNull();
    }
}
