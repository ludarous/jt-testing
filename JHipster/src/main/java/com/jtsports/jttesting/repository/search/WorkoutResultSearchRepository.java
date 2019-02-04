package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.WorkoutResult;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the WorkoutResult entity.
 */
public interface WorkoutResultSearchRepository extends ElasticsearchRepository<WorkoutResult, Long> {
}
