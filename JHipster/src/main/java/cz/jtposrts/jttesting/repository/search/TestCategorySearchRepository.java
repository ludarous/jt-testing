package cz.jtposrts.jttesting.repository.search;

import cz.jtposrts.jttesting.domain.TestCategory;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

/**
 * Spring Data Elasticsearch repository for the TestCategory entity.
 */
public interface TestCategorySearchRepository extends ElasticsearchRepository<TestCategory, Long> {
}
