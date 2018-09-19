package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.TestCategory;
import com.jtsports.jttesting.repository.TestCategoryRepository;
import com.jtsports.jttesting.repository.search.TestCategorySearchRepository;
import com.jtsports.jttesting.service.TestCategoryService;
import com.jtsports.jttesting.service.dto.TestCategoryDTO;
import com.jtsports.jttesting.service.mapper.TestCategoryMapper;
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
 * Test class for the TestCategoryResource REST controller.
 *
 * @see TestCategoryResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class TestCategoryResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_KEY = "AAAAAAAAAA";
    private static final String UPDATED_KEY = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    @Autowired
    private TestCategoryRepository testCategoryRepository;


    @Autowired
    private TestCategoryMapper testCategoryMapper;
    

    @Autowired
    private TestCategoryService testCategoryService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.TestCategorySearchRepositoryMockConfiguration
     */
    @Autowired
    private TestCategorySearchRepository mockTestCategorySearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restTestCategoryMockMvc;

    private TestCategory testCategory;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final TestCategoryResource testCategoryResource = new TestCategoryResource(testCategoryService);
        this.restTestCategoryMockMvc = MockMvcBuilders.standaloneSetup(testCategoryResource)
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
    public static TestCategory createEntity(EntityManager em) {
        TestCategory testCategory = new TestCategory()
            .name(DEFAULT_NAME)
            .key(DEFAULT_KEY)
            .description(DEFAULT_DESCRIPTION);
        return testCategory;
    }

    @Before
    public void initTest() {
        testCategory = createEntity(em);
    }

    @Test
    @Transactional
    public void createTestCategory() throws Exception {
        int databaseSizeBeforeCreate = testCategoryRepository.findAll().size();

        // Create the TestCategory
        TestCategoryDTO testCategoryDTO = testCategoryMapper.toDto(testCategory);
        restTestCategoryMockMvc.perform(post("/api/test-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testCategoryDTO)))
            .andExpect(status().isCreated());

        // Validate the TestCategory in the database
        List<TestCategory> testCategoryList = testCategoryRepository.findAll();
        assertThat(testCategoryList).hasSize(databaseSizeBeforeCreate + 1);
        TestCategory testTestCategory = testCategoryList.get(testCategoryList.size() - 1);
        assertThat(testTestCategory.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testTestCategory.getKey()).isEqualTo(DEFAULT_KEY);
        assertThat(testTestCategory.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);

        // Validate the TestCategory in Elasticsearch
        verify(mockTestCategorySearchRepository, times(1)).save(testTestCategory);
    }

    @Test
    @Transactional
    public void createTestCategoryWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = testCategoryRepository.findAll().size();

        // Create the TestCategory with an existing ID
        testCategory.setId(1L);
        TestCategoryDTO testCategoryDTO = testCategoryMapper.toDto(testCategory);

        // An entity with an existing ID cannot be created, so this API call must fail
        restTestCategoryMockMvc.perform(post("/api/test-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the TestCategory in the database
        List<TestCategory> testCategoryList = testCategoryRepository.findAll();
        assertThat(testCategoryList).hasSize(databaseSizeBeforeCreate);

        // Validate the TestCategory in Elasticsearch
        verify(mockTestCategorySearchRepository, times(0)).save(testCategory);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = testCategoryRepository.findAll().size();
        // set the field null
        testCategory.setName(null);

        // Create the TestCategory, which fails.
        TestCategoryDTO testCategoryDTO = testCategoryMapper.toDto(testCategory);

        restTestCategoryMockMvc.perform(post("/api/test-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testCategoryDTO)))
            .andExpect(status().isBadRequest());

        List<TestCategory> testCategoryList = testCategoryRepository.findAll();
        assertThat(testCategoryList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllTestCategories() throws Exception {
        // Initialize the database
        testCategoryRepository.saveAndFlush(testCategory);

        // Get all the testCategoryList
        restTestCategoryMockMvc.perform(get("/api/test-categories?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(testCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }
    

    @Test
    @Transactional
    public void getTestCategory() throws Exception {
        // Initialize the database
        testCategoryRepository.saveAndFlush(testCategory);

        // Get the testCategory
        restTestCategoryMockMvc.perform(get("/api/test-categories/{id}", testCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(testCategory.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.key").value(DEFAULT_KEY.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingTestCategory() throws Exception {
        // Get the testCategory
        restTestCategoryMockMvc.perform(get("/api/test-categories/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateTestCategory() throws Exception {
        // Initialize the database
        testCategoryRepository.saveAndFlush(testCategory);

        int databaseSizeBeforeUpdate = testCategoryRepository.findAll().size();

        // Update the testCategory
        TestCategory updatedTestCategory = testCategoryRepository.findById(testCategory.getId()).get();
        // Disconnect from session so that the updates on updatedTestCategory are not directly saved in db
        em.detach(updatedTestCategory);
        updatedTestCategory
            .name(UPDATED_NAME)
            .key(UPDATED_KEY)
            .description(UPDATED_DESCRIPTION);
        TestCategoryDTO testCategoryDTO = testCategoryMapper.toDto(updatedTestCategory);

        restTestCategoryMockMvc.perform(put("/api/test-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testCategoryDTO)))
            .andExpect(status().isOk());

        // Validate the TestCategory in the database
        List<TestCategory> testCategoryList = testCategoryRepository.findAll();
        assertThat(testCategoryList).hasSize(databaseSizeBeforeUpdate);
        TestCategory testTestCategory = testCategoryList.get(testCategoryList.size() - 1);
        assertThat(testTestCategory.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testTestCategory.getKey()).isEqualTo(UPDATED_KEY);
        assertThat(testTestCategory.getDescription()).isEqualTo(UPDATED_DESCRIPTION);

        // Validate the TestCategory in Elasticsearch
        verify(mockTestCategorySearchRepository, times(1)).save(testTestCategory);
    }

    @Test
    @Transactional
    public void updateNonExistingTestCategory() throws Exception {
        int databaseSizeBeforeUpdate = testCategoryRepository.findAll().size();

        // Create the TestCategory
        TestCategoryDTO testCategoryDTO = testCategoryMapper.toDto(testCategory);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restTestCategoryMockMvc.perform(put("/api/test-categories")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(testCategoryDTO)))
            .andExpect(status().isBadRequest());

        // Validate the TestCategory in the database
        List<TestCategory> testCategoryList = testCategoryRepository.findAll();
        assertThat(testCategoryList).hasSize(databaseSizeBeforeUpdate);

        // Validate the TestCategory in Elasticsearch
        verify(mockTestCategorySearchRepository, times(0)).save(testCategory);
    }

    @Test
    @Transactional
    public void deleteTestCategory() throws Exception {
        // Initialize the database
        testCategoryRepository.saveAndFlush(testCategory);

        int databaseSizeBeforeDelete = testCategoryRepository.findAll().size();

        // Get the testCategory
        restTestCategoryMockMvc.perform(delete("/api/test-categories/{id}", testCategory.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<TestCategory> testCategoryList = testCategoryRepository.findAll();
        assertThat(testCategoryList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the TestCategory in Elasticsearch
        verify(mockTestCategorySearchRepository, times(1)).deleteById(testCategory.getId());
    }

    @Test
    @Transactional
    public void searchTestCategory() throws Exception {
        // Initialize the database
        testCategoryRepository.saveAndFlush(testCategory);
        when(mockTestCategorySearchRepository.search(queryStringQuery("id:" + testCategory.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(testCategory), PageRequest.of(0, 1), 1));
        // Search the testCategory
        restTestCategoryMockMvc.perform(get("/api/_search/test-categories?query=id:" + testCategory.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(testCategory.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].key").value(hasItem(DEFAULT_KEY.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(TestCategory.class);
        TestCategory testCategory1 = new TestCategory();
        testCategory1.setId(1L);
        TestCategory testCategory2 = new TestCategory();
        testCategory2.setId(testCategory1.getId());
        assertThat(testCategory1).isEqualTo(testCategory2);
        testCategory2.setId(2L);
        assertThat(testCategory1).isNotEqualTo(testCategory2);
        testCategory1.setId(null);
        assertThat(testCategory1).isNotEqualTo(testCategory2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(TestCategoryDTO.class);
        TestCategoryDTO testCategoryDTO1 = new TestCategoryDTO();
        testCategoryDTO1.setId(1L);
        TestCategoryDTO testCategoryDTO2 = new TestCategoryDTO();
        assertThat(testCategoryDTO1).isNotEqualTo(testCategoryDTO2);
        testCategoryDTO2.setId(testCategoryDTO1.getId());
        assertThat(testCategoryDTO1).isEqualTo(testCategoryDTO2);
        testCategoryDTO2.setId(2L);
        assertThat(testCategoryDTO1).isNotEqualTo(testCategoryDTO2);
        testCategoryDTO1.setId(null);
        assertThat(testCategoryDTO1).isNotEqualTo(testCategoryDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(testCategoryMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(testCategoryMapper.fromId(null)).isNull();
    }
}
