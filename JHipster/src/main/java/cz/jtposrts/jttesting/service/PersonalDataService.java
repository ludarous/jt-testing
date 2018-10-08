package cz.jtposrts.jttesting.service;

import cz.jtposrts.jttesting.service.dto.PersonalDataDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing PersonalData.
 */
public interface PersonalDataService {

    /**
     * Save a personalData.
     *
     * @param personalDataDTO the entity to save
     * @return the persisted entity
     */
    PersonalDataDTO save(PersonalDataDTO personalDataDTO);

    /**
     * Get all the personalData.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<PersonalDataDTO> findAll(Pageable pageable);


    /**
     * Get the "id" personalData.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<PersonalDataDTO> findOne(Long id);

    /**
     * Delete the "id" personalData.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the personalData corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<PersonalDataDTO> search(String query, Pageable pageable);
}
