package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.Sport;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the Sport entity.
 */
public interface SportSearchRepository extends ElasticsearchRepository<Sport, Long> {
}
