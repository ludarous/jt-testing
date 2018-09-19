package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.ActivityCategory;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the ActivityCategory entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityCategoryRepository extends JpaRepository<ActivityCategory, Long> {

}
