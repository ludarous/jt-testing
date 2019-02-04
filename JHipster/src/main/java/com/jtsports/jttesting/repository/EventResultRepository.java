package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.EventResult;
import com.jtsports.jttesting.service.dto.EventResultDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * Spring Data  repository for the EventResult entity.
 */
@SuppressWarnings("unused")
@Repository
public interface EventResultRepository extends JpaRepository<EventResult, Long> {

    @Query(value = "select distinct eventResult from EventResult eventResult " +
        "left join fetch eventResult.workoutResults where eventResult.event.id = :eventId",
        countQuery = "select count(distinct eventResult) from EventResult eventResult where eventResult.event.id = :eventId")
    Page<EventResult> findAllByEventIdWithEagerRelationships(Pageable pageable, @Param("eventId") Long eventId);


    @Query(value = "select distinct eventResult from EventResult eventResult " +
        "left join fetch eventResult.workoutResults where eventResult.person.id = :personId",
        countQuery = "select count(distinct eventResult) from EventResult eventResult where eventResult.event.id = :personId")
    Page<EventResult> findAllByPersonIdWithEagerRelationships(Pageable pageable, @Param("personId") Long personId);


    @Query(value = "select distinct eventResult from EventResult eventResult " +
        "left join fetch eventResult.workoutResults where eventResult.person.id = :personId and eventResult.event.id = :eventId")
    List<EventResult> findAllByPersonAndEventIdWithEagerRelationships(@Param("personId") Long personId, @Param("eventId") Long eventId);

    @Query(value = "select distinct eventResult from EventResult eventResult " +
        "left join fetch eventResult.workoutResults " +
        "where eventResult.event.id = :eventId and eventResult.person.id = :personId")
    List<EventResult> findAllByEventIdAndPersonIdWithEagerRelationships(@Param("personId") Long personId, @Param("eventId") Long eventId);
}
