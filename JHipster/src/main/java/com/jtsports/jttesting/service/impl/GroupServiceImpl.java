package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.GroupService;
import com.jtsports.jttesting.domain.Group;
import com.jtsports.jttesting.repository.GroupRepository;
import com.jtsports.jttesting.repository.search.GroupSearchRepository;
import com.jtsports.jttesting.service.dto.GroupDTO;
import com.jtsports.jttesting.service.mapper.GroupMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing Group.
 */
@Service
@Transactional
public class GroupServiceImpl implements GroupService {

    private final Logger log = LoggerFactory.getLogger(GroupServiceImpl.class);

    private final GroupRepository groupRepository;

    private final GroupMapper groupMapper;

    private final GroupSearchRepository groupSearchRepository;

    public GroupServiceImpl(GroupRepository groupRepository, GroupMapper groupMapper, GroupSearchRepository groupSearchRepository) {
        this.groupRepository = groupRepository;
        this.groupMapper = groupMapper;
        this.groupSearchRepository = groupSearchRepository;
    }

    /**
     * Save a group.
     *
     * @param groupDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public GroupDTO save(GroupDTO groupDTO) {
        log.debug("Request to save Group : {}", groupDTO);
        Group group = groupMapper.toEntity(groupDTO);
        group = groupRepository.save(group);
        GroupDTO result = groupMapper.toDto(group);
        groupSearchRepository.save(group);
        return result;
    }

    /**
     * Get all the groups.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<GroupDTO> findAll(Pageable pageable) {
        log.debug("Request to get all Groups");
        return groupRepository.findAll(pageable)
            .map(groupMapper::toDto);
    }


    /**
     * Get one group by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<GroupDTO> findOne(Long id) {
        log.debug("Request to get Group : {}", id);
        return groupRepository.findById(id)
            .map(groupMapper::toDto);
    }

    /**
     * Delete the group by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete Group : {}", id);
        groupRepository.deleteById(id);
        groupSearchRepository.deleteById(id);
    }

    /**
     * Search for the group corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<GroupDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of Groups for query {}", query);
        return groupSearchRepository.search(queryStringQuery(query), pageable)
            .map(groupMapper::toDto);
    }
}
