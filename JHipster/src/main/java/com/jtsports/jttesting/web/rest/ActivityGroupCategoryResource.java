package com.jtsports.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.jtsports.jttesting.service.ActivityGroupCategoryService;
import com.jtsports.jttesting.web.rest.errors.BadRequestAlertException;
import com.jtsports.jttesting.web.rest.util.HeaderUtil;
import com.jtsports.jttesting.web.rest.util.PaginationUtil;
import com.jtsports.jttesting.service.dto.ActivityGroupCategoryDTO;
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
 * REST controller for managing ActivityGroupCategory.
 */
@RestController
@RequestMapping("/api")
public class ActivityGroupCategoryResource {

    private final Logger log = LoggerFactory.getLogger(ActivityGroupCategoryResource.class);

    private static final String ENTITY_NAME = "activityGroupCategory";

    private final ActivityGroupCategoryService activityGroupCategoryService;

    public ActivityGroupCategoryResource(ActivityGroupCategoryService activityGroupCategoryService) {
        this.activityGroupCategoryService = activityGroupCategoryService;
    }

    /**
     * POST  /activity-group-categories : Create a new activityGroupCategory.
     *
     * @param activityGroupCategoryDTO the activityGroupCategoryDTO to create
     * @return the ResponseEntity with status 201 (Created) and with body the new activityGroupCategoryDTO, or with status 400 (Bad Request) if the activityGroupCategory has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/activity-group-categories")
    @Timed
    public ResponseEntity<ActivityGroupCategoryDTO> createActivityGroupCategory(@Valid @RequestBody ActivityGroupCategoryDTO activityGroupCategoryDTO) throws URISyntaxException {
        log.debug("REST request to save ActivityGroupCategory : {}", activityGroupCategoryDTO);
        if (activityGroupCategoryDTO.getId() != null) {
            throw new BadRequestAlertException("A new activityGroupCategory cannot already have an ID", ENTITY_NAME, "idexists");
        }
        ActivityGroupCategoryDTO result = activityGroupCategoryService.save(activityGroupCategoryDTO);
        return ResponseEntity.created(new URI("/api/activity-group-categories/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /activity-group-categories : Updates an existing activityGroupCategory.
     *
     * @param activityGroupCategoryDTO the activityGroupCategoryDTO to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated activityGroupCategoryDTO,
     * or with status 400 (Bad Request) if the activityGroupCategoryDTO is not valid,
     * or with status 500 (Internal Server Error) if the activityGroupCategoryDTO couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/activity-group-categories")
    @Timed
    public ResponseEntity<ActivityGroupCategoryDTO> updateActivityGroupCategory(@Valid @RequestBody ActivityGroupCategoryDTO activityGroupCategoryDTO) throws URISyntaxException {
        log.debug("REST request to update ActivityGroupCategory : {}", activityGroupCategoryDTO);
        if (activityGroupCategoryDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        ActivityGroupCategoryDTO result = activityGroupCategoryService.save(activityGroupCategoryDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, activityGroupCategoryDTO.getId().toString()))
            .body(result);
    }

    /**
     * GET  /activity-group-categories : get all the activityGroupCategories.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of activityGroupCategories in body
     */
    @GetMapping("/activity-group-categories")
    @Timed
    public ResponseEntity<List<ActivityGroupCategoryDTO>> getAllActivityGroupCategories(Pageable pageable) {
        log.debug("REST request to get a page of ActivityGroupCategories");
        Page<ActivityGroupCategoryDTO> page = activityGroupCategoryService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/activity-group-categories");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /activity-group-categories/:id : get the "id" activityGroupCategory.
     *
     * @param id the id of the activityGroupCategoryDTO to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the activityGroupCategoryDTO, or with status 404 (Not Found)
     */
    @GetMapping("/activity-group-categories/{id}")
    @Timed
    public ResponseEntity<ActivityGroupCategoryDTO> getActivityGroupCategory(@PathVariable Long id) {
        log.debug("REST request to get ActivityGroupCategory : {}", id);
        Optional<ActivityGroupCategoryDTO> activityGroupCategoryDTO = activityGroupCategoryService.findOne(id);
        return ResponseUtil.wrapOrNotFound(activityGroupCategoryDTO);
    }

    /**
     * DELETE  /activity-group-categories/:id : delete the "id" activityGroupCategory.
     *
     * @param id the id of the activityGroupCategoryDTO to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/activity-group-categories/{id}")
    @Timed
    public ResponseEntity<Void> deleteActivityGroupCategory(@PathVariable Long id) {
        log.debug("REST request to delete ActivityGroupCategory : {}", id);
        activityGroupCategoryService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }

    /**
     * SEARCH  /_search/activity-group-categories?query=:query : search for the activityGroupCategory corresponding
     * to the query.
     *
     * @param query the query of the activityGroupCategory search
     * @param pageable the pagination information
     * @return the result of the search
     */
    @GetMapping("/_search/activity-group-categories")
    @Timed
    public ResponseEntity<List<ActivityGroupCategoryDTO>> searchActivityGroupCategories(@RequestParam String query, Pageable pageable) {
        log.debug("REST request to search for a page of ActivityGroupCategories for query {}", query);
        Page<ActivityGroupCategoryDTO> page = activityGroupCategoryService.search(query, pageable);
        HttpHeaders headers = PaginationUtil.generateSearchPaginationHttpHeaders(query, page, "/api/_search/activity-group-categories");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

}
