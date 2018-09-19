package com.jtsports.jttesting.repository.search;

import com.jtsports.jttesting.domain.PersonalData;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the PersonalData entity.
 */
public interface PersonalDataSearchRepository extends ElasticsearchRepository<PersonalData, Long> {
}
