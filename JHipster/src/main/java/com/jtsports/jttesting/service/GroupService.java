package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.GroupDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing Group.
 */
public interface GroupService {

    /**
     * Save a group.
     *
     * @param groupDTO the entity to save
     * @return the persisted entity
     */
    GroupDTO save(GroupDTO groupDTO);

    /**
     * Get all the groups.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<GroupDTO> findAll(Pageable pageable);


    /**
     * Get the "id" group.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<GroupDTO> findOne(Long id);

    /**
     * Delete the "id" group.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the group corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<GroupDTO> search(String query, Pageable pageable);
}
