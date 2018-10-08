package cz.jtposrts.jttesting.service.impl;

import cz.jtposrts.jttesting.service.EventResultService;
import cz.jtposrts.jttesting.domain.EventResult;
import cz.jtposrts.jttesting.repository.EventResultRepository;
import cz.jtposrts.jttesting.repository.search.EventResultSearchRepository;
import cz.jtposrts.jttesting.service.dto.EventResultDTO;
import cz.jtposrts.jttesting.service.mapper.EventResultMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing EventResult.
 */
@Service
@Transactional
public class EventResultServiceImpl implements EventResultService {

    private final Logger log = LoggerFactory.getLogger(EventResultServiceImpl.class);

    private final EventResultRepository eventResultRepository;

    private final EventResultMapper eventResultMapper;

    private final EventResultSearchRepository eventResultSearchRepository;

    public EventResultServiceImpl(EventResultRepository eventResultRepository, EventResultMapper eventResultMapper, EventResultSearchRepository eventResultSearchRepository) {
        this.eventResultRepository = eventResultRepository;
        this.eventResultMapper = eventResultMapper;
        this.eventResultSearchRepository = eventResultSearchRepository;
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
        eventResult = eventResultRepository.save(eventResult);
        EventResultDTO result = eventResultMapper.toDto(eventResult);
        eventResultSearchRepository.save(eventResult);
        return result;
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
}
