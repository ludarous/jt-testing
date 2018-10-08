package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.PersonalData;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the PersonalData entity.
 */
public interface PersonalDataSearchRepository extends ElasticsearchRepository<PersonalData, Long> {
}
