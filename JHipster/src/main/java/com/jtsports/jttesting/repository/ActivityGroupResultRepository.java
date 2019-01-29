package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.ActivityGroupResult;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the ActivityGroupResult entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityGroupResultRepository extends JpaRepository<ActivityGroupResult, Long> {

}
