package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.Activity;
import com.jtsports.jttesting.domain.ActivityCategory;
import com.jtsports.jttesting.domain.ActivityResult;
import com.jtsports.jttesting.domain.Event;

import com.jtsports.jttesting.service.dto.ActivityResultDTO;
import com.jtsports.jttesting.service.dto.StatsRequestDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.NamedNativeQuery;
import javax.persistence.SqlResultSetMapping;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.Optional;

/**
 * Spring Data  repository for the Activity entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityRepository extends JpaRepository<Activity, Long> {

    Optional<Activity> findOneByKey(String key);

    @Query(value = "select distinct activity from Activity activity left join fetch activity.categories",
        countQuery = "select count(distinct activity) from Activity activity")
    Page<Activity> findAllWithEagerRelationships(Pageable pageable);

    @Query(value = "select distinct activity from Activity activity left join fetch activity.categories")
    List<Activity> findAllWithEagerRelationships();

    @Query("select activity from Activity activity left join fetch activity.categories where activity.id =:id")
    Optional<Activity> findOneWithEagerRelationships(@Param("id") Long id);

    @Query("select activityResult from ActivityResult activityResult " +
        "join activityResult.activity activity " +
        "join activityResult.workoutResult workoutResult " +
        "join workoutResult.eventResult eventResult " +
        "join eventResult.event event " +
        "join eventResult.person person " +
        "where activityResult.activity.id = :id")
    List<ActivityResult> findActivityResults(@Param("id") Long id);

    //@Query(name = "activityResults", nativeQuery = true)
    @Query("select activityResult from ActivityResult activityResult " +
        "join fetch activityResult.activity activity " +
        "join fetch activityResult.workoutResult workoutResult " +
        "join fetch workoutResult.workout workout " +
        "join fetch workoutResult.eventResult eventResult " +
        "join fetch eventResult.person person " +
        "join fetch activity.categories categories " +
        "where ((:personId is null) or (:personId = person.id)) " +
        "and ((:activityId is null) or (:activityId = activity.id)) " +
        "and ((:workoutId is null) or (:workoutId = workout.id)) " +
        "and ((:eventId is null) or (:eventId = eventResult.event.id)) " +
        "and ((cast(:dateFrom as timestamp) is null) or (:dateFrom <= activityResult.date)) " +
        "and ((cast(:dateTo as timestamp) is null) or (:dateTo >= activityResult.date)) " +
        "and ((cast(:usersBirthdayFrom as timestamp) is null) or (:usersBirthdayFrom <= person.personalData.birthDate)) " +
        "and ((cast(:usersBirthdayTo as timestamp) is null) or (:usersBirthdayTo >= person.personalData.birthDate))")
    List<ActivityResult> findAllActivitiesResultsWithRequest(
        @Param("personId") Long personId,
        @Param("activityId") Long activityId,
        @Param("workoutId") Long workoutId,
        @Param("eventId") Long eventId,
        @Param("dateFrom") ZonedDateTime dateFrom,
        @Param("dateTo") ZonedDateTime dateTo,
        @Param("usersBirthdayFrom") ZonedDateTime usersBirthdayFrom,
        @Param("usersBirthdayTo") ZonedDateTime usersBirthdayTo
    );

    @Query("select activity from Activity activity " +
        "inner join activity.categories category " +
        "where category.id in :ids")
    List<Activity> findActivityByCategories(@Param("ids") List<Long> ids);

    @Query("select activity from Event event " +
        "inner join event.workouts workout " +
        "inner join workout.activities activity " +
        "inner join activity.categories category " +
        "where category.id in :ids and event.id = :eventId")
    List<Activity> findActivityByCategoriesAndEventId(@Param("ids") List<Long> ids, @Param("eventId") Long eventId);

    @Query("select activity from Event event " +
        "inner join event.workouts workout " +
        "inner join workout.activities activity " +
        "inner join activity.categories category " +
        "where category.id in :ids and event.id = :eventId and workout.id = :workoutId")
    List<Activity> findActivityByCategoriesAndEventIdAndTestId(@Param("ids") List<Long> ids, @Param("eventId") Long eventId, @Param("workoutId") Long workoutId);

}
