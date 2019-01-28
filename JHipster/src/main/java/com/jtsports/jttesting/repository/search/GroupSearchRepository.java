package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.Group;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the Group entity.
 */
public interface GroupSearchRepository extends ElasticsearchRepository<Group, Long> {
}
