package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.ActivityGroup;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the ActivityGroup entity.
 */
public interface ActivityGroupSearchRepository extends ElasticsearchRepository<ActivityGroup, Long> {
}
