package com.jtsports.jttesting.repository;

import com.jtsports.jttesting.domain.JTTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Spring Data  repository for the JTTest entity.
 */
@SuppressWarnings("unused")
@Repository
public interface JTTestRepository extends JpaRepository<JTTest, Long> {

    @Query(value = "select distinct jt_test from JTTest jt_test left join fetch jt_test.activities left join fetch jt_test.categories left join fetch jt_test.sports",
        countQuery = "select count(distinct jt_test) from JTTest jt_test")
    Page<JTTest> findAllWithEagerRelationships(Pageable pageable);

    @Query(value = "select distinct jt_test from JTTest jt_test left join fetch jt_test.activities left join fetch jt_test.categories left join fetch jt_test.sports")
    List<JTTest> findAllWithEagerRelationships();

    @Query("select jt_test from JTTest jt_test left join fetch jt_test.activities left join fetch jt_test.categories left join fetch jt_test.sports where jt_test.id =:id")
    Optional<JTTest> findOneWithEagerRelationships(@Param("id") Long id);

}
