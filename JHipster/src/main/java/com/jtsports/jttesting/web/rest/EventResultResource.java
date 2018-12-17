package com.jtsports.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.jtsports.jttesting.domain.User;
import com.jtsports.jttesting.service.EventResultService;
import com.jtsports.jttesting.service.PersonService;
import com.jtsports.jttesting.service.UserService;
import com.jtsports.jttesting.service.dto.PersonFullDTO;
import com.jtsports.jttesting.service.dto.TestResultDTO;
import com.jtsports.jttesting.web.rest.errors.BadRequestAlertException;
import com.jtsports.jttesting.web.rest.util.HeaderUtil;
import com.jtsports.jttesting.web.rest.util.PaginationUtil;
import com.jtsports.jttesting.service.dto.EventResultDTO;
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

/**
 * REST controller for managing EventResult.
 */
@RestController
@RequestMapping("/api")
public class EventResultResource {

    private final Logger log = LoggerFactory.getLogger(EventResultResource.class);

    private static final String ENTITY_NAME = "eventResult";

    private final EventResultService eventResultService;

    private final UserService userService;

    private final PersonService personService;

    public EventResultResource(EventResultService eventResultService, UserService userService, PersonService personService) {
        this.eventResultService = eventResultService;
        this.userService = userService;
        this.personService = personService;
    }

    /**
     * POST  /event-results : Create a new eventResult.
     *
     * @param eventResultDTO the eventResultDTO to create
     * @return the ResponseEntity with status 201 (Created) and with body the new eventResultDTO, or with status 400 (Bad Request) if the eventResult has already an ID
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PostMapping("/event-results")
    @Timed
    public ResponseEntity<EventResultDTO> createEventResult(@Valid @RequestBody EventResultDTO eventResultDTO) throws URISyntaxException {
        log.debug("REST request to save EventResult : {}", eventResultDTO);
        if (eventResultDTO.getId() != null) {
            throw new BadRequestAlertException("A new eventResult cannot already have an ID", ENTITY_NAME, "idexists");
        }
        EventResultDTO result = eventResultService.save(eventResultDTO);
        return ResponseEntity.created(new URI("/api/event-results/" + result.getId()))
            .headers(HeaderUtil.createEntityCreationAlert(ENTITY_NAME, result.getId().toString()))
            .body(result);
    }

    /**
     * PUT  /event-results : Updates an existing eventResult.
     *
     * @param eventResultDTO the eventResultDTO to update
     * @return the ResponseEntity with status 200 (OK) and with body the updated eventResultDTO,
     * or with status 400 (Bad Request) if the eventResultDTO is not valid,
     * or with status 500 (Internal Server Error) if the eventResultDTO couldn't be updated
     * @throws URISyntaxException if the Location URI syntax is incorrect
     */
    @PutMapping("/event-results")
    @Timed
    public ResponseEntity<EventResultDTO> updateEventResult(@Valid @RequestBody EventResultDTO eventResultDTO) throws URISyntaxException {
        log.debug("REST request to update EventResult : {}", eventResultDTO);
        if (eventResultDTO.getId() == null) {
            throw new BadRequestAlertException("Invalid id", ENTITY_NAME, "idnull");
        }
        EventResultDTO result = eventResultService.save(eventResultDTO);
        return ResponseEntity.ok()
            .headers(HeaderUtil.createEntityUpdateAlert(ENTITY_NAME, eventResultDTO.getId().toString()))
            .body(result);
    }

    /**
     * GET  /event-results : get all the eventResults.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of eventResults in body
     */
    @GetMapping("/event-results")
    @Timed
    public ResponseEntity<List<EventResultDTO>> getAllEventResults(Pageable pageable) {
        log.debug("REST request to get a page of EventResults");
        Page<EventResultDTO> page = eventResultService.findAll(pageable);
        HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/event-results");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /**
     * GET  /event-results/:id : get the "id" eventResult.
     *
     * @param id the id of the eventResultDTO to retrieve
     * @return the ResponseEntity with status 200 (OK) and with body the eventResultDTO, or with status 404 (Not Found)
     */
    @GetMapping("/event-results/{id}")
    @Timed
    public ResponseEntity<EventResultDTO> getEventResult(@PathVariable Long id) {
        log.debug("REST request to get EventResult : {}", id);
        Optional<EventResultDTO> eventResultDTO = eventResultService.findOne(id);
        return ResponseUtil.wrapOrNotFound(eventResultDTO);
    }

    /**
     * DELETE  /event-results/:id : delete the "id" eventResult.
     *
     * @param id the id of the eventResultDTO to delete
     * @return the ResponseEntity with status 200 (OK)
     */
    @DeleteMapping("/event-results/{id}")
    @Timed
    public ResponseEntity<Void> deleteEventResult(@PathVariable Long id) {
        log.debug("REST request to delete EventResult : {}", id);
        eventResultService.delete(id);
        return ResponseEntity.ok().headers(HeaderUtil.createEntityDeletionAlert(ENTITY_NAME, id.toString())).build();
    }

    /**
     * SEARCH  /_search/event-results?query=:query : search for the eventResult corresponding
     * to the query.
     *
     * @param query the query of the eventResult search
     * @param pageable the pagination information
     * @return the result of the search
     */
    @GetMapping("/_search/event-results")
    @Timed
    public ResponseEntity<List<EventResultDTO>> searchEventResults(@RequestParam String query, Pageable pageable) {
        log.debug("REST request to search for a page of EventResults for query {}", query);
        Page<EventResultDTO> page = eventResultService.search(query, pageable);
        HttpHeaders headers = PaginationUtil.generateSearchPaginationHttpHeaders(query, page, "/api/_search/event-results");
        return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
    }

    /* ----------------------------- MY RESULTS ----------------------------- */

    /**
     * GET  /event-results/my : get all the eventResults.
     *
     * @param pageable the pagination information
     * @return the ResponseEntity with status 200 (OK) and the list of eventResults in body
     */
    @GetMapping("/event-results/my")
    @Timed
    public ResponseEntity<List<EventResultDTO>> getAllMyEventResults(Pageable pageable) {
        log.debug("REST request to get a page of EventResults");

        Optional<User> user = userService.getUserWithAuthorities();
        if(user.isPresent()) {
            Optional<PersonFullDTO> personFullDTO = this.personService.findOneByUserId(user.get().getId());
            if(personFullDTO.isPresent()) {
                Page<EventResultDTO> page = eventResultService.findAllByPersonId(pageable, personFullDTO.get().getId());
                HttpHeaders headers = PaginationUtil.generatePaginationHttpHeaders(page, "/api/event-results/my");
                return new ResponseEntity<>(page.getContent(), headers, HttpStatus.OK);
            }
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.notFound().build();
    }

}
