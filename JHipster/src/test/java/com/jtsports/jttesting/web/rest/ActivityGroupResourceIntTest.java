package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.ActivityGroup;
import com.jtsports.jttesting.repository.ActivityGroupRepository;
import com.jtsports.jttesting.repository.search.ActivityGroupSearchRepository;
import com.jtsports.jttesting.service.ActivityGroupService;
import com.jtsports.jttesting.service.dto.ActivityGroupDTO;
import com.jtsports.jttesting.service.mapper.ActivityGroupMapper;
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
 * Test class for the ActivityGroupResource REST controller.
 *
 * @see ActivityGroupResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class ActivityGroupResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    private static final String DEFAULT_DESCRIPTION = "AAAAAAAAAA";
    private static final String UPDATED_DESCRIPTION = "BBBBBBBBBB";

    private static final Integer DEFAULT_MIN_AGE = 1;
    private static final Integer UPDATED_MIN_AGE = 2;

    private static final Integer DEFAULT_MAX_AGE = 1;
    private static final Integer UPDATED_MAX_AGE = 2;

    @Autowired
    private ActivityGroupRepository activityGroupRepository;
    @Mock
    private ActivityGroupRepository activityGroupRepositoryMock;

    @Autowired
    private ActivityGroupMapper activityGroupMapper;
    
    @Mock
    private ActivityGroupService activityGroupServiceMock;

    @Autowired
    private ActivityGroupService activityGroupService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.ActivityGroupSearchRepositoryMockConfiguration
     */
    @Autowired
    private ActivityGroupSearchRepository mockActivityGroupSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restActivityGroupMockMvc;

    private ActivityGroup activityGroup;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final ActivityGroupResource activityGroupResource = new ActivityGroupResource(activityGroupService);
        this.restActivityGroupMockMvc = MockMvcBuilders.standaloneSetup(activityGroupResource)
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
    public static ActivityGroup createEntity(EntityManager em) {
        ActivityGroup activityGroup = new ActivityGroup()
            .name(DEFAULT_NAME)
            .description(DEFAULT_DESCRIPTION)
            .minAge(DEFAULT_MIN_AGE)
            .maxAge(DEFAULT_MAX_AGE);
        return activityGroup;
    }

    @Before
    public void initTest() {
        activityGroup = createEntity(em);
    }

    @Test
    @Transactional
    public void createActivityGroup() throws Exception {
        int databaseSizeBeforeCreate = activityGroupRepository.findAll().size();

        // Create the ActivityGroup
        ActivityGroupDTO activityGroupDTO = activityGroupMapper.toDto(activityGroup);
        restActivityGroupMockMvc.perform(post("/api/activity-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupDTO)))
            .andExpect(status().isCreated());

        // Validate the ActivityGroup in the database
        List<ActivityGroup> activityGroupList = activityGroupRepository.findAll();
        assertThat(activityGroupList).hasSize(databaseSizeBeforeCreate + 1);
        ActivityGroup testActivityGroup = activityGroupList.get(activityGroupList.size() - 1);
        assertThat(testActivityGroup.getName()).isEqualTo(DEFAULT_NAME);
        assertThat(testActivityGroup.getDescription()).isEqualTo(DEFAULT_DESCRIPTION);
        assertThat(testActivityGroup.getMinAge()).isEqualTo(DEFAULT_MIN_AGE);
        assertThat(testActivityGroup.getMaxAge()).isEqualTo(DEFAULT_MAX_AGE);

        // Validate the ActivityGroup in Elasticsearch
        verify(mockActivityGroupSearchRepository, times(1)).save(testActivityGroup);
    }

    @Test
    @Transactional
    public void createActivityGroupWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = activityGroupRepository.findAll().size();

        // Create the ActivityGroup with an existing ID
        activityGroup.setId(1L);
        ActivityGroupDTO activityGroupDTO = activityGroupMapper.toDto(activityGroup);

        // An entity with an existing ID cannot be created, so this API call must fail
        restActivityGroupMockMvc.perform(post("/api/activity-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityGroup in the database
        List<ActivityGroup> activityGroupList = activityGroupRepository.findAll();
        assertThat(activityGroupList).hasSize(databaseSizeBeforeCreate);

        // Validate the ActivityGroup in Elasticsearch
        verify(mockActivityGroupSearchRepository, times(0)).save(activityGroup);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = activityGroupRepository.findAll().size();
        // set the field null
        activityGroup.setName(null);

        // Create the ActivityGroup, which fails.
        ActivityGroupDTO activityGroupDTO = activityGroupMapper.toDto(activityGroup);

        restActivityGroupMockMvc.perform(post("/api/activity-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupDTO)))
            .andExpect(status().isBadRequest());

        List<ActivityGroup> activityGroupList = activityGroupRepository.findAll();
        assertThat(activityGroupList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllActivityGroups() throws Exception {
        // Initialize the database
        activityGroupRepository.saveAndFlush(activityGroup);

        // Get all the activityGroupList
        restActivityGroupMockMvc.perform(get("/api/activity-groups?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityGroup.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)));
    }
    
    public void getAllActivityGroupsWithEagerRelationshipsIsEnabled() throws Exception {
        ActivityGroupResource activityGroupResource = new ActivityGroupResource(activityGroupServiceMock);
        when(activityGroupServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));

        MockMvc restActivityGroupMockMvc = MockMvcBuilders.standaloneSetup(activityGroupResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restActivityGroupMockMvc.perform(get("/api/activity-groups?eagerload=true"))
        .andExpect(status().isOk());

        verify(activityGroupServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    public void getAllActivityGroupsWithEagerRelationshipsIsNotEnabled() throws Exception {
        ActivityGroupResource activityGroupResource = new ActivityGroupResource(activityGroupServiceMock);
            when(activityGroupServiceMock.findAllWithEagerRelationships(any())).thenReturn(new PageImpl(new ArrayList<>()));
            MockMvc restActivityGroupMockMvc = MockMvcBuilders.standaloneSetup(activityGroupResource)
            .setCustomArgumentResolvers(pageableArgumentResolver)
            .setControllerAdvice(exceptionTranslator)
            .setConversionService(createFormattingConversionService())
            .setMessageConverters(jacksonMessageConverter).build();

        restActivityGroupMockMvc.perform(get("/api/activity-groups?eagerload=true"))
        .andExpect(status().isOk());

            verify(activityGroupServiceMock, times(1)).findAllWithEagerRelationships(any());
    }

    @Test
    @Transactional
    public void getActivityGroup() throws Exception {
        // Initialize the database
        activityGroupRepository.saveAndFlush(activityGroup);

        // Get the activityGroup
        restActivityGroupMockMvc.perform(get("/api/activity-groups/{id}", activityGroup.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(activityGroup.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()))
            .andExpect(jsonPath("$.description").value(DEFAULT_DESCRIPTION.toString()))
            .andExpect(jsonPath("$.minAge").value(DEFAULT_MIN_AGE))
            .andExpect(jsonPath("$.maxAge").value(DEFAULT_MAX_AGE));
    }
    @Test
    @Transactional
    public void getNonExistingActivityGroup() throws Exception {
        // Get the activityGroup
        restActivityGroupMockMvc.perform(get("/api/activity-groups/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateActivityGroup() throws Exception {
        // Initialize the database
        activityGroupRepository.saveAndFlush(activityGroup);

        int databaseSizeBeforeUpdate = activityGroupRepository.findAll().size();

        // Update the activityGroup
        ActivityGroup updatedActivityGroup = activityGroupRepository.findById(activityGroup.getId()).get();
        // Disconnect from session so that the updates on updatedActivityGroup are not directly saved in db
        em.detach(updatedActivityGroup);
        updatedActivityGroup
            .name(UPDATED_NAME)
            .description(UPDATED_DESCRIPTION)
            .minAge(UPDATED_MIN_AGE)
            .maxAge(UPDATED_MAX_AGE);
        ActivityGroupDTO activityGroupDTO = activityGroupMapper.toDto(updatedActivityGroup);

        restActivityGroupMockMvc.perform(put("/api/activity-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupDTO)))
            .andExpect(status().isOk());

        // Validate the ActivityGroup in the database
        List<ActivityGroup> activityGroupList = activityGroupRepository.findAll();
        assertThat(activityGroupList).hasSize(databaseSizeBeforeUpdate);
        ActivityGroup testActivityGroup = activityGroupList.get(activityGroupList.size() - 1);
        assertThat(testActivityGroup.getName()).isEqualTo(UPDATED_NAME);
        assertThat(testActivityGroup.getDescription()).isEqualTo(UPDATED_DESCRIPTION);
        assertThat(testActivityGroup.getMinAge()).isEqualTo(UPDATED_MIN_AGE);
        assertThat(testActivityGroup.getMaxAge()).isEqualTo(UPDATED_MAX_AGE);

        // Validate the ActivityGroup in Elasticsearch
        verify(mockActivityGroupSearchRepository, times(1)).save(testActivityGroup);
    }

    @Test
    @Transactional
    public void updateNonExistingActivityGroup() throws Exception {
        int databaseSizeBeforeUpdate = activityGroupRepository.findAll().size();

        // Create the ActivityGroup
        ActivityGroupDTO activityGroupDTO = activityGroupMapper.toDto(activityGroup);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restActivityGroupMockMvc.perform(put("/api/activity-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(activityGroupDTO)))
            .andExpect(status().isBadRequest());

        // Validate the ActivityGroup in the database
        List<ActivityGroup> activityGroupList = activityGroupRepository.findAll();
        assertThat(activityGroupList).hasSize(databaseSizeBeforeUpdate);

        // Validate the ActivityGroup in Elasticsearch
        verify(mockActivityGroupSearchRepository, times(0)).save(activityGroup);
    }

    @Test
    @Transactional
    public void deleteActivityGroup() throws Exception {
        // Initialize the database
        activityGroupRepository.saveAndFlush(activityGroup);

        int databaseSizeBeforeDelete = activityGroupRepository.findAll().size();

        // Get the activityGroup
        restActivityGroupMockMvc.perform(delete("/api/activity-groups/{id}", activityGroup.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<ActivityGroup> activityGroupList = activityGroupRepository.findAll();
        assertThat(activityGroupList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the ActivityGroup in Elasticsearch
        verify(mockActivityGroupSearchRepository, times(1)).deleteById(activityGroup.getId());
    }

    @Test
    @Transactional
    public void searchActivityGroup() throws Exception {
        // Initialize the database
        activityGroupRepository.saveAndFlush(activityGroup);
        when(mockActivityGroupSearchRepository.search(queryStringQuery("id:" + activityGroup.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(activityGroup), PageRequest.of(0, 1), 1));
        // Search the activityGroup
        restActivityGroupMockMvc.perform(get("/api/_search/activity-groups?query=id:" + activityGroup.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(activityGroup.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())))
            .andExpect(jsonPath("$.[*].description").value(hasItem(DEFAULT_DESCRIPTION.toString())))
            .andExpect(jsonPath("$.[*].minAge").value(hasItem(DEFAULT_MIN_AGE)))
            .andExpect(jsonPath("$.[*].maxAge").value(hasItem(DEFAULT_MAX_AGE)));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityGroup.class);
        ActivityGroup activityGroup1 = new ActivityGroup();
        activityGroup1.setId(1L);
        ActivityGroup activityGroup2 = new ActivityGroup();
        activityGroup2.setId(activityGroup1.getId());
        assertThat(activityGroup1).isEqualTo(activityGroup2);
        activityGroup2.setId(2L);
        assertThat(activityGroup1).isNotEqualTo(activityGroup2);
        activityGroup1.setId(null);
        assertThat(activityGroup1).isNotEqualTo(activityGroup2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(ActivityGroupDTO.class);
        ActivityGroupDTO activityGroupDTO1 = new ActivityGroupDTO();
        activityGroupDTO1.setId(1L);
        ActivityGroupDTO activityGroupDTO2 = new ActivityGroupDTO();
        assertThat(activityGroupDTO1).isNotEqualTo(activityGroupDTO2);
        activityGroupDTO2.setId(activityGroupDTO1.getId());
        assertThat(activityGroupDTO1).isEqualTo(activityGroupDTO2);
        activityGroupDTO2.setId(2L);
        assertThat(activityGroupDTO1).isNotEqualTo(activityGroupDTO2);
        activityGroupDTO1.setId(null);
        assertThat(activityGroupDTO1).isNotEqualTo(activityGroupDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(activityGroupMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(activityGroupMapper.fromId(null)).isNull();
    }
}
