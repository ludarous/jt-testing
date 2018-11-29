package com.jtsports.jttesting.web.rest;

import com.codahale.metrics.annotation.Timed;
import com.jtsports.jttesting.service.PersonService;
import com.jtsports.jttesting.service.dto.PersonDTO;
import com.jtsports.jttesting.service.dto.PersonFullDTO;
import com.jtsports.jttesting.service.dto.PersonalDataDTO;
import com.jtsports.jttesting.web.rest.util.HeaderUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.ZonedDateTime;

/**
 * REST controller for managing TestResult.
 */
@RestController
@RequestMapping("/api")
public class AdminResource {

    private final Logger log = LoggerFactory.getLogger(AdminResource.class);

    private static final String ENTITY_NAME = "adminResource";

    private final PersonService personService;

    public AdminResource(PersonService personService) {

        this.personService = personService;
    }


    /**
     * GET  /generate-virtual-users : generates virtual users
     *
     * @return the ResponseEntity with status 200 (OK) and the list of testResults in body
     */
    @GetMapping("/generate-virtual-users")
    @Timed
    public ResponseEntity generateVirtualUsers() {
        log.debug("REST request to get a page of TestResults");

        int levels = 2;
        for(int i = 6; i < 50; i++) {

            for(int j = 0; j < levels; j++) {
                PersonFullDTO person = new PersonFullDTO();
                person.setEmail(i + "-" + j + "@virtual.virtual");
                person.setVirtual(true);

                PersonalDataDTO personalDataDTO = new PersonalDataDTO();
                personalDataDTO.setFirstName(i + " let");
                personalDataDTO.setLastName("úroveň " + j);
                ZonedDateTime now = ZonedDateTime.now();
                ZonedDateTime birthDate = now.withDayOfMonth(1).withMonth(7).minusYears(i);
                personalDataDTO.setBirthDate(birthDate);
                person.setPersonalData(personalDataDTO);
                this.personService.saveFull(person);
            }

        }

        return ResponseEntity.ok().build();
    }


}
