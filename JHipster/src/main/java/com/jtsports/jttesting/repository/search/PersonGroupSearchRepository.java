package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.PersonGroup;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the PersonGroup entity.
 */
public interface PersonGroupSearchRepository extends ElasticsearchRepository<PersonGroup, Long> {
}
