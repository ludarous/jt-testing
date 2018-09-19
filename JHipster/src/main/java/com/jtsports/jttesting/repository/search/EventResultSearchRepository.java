package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.EventResult;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the EventResult entity.
 */
public interface EventResultSearchRepository extends ElasticsearchRepository<EventResult, Long> {
}
