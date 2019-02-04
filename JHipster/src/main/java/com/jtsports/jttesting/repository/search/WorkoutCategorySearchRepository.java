package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.WorkoutCategory;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the WorkoutCategory entity.
 */
public interface WorkoutCategorySearchRepository extends ElasticsearchRepository<WorkoutCategory, Long> {
}
