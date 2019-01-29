package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.ActivityGroupResult;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the ActivityGroupResult entity.
 */
public interface ActivityGroupResultSearchRepository extends ElasticsearchRepository<ActivityGroupResult, Long> {
}
