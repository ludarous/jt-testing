package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.service.TestResultService;
import com.jtsports.jttesting.domain.TestResult;
import com.jtsports.jttesting.repository.TestResultRepository;
import com.jtsports.jttesting.repository.search.TestResultSearchRepository;
import com.jtsports.jttesting.service.dto.TestResultDTO;
import com.jtsports.jttesting.service.mapper.TestResultMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing TestResult.
 */
@Service
@Transactional
public class TestResultServiceImpl implements TestResultService {

    private final Logger log = LoggerFactory.getLogger(TestResultServiceImpl.class);

    private final TestResultRepository testResultRepository;

    private final TestResultMapper testResultMapper;

    private final TestResultSearchRepository testResultSearchRepository;

    public TestResultServiceImpl(TestResultRepository testResultRepository, TestResultMapper testResultMapper, TestResultSearchRepository testResultSearchRepository) {
        this.testResultRepository = testResultRepository;
        this.testResultMapper = testResultMapper;
        this.testResultSearchRepository = testResultSearchRepository;
    }

    /**
     * Save a testResult.
     *
     * @param testResultDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public TestResultDTO save(TestResultDTO testResultDTO) {
        log.debug("Request to save TestResult : {}", testResultDTO);
        TestResult testResult = testResultMapper.toEntity(testResultDTO);
        testResult = testResultRepository.save(testResult);
        TestResultDTO result = testResultMapper.toDto(testResult);
        testResultSearchRepository.save(testResult);
        return result;
    }

    /**
     * Get all the testResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<TestResultDTO> findAll(Pageable pageable) {
        log.debug("Request to get all TestResults");
        return testResultRepository.findAll(pageable)
            .map(testResultMapper::toDto);
    }


    /**
     * Get one testResult by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<TestResultDTO> findOne(Long id) {
        log.debug("Request to get TestResult : {}", id);
        return testResultRepository.findById(id)
            .map(testResultMapper::toDto);
    }

    /**
     * Delete the testResult by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete TestResult : {}", id);
        testResultRepository.deleteById(id);
        testResultSearchRepository.deleteById(id);
    }

    /**
     * Search for the testResult corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<TestResultDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of TestResults for query {}", query);
        return testResultSearchRepository.search(queryStringQuery(query), pageable)
            .map(testResultMapper::toDto);
    }
}
