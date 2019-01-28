package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.PersonGroupService;
import com.jtsports.jttesting.domain.PersonGroup;
import com.jtsports.jttesting.repository.PersonGroupRepository;
import com.jtsports.jttesting.repository.search.PersonGroupSearchRepository;
import com.jtsports.jttesting.service.dto.PersonGroupDTO;
import com.jtsports.jttesting.service.mapper.PersonGroupMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing PersonGroup.
 */
@Service
@Transactional
public class PersonGroupServiceImpl implements PersonGroupService {

    private final Logger log = LoggerFactory.getLogger(PersonGroupServiceImpl.class);

    private final PersonGroupRepository personGroupRepository;

    private final PersonGroupMapper personGroupMapper;

    private final PersonGroupSearchRepository personGroupSearchRepository;

    public PersonGroupServiceImpl(PersonGroupRepository personGroupRepository, PersonGroupMapper personGroupMapper, PersonGroupSearchRepository personGroupSearchRepository) {
        this.personGroupRepository = personGroupRepository;
        this.personGroupMapper = personGroupMapper;
        this.personGroupSearchRepository = personGroupSearchRepository;
    }

    /**
     * Save a personGroup.
     *
     * @param personGroupDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public PersonGroupDTO save(PersonGroupDTO personGroupDTO) {
        log.debug("Request to save PersonGroup : {}", personGroupDTO);
        PersonGroup personGroup = personGroupMapper.toEntity(personGroupDTO);
        personGroup = personGroupRepository.save(personGroup);
        PersonGroupDTO result = personGroupMapper.toDto(personGroup);
        personGroupSearchRepository.save(personGroup);
        return result;
    }

    /**
     * Get all the personGroups.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PersonGroupDTO> findAll(Pageable pageable) {
        log.debug("Request to get all PersonGroups");
        return personGroupRepository.findAll(pageable)
            .map(personGroupMapper::toDto);
    }


    /**
     * Get one personGroup by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<PersonGroupDTO> findOne(Long id) {
        log.debug("Request to get PersonGroup : {}", id);
        return personGroupRepository.findById(id)
            .map(personGroupMapper::toDto);
    }

    /**
     * Delete the personGroup by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete PersonGroup : {}", id);
        personGroupRepository.deleteById(id);
        personGroupSearchRepository.deleteById(id);
    }

    /**
     * Search for the personGroup corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PersonGroupDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of PersonGroups for query {}", query);
        return personGroupSearchRepository.search(queryStringQuery(query), pageable)
            .map(personGroupMapper::toDto);
    }
}
