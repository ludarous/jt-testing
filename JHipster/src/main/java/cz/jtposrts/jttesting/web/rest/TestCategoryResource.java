package cz.jtposrts.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import cz.jtposrts.jttesting.service.TestCategoryService;
import cz.jtposrts.jttesting.web.rest.errors.BadRequestAlertException;
import cz.jtposrts.jttesting.web.rest.util.HeaderUtil;
import cz.jtposrts.jttesting.web.rest.util.PaginationUtil;
import cz.jtposrts.jttesting.service.dto.TestCategoryDTO;
import io.github.jhipster.web.util.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.net.URI;
import java.net.URISyntaxException;

import java.util.List;
import java.util.Optional;
import java.util.stream.StreamSupport;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * REST controller for managing TestCategory.
 */
@RestController
@RequestMapping("/api")
public class TestCategoryResource {

    private final Logger log = LoggerFactory.getLogger(TestCategoryResource.class);

    private static final String ENTITY_NAME = "testCategory";

    private final TestCategoryService testCategoryService;

    public TestCategoryResource(TestCategoryService testCategoryService) {
        this.testCategoryService = testCategoryService;
    }

    /**
     * POST  /test-categories : Create a new testCategory.
     *
     * @param testCategoryDTO the testCategoryDTO to create
     * @return the ResponseEntity with status 201 (Created) and with body the new testCategoryDTO, or with status 400 (Bad Request) if the testCategory has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/test-categories")
    @Timed
    public ResponseEntity<TestCategoryDTO> createTestCategory(@Valid @RequestBody TestCategoryDTO testCategoryDTO) throws URISyntaxException {
        log.debug("REST request to save TestCategory : {}", testCategoryDTO);
        if (testCategoryDTO.getId() != null) {
            throw new BadRequestAlertException("A new testCategory cannot already have an ID", ENTITY_NAME, "idexists");
        }
        TestCategoryDTO result = testCategoryService.save(testCategoryDTO);
        return ResponseEntity.created(new URI("/api/test-categories/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /test-categories : Updates an existing testCategory.
     *
     * @param testCategoryDTO the testCategoryDTO to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated testCategoryDTO,
     * or with status 400 (Bad Request) if the testCategoryDTO is not valid,
     * or with status 500 (Internal Server Error) if the testCategoryDTO couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/test-categories")
    @Timed
    public ResponseEntity<TestCategoryDTO> updateTestCategory(@Valid @RequestBody TestCategoryDTO testCategoryDTO) throws URISyntaxException {
        log.debug("REST request to update TestCategory : {}", testCategoryDTO);
        if (testCategoryDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        TestCategoryDTO result = testCategoryService.save(testCategoryDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, testCategoryDTO.getId().toString()))
            .body(result);
    }

    /**
     * GET  /test-categories : get all the testCategories.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of testCategories in body
     */
    @GetMapping("/test-categories")
    @Timed
    public ResponseEntity<List<TestCategoryDTO>> getAllTestCategories(Pageable pageable) {
        log.debug("REST request to get a page of TestCategories");
        Page<TestCategoryDTO> page = testCategoryService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/test-categories");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /test-categories/:id : get the "id" testCategory.
     *
     * @param id the id of the testCategoryDTO to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the testCategoryDTO, or with status 404 (Not Found)
     */
    @GetMapping("/test-categories/{id}")
    @Timed
    public ResponseEntity<TestCategoryDTO> getTestCategory(@PathVariable Long id) {
        log.debug("REST request to get TestCategory : {}", id);
        Optional<TestCategoryDTO> testCategoryDTO = testCategoryService.findOne(id);
        return ResponseUtil.wrapOrNotFound(testCategoryDTO);
    }

    /**
     * DELETE  /test-categories/:id : delete the "id" testCategory.
     *
     * @param id the id of the testCategoryDTO to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/test-categories/{id}")
    @Timed
    public ResponseEntity<Void> deleteTestCategory(@PathVariable Long id) {
        log.debug("REST request to delete TestCategory : {}", id);
        testCategoryService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }

    /**
     * SEARCH  /_search/test-categories?query=:query : search for the testCategory corresponding
     * to the query.
     *
     * @param query the query of the testCategory search
     * @param pageable the pagination information
     * @return the result of the search
     */
    @GetMapping("/_search/test-categories")
    @Timed
    public ResponseEntity<List<TestCategoryDTO>> searchTestCategories(@RequestParam String query, Pageable pageable) {
        log.debug("REST request to search for a page of TestCategories for query {}", query);
        Page<TestCategoryDTO> page = testCategoryService.search(query, pageable);
        HttpHeaders headers = PaginationUtil.generateSearchPaginationHttpHeaders(query, page, "/api/_search/test-categories");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

}
