package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.Sport;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the Sport entity.
 */
public interface SportSearchRepository extends ElasticsearchRepository<Sport, Long> {
}
