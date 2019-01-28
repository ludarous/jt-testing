package com.jtsports.jttesting.web.rest;

import com.jtsports.jttesting.JtTestingApp;

import com.jtsports.jttesting.domain.PersonGroup;
import com.jtsports.jttesting.domain.Person;
import com.jtsports.jttesting.domain.Group;
import com.jtsports.jttesting.repository.PersonGroupRepository;
import com.jtsports.jttesting.repository.search.PersonGroupSearchRepository;
import com.jtsports.jttesting.service.PersonGroupService;
import com.jtsports.jttesting.service.dto.PersonGroupDTO;
import com.jtsports.jttesting.service.mapper.PersonGroupMapper;
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

import com.jtsports.jttesting.domain.enumeration.GroupAuthority;
/**
 * Test class for the PersonGroupResource REST controller.
 *
 * @see PersonGroupResource
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = JtTestingApp.class)
public class PersonGroupResourceIntTest {

    private static final GroupAuthority DEFAULT_GROUP_ROLE = GroupAuthority.ADMIN;
    private static final GroupAuthority UPDATED_GROUP_ROLE = GroupAuthority.MEMBER;

    @Autowired
    private PersonGroupRepository personGroupRepository;


    @Autowired
    private PersonGroupMapper personGroupMapper;
    

    @Autowired
    private PersonGroupService personGroupService;

    /**
     * This repository is mocked in the com.jtsports.jttesting.repository.search test package.
     *
     * @see com.jtsports.jttesting.repository.search.PersonGroupSearchRepositoryMockConfiguration
     */
    @Autowired
    private PersonGroupSearchRepository mockPersonGroupSearchRepository;

    @Autowired
    private MappingJackson2HttpMessageConverter jacksonMessageConverter;

    @Autowired
    private PageableHandlerMethodArgumentResolver pageableArgumentResolver;

    @Autowired
    private ExceptionTranslator exceptionTranslator;

    @Autowired
    private EntityManager em;

    private MockMvc restPersonGroupMockMvc;

    private PersonGroup personGroup;

    @Before
    public void setup() {
        MockitoAnnotations.initMocks(this);
        final PersonGroupResource personGroupResource = new PersonGroupResource(personGroupService);
        this.restPersonGroupMockMvc = MockMvcBuilders.standaloneSetup(personGroupResource)
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
    public static PersonGroup createEntity(EntityManager em) {
        PersonGroup personGroup = new PersonGroup()
            .groupRole(DEFAULT_GROUP_ROLE);
        // Add required entity
        Person person = PersonResourceIntTest.createEntity(em);
        em.persist(person);
        em.flush();
        personGroup.setPerson(person);
        // Add required entity
        Group group = GroupResourceIntTest.createEntity(em);
        em.persist(group);
        em.flush();
        personGroup.setGroup(group);
        return personGroup;
    }

    @Before
    public void initTest() {
        personGroup = createEntity(em);
    }

    @Test
    @Transactional
    public void createPersonGroup() throws Exception {
        int databaseSizeBeforeCreate = personGroupRepository.findAll().size();

        // Create the PersonGroup
        PersonGroupDTO personGroupDTO = personGroupMapper.toDto(personGroup);
        restPersonGroupMockMvc.perform(post("/api/person-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personGroupDTO)))
            .andExpect(status().isCreated());

        // Validate the PersonGroup in the database
        List<PersonGroup> personGroupList = personGroupRepository.findAll();
        assertThat(personGroupList).hasSize(databaseSizeBeforeCreate + 1);
        PersonGroup testPersonGroup = personGroupList.get(personGroupList.size() - 1);
        assertThat(testPersonGroup.getGroupRole()).isEqualTo(DEFAULT_GROUP_ROLE);

        // Validate the PersonGroup in Elasticsearch
        verify(mockPersonGroupSearchRepository, times(1)).save(testPersonGroup);
    }

    @Test
    @Transactional
    public void createPersonGroupWithExistingId() throws Exception {
        int databaseSizeBeforeCreate = personGroupRepository.findAll().size();

        // Create the PersonGroup with an existing ID
        personGroup.setId(1L);
        PersonGroupDTO personGroupDTO = personGroupMapper.toDto(personGroup);

        // An entity with an existing ID cannot be created, so this API call must fail
        restPersonGroupMockMvc.perform(post("/api/person-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personGroupDTO)))
            .andExpect(status().isBadRequest());

        // Validate the PersonGroup in the database
        List<PersonGroup> personGroupList = personGroupRepository.findAll();
        assertThat(personGroupList).hasSize(databaseSizeBeforeCreate);

        // Validate the PersonGroup in Elasticsearch
        verify(mockPersonGroupSearchRepository, times(0)).save(personGroup);
    }

    @Test
    @Transactional
    public void checkGroupRoleIsRequired() throws Exception {
        int databaseSizeBeforeTest = personGroupRepository.findAll().size();
        // set the field null
        personGroup.setGroupRole(null);

        // Create the PersonGroup, which fails.
        PersonGroupDTO personGroupDTO = personGroupMapper.toDto(personGroup);

        restPersonGroupMockMvc.perform(post("/api/person-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personGroupDTO)))
            .andExpect(status().isBadRequest());

        List<PersonGroup> personGroupList = personGroupRepository.findAll();
        assertThat(personGroupList).hasSize(databaseSizeBeforeTest);
    }

    @Test
    @Transactional
    public void getAllPersonGroups() throws Exception {
        // Initialize the database
        personGroupRepository.saveAndFlush(personGroup);

        // Get all the personGroupList
        restPersonGroupMockMvc.perform(get("/api/person-groups?sort=id,desc"))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(personGroup.getId().intValue())))
            .andExpect(jsonPath("$.[*].groupRole").value(hasItem(DEFAULT_GROUP_ROLE.toString())));
    }
    

    @Test
    @Transactional
    public void getPersonGroup() throws Exception {
        // Initialize the database
        personGroupRepository.saveAndFlush(personGroup);

        // Get the personGroup
        restPersonGroupMockMvc.perform(get("/api/person-groups/{id}", personGroup.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.id").value(personGroup.getId().intValue()))
            .andExpect(jsonPath("$.groupRole").value(DEFAULT_GROUP_ROLE.toString()));
    }
    @Test
    @Transactional
    public void getNonExistingPersonGroup() throws Exception {
        // Get the personGroup
        restPersonGroupMockMvc.perform(get("/api/person-groups/{id}", Long.MAX_VALUE))
            .andExpect(status().isNotFound());
    }

    @Test
    @Transactional
    public void updatePersonGroup() throws Exception {
        // Initialize the database
        personGroupRepository.saveAndFlush(personGroup);

        int databaseSizeBeforeUpdate = personGroupRepository.findAll().size();

        // Update the personGroup
        PersonGroup updatedPersonGroup = personGroupRepository.findById(personGroup.getId()).get();
        // Disconnect from session so that the updates on updatedPersonGroup are not directly saved in db
        em.detach(updatedPersonGroup);
        updatedPersonGroup
            .groupRole(UPDATED_GROUP_ROLE);
        PersonGroupDTO personGroupDTO = personGroupMapper.toDto(updatedPersonGroup);

        restPersonGroupMockMvc.perform(put("/api/person-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personGroupDTO)))
            .andExpect(status().isOk());

        // Validate the PersonGroup in the database
        List<PersonGroup> personGroupList = personGroupRepository.findAll();
        assertThat(personGroupList).hasSize(databaseSizeBeforeUpdate);
        PersonGroup testPersonGroup = personGroupList.get(personGroupList.size() - 1);
        assertThat(testPersonGroup.getGroupRole()).isEqualTo(UPDATED_GROUP_ROLE);

        // Validate the PersonGroup in Elasticsearch
        verify(mockPersonGroupSearchRepository, times(1)).save(testPersonGroup);
    }

    @Test
    @Transactional
    public void updateNonExistingPersonGroup() throws Exception {
        int databaseSizeBeforeUpdate = personGroupRepository.findAll().size();

        // Create the PersonGroup
        PersonGroupDTO personGroupDTO = personGroupMapper.toDto(personGroup);

        // If the entity doesn't have an ID, it will be created instead of just being updated
        restPersonGroupMockMvc.perform(put("/api/person-groups")
            .contentType(TestUtil.APPLICATION_JSON_UTF8)
            .content(TestUtil.convertObjectToJsonBytes(personGroupDTO)))
            .andExpect(status().isBadRequest());

        // Validate the PersonGroup in the database
        List<PersonGroup> personGroupList = personGroupRepository.findAll();
        assertThat(personGroupList).hasSize(databaseSizeBeforeUpdate);

        // Validate the PersonGroup in Elasticsearch
        verify(mockPersonGroupSearchRepository, times(0)).save(personGroup);
    }

    @Test
    @Transactional
    public void deletePersonGroup() throws Exception {
        // Initialize the database
        personGroupRepository.saveAndFlush(personGroup);

        int databaseSizeBeforeDelete = personGroupRepository.findAll().size();

        // Get the personGroup
        restPersonGroupMockMvc.perform(delete("/api/person-groups/{id}", personGroup.getId())
            .accept(TestUtil.APPLICATION_JSON_UTF8))
            .andExpect(status().isOk());

        // Validate the database is empty
        List<PersonGroup> personGroupList = personGroupRepository.findAll();
        assertThat(personGroupList).hasSize(databaseSizeBeforeDelete - 1);

        // Validate the PersonGroup in Elasticsearch
        verify(mockPersonGroupSearchRepository, times(1)).deleteById(personGroup.getId());
    }

    @Test
    @Transactional
    public void searchPersonGroup() throws Exception {
        // Initialize the database
        personGroupRepository.saveAndFlush(personGroup);
        when(mockPersonGroupSearchRepository.search(queryStringQuery("id:" + personGroup.getId()), PageRequest.of(0, 20)))
            .thenReturn(new PageImpl<>(Collections.singletonList(personGroup), PageRequest.of(0, 1), 1));
        // Search the personGroup
        restPersonGroupMockMvc.perform(get("/api/_search/person-groups?query=id:" + personGroup.getId()))
            .andExpect(status().isOk())
            .andExpect(content().contentType(MediaType.APPLICATION_JSON_UTF8_VALUE))
            .andExpect(jsonPath("$.[*].id").value(hasItem(personGroup.getId().intValue())))
            .andExpect(jsonPath("$.[*].groupRole").value(hasItem(DEFAULT_GROUP_ROLE.toString())));
    }

    @Test
    @Transactional
    public void equalsVerifier() throws Exception {
        TestUtil.equalsVerifier(PersonGroup.class);
        PersonGroup personGroup1 = new PersonGroup();
        personGroup1.setId(1L);
        PersonGroup personGroup2 = new PersonGroup();
        personGroup2.setId(personGroup1.getId());
        assertThat(personGroup1).isEqualTo(personGroup2);
        personGroup2.setId(2L);
        assertThat(personGroup1).isNotEqualTo(personGroup2);
        personGroup1.setId(null);
        assertThat(personGroup1).isNotEqualTo(personGroup2);
    }

    @Test
    @Transactional
    public void dtoEqualsVerifier() throws Exception {
        TestUtil.equalsVerifier(PersonGroupDTO.class);
        PersonGroupDTO personGroupDTO1 = new PersonGroupDTO();
        personGroupDTO1.setId(1L);
        PersonGroupDTO personGroupDTO2 = new PersonGroupDTO();
        assertThat(personGroupDTO1).isNotEqualTo(personGroupDTO2);
        personGroupDTO2.setId(personGroupDTO1.getId());
        assertThat(personGroupDTO1).isEqualTo(personGroupDTO2);
        personGroupDTO2.setId(2L);
        assertThat(personGroupDTO1).isNotEqualTo(personGroupDTO2);
        personGroupDTO1.setId(null);
        assertThat(personGroupDTO1).isNotEqualTo(personGroupDTO2);
    }

    @Test
    @Transactional
    public void testEntityFromId() {
        assertThat(personGroupMapper.fromId(42L).getId()).isEqualTo(42);
        assertThat(personGroupMapper.fromId(null)).isNull();
    }
}
