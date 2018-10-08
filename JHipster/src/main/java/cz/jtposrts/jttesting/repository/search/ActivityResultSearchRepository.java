package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.ActivityResult;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the ActivityResult entity.
 */
public interface ActivityResultSearchRepository extends ElasticsearchRepository<ActivityResult, Long> {
}
