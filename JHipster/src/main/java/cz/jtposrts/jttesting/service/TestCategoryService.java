package cz.jtposrts.jttesting.service;

import cz.jtposrts.jttesting.service.dto.TestCategoryDTO;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Optional;

/**
 * Service Interface for managing TestCategory.
 */
public interface TestCategoryService {

    /**
     * Save a testCategory.
     *
     * @param testCategoryDTO the entity to save
     * @return the persisted entity
     */
    TestCategoryDTO save(TestCategoryDTO testCategoryDTO);

    /**
     * Get all the testCategories.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<TestCategoryDTO> findAll(Pageable pageable);


    /**
     * Get the "id" testCategory.
     *
     * @param id the id of the entity
     * @return the entity
     */
    Optional<TestCategoryDTO> findOne(Long id);

    /**
     * Delete the "id" testCategory.
     *
     * @param id the id of the entity
     */
    void delete(Long id);

    /**
     * Search for the testCategory corresponding to the query.
     *
     * @param query the query of the search
     * 
     * @param pageable the pagination information
     * @return the list of entities
     */
    Page<TestCategoryDTO> search(String query, Pageable pageable);
}
