package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.ActivityGroup;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data  repository for the ActivityGroup entity.
 */
@SuppressWarnings("unused")
@Repository
public interface ActivityGroupRepository extends JpaRepository<ActivityGroup, Long> {

    @Query(value = "select distinct activity_group from ActivityGroup activity_group left join fetch activity_group.activities left join fetch activity_group.activityGroupCategories",
        countQuery = "select count(distinct activity_group) from ActivityGroup activity_group")
    Page<ActivityGroup> findAllWithEagerRelationships(Pageable pageable);

    @Query(value = "select distinct activity_group from ActivityGroup activity_group left join fetch activity_group.activities left join fetch activity_group.activityGroupCategories")
    List<ActivityGroup> findAllWithEagerRelationships();

    @Query("select activity_group from ActivityGroup activity_group left join fetch activity_group.activities left join fetch activity_group.activityGroupCategories where activity_group.id =:id")
    Optional<ActivityGroup> findOneWithEagerRelationships(@Param("id") Long id);

}
