package com.jtsports.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.jtsports.jttesting.service.ActivityGroupService;
import com.jtsports.jttesting.web.rest.errors.BadRequestAlertException;
import com.jtsports.jttesting.web.rest.util.HeaderUtil;
import com.jtsports.jttesting.web.rest.util.PaginationUtil;
import com.jtsports.jttesting.service.dto.ActivityGroupDTO;
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
 * REST controller for managing ActivityGroup.
 */
@RestController
@RequestMapping("/api")
public class ActivityGroupResource {

    private final Logger log = LoggerFactory.getLogger(ActivityGroupResource.class);

    private static final String ENTITY_NAME = "activityGroup";

    private final ActivityGroupService activityGroupService;

    public ActivityGroupResource(ActivityGroupService activityGroupService) {
        this.activityGroupService = activityGroupService;
    }

    /**
     * POST  /activity-groups : Create a new activityGroup.
     *
     * @param activityGroupDTO the activityGroupDTO to create
     * @return the ResponseEntity with status 201 (Created) and with body the new activityGroupDTO, or with status 400 (Bad Request) if the activityGroup has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/activity-groups")
    @Timed
    public ResponseEntity<ActivityGroupDTO> createActivityGroup(@Valid @RequestBody ActivityGroupDTO activityGroupDTO) throws URISyntaxException {
        log.debug("REST request to save ActivityGroup : {}", activityGroupDTO);
        if (activityGroupDTO.getId() != null) {
            throw new BadRequestAlertException("A new activityGroup cannot already have an ID", ENTITY_NAME, "idexists");
        }
        ActivityGroupDTO result = activityGroupService.save(activityGroupDTO);
        return ResponseEntity.created(new URI("/api/activity-groups/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /activity-groups : Updates an existing activityGroup.
     *
     * @param activityGroupDTO the activityGroupDTO to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated activityGroupDTO,
     * or with status 400 (Bad Request) if the activityGroupDTO is not valid,
     * or with status 500 (Internal Server Error) if the activityGroupDTO couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/activity-groups")
    @Timed
    public ResponseEntity<ActivityGroupDTO> updateActivityGroup(@Valid @RequestBody ActivityGroupDTO activityGroupDTO) throws URISyntaxException {
        log.debug("REST request to update ActivityGroup : {}", activityGroupDTO);
        if (activityGroupDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        ActivityGroupDTO result = activityGroupService.save(activityGroupDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, activityGroupDTO.getId().toString()))
            .body(result);
    }

    /**
     * GET  /activity-groups : get all the activityGroups.
     *
     * @param pageable the pagination information
     * @param eagerload flag to eager load entities from relationships (This is applicable for many-to-many)
     * @return the ResponseEntity with status 200 (OK) and the list of activityGroups in body
     */
    @GetMapping("/activity-groups")
    @Timed
    public ResponseEntity<List<ActivityGroupDTO>> getAllActivityGroups(Pageable pageable, @RequestParam(required = false, defaultValue = "false") boolean eagerload) {
        log.debug("REST request to get a page of ActivityGroups");
        Page<ActivityGroupDTO> page;
        if (eagerload) {
            page = activityGroupService.findAllWithEagerRelationships(pageable);
        } else {
            page = activityGroupService.findAll(pageable);
        }
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, String.format("/api/activity-groups?eagerload=%b", eagerload));
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /activity-groups/:id : get the "id" activityGroup.
     *
     * @param id the id of the activityGroupDTO to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the activityGroupDTO, or with status 404 (Not Found)
     */
    @GetMapping("/activity-groups/{id}")
    @Timed
    public ResponseEntity<ActivityGroupDTO> getActivityGroup(@PathVariable Long id) {
        log.debug("REST request to get ActivityGroup : {}", id);
        Optional<ActivityGroupDTO> activityGroupDTO = activityGroupService.findOne(id);
        return ResponseUtil.wrapOrNotFound(activityGroupDTO);
    }

    /**
     * DELETE  /activity-groups/:id : delete the "id" activityGroup.
     *
     * @param id the id of the activityGroupDTO to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/activity-groups/{id}")
    @Timed
    public ResponseEntity<Void> deleteActivityGroup(@PathVariable Long id) {
        log.debug("REST request to delete ActivityGroup : {}", id);
        activityGroupService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }

    /**
     * SEARCH  /_search/activity-groups?query=:query : search for the activityGroup corresponding
     * to the query.
     *
     * @param query the query of the activityGroup search
     * @param pageable the pagination information
     * @return the result of the search
     */
    @GetMapping("/_search/activity-groups")
    @Timed
    public ResponseEntity<List<ActivityGroupDTO>> searchActivityGroups(@RequestParam String query, Pageable pageable) {
        log.debug("REST request to search for a page of ActivityGroups for query {}", query);
        Page<ActivityGroupDTO> page = activityGroupService.search(query, pageable);
        HttpHeaders headers = PaginationUtil.generateSearchPaginationHttpHeaders(query, page, "/api/_search/activity-groups");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

}
