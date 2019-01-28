package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.PersonGroup;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the PersonGroup entity.
 */
@SuppressWarnings("unused")
@Repository
public interface PersonGroupRepository extends JpaRepository<PersonGroup, Long> {

}
