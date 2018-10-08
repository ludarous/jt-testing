package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.EventResult;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the EventResult entity.
 */
public interface EventResultSearchRepository extends ElasticsearchRepository<EventResult, Long> {
}
