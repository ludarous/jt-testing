package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.Person;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

import java.util.Optional;


/**
 * Spring Data  repository for the Person entity.
 */
@SuppressWarnings("unused")
@Repository
public interface PersonRepository extends JpaRepository<Person, Long> {

    Optional<Person> findByUserId(Long userId);
}
