package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.TestCategory;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;


/**
 * Spring Data  repository for the TestCategory entity.
 */
@SuppressWarnings("unused")
@Repository
public interface TestCategoryRepository extends JpaRepository<TestCategory, Long> {

}
