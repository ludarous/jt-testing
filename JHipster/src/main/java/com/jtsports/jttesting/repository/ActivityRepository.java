package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.domain.Event;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data  repository for the Activity entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityRepository extends JpaRepository<Activity, Long> {

    @Query(value = "select distinct activity from Activity activity left join fetch activity.categories",
        countQuery = "select count(distinct activity) from Activity activity")
    Page<Activity> findAllWithEagerRelationships(Pageable pageable);

    @Query(value = "select distinct activity from Activity activity left join fetch activity.categories")
    List<Activity> findAllWithEagerRelationships();

    @Query("select activity from Activity activity left join fetch activity.categories where activity.id =:id")
    Optional<Activity> findOneWithEagerRelationships(@Param("id") Long id);

    @Query("select activityResult from ActivityResult activityResult " +
        "inner join fetch activityResult.activity activity " +
        "inner join activityResult.testResult testResult " +
        "inner join testResult.eventResult eventResult " +
        "inner join eventResult.person person " +
        "where activity.id = :id")
    List<ActivityResult> findActivityResults(@Param("id") Long id);

    @Query("select activity from Activity activity " +
        "inner join activity.categories category " +
        "where category.id in :ids")
    List<Activity> findActivityByCategories(@Param("ids") List<Long> ids);

    @Query("select activity from Event event " +
        "inner join event.tests test " +
        "inner join test.activities activity " +
        "inner join activity.categories category " +
        "where category.id in :ids and event.id = :eventId")
    List<Activity> findActivityByCategoriesAndEventId(@Param("ids") List<Long> ids, @Param("eventId") Long eventId);

    @Query("select activity from Event event " +
        "inner join event.tests test " +
        "inner join test.activities activity " +
        "inner join activity.categories category " +
        "where category.id in :ids and event.id = :eventId and test.id = :testId")
    List<Activity> findActivityByCategoriesAndEventIdAndTestId(@Param("ids") List<Long> ids, @Param("eventId") Long eventId, @Param("testId") Long testId);

}
