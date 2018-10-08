package cz.jtposrts.jttesting.service.impl;

import cz.jtposrts.jttesting.service.PersonalDataService;
import cz.jtposrts.jttesting.domain.PersonalData;
import cz.jtposrts.jttesting.repository.PersonalDataRepository;
import cz.jtposrts.jttesting.repository.search.PersonalDataSearchRepository;
import cz.jtposrts.jttesting.service.dto.PersonalDataDTO;
import cz.jtposrts.jttesting.service.mapper.PersonalDataMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing PersonalData.
 */
@Service
@Transactional
public class PersonalDataServiceImpl implements PersonalDataService {

    private final Logger log = LoggerFactory.getLogger(PersonalDataServiceImpl.class);

    private final PersonalDataRepository personalDataRepository;

    private final PersonalDataMapper personalDataMapper;

    private final PersonalDataSearchRepository personalDataSearchRepository;

    public PersonalDataServiceImpl(PersonalDataRepository personalDataRepository, PersonalDataMapper personalDataMapper, PersonalDataSearchRepository personalDataSearchRepository) {
        this.personalDataRepository = personalDataRepository;
        this.personalDataMapper = personalDataMapper;
        this.personalDataSearchRepository = personalDataSearchRepository;
    }

    /**
     * Save a personalData.
     *
     * @param personalDataDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public PersonalDataDTO save(PersonalDataDTO personalDataDTO) {
        log.debug("Request to save PersonalData : {}", personalDataDTO);

        PersonalData personalData = personalDataMapper.toEntity(personalDataDTO);
        personalData = personalDataRepository.save(personalData);
        PersonalDataDTO result = personalDataMapper.toDto(personalData);
        personalDataSearchRepository.save(personalData);
        return result;
    }

    /**
     * Get all the personalData.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PersonalDataDTO> findAll(Pageable pageable) {
        log.debug("Request to get all PersonalData");
        return personalDataRepository.findAll(pageable)
            .map(personalDataMapper::toDto);
    }


    /**
     * Get one personalData by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<PersonalDataDTO> findOne(Long id) {
        log.debug("Request to get PersonalData : {}", id);
        return personalDataRepository.findById(id)
            .map(personalDataMapper::toDto);
    }

    /**
     * Delete the personalData by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete PersonalData : {}", id);
        personalDataRepository.deleteById(id);
        personalDataSearchRepository.deleteById(id);
    }

    /**
     * Search for the personalData corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PersonalDataDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of PersonalData for query {}", query);
        return personalDataSearchRepository.search(queryStringQuery(query), pageable)
            .map(personalDataMapper::toDto);
    }
}
