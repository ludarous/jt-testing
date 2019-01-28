package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.JTTestDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing JTTest.
 */
public interface JTTestService {

    /**
     * Save a jTTest.
     *
     * @param jTTestDTO the entity to save
     * @return the persisted entity
     */
    JTTestDTO save(JTTestDTO jTTestDTO);

    /**
     * Get all the jTTests.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<JTTestDTO> findAll(Pageable pageable);

    /**
     * Get all the JTTest with eager load of many-to-many relationships.
     *
     * @return the list of entities
     */
    Page<JTTestDTO> findAllWithEagerRelationships(Pageable pageable);
    
    /**
     * Get the "id" jTTest.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<JTTestDTO> findOne(Long id);

    /**
     * Delete the "id" jTTest.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the jTTest corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<JTTestDTO> search(String query, Pageable pageable);

}
