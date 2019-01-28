package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.ActivityGroupCategory;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the ActivityGroupCategory entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityGroupCategoryRepository extends JpaRepository<ActivityGroupCategory, Long> {

}
