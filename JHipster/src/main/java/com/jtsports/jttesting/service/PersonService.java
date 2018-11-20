package com.jtsports.jttesting.service;

import com.jtsports.jttesting.service.dto.PersonDTO;

import com.jtsports.jttesting.service.dto.PersonFullDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing Person.
 */
public interface PersonService {

    /**
     * Save a person.
     *
     * @param personDTO the entity to save
     * @return the persisted entity
     */
    PersonDTO save(PersonDTO personDTO);

    /**
     * Get all the people.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<PersonDTO> findAll(Pageable pageable);

    /**
     * Get all the people.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<PersonFullDTO> findAllFull(Pageable pageable);


    /**
     * Get the "id" person.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<PersonDTO> findOne(Long id);

    /**
     * Get the "id" person.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<PersonFullDTO> findOneFull(Long id);

    /**
     * Get the "userId" person.
     *
     * @param userId the userId of the entity
     * @return the entity
     */
    Optional<PersonDTO> findOneByUserId(Long userId);

    /**
     * Delete the "id" person.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the person corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<PersonDTO> search(String query, Pageable pageable);


    PersonFullDTO saveFull(PersonFullDTO personFullDTO);
}
