package com.jtsports.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.jtsports.jttesting.service.WorkoutResultService;
import com.jtsports.jttesting.web.rest.errors.BadRequestAlertException;
import com.jtsports.jttesting.web.rest.util.HeaderUtil;
import com.jtsports.jttesting.web.rest.util.PaginationUtil;
import com.jtsports.jttesting.service.dto.WorkoutResultDTO;
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
 * REST controller for managing WorkoutResult.
 */
@RestController
@RequestMapping("/api")
public class WorkoutResultResource {

    private final Logger log = LoggerFactory.getLogger(WorkoutResultResource.class);

    private static final String ENTITY_NAME = "workoutResult";

    private final WorkoutResultService workoutResultService;

    public WorkoutResultResource(WorkoutResultService workoutResultService) {
        this.workoutResultService = workoutResultService;
    }

    /**
     * POST  /activity-group-results : Create a new workoutResult.
     *
     * @param workoutResultDTO the workoutResultDTO to create
     * @return the ResponseEntity with status 201 (Created) and with body the new workoutResultDTO, or with status 400 (Bad Request) if the workoutResult has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/activity-group-results")
    @Timed
    public ResponseEntity<WorkoutResultDTO> createWorkoutResult(@Valid @RequestBody WorkoutResultDTO workoutResultDTO) throws URISyntaxException {
        log.debug("REST request to save WorkoutResult : {}", workoutResultDTO);
        if (workoutResultDTO.getId() != null) {
            throw new BadRequestAlertException("A new workoutResult cannot already have an ID", ENTITY_NAME, "idexists");
        }
        WorkoutResultDTO result = workoutResultService.save(workoutResultDTO);
        return ResponseEntity.created(new URI("/api/activity-group-results/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /activity-group-results : Updates an existing workoutResult.
     *
     * @param workoutResultDTO the workoutResultDTO to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated workoutResultDTO,
     * or with status 400 (Bad Request) if the workoutResultDTO is not valid,
     * or with status 500 (Internal Server Error) if the workoutResultDTO couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/activity-group-results")
    @Timed
    public ResponseEntity<WorkoutResultDTO> updateWorkoutResult(@Valid @RequestBody WorkoutResultDTO workoutResultDTO) throws URISyntaxException {
        log.debug("REST request to update WorkoutResult : {}", workoutResultDTO);
        if (workoutResultDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        WorkoutResultDTO result = workoutResultService.save(workoutResultDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, workoutResultDTO.getId().toString()))
            .body(result);
    }

    /**
     * GET  /activity-group-results : get all the workoutResults.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of workoutResults in body
     */
    @GetMapping("/activity-group-results")
    @Timed
    public ResponseEntity<List<WorkoutResultDTO>> getAllWorkoutResults(Pageable pageable) {
        log.debug("REST request to get a page of WorkoutResults");
        Page<WorkoutResultDTO> page = workoutResultService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/activity-group-results");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /activity-group-results/:id : get the "id" workoutResult.
     *
     * @param id the id of the workoutResultDTO to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the workoutResultDTO, or with status 404 (Not Found)
     */
    @GetMapping("/activity-group-results/{id}")
    @Timed
    public ResponseEntity<WorkoutResultDTO> getWorkoutResult(@PathVariable Long id) {
        log.debug("REST request to get WorkoutResult : {}", id);
        Optional<WorkoutResultDTO> workoutResultDTO = workoutResultService.findOne(id);
        return ResponseUtil.wrapOrNotFound(workoutResultDTO);
    }

    /**
     * DELETE  /activity-group-results/:id : delete the "id" workoutResult.
     *
     * @param id the id of the workoutResultDTO to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/activity-group-results/{id}")
    @Timed
    public ResponseEntity<Void> deleteWorkoutResult(@PathVariable Long id) {
        log.debug("REST request to delete WorkoutResult : {}", id);
        workoutResultService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }

    /**
     * SEARCH  /_search/activity-group-results?query=:query : search for the workoutResult corresponding
     * to the query.
     *
     * @param query the query of the workoutResult search
     * @param pageable the pagination information
     * @return the result of the search
     */
    @GetMapping("/_search/activity-group-results")
    @Timed
    public ResponseEntity<List<WorkoutResultDTO>> searchWorkoutResults(@RequestParam String query, Pageable pageable) {
        log.debug("REST request to search for a page of WorkoutResults for query {}", query);
        Page<WorkoutResultDTO> page = workoutResultService.search(query, pageable);
        HttpHeaders headers = PaginationUtil.generateSearchPaginationHttpHeaders(query, page, "/api/_search/activity-group-results");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

}
