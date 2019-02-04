package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.WorkoutCategory;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the WorkoutCategory entity.
 */
@SuppressWarnings("unused")
@Repository
public interface WorkoutCategoryRepository extends JpaRepository<WorkoutCategory, Long> {

}
