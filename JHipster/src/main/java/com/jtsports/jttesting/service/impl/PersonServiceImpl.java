package com.jtsports.jttesting.service.impl;

import com.jtsports.jttesting.domain.PersonalData;
import com.jtsports.jttesting.domain.User;
import com.jtsports.jttesting.repository.AddressRepository;
import com.jtsports.jttesting.repository.UserRepository;
import com.jtsports.jttesting.security.SecurityUtils;
import com.jtsports.jttesting.service.AddressService;
import com.jtsports.jttesting.service.PersonService;
import com.jtsports.jttesting.domain.Person;
import com.jtsports.jttesting.repository.PersonRepository;
import com.jtsports.jttesting.repository.search.PersonSearchRepository;
import com.jtsports.jttesting.service.PersonalDataService;
import com.jtsports.jttesting.service.UserService;
import com.jtsports.jttesting.service.dto.*;
import com.jtsports.jttesting.service.mapper.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.Optional;

import static org.elasticsearch.index.query.QueryBuilders.*;

/**
 * Service Implementation for managing Person.
 */
@Service
@Transactional
public class PersonServiceImpl implements PersonService {

    private final Logger log = LoggerFactory.getLogger(PersonServiceImpl.class);

    private final PersonRepository personRepository;

    private final AddressService addressService;

    private final AddressMapper addressMapper;

    private final UserService userService;

    private final UserRepository userRepository;

    private final UserMapper userMapper;

    private final PersonalDataService personalDataService;

    private final PersonalDataMapper personalDataMapper;

    private final PersonMapper personMapper;

    private final PersonFullMapper personFullMapper;

    private final PersonSearchRepository personSearchRepository;

    public PersonServiceImpl(PersonRepository personRepository, AddressRepository addressRepository, AddressService addressService, AddressMapper addressMapper, UserService userService, UserRepository userRepository, UserMapper userMapper, PersonalDataService personalDataService, PersonalDataMapper personalDataMapper, PersonMapper personMapper, PersonFullMapper personFullMapper, PersonSearchRepository personSearchRepository) {
        this.personRepository = personRepository;
        this.addressService = addressService;
        this.addressMapper = addressMapper;
        this.userService = userService;
        this.userRepository = userRepository;
        this.userMapper = userMapper;
        this.personalDataService = personalDataService;
        this.personalDataMapper = personalDataMapper;
        this.personMapper = personMapper;
        this.personFullMapper = personFullMapper;
        this.personSearchRepository = personSearchRepository;
    }

    /**
     * Save a person.
     *
     * @param personDTO the entity to save
     * @return the persisted entity
     */
    @Override
    public PersonDTO save(PersonDTO personDTO) {
        log.debug("Request to save Person : {}", personDTO);
        Person person = personMapper.toEntity(personDTO);
        person = personRepository.save(person);

        this.updateUser(person);

        PersonDTO result = personMapper.toDto(person);
        personSearchRepository.save(person);
        return result;
    }

    /**
     * Get all the people.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PersonDTO> findAll(Pageable pageable) {
        log.debug("Request to get all People");
        return personRepository.findAll(pageable)
            .map(personMapper::toDto);
    }

    /**
     * Get all the people.
     *
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PersonFullDTO> findAllFull(Pageable pageable) {
        log.debug("Request to get all People");
        return personRepository.findAll(pageable)
            .map(personFullMapper::toDto);
    }


    /**
     * Get one person by id.
     *
     * @param id the id of the entity
     * @return the entity
     */
    @Override
    @Transactional(readOnly = true)
    public Optional<PersonDTO> findOne(Long id) {
        log.debug("Request to get Person : {}", id);
        return personRepository.findById(id)
            .map(personMapper::toDto);
    }

    @Override
    public Optional<PersonFullDTO> findOneFull(Long id) {
        log.debug("Request to get Person : {}", id);
        return personRepository.findById(id)
            .map(personFullMapper::toDto);
    }

    @Override
    public Optional<PersonFullDTO> findOneByUserId(Long userId) {
        log.debug("Request to get Person by userId : {}", userId);
        return personRepository.findByUserId(userId)
            .map(personFullMapper::toDto);
    }

    @Override
    public Person findCurrentPerson() {

        Optional<String> currentLoginOptional = SecurityUtils.getCurrentUserLogin();
        if(!currentLoginOptional.isPresent()) {
            log.warn("Current user not found!");
            return null;
        }

        String userLogin = currentLoginOptional.get();

        Optional<Person> personOptional = this.personRepository.findByUserLogin(userLogin);
        if(!personOptional.isPresent()) {
            log.warn("Current person for user login " + userLogin + " not found!");
            return null;
        }

        return personOptional.get();

    }

    /**
     * Delete the person by id.
     *
     * @param id the id of the entity
     */
    @Override
    public void delete(Long id) {
        log.debug("Request to delete Person : {}", id);
        personRepository.deleteById(id);
        personSearchRepository.deleteById(id);
    }

    /**
     * Search for the person corresponding to the query.
     *
     * @param query the query of the search
     * @param pageable the pagination information
     * @return the list of entities
     */
    @Override
    @Transactional(readOnly = true)
    public Page<PersonDTO> search(String query, Pageable pageable) {
        log.debug("Request to search for a page of People for query {}", query);
        return personSearchRepository.search(queryStringQuery(query), pageable)
            .map(personMapper::toDto);
    }

    @Override
    public PersonFullDTO saveFull(PersonFullDTO personFullDTO) {
        Person person = new Person();

        if(personFullDTO.getId() != null) {
            Optional<Person> personOptional = this.personRepository.findById(personFullDTO.getId());
            if(personOptional.isPresent()) {
                person = personOptional.get();
            }
        }


        if(personFullDTO.getAddress() != null) {
            AddressDTO addressDTO = this.addressService.save(personFullDTO.getAddress());
            person.setAddress(addressMapper.toEntity(addressDTO));
        }

        if(personFullDTO.getPersonalData() != null) {
            PersonalDataDTO personalDataDTO = this.personalDataService.save(personFullDTO.getPersonalData());
            person.setPersonalData(personalDataMapper.toEntity(personalDataDTO));
        }

        if(personFullDTO.getUser() != null) {
            UserDTO userDTO = personFullDTO.getUser();
            User user;
            if(userDTO.getId() != null) {
                Optional<User> userOptional = this.userRepository.findById(personFullDTO.getUser().getId());
                if(userOptional.isPresent()) {
                    user = userOptional.get();
                } else {
                    user = this.userService.createUser(personFullDTO.getUser());
                }
            } else {
                user = this.userService.createUser(personFullDTO.getUser());
            }

            person.setUser(user);
        }

        person.setEmail(personFullDTO.getEmail());
        person.setVirtual(personFullDTO.isVirtual());

        this.updateUser(person);


        person = personRepository.save(person);
        PersonDTO result = personMapper.toDto(person);
        personSearchRepository.save(person);
        return personFullMapper.toDto(person);
    }

    void updateUser(Person person) {
        User currentUser = userService.getCurrentUser();
        if(person.getPersonalData() != null) {
            PersonalData personalData = person.getPersonalData();
            currentUser.setFirstName(personalData.getFirstName());
            currentUser.setLastName(personalData.getLastName());
            userRepository.save(currentUser);
        }
    }
}
