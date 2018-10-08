package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.JTTest;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the JTTest entity.
 */
public interface JTTestSearchRepository extends ElasticsearchRepository<JTTest, Long> {
}
