package cz.jtposrts.jttesting.service.impl;

import cz.jtposrts.jttesting.service.TestCategoryService;
import cz.jtposrts.jttesting.domain.TestCategory;
import cz.jtposrts.jttesting.repository.TestCategoryRepository;
import cz.jtposrts.jttesting.repository.search.TestCategorySearchRepository;
import cz.jtposrts.jttesting.service.dto.TestCategoryDTO;
import cz.jtposrts.jttesting.service.mapper.TestCategoryMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing TestCategory.
 */
@Service
@Transactional
public class TestCategoryServiceImpl implements TestCategoryService {

    private final Logger log = LoggerFactory.getLogger(TestCategoryServiceImpl.class);

    private final TestCategoryRepository testCategoryRepository;

    private final TestCategoryMapper testCategoryMapper;

    private final TestCategorySearchRepository testCategorySearchRepository;

    public TestCategoryServiceImpl(TestCategoryRepository testCategoryRepository, TestCategoryMapper testCategoryMapper, TestCategorySearchRepository testCategorySearchRepository) {
        this.testCategoryRepository = testCategoryRepository;
        this.testCategoryMapper = testCategoryMapper;
        this.testCategorySearchRepository = testCategorySearchRepository;
    }

    /**
     * Save a testCategory.
     *
     * @param testCategoryDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public TestCategoryDTO save(TestCategoryDTO testCategoryDTO) {
        log.debug("Request to save TestCategory : {}", testCategoryDTO);

        TestCategory testCategory = testCategoryMapper.toEntity(testCategoryDTO);
        testCategory = testCategoryRepository.save(testCategory);
        TestCategoryDTO result = testCategoryMapper.toDto(testCategory);
        testCategorySearchRepository.save(testCategory);
        return result;
    }

    /**
     * Get all the testCategories.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<TestCategoryDTO> findAll(Pageable pageable) {
        log.debug("Request to get all TestCategories");
        return testCategoryRepository.findAll(pageable)
            .map(testCategoryMapper::toDto);
    }


    /**
     * Get one testCategory by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<TestCategoryDTO> findOne(Long id) {
        log.debug("Request to get TestCategory : {}", id);
        return testCategoryRepository.findById(id)
            .map(testCategoryMapper::toDto);
    }

    /**
     * Delete the testCategory by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete TestCategory : {}", id);
        testCategoryRepository.deleteById(id);
        testCategorySearchRepository.deleteById(id);
    }

    /**
     * Search for the testCategory corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<TestCategoryDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of TestCategories for query {}", query);
        return testCategorySearchRepository.search(queryStringQuery(query), pageable)
            .map(testCategoryMapper::toDto);
    }
}
