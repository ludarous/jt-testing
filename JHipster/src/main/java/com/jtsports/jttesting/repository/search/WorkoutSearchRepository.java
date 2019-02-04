package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.Workout;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the Workout entity.
 */
public interface WorkoutSearchRepository extends ElasticsearchRepository<Workout, Long> {
}
