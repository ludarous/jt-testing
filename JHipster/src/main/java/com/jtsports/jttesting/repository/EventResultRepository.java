package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.EventResult;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the EventResult entity.
 */
@SuppressWarnings("unused")
@Repository
public interface EventResultRepository extends JpaRepository<EventResult, Long> {

}
