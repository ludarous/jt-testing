package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.ActivityResult;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the ActivityResult entity.
 */
public interface ActivityResultSearchRepository extends ElasticsearchRepository<ActivityResult, Long> {
}
