package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.Group;
import com.jtsports.jttesting.repository.GroupRepository;
import com.jtsports.jttesting.repository.search.GroupSearchRepository;
import com.jtsports.jttesting.service.GroupService;
import com.jtsports.jttesting.service.dto.GroupDTO;
import com.jtsports.jttesting.service.mapper.GroupMapper;
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
 * Test class for the GroupResource REST controller.
 *
 * @see GroupResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class GroupResourceIntTest {

    private static final String DEFAULT_NAME = "AAAAAAAAAA";
    private static final String UPDATED_NAME = "BBBBBBBBBB";

    @Autowired
    private GroupRepository groupRepository;


    @Autowired
    private GroupMapper groupMapper;
    

    @Autowired
    private GroupService groupService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.GroupSearchRepositoryMockConfiguration
     */
    @Autowired
    private GroupSearchRepository mockGroupSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restGroupMockMvc;

    private Group group;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final GroupResource groupResource = new GroupResource(groupService);
        this.restGroupMockMvc = MockMvcBuilders.standaloneSetup(groupResource)
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
    public static Group createEntity(EntityManager em) {
        Group group = new Group()
            .name(DEFAULT_NAME);
        return group;
    }

    @Before
    public void initTest() {
        group = createEntity(em);
    }

    @Test
    @Transactional
    public void createGroup() throws Exception {
        int databaseSizeBeforeCreate = groupRepository.findAll().size();

        // Create the Group
        GroupDTO groupDTO = groupMapper.toDto(group);
        restGroupMockMvc.perform(post("/api/groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(groupDTO)))
            .andExpect(status().isCreated());

        // Validate the Group in the database
        List<Group> groupList = groupRepository.findAll();
        assertThat(groupList).hasSize(databaseSizeBeforeCreate + 1);
        Group testGroup = groupList.get(groupList.size() - 1);
        assertThat(testGroup.getName()).isEqualTo(DEFAULT_NAME);

        // Validate the Group in Elasticsearch
        verify(mockGroupSearchRepository, times(1)).save(testGroup);
    }

    @Test
    @Transactional
    public void createGroupWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = groupRepository.findAll().size();

        // Create the Group with an existing ID
        group.setId(1L);
        GroupDTO groupDTO = groupMapper.toDto(group);

        // An entity with an existing ID cannot be created, so this API call must fail
        restGroupMockMvc.perform(post("/api/groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(groupDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Group in the database
        List<Group> groupList = groupRepository.findAll();
        assertThat(groupList).hasSize(databaseSizeBeforeCreate);

        // Validate the Group in Elasticsearch
        verify(mockGroupSearchRepository, times(0)).save(group);
    }

    @Test
    @Transactional
    public void checkNameIsRequired() throws Exception {
        int databaseSizeBeforeTest = groupRepository.findAll().size();
        // set the field null
        group.setName(null);

        // Create the Group, which fails.
        GroupDTO groupDTO = groupMapper.toDto(group);

        restGroupMockMvc.perform(post("/api/groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(groupDTO)))
            .andExpect(status().isBadRequest());

        List<Group> groupList = groupRepository.findAll();
        assertThat(groupList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllGroups() throws Exception {
        // Initialize the database
        groupRepository.saveAndFlush(group);

        // Get all the groupList
        restGroupMockMvc.perform(get("/api/groups?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(group.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())));
    }
    

    @Test
    @Transactional
    public void getGroup() throws Exception {
        // Initialize the database
        groupRepository.saveAndFlush(group);

        // Get the group
        restGroupMockMvc.perform(get("/api/groups/{id}", group.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(group.getId().intValue()))
            .andExpect(jsonPath("$.name").value(DEFAULT_NAME.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingGroup() throws Exception {
        // Get the group
        restGroupMockMvc.perform(get("/api/groups/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updateGroup() throws Exception {
        // Initialize the database
        groupRepository.saveAndFlush(group);

        int databaseSizeBeforeUpdate = groupRepository.findAll().size();

        // Update the group
        Group updatedGroup = groupRepository.findById(group.getId()).get();
        // Disconnect from session so that the updates on updatedGroup are not directly saved in db
        em.detach(updatedGroup);
        updatedGroup
            .name(UPDATED_NAME);
        GroupDTO groupDTO = groupMapper.toDto(updatedGroup);

        restGroupMockMvc.perform(put("/api/groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(groupDTO)))
            .andExpect(status().isOk());

        // Validate the Group in the database
        List<Group> groupList = groupRepository.findAll();
        assertThat(groupList).hasSize(databaseSizeBeforeUpdate);
        Group testGroup = groupList.get(groupList.size() - 1);
        assertThat(testGroup.getName()).isEqualTo(UPDATED_NAME);

        // Validate the Group in Elasticsearch
        verify(mockGroupSearchRepository, times(1)).save(testGroup);
    }

    @Test
    @Transactional
    public void updateNonExistingGroup() throws Exception {
        int databaseSizeBeforeUpdate = groupRepository.findAll().size();

        // Create the Group
        GroupDTO groupDTO = groupMapper.toDto(group);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restGroupMockMvc.perform(put("/api/groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(groupDTO)))
            .andExpect(status().isBadRequest());

        // Validate the Group in the database
        List<Group> groupList = groupRepository.findAll();
        assertThat(groupList).hasSize(databaseSizeBeforeUpdate);

        // Validate the Group in Elasticsearch
        verify(mockGroupSearchRepository, times(0)).save(group);
    }

    @Test
    @Transactional
    public void deleteGroup() throws Exception {
        // Initialize the database
        groupRepository.saveAndFlush(group);

        int databaseSizeBeforeDelete = groupRepository.findAll().size();

        // Get the group
        restGroupMockMvc.perform(delete("/api/groups/{id}", group.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<Group> groupList = groupRepository.findAll();
        assertThat(groupList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the Group in Elasticsearch
        verify(mockGroupSearchRepository, times(1)).deleteById(group.getId());
    }

    @Test
    @Transactional
    public void searchGroup() throws Exception {
        // Initialize the database
        groupRepository.saveAndFlush(group);
        when(mockGroupSearchRepository.search(queryStringQuery("id:" + group.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(group), PageRequest.of(0, 1), 1));
        // Search the group
        restGroupMockMvc.perform(get("/api/_search/groups?query=id:" + group.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(group.getId().intValue())))
            .andExpect(jsonPath("$.[*].name").value(hasItem(DEFAULT_NAME.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(Group.class);
        Group group1 = new Group();
        group1.setId(1L);
        Group group2 = new Group();
        group2.setId(group1.getId());
        assertThat(group1).isEqualTo(group2);
        group2.setId(2L);
        assertThat(group1).isNotEqualTo(group2);
        group1.setId(null);
        assertThat(group1).isNotEqualTo(group2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(GroupDTO.class);
        GroupDTO groupDTO1 = new GroupDTO();
        groupDTO1.setId(1L);
        GroupDTO groupDTO2 = new GroupDTO();
        assertThat(groupDTO1).isNotEqualTo(groupDTO2);
        groupDTO2.setId(groupDTO1.getId());
        assertThat(groupDTO1).isEqualTo(groupDTO2);
        groupDTO2.setId(2L);
        assertThat(groupDTO1).isNotEqualTo(groupDTO2);
        groupDTO1.setId(null);
        assertThat(groupDTO1).isNotEqualTo(groupDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(groupMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(groupMapper.fromId(null)).isNull();
    }
}
