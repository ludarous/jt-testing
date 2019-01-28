package com.jtsports.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.jtsports.jttesting.domain.User;
import com.jtsports.jttesting.service.JTTestService;
import com.jtsports.jttesting.service.PersonService;
import com.jtsports.jttesting.service.StatsService;
import com.jtsports.jttesting.service.UserService;
import com.jtsports.jttesting.service.dto.JTTestDTO;
import com.jtsports.jttesting.service.dto.PersonFullDTO;
import com.jtsports.jttesting.service.dto.Stats.PersonalStatsDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import com.jtsports.jttesting.web.rest.errors.BadRequestAlertException;
import com.jtsports.jttesting.web.rest.util.HeaderUtil;
import com.jtsports.jttesting.web.rest.util.PaginationUtil;
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
 * REST controller for managing Stats.
 */
@RestController
@RequestMapping("/api")
public class StatsResource {

    private final Logger log = LoggerFactory.getLogger(StatsResource.class);

    private static final String ENTITY_NAME = "Stats";

    private final JTTestService jTTestService;

    private final UserService userService;

    private final PersonService personService;

    private final StatsService statsService;

    public StatsResource(JTTestService jTTestService, UserService userService, PersonService personService, StatsService statsService) {
        this.jTTestService = jTTestService;
        this.userService = userService;
        this.personService = personService;
        this.statsService = statsService;
    }

    /**
     * POST  /stats/my-stats : get the tests stats
     *
     * @return the ResponseEntity with status 200 (OK) and with body the PersonalStatsDTO, or with status 404 (Not Found)
     */
    @PostMapping("/stats/my-stats")
    @Timed
    public ResponseEntity<PersonalStatsDTO> getPersonalStats(@RequestBody StatsRequestDTO statsRequestDTO) {
        log.debug("REST request to get Personal Activities stats");
        Optional<User> user = userService.getUserWithAuthorities();
        if(user.isPresent()) {
            Optional<PersonFullDTO> personFullDTO = this.personService.findOneByUserId(user.get().getId());
            if (personFullDTO.isPresent()) {
                PersonalStatsDTO personalStatsDTO = statsService.getPersonalStats(personFullDTO.get().getId(), statsRequestDTO);
                return ResponseEntity.ok(personalStatsDTO);
            }
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.notFound().build();
    }

}
