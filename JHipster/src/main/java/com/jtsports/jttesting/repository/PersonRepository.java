package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.Person;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


/**
 * Spring Data  repository for the Person entity.
 */
@SuppressWarnings("unused")
@Repository
public interface PersonRepository extends JpaRepository<Person, Long> {

    Optional<Person> findByUserId(Long userId);

    Optional<Person> findByEmail(String email);

    List<Person> findAllByVirtual(Boolean virtual);

    @Query("select person from Person person " +
        "join person.user user " +
        "where user.login = :login")
    Optional<Person> findByUserLogin(@Param("login") String login);
}
