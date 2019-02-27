package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.*;
import com.jtsports.jttesting.repository.*;
import com.jtsports.jttesting.service.EventResultService;
import com.jtsports.jttesting.repository.search.EventResultSearchRepository;
import com.jtsports.jttesting.service.dto.EventResultDTO;
import com.jtsports.jttesting.service.mapper.EventResultMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing EventResult.
 */
@Service
@Transactional
public class EventResultServiceImpl implements EventResultService {

    private final Logger log = LoggerFactory.getLogger(EventResultServiceImpl.class);

    private final EventResultRepository eventResultRepository;

    private final EventRepository eventRepository;

    private final PersonRepository personRepository;

    private final WorkoutResultRepository workoutResultRepository;

    private final ActivityResultRepository activityResultRepository;

    private final EventResultMapper eventResultMapper;

    private final EventResultSearchRepository eventResultSearchRepository;

    private final EntityManager entityManager;

    public EventResultServiceImpl(EventResultRepository eventResultRepository, EventRepository eventRepository, PersonRepository personRepository, WorkoutResultRepository workoutResultRepository, ActivityResultRepository activityResultRepository, EventResultMapper eventResultMapper, EventResultSearchRepository eventResultSearchRepository, EntityManager entityManager) {
        this.eventResultRepository = eventResultRepository;
        this.eventRepository = eventRepository;
        this.personRepository = personRepository;
        this.workoutResultRepository = workoutResultRepository;
        this.activityResultRepository = activityResultRepository;
        this.eventResultMapper = eventResultMapper;
        this.eventResultSearchRepository = eventResultSearchRepository;
        this.entityManager = entityManager;
    }

    /**
     * Save a eventResult.
     *
     * @param eventResultDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public EventResultDTO save(EventResultDTO eventResultDTO) {
        log.debug("Request to save EventResult : {}", eventResultDTO);
        EventResult eventResult = eventResultMapper.toEntity(eventResultDTO);
        eventResult = eventResultRepository.saveAndFlush(eventResult);
        entityManager.detach(eventResult);
        eventResult = eventResultRepository.findById(eventResult.getId()).get();


        for(WorkoutResult workoutResult : eventResult.getWorkoutResults()) {
            workoutResult.setEventResult(eventResult);

            for(ActivityResult activityResult : workoutResult.getActivitiesResults()) {
                activityResult.setWorkoutResult(workoutResult);
                activityResult.setPerson(eventResult.getPerson());
                activityResult.setEvent(eventResult.getEvent());
                activityResult.setWorkout(workoutResult.getWorkout());
                activityResultRepository.save(activityResult);
            }

            workoutResultRepository.save(workoutResult);
        }

        EventResultDTO result = eventResultMapper.toDto(eventResult);
        eventResultSearchRepository.save(eventResult);
        return result;
    }

    /**
     * Create a eventResult.
     *
     * @param eventResultDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public EventResultDTO create(EventResultDTO eventResultDTO) {

        Optional<Event> eventOptional = this.eventRepository.findOneWithEagerRelationships(eventResultDTO.getEventId());
        if(!eventOptional.isPresent()) {
            log.warn("Cannot find event with id: " + eventResultDTO.getEventId());
            return null;
        }

        Optional<Person> personOptional = this.personRepository.findById(eventResultDTO.getPersonId());
        if(!personOptional.isPresent()) {
            log.warn("Cannot find person with id: " + eventResultDTO.getPersonId());
            return null;
        }

        Event event = eventOptional.get();
        Person person = personOptional.get();

        EventResult eventResult = new EventResult();
        eventResult.setEvent(event);
        eventResult.setPerson(person);

        Set<WorkoutResult> workoutResultSet = new HashSet<>();

        for(Workout workout : event.getWorkouts()) {
            WorkoutResult workoutResult = new WorkoutResult();
            workoutResult.setWorkout(workout);
            workoutResult.setEventResult(eventResult);


            Set<ActivityResult> activityResultSet = new HashSet<>();
            for(Activity activity : workout.getActivities()) {
                ActivityResult activityResult = new ActivityResult();
                activityResult.setEvent(event);
                activityResult.setPerson(person);
                activityResult.setWorkoutResult(workoutResult);
                activityResult.setWorkout(workout);
                activityResult.setActivity(activity);
                activityResultSet.add(activityResult);
            }
            workoutResult.setActivitiesResults(activityResultSet);

            workoutResultSet.add(workoutResult);
        }

        eventResult.setWorkoutResults(workoutResultSet);

        eventResult = eventResultRepository.save(eventResult);

        eventResultDTO = eventResultMapper.toDto(eventResult);
        eventResultSearchRepository.save(eventResult);

        return eventResultDTO;
    }

    /**
     * Get all the eventResults.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<EventResultDTO> findAll(Pageable pageable) {
        log.debug("Request to get all EventResults");
        return eventResultRepository.findAll(pageable)
            .map(eventResultMapper::toDto);
    }


    /**
     * Get one eventResult by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<EventResultDTO> findOne(Long id) {
        log.debug("Request to get EventResult : {}", id);
        return eventResultRepository.findById(id)
            .map(eventResultMapper::toDto);
    }

    /**
     * Delete the eventResult by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete EventResult : {}", id);
        eventResultRepository.deleteById(id);
        eventResultSearchRepository.deleteById(id);
    }

    /**
     * Search for the eventResult corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<EventResultDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of EventResults for query {}", query);
        return eventResultSearchRepository.search(queryStringQuery(query), pageable)
            .map(eventResultMapper::toDto);
    }

    @Override
    public Page<EventResultDTO> findAllByEventId(Pageable pageable, Long eventId) {
        log.debug("Request to get all EventResults");
        return eventResultRepository.findAllByEventIdWithEagerRelationships(pageable, eventId)
            .map(eventResultMapper::toDto);
    }

    @Override
    public List<EventResultDTO> findAllByPersonIdAndEventId(Long personId, Long eventId) {
        log.debug("Request to get all EventResults");
        return eventResultRepository.findAllByEventIdAndPersonIdWithEagerRelationships(personId, eventId).stream()
            .map(eventResultMapper::toDto).collect(Collectors.toList());
    }

    @Override
    public Page<EventResultDTO> findAllByPersonId(Pageable pageable, Long id) {
        return eventResultRepository.findAllByPersonIdWithEagerRelationships(pageable, id)
            .map(eventResultMapper::toDto);
    }

    @Override
    public void generateFakeEventsResults() {
        List<Event> events = this.eventRepository.findAll();
        List<Person> persons = this.personRepository.findAllByVirtual(false);

        for(Event event : events) {
            for(Person person : event.getAttachedPersons()) {
                EventResult eventResult = EventResult.createEventResult(event, person);
                this.eventResultRepository.save(eventResult);
            }
        }
    }
}
