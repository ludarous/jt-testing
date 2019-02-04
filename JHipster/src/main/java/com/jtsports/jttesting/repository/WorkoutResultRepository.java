package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.WorkoutResult;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the WorkoutResult entity.
 */
@SuppressWarnings("unused")
@Repository
public interface WorkoutResultRepository extends JpaRepository<WorkoutResult, Long> {

}
