package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.Workout;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data  repository for the Workout entity.
 */
@SuppressWarnings("unused")
@Repository
public interface WorkoutRepository extends JpaRepository<Workout, Long> {

    @Query(value = "select distinct workout from Workout workout left join fetch workout.activities left join fetch workout.workoutCategories",
        countQuery = "select count(distinct workout) from Workout workout")
    Page<Workout> findAllWithEagerRelationships(Pageable pageable);

    @Query(value = "select distinct workout from Workout workout left join fetch workout.activities left join fetch workout.workoutCategories")
    List<Workout> findAllWithEagerRelationships();

    @Query("select workout from Workout workout left join fetch workout.activities left join fetch workout.workoutCategories where workout.id =:id")
    Optional<Workout> findOneWithEagerRelationships(@Param("id") Long id);

}
