package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.ActivityCategory;
import org.springframework.data.jpa.repository.*;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * Spring Data  repository for the ActivityCategory entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityCategoryRepository extends JpaRepository<ActivityCategory, Long> {

    List<ActivityCategory> findAllByParentId(Long parentId);

    @Query("select category from ActivityCategory category " +
        "where category.parent is null")
    List<ActivityCategory> findAllMainCategories();
}
