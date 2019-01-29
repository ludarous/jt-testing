package com.jtsports.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.jtsports.jttesting.service.ActivityGroupResultService;
import com.jtsports.jttesting.web.rest.errors.BadRequestAlertException;
import com.jtsports.jttesting.web.rest.util.HeaderUtil;
import com.jtsports.jttesting.web.rest.util.PaginationUtil;
import com.jtsports.jttesting.service.dto.ActivityGroupResultDTO;
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
 * REST controller for managing ActivityGroupResult.
 */
@RestController
@RequestMapping("/api")
public class ActivityGroupResultResource {

    private final Logger log = LoggerFactory.getLogger(ActivityGroupResultResource.class);

    private static final String ENTITY_NAME = "activityGroupResult";

    private final ActivityGroupResultService activityGroupResultService;

    public ActivityGroupResultResource(ActivityGroupResultService activityGroupResultService) {
        this.activityGroupResultService = activityGroupResultService;
    }

    /**
     * POST  /activity-group-results : Create a new activityGroupResult.
     *
     * @param activityGroupResultDTO the activityGroupResultDTO to create
     * @return the ResponseEntity with status 201 (Created) and with body the new activityGroupResultDTO, or with status 400 (Bad Request) if the activityGroupResult has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/activity-group-results")
    @Timed
    public ResponseEntity<ActivityGroupResultDTO> createActivityGroupResult(@Valid @RequestBody ActivityGroupResultDTO activityGroupResultDTO) throws URISyntaxException {
        log.debug("REST request to save ActivityGroupResult : {}", activityGroupResultDTO);
        if (activityGroupResultDTO.getId() != null) {
            throw new BadRequestAlertException("A new activityGroupResult cannot already have an ID", ENTITY_NAME, "idexists");
        }
        ActivityGroupResultDTO result = activityGroupResultService.save(activityGroupResultDTO);
        return ResponseEntity.created(new URI("/api/activity-group-results/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /activity-group-results : Updates an existing activityGroupResult.
     *
     * @param activityGroupResultDTO the activityGroupResultDTO to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated activityGroupResultDTO,
     * or with status 400 (Bad Request) if the activityGroupResultDTO is not valid,
     * or with status 500 (Internal Server Error) if the activityGroupResultDTO couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/activity-group-results")
    @Timed
    public ResponseEntity<ActivityGroupResultDTO> updateActivityGroupResult(@Valid @RequestBody ActivityGroupResultDTO activityGroupResultDTO) throws URISyntaxException {
        log.debug("REST request to update ActivityGroupResult : {}", activityGroupResultDTO);
        if (activityGroupResultDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        ActivityGroupResultDTO result = activityGroupResultService.save(activityGroupResultDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, activityGroupResultDTO.getId().toString()))
            .body(result);
    }

    /**
     * GET  /activity-group-results : get all the activityGroupResults.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of activityGroupResults in body
     */
    @GetMapping("/activity-group-results")
    @Timed
    public ResponseEntity<List<ActivityGroupResultDTO>> getAllActivityGroupResults(Pageable pageable) {
        log.debug("REST request to get a page of ActivityGroupResults");
        Page<ActivityGroupResultDTO> page = activityGroupResultService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/activity-group-results");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /activity-group-results/:id : get the "id" activityGroupResult.
     *
     * @param id the id of the activityGroupResultDTO to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the activityGroupResultDTO, or with status 404 (Not Found)
     */
    @GetMapping("/activity-group-results/{id}")
    @Timed
    public ResponseEntity<ActivityGroupResultDTO> getActivityGroupResult(@PathVariable Long id) {
        log.debug("REST request to get ActivityGroupResult : {}", id);
        Optional<ActivityGroupResultDTO> activityGroupResultDTO = activityGroupResultService.findOne(id);
        return ResponseUtil.wrapOrNotFound(activityGroupResultDTO);
    }

    /**
     * DELETE  /activity-group-results/:id : delete the "id" activityGroupResult.
     *
     * @param id the id of the activityGroupResultDTO to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/activity-group-results/{id}")
    @Timed
    public ResponseEntity<Void> deleteActivityGroupResult(@PathVariable Long id) {
        log.debug("REST request to delete ActivityGroupResult : {}", id);
        activityGroupResultService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }

    /**
     * SEARCH  /_search/activity-group-results?query=:query : search for the activityGroupResult corresponding
     * to the query.
     *
     * @param query the query of the activityGroupResult search
     * @param pageable the pagination information
     * @return the result of the search
     */
    @GetMapping("/_search/activity-group-results")
    @Timed
    public ResponseEntity<List<ActivityGroupResultDTO>> searchActivityGroupResults(@RequestParam String query, Pageable pageable) {
        log.debug("REST request to search for a page of ActivityGroupResults for query {}", query);
        Page<ActivityGroupResultDTO> page = activityGroupResultService.search(query, pageable);
        HttpHeaders headers = PaginationUtil.generateSearchPaginationHttpHeaders(query, page, "/api/_search/activity-group-results");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

}
