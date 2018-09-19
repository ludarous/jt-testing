package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.ActivityResult;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the ActivityResult entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityResultRepository extends JpaRepository<ActivityResult, Long> {

}
