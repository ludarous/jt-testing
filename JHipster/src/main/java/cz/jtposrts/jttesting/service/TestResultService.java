package cz.jtposrts.jttesting.service;

import cz.jtposrts.jttesting.service.dto.TestResultDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing TestResult.
 */
public interface TestResultService {

    /**
     * Save a testResult.
     *
     * @param testResultDTO the entity to save
     * @return the persisted entity
     */
    TestResultDTO save(TestResultDTO testResultDTO);

    /**
     * Get all the testResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<TestResultDTO> findAll(Pageable pageable);


    /**
     * Get the "id" testResult.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<TestResultDTO> findOne(Long id);

    /**
     * Delete the "id" testResult.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the testResult corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<TestResultDTO> search(String query, Pageable pageable);
}
