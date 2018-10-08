package cz.jtposrts.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import cz.jtposrts.jttesting.service.JTTestService;
import cz.jtposrts.jttesting.web.rest.errors.BadRequestAlertException;
import cz.jtposrts.jttesting.web.rest.util.HeaderUtil;
import cz.jtposrts.jttesting.web.rest.util.PaginationUtil;
import cz.jtposrts.jttesting.service.dto.JTTestDTO;
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
 * REST controller for managing JTTest.
 */
@RestController
@RequestMapping("/api")
public class JTTestResource {

    private final Logger log = LoggerFactory.getLogger(JTTestResource.class);

    private static final String ENTITY_NAME = "jTTest";

    private final JTTestService jTTestService;

    public JTTestResource(JTTestService jTTestService) {
        this.jTTestService = jTTestService;
    }

    /**
     * POST  /jt-tests : Create a new jTTest.
     *
     * @param jTTestDTO the jTTestDTO to create
     * @return the ResponseEntity with status 201 (Created) and with body the new jTTestDTO, or with status 400 (Bad Request) if the jTTest has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/jt-tests")
    @Timed
    public ResponseEntity<JTTestDTO> createJTTest(@Valid @RequestBody JTTestDTO jTTestDTO) throws URISyntaxException {
        log.debug("REST request to save JTTest : {}", jTTestDTO);
        if (jTTestDTO.getId() != null) {
            throw new BadRequestAlertException("A new jTTest cannot already have an ID", ENTITY_NAME, "idexists");
        }
        JTTestDTO result = jTTestService.save(jTTestDTO);
        return ResponseEntity.created(new URI("/api/jt-tests/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /jt-tests : Updates an existing jTTest.
     *
     * @param jTTestDTO the jTTestDTO to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated jTTestDTO,
     * or with status 400 (Bad Request) if the jTTestDTO is not valid,
     * or with status 500 (Internal Server Error) if the jTTestDTO couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/jt-tests")
    @Timed
    public ResponseEntity<JTTestDTO> updateJTTest(@Valid @RequestBody JTTestDTO jTTestDTO) throws URISyntaxException {
        log.debug("REST request to update JTTest : {}", jTTestDTO);
        if (jTTestDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        JTTestDTO result = jTTestService.save(jTTestDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, jTTestDTO.getId().toString()))
            .body(result);
    }

    /**
     * GET  /jt-tests : get all the jTTests.
     *
     * @param pageable the pagination information
     * @param eagerload flag to eager load entities from relationships (This is applicable for many-to-many)
     * @return the ResponseEntity with status 200 (OK) and the list of jTTests in body
     */
    @GetMapping("/jt-tests")
    @Timed
    public ResponseEntity<List<JTTestDTO>> getAllJTTests(Pageable pageable, @RequestParam(required = false, defaultValue = "false") boolean eagerload) {
        log.debug("REST request to get a page of JTTests");
        Page<JTTestDTO> page;
        if (eagerload) {
            page = jTTestService.findAllWithEagerRelationships(pageable);
        } else {
            page = jTTestService.findAll(pageable);
        }
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, String.format("/api/jt-tests?eagerload=%b", eagerload));
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /jt-tests/:id : get the "id" jTTest.
     *
     * @param id the id of the jTTestDTO to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the jTTestDTO, or with status 404 (Not Found)
     */
    @GetMapping("/jt-tests/{id}")
    @Timed
    public ResponseEntity<JTTestDTO> getJTTest(@PathVariable Long id) {
        log.debug("REST request to get JTTest : {}", id);
        Optional<JTTestDTO> jTTestDTO = jTTestService.findOne(id);
        return ResponseUtil.wrapOrNotFound(jTTestDTO);
    }

    /**
     * DELETE  /jt-tests/:id : delete the "id" jTTest.
     *
     * @param id the id of the jTTestDTO to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/jt-tests/{id}")
    @Timed
    public ResponseEntity<Void> deleteJTTest(@PathVariable Long id) {
        log.debug("REST request to delete JTTest : {}", id);
        jTTestService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }

    /**
     * SEARCH  /_search/jt-tests?query=:query : search for the jTTest corresponding
     * to the query.
     *
     * @param query the query of the jTTest search
     * @param pageable the pagination information
     * @return the result of the search
     */
    @GetMapping("/_search/jt-tests")
    @Timed
    public ResponseEntity<List<JTTestDTO>> searchJTTests(@RequestParam String query, Pageable pageable) {
        log.debug("REST request to search for a page of JTTests for query {}", query);
        Page<JTTestDTO> page = jTTestService.search(query, pageable);
        HttpHeaders headers = PaginationUtil.generateSearchPaginationHttpHeaders(query, page, "/api/_search/jt-tests");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

}
